# =============================================================================
# ACESSILIA Lint Demo Script (PowerShell 5.1+)
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
$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Non-breaking hyphen for filenames (U+2011)
$nbsp = [char]0x2011

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

# --- Report header (UTF-8 via byte concatenation for PS5.1) ---
$rpt = @()
# "Relatorio" = 52 65 6C 61 74 C3 B3 72 69 6F
$hdr = [byte[]](0x52,0x65,0x6C,0x61,0x74,0xC3,0xB3,0x72,0x69,0x6F)
$hdrStr = [System.Text.Encoding]::UTF8.GetString($hdr)
$rpt += "# $hdrStr de Conformidade ACESSILIA"
$rpt += ""
$rpt += "**Data**: $Date  "
# "Versao do padrao" = 56 65 72 73 C3 A3 6F 20 64 6F 20 70 61 64 72 C3 A3 6F
$versao = [System.Text.Encoding]::UTF8.GetString([byte[]](0x56,0x65,0x72,0x73,0xC3,0xA3,0x6F))
$padrao = [System.Text.Encoding]::UTF8.GetString([byte[]](0x70,0x61,0x64,0x72,0xC3,0xA3,0x6F))
$rpt += "**$versao do $padrao**: $Version  "
# "Diretorio" = 44 69 72 65 74 C3 B3 72 69 6F
$diretorio = [System.Text.Encoding]::UTF8.GetString([byte[]](0x44,0x69,0x72,0x65,0x74,0xC3,0xB3,0x72,0x69,0x6F))
$rpt += "**$diretorio analisado**: $Dir  "
$rpt += "**Schema utilizado**: $Schema"
$rpt += ""
$rpt += "---"
$rpt += ""
$rpt += "## Resumo Geral"
$rpt += ""
# "Familia" = F a m iacute l i a
$familia = [System.Text.Encoding]::UTF8.GetString([byte[]](0x46,0x61,0x6D,0xC3,0xAD,0x6C,0x69,0x61))
# "Criterios" = C r i t eacute r i o s
$criterios = [System.Text.Encoding]::UTF8.GetString([byte[]](0x43,0x72,0x69,0x74,0xC3,0xA9,0x72,0x69,0x6F,0x73))
$rpt += "| $familia | $criterios | Checks | PASS | FAIL | WARN |"
$rpt += "|---------|-----------|--------|------|------|------|"

# Section name substrings (ASCII-safe for matching)
$requiredSections = @("Escopo", "Diretrizes", "Crit", "Exemplo", "Valida")

foreach ($Fam in $Families) {
    $FamDir = Join-Path $Dir "$Fam"
    $FamFile = Join-Path $FamDir "ACESSILIA${nbsp}$Fam.md"

    Write-Info "Analisando Familia $Fam..."

    if (-not (Test-Path -LiteralPath $FamFile)) {
        Write-Warn "Arquivo nao encontrado: $FamFile"
        $rpt += "| $Fam | 0 | 0 | 0 | 0 | 1 |"
        $TotalWarn++
        continue
    }

    $content = Get-Content $FamFile -Raw -Encoding UTF8

    # --- Count unique criteria identifiers ---
    $allMatches = [regex]::Matches($content, '^\| (ACL[^\s\|]+)', 'Multiline')
    $uniqueCriteria = @{}
    foreach ($m in $allMatches) {
        $id = $m.Groups[1].Value.Trim()
        if ($id -and -not $uniqueCriteria.ContainsKey($id)) {
            $uniqueCriteria[$id] = $true
        }
    }
    $criteriaCount = $uniqueCriteria.Count

    # --- JSON schema validation ---
    $jsonPass = 0
    $jsonFail = 0
    $jsonFiles = Get-ChildItem -Path $FamDir -Filter "*.json" -ErrorAction SilentlyContinue
    if ($jsonFiles.Count -gt 0) {
        $jsonFile = $jsonFiles[0].FullName
        $nodeScript = "const fs = require('fs'); const schema = JSON.parse(fs.readFileSync('" + $Schema.Replace('\','\\') + "', 'utf8')); const data = JSON.parse(fs.readFileSync('" + $jsonFile.Replace('\','\\') + "', 'utf8')); const required = schema.required || []; const missing = required.filter(function(f) { return !data[f]; }); if (missing.length > 0) { console.error('Missing: ' + missing.join(', ')); process.exit(1); }"
        $result = node -e $nodeScript 2>&1
        if ($LASTEXITCODE -eq 0) { $jsonPass = 1 } else { $jsonFail = 1 }
    }

    # --- RFC 2119 reference check ---
    $rfcPass = if ($content -match "RFC 2119") { 1 } else { 0 }

    # --- Required sections check ---
    $missingSections = @()
    foreach ($section in $requiredSections) {
        if ($content -notmatch [regex]::Escape($section)) {
            $missingSections += $section
        }
    }
    $sectionsPass = if ($missingSections.Count -eq 0) { 1 } else { 0 }

    # --- Calculate totals ---
    $famPass = $criteriaCount + $jsonPass + $rfcPass + $sectionsPass
    $famFail = $jsonFail + $missingSections.Count
    $famChecks = $famPass + $famFail

    $TotalPass += $famPass
    $TotalFail += $famFail

    $rpt += "| $Fam | $criteriaCount | $famChecks | $famPass | $famFail | 0 |"

    if ($famFail -eq 0) {
        Write-Pass "Familia ${Fam}: ${famPass} checks PASS (${criteriaCount} criterios)"
    } else {
        Write-Fail "Familia ${Fam}: ${famPass} PASS, ${famFail} FAIL"
    }
}

