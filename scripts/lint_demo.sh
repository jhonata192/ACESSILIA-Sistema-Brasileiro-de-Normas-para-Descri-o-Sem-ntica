#!/bin/bash
# =============================================================================
# ACESSILIA Lint Demo Script
# =============================================================================
# Este script demonstra como executar a validação automática do padrão ACESSILIA.
# Uso: ./lint_demo.sh [diretorio] [schema] [output]
#
# Exemplos:
#   ./lint_demo.sh                              # Usa valores padrão
#   ./lint_demo.sh ./families ./schemas/acessilia.schema.json ./relatorio.md
# =============================================================================

set -euo pipefail

# ─── Configurações Padrão ───────────────────────────────────────────────────
DIR="${1:-./families}"
SCHEMA="${2:-./schemas/acessilia.schema.json}"
OUTPUT="${3:-./relatorio-conformidade.md}"
FAMILIES=(200 300 400 500 600 700 800)
VERSION="1.0.0"
DATE=$(date +%Y-%m-%d)

# ─── Cores para Terminal ────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ─── Funções Auxiliares ─────────────────────────────────────────────────────
log_info()  { echo -e "${BLUE}[INFO]${NC} $1"; }
log_pass()  { echo -e "${GREEN}[PASS]${NC} $1"; }
log_fail()  { echo -e "${RED}[FAIL]${NC} $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }

# ─── Verificação de Dependências ────────────────────────────────────────────
log_info "Verificando dependências..."

if ! command -v node &> /dev/null; then
    log_fail "Node.js não encontrado. Instale em https://nodejs.org"
    exit 1
fi

if [ ! -f "$SCHEMA" ]; then
    log_fail "Schema não encontrado: $SCHEMA"
    exit 1
fi

if [ ! -d "$DIR" ]; then
    log_fail "Diretório não encontrado: $DIR"
    exit 1
fi

log_info "Node.js: $(node --version)"
log_info "Schema: $SCHEMA"
log_info "Diretório: $DIR"

# ─── Início do Relatório ────────────────────────────────────────────────────
log_info "Gerando relatório em $OUTPUT..."

cat > "$OUTPUT" << EOF
# Relatório de Conformidade ACESSILIA

**Data**: $DATE  
**Versão do padrão**: $VERSION  
**Diretório analisado**: $DIR  
**Schema utilizado**: $SCHEMA

---

## Resumo Geral

| Família | Total de Critérios | PASS | FAIL | WARN |
|---------|-------------------|------|------|------|
EOF

# ─── Validação por Família ──────────────────────────────────────────────────
TOTAL_PASS=0
TOTAL_FAIL=0
TOTAL_WARN=0

for FAM in "${FAMILIES[@]}"; do
    FAM_DIR="$DIR/$FAM"
    FAM_FILE="$FAM_DIR/ACESSILIA‑$FAM.md"

    log_info "Analisando Família $FAM..."

    if [ ! -f "$FAM_FILE" ]; then
        log_warn "Arquivo não encontrado: $FAM_FILE"
        echo "| $FAM | 0 | 0 | 0 | 1 |" >> "$OUTPUT"
        ((TOTAL_WARN++))
        continue
    fi

    # Contagem de critérios (linhas com ACL-)
    CRITERIA=$(grep -c "^| ACL‑" "$FAM_FILE" 2>/dev/null || echo "0")

    # Validação de esquema JSON (se houver metadados)
    JSON_FILE=$(find "$FAM_DIR" -name "*.json" 2>/dev/null | head -1)
    SCHEMA_PASS=0
    SCHEMA_FAIL=0

    if [ -n "$JSON_FILE" ]; then
        if node -e "
            const fs = require('fs');
            const schema = JSON.parse(fs.readFileSync('$SCHEMA', 'utf8'));
            const data = JSON.parse(fs.readFileSync('$JSON_FILE', 'utf8'));
            // Validação básica de campos obrigatórios
            const required = schema.required || [];
            const missing = required.filter(f => !data[f]);
            if (missing.length > 0) {
                console.error('Campos faltando:', missing.join(', '));
                process.exit(1);
            }
        " 2>/dev/null; then
            SCHEMA_PASS=1
        else
            SCHEMA_FAIL=1
        fi
    fi

    # Validação de RFC 2119
    RFC_PASS=0
    if grep -q "RFC 2119" "$FAM_FILE" 2>/dev/null; then
        RFC_PASS=1
    fi

    # Validação de seções obrigatórias
    SECTIONS_PASS=0
    REQUIRED_SECTIONS=("Escopo" "Diretrizes" "Critérios Obrigatórios" "Exemplos" "Metadados" "Validação")
    MISSING_SECTIONS=()
    for SECTION in "${REQUIRED_SECTIONS[@]}"; do
        if ! grep -q "$SECTION" "$FAM_FILE" 2>/dev/null; then
            MISSING_SECTIONS+=("$SECTION")
        fi
    done
    if [ ${#MISSING_SECTIONS[@]} -eq 0 ]; then
        SECTIONS_PASS=1
    fi

    # Cálculo de resultados
    FAM_PASS=$((CRITERIA + SCHEMA_PASS + RFC_PASS + SECTIONS_PASS))
    FAM_FAIL=$((SCHEMA_FAIL + ${#MISSING_SECTIONS[@]}))
    FAM_WARN=0

    TOTAL_PASS=$((TOTAL_PASS + FAM_PASS))
    TOTAL_FAIL=$((TOTAL_FAIL + FAM_FAIL))
    TOTAL_WARN=$((TOTAL_WARN + FAM_WARN))

    echo "| $FAM | $CRITERIA | $FAM_PASS | $FAM_FAIL | $FAM_WARN |" >> "$OUTPUT"

    if [ $FAM_FAIL -eq 0 ]; then
        log_pass "Família $FAM: $FAM_PASS checks PASS"
    else
        log_fail "Família $FAM: $FAM_PASS PASS, $FAM_FAIL FAIL"
    fi
done

# ─── Resumo Final ───────────────────────────────────────────────────────────
TOTAL=$((TOTAL_PASS + TOTAL_FAIL + TOTAL_WARN))

cat >> "$OUTPUT" << EOF

**Total**: $TOTAL checks ($TOTAL_PASS PASS, $TOTAL_FAIL FAIL, $TOTAL_WARN WARN)

---

## Detalhes por Família

EOF

# ─── Detalhes por Família ───────────────────────────────────────────────────
for FAM in "${FAMILIES[@]}"; do
    FAM_FILE="$DIR/$FAM/ACESSILIA‑$FAM.md"

    if [ ! -f "$FAM_FILE" ]; then
        continue
    fi

    cat >> "$OUTPUT" << EOF
### Família $FAM

EOF

    # Listar critérios encontrados
    echo "**Critérios identificados:**" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    grep "^| ACL‑" "$FAM_FILE" 2>/dev/null | while IFS='|' read -r _ COD _; do
        COD=$(echo "$COD" | xargs)
        if [ -n "$COD" ]; then
            echo "- \`$COD\`" >> "$OUTPUT"
        fi
    done
    echo "" >> "$OUTPUT"

    # Verificar RFC 2119
    if grep -q "RFC 2119" "$FAM_FILE" 2>/dev/null; then
        echo "✅ RFC 2119: Referenciado" >> "$OUTPUT"
    else
        echo "❌ RFC 2119: Não referenciado" >> "$OUTPUT"
    fi

    # Verificar seções obrigatórias
    echo "**Seções:**" >> "$OUTPUT"
    for SECTION in "${REQUIRED_SECTIONS[@]}"; do
        if grep -q "$SECTION" "$FAM_FILE" 2>/dev/null; then
            echo "- ✅ $SECTION" >> "$OUTPUT"
        else
            echo "- ❌ $SECTION (ausente)" >> "$OUTPUT"
        fi
    done
    echo "" >> "$OUTPUT"
done

# ─── Rodapé ─────────────────────────────────────────────────────────────────
cat >> "$OUTPUT" << EOF
---

## Informações do Ambiente

- **OS**: $(uname -s) $(uname -r)
- **Shell**: $SHELL
- **Node.js**: $(node --version 2>/dev/null || echo "N/A")
- **Data/Hora**: $(date)

---

*Relatório gerado automaticamente pelo ACESSILIA Lint Demo v$VERSION*
EOF

# ─── Resultado ──────────────────────────────────────────────────────────────
echo ""
log_info "========================================="
log_info "RELATÓRIO GERADO COM SUCESSO"
log_info "========================================="
log_info "Arquivo: $OUTPUT"
log_info "Total: $TOTAL checks ($TOTAL_PASS PASS, $TOTAL_FAIL FAIL, $TOTAL_WARN WARN)"
echo ""

if [ $TOTAL_FAIL -gt 0 ]; then
    log_fail "Existem $TOTAL_FAIL falhas que precisam ser corrigidas."
    exit 1
else
    log_pass "Todos os checks passaram!"
    exit 0
fi
