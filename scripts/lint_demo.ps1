# =============================================================================
# ACESSILIA Lint Demo Script (PowerShell)
# =============================================================================
# Uso: .\lint_demo.ps1 [-Dir <diretorio>] [-Schema <schema>] [-Output <output>]
# =============================================================================

param(
    [string]$Dir = ".\families",
    [string]$Schema = ".\schemas\acessilia.schema.json",
    [string]$Output = ".\relatorio-conformidade.md"
)

$Families = @(200, 300, 400, 500, 600, 700, 800)
$Version = "1.0.0"
$Date = Get-Date -Format "yyyy-MM-dd"

function Write-Info  { param([string]$Msg) Write-Host "[INFO] $Msg" -ForegroundColor Blue }
function Write-Pass  { param([string]$Msg) Write-Host "[PASS] $Msg" -ForegroundColor Green }
function Write-Fail  { param([string]$Msg) Write-Host "[FAIL] $Msg" -ForegroundColor Red }
function Write-Warn  { param([string]$Msg) Write-Host "[WARN] $Msg" -ForegroundColor Yellow }

Write-Info "Verificando dependencias..."

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Fail "Node.js nao encontrado."
    exit 1
}
if (-not (Test-Path $Schema)) {
    Write-Fail "Schema nao encontrado: $Schema"
    exit 1
}
if (-not (Test-Path $Dir)) {
    Write-Fail "Diretorio nao encontrado: $Dir"
    exit 1
}

Write-Info "Node.js: $(node --version)"
Write-Info "Schema: $Schema"
Write-Info "Diretorio: $Dir"

$TotalPass = 0
$TotalFail = 0
$TotalWarn = 0

$reportLines = @()
$reportLines += "# Relatorio de Conformidade ACESSILIA"
$reportLines += ""
$reportLines += "**Data**: $Date  "
$reportLines += "**Versao do padrao**: $Version  "
$reportLines += "**Diretorio analisado**: $Dir  "
$reportLines += "**Schema utilizado**: $Schema"
$reportLines += ""
$reportLines += "---"
$reportLines += ""
$reportLines += "## Resumo Geral"
$reportLines += ""
$reportLines += "| Familia | Total de Criterios | PASS | FAIL | WARN |"
$reportLines += "|---------|-------------------|------|------|------|"

foreach ($Fam in $Families) {
    $FamDir = Join-Path $Dir "$Fam"
    $nbsp = [char]0x2011
    $FamFile = Join-Path $FamDir "ACESSILIA${nbsp}200.md".Replace("200", "$Fam")

    Write-Info "Analisando Familia $Fam..."

    if (-not (Test-Path -LiteralPath $FamFile)) {
        Write-Warn "Arquivo nao encontrado: $FamFile"
        $reportLines += "| $Fam | 0 | 0 | 0 | 1 |"
        $TotalWarn++
        continue
    }

    $content = Get-Content $FamFile -Raw -Encoding UTF8

    $criteriaPattern = '^\| ACL'
    $criteria = ([regex]::Matches($content, $criteriaPattern, 'Multiline')).Count

    $rfcPass = if ($content -match "RFC 2119") { 1 } else { 0 }

    $requiredSections = @("Escopo", "Crit", "Exemplo", "Valida")
    $missingCount = 0
    foreach ($section in $requiredSections) {
        if ($content -notmatch [regex]::Escape($section)) {
            $missingCount++
        }
    }
    $sectionsPass = if ($missingCount -eq 0) { 1 } else { 0 }

    $famPass = $criteria + $rfcPass + $sectionsPass
    $famFail = $missingCount

    $TotalPass += $famPass
    $TotalFail += $famFail

    $reportLines += "| $Fam | $criteria | $famPass | $famFail | 0 |"

    if ($famFail -eq 0) {
        Write-Pass "Familia ${Fam}: ${famPass} checks PASS"
    } else {
        Write-Fail "Familia ${Fam}: ${famPass} PASS, ${famFail} FAIL"
    }
}

$Total = $TotalPass + $TotalFail + $TotalWarn

$reportLines += ""
$reportLines += "**Total**: $Total checks ($TotalPass PASS, $TotalFail FAIL, $TotalWarn WARN)"
$reportLines += ""
$reportLines += "---"
$reportLines += ""
$reportLines += "## Detalhes por Familia"
$reportLines += ""

foreach ($Fam in $Families) {
    $nbsp = [char]0x2011
    $FamDir = Join-Path $Dir "$Fam"
    $FamFile = Join-Path $FamDir "ACESSILIA${nbsp}200.md".Replace("200", "$Fam")

    if (-not (Test-Path -LiteralPath $FamFile)) { continue }

    $content = Get-Content $FamFile -Raw -Encoding UTF8

    $reportLines += "### Familia $Fam"
    $reportLines += ""
    $reportLines += "**Criterios identificados:**"
    $reportLines += ""

    $matches = [regex]::Matches($content, '\| (ACL[^\|]+) \|')
    foreach ($m in $matches) {
        $cod = $m.Groups[1].Value.Trim()
        if ($cod) { $reportLines += "- $cod" }
    }
    $reportLines += ""

    if ($content -match "RFC 2119") {
        $reportLines += "RFC 2119: Referenciado"
    } else {
        $reportLines += "RFC 2119: Nao referenciado"
    }

    $reportLines += ""
    $reportLines += "**Secoes:**"
    foreach ($section in $requiredSections) {
        if ($content -match [regex]::Escape($section)) {
            $reportLines += "- OK $section"
        } else {
            $reportLines += "- FALTA $section"
        }
    }
    $reportLines += ""
}

$reportLines += "---"
$reportLines += ""
$reportLines += "Relatorio gerado automaticamente pelo ACESSILIA Lint Demo v$Version"

$reportLines | Out-File -FilePath $Output -Encoding UTF8

Write-Host ""
Write-Info "========================================="
Write-Info "RELATORIO GERADO COM SUCESSO"
Write-Info "========================================="
Write-Info "Arquivo: $Output"
Write-Info "Total: $Total checks ($TotalPass PASS, $TotalFail FAIL, $TotalWarn WARN)"

if ($TotalFail -gt 0) {
    Write-Fail "Existem $TotalFail falhas que precisam ser corrigidas."
    exit 1
} else {
    Write-Pass "Todos os checks passaram!"
    exit 0
}