$Total = $TotalPass + $TotalFail + $TotalWarn

$rpt += ""
$rpt += "**Total**: $Total checks - $TotalPass PASS, $TotalFail FAIL, $TotalWarn WARN"
$rpt += ""
$rpt += "---"
$rpt += ""
# "Detalhes por familia"
$familiaL = [System.Text.Encoding]::UTF8.GetString([byte[]](0x66,0x61,0x6D,0xC3,0xAD,0x6C,0x69,0x61))
$rpt += "## Detalhes por $familiaL"
$rpt += ""

# --- Detail section for each family ---
foreach ($Fam in $Families) {
    $FamDir = Join-Path $Dir "$Fam"
    $FamFile = Join-Path $FamDir "ACESSILIA${nbsp}$Fam.md"

    if (-not (Test-Path -LiteralPath $FamFile)) { continue }

    $content = Get-Content $FamFile -Raw -Encoding UTF8

    $rpt += "### $familia $Fam"
    $rpt += ""
    $rpt += "**$criterios identificados:**"
    $rpt += ""

    # Extract unique criteria with deduplication
    $allMatches = [regex]::Matches($content, '^\| (ACL[^\s\|]+)', 'Multiline')
    $seen = @{}
    foreach ($m in $allMatches) {
        $cod = $m.Groups[1].Value.Trim()
        if ($cod -and -not $seen.ContainsKey($cod)) {
            $seen[$cod] = $true
            $rpt += "- $cod"
        }
    }
    $rpt += ""

    # RFC 2119 reference
    if ($content -match "RFC 2119") {
        $rpt += "RFC 2119: Referenciado"
    } else {
        $nao = [System.Text.Encoding]::UTF8.GetString([byte[]](0x4E,0xC3,0xA3,0x6F))
        $rpt += "RFC 2119: $nao referenciado"
    }
    $rpt += ""

    # Required sections status
    $secoes = [System.Text.Encoding]::UTF8.GetString([byte[]](0x53,0x65,0xC3,0xA7,0xC3,0xB5,0x65,0x73))
    $obrigatorias = [System.Text.Encoding]::UTF8.GetString([byte[]](0x6F,0x62,0x72,0x69,0x67,0x61,0x74,0xC3,0xB3,0x72,0x69,0x61,0x73))
    $rpt += "**${secoes} ${obrigatorias}:**"
    foreach ($section in $requiredSections) {
        if ($content -match [regex]::Escape($section)) {
            $rpt += "- OK $section"
        } else {
            $rpt += "- FALTA $section"
        }
    }
    $rpt += ""

    # Optional sections status (informational)
    $optionalSections = @("Metadados", "Limita")
    $hasOptional = $false
    $opcionais = [System.Text.Encoding]::UTF8.GetString([byte[]](0x6F,0x70,0x63,0x69,0x6F,0x6E,0x61,0x69,0x73))
    foreach ($section in $optionalSections) {
        if ($content -match [regex]::Escape($section)) {
            if (-not $hasOptional) {
                $rpt += "**${secoes} ${opcionais}:**"
                $hasOptional = $true
            }
            $rpt += "- OK $section"
        }
    }
    if ($hasOptional) { $rpt += "" }
}

# --- Footer ---
$rpt += "---"
$rpt += ""
$informacoes = [System.Text.Encoding]::UTF8.GetString([byte[]](0x49,0x6E,0x66,0x6F,0x72,0x6D,0x61,0xC3,0xA7,0xC3,0xB5,0x65,0x73))
$rpt += "## $informacoes do Ambiente"
$rpt += ""
$rpt += "- **SO**: Windows $([Environment]::OSVersion.Version)"
$rpt += "- **Shell**: PowerShell $($PSVersionTable.PSVersion)"
$rpt += "- **Node.js**: $(node --version 2>$null)"
$rpt += "- **Data/Hora**: $Timestamp"
$rpt += ""
$rpt += "---"
$rpt += ""
$rpt += "*$hdrStr gerado automaticamente pelo ACESSILIA Lint Demo v$Version*"

$rpt | Out-File -FilePath $Output -Encoding UTF8

Write-Host ""
Write-Info "========================================="
Write-Info "RELATORIO GERADO COM SUCESSO"
Write-Info "========================================="
Write-Info "Arquivo: $Output"
Write-Info "Total: $Total checks - $TotalPass PASS, $TotalFail FAIL, $TotalWarn WARN"

if ($TotalFail -gt 0) {
    Write-Fail "Existem $TotalFail falhas que precisam ser corrigidas."
    exit 1
} else {
    Write-Pass "Todos os checks passaram!"
    exit 0
}
