# ACESSILIA‑Base – Modelo Central de Referência

> **RFC 2119**: Os termos **DEVE**, **NÃO DEVE**, **PODE** e **RECOMENDA‑SE** devem ser interpretados conforme [RFC 2119](https://tools.ietf.org/html/rfc2119) e [RFC 8174](https://tools.ietf.org/html/rfc8174).

## Sumário

- [1. Objetivo](#1-objetivo)
- [2. Estrutura de Inclusão](#2-estrutura-de-inclusão)
- [3. Versionamento](#3-versionamento)
- [4. Fluxo de Revisões](#4-fluxo-de-revisões)
- [5. Identificadores Permanentes](#5-identificadores-permanentes)
- [6. Manifesto de Famílias](#6-manifesto-de-famílias)
- [7. Validação Automatizada](#7-validação-automatizada)

## 1. Objetivo
Este documento descreve a arquitetura modular do ACESSILIA, os mecanismos de versionamento e as regras de inclusão entre módulos.

## 2. Estrutura de Inclusão

Os módulos individuais (famílias) são incluídos em contexto de uso via sintaxe de Markdown:

```markdown
![ACESSILIA 200](/families/200/ACESSILIA‑200.md)
```

Para garantir a consistência, o conteúdo de cada família **DEVE** começar com um *header* que identifique a família (ex.: `# ACESSILIA‑200 – Descrição de Imagens Estáticas`).

**Exemplo de inclusão em um relatório completo:**

```markdown
# ACESSILIA‑Specification – Conteúdo Acessível

![ACESSILIA 200](/families/200/ACESSILIA‑200.md)
![ACESSILIA 300](/families/300/ACESSILIA‑300.md)
![ACESSILIA 400](/families/400/ACESSILIA‑400.md)
```

Escreva a descrição final concatenando ou importando os arquivos desejados.

## 3. Versionamento

| Categoria | Descrição | Exemplo |
|-----------|-----------|---------|
| MAJOR | Mudança de estrutura ou introdução de nova família. | Adição de nova família (ex.: 800 quando disponível). |
| MINOR | Adição ou alteração de critério dentro de uma família. | Novo critério `ACL‑200‑IMG‑008`. |
| PATCH | Correção editorial ou pequenas melhorias de redação. | Correção de tipografia. |

## 4. Fluxo de Revisões

| Fase | Descrição |
|------|-----------|
| **Draft** | Proposta não oficial. |
| **Working Draft** | Revisão interna pelo comitê técnico. |
| **Candidate Recommendation** | Comentários de stakeholders externos. |
| **Recommendation** | Apto para publicação oficial. |

> Todos os documentos **DEVEM** usar *RFC 2119* para expressões como **DEVE** e **NÃO DEVE**.

## 5. Identificadores Permanentes

Os identificadores seguem o padrão `ACL‑<FAMÍLIA>-<TIPO>-<NÚMERO>`.

| Família | Padrão | Exemplo |
|---------|--------|---------|
| 200 | `ACL‑200‑IMG‑NNN` | `ACL‑200‑IMG‑001` |
| 300 | `ACL‑300‑GRF‑NNN` | `ACL‑300‑GRF‑001` |
| 400 | `ACL‑400‑SCI‑NNN` | `ACL‑400‑SCI‑001` |
| 500 | `ACL‑500‑EDU‑NNN` | `ACL‑500‑EDU‑001` |
| 600 | `ACL‑600‑MDM‑NNN` | `ACL‑600‑MDM‑001` |
| 700 | `ACL‑700‑VAL‑NNN` | `ACL‑700‑VAL‑001` |
| 800 | `ACL‑800‑PRF‑NNN` | `ACL‑800‑PRF‑001` |

Estes IDs são **fixos** e não mudam entre versões.

## 6. Manifesto de Famílias

O arquivo **`manifest.yml`** lista todas as famílias existentes, sua ordem de importação e controla a versão do `ACESSILIA‑Base`.

```yaml
families:
  - id: 100
    title: "Terminologia e Princípios Fundamentais"
    path: "ACESSILIA-100.md"
    requires: []
  - id: 200
    title: "Descrição de Imagens Estáticas"
    path: "families/200/ACESSILIA‑200.md"
    requires: [100]
  - id: 300
    title: "Gráficos, Tabelas e Diagramas"
    path: "families/300/ACESSILIA‑300.md"
    requires: [100]
  - id: 400
    title: "Conteúdo Científico"
    path: "families/400/ACESSILIA‑400.md"
    requires: [100]
  - id: 500
    title: "Conteúdo Educacional"
    path: "families/500/ACESSILIA‑500.md"
    requires: [100]
  - id: 600
    title: "Conteúdo Multimídia"
    path: "families/600/ACESSILIA‑600.md"
    requires: [100]
  - id: 700
    title: "Validação e Conformidade"
    path: "families/700/ACESSILIA‑700.md"
    requires: [100, 200, 300, 400, 500, 600]
  - id: 800
    title: "Perfis de Acessibilidade e Conformidade"
    path: "families/800/ACESSILIA‑800.md"
    requires: [100, 200, 300, 400, 500, 600, 700]
```

## 7. Validação Automatizada

Uma ferramenta de lint, **`acessilia-lint`**, **DEVE** ser fornecida. Ela:

1. Carrega **`schemas/acessilia.schema.json`**.
2. Executa validação de metadados em arquivos JSON ou XML.
3. Verifica regras de conteúdo por família (verbos ativos, ausência de emoções, etc.).
4. Gera relatório em formato Markdown indicando falhas, warnings e sugestões.
5. Pode ser integrável em CI (GitHub Actions, GitLab CI).

### 7.1 Exemplo de Integração em CI

```yaml
# .github/workflows/acessilia-lint.yml
name: ACESSILIA Lint
on: [push, pull_request]
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
      - name: Install dependencies
        run: npm install
      - name: Run ACESSILIA Lint
        run: |
          npx acessilia-lint \
            --schema schemas/acessilia.schema.json \
            --dir ./families \
            --output relatorio-conformidade.md
      - name: Upload Report
        uses: actions/upload-artifact@v4
        with:
          name: acessilia-report
          path: relatorio-conformidade.md
```

### 7.2 Exemplo de Execução Local

```bash
# Validar todas as famílias
acessilia-lint \
  --schema schemas/acessilia.schema.json \
  --dir ./families \
  --output relatorio-conformidade.md

# Validar uma família específica
acessilia-lint \
  --schema schemas/acessilia.schema.json \
  --dir ./families/200 \
  --output relatorio-familia200.md

# Validação com modo verboso
acessilia-lint \
  --schema schemas/acessilia.schema.json \
  --dir ./families \
  --verbose \
  --output relatorio-detalhado.md
```

### 7.3 Formato do Relatório

O relatório gerado **DEVE** seguir o formato abaixo:

```markdown
# Relatório de Conformidade ACESSILIA

**Data**: 2026-07-14  
**Versão do padrão**: 1.0.0  
**Famílias analisadas**: 200, 300, 400, 500, 600, 700

## Resumo

| Família | Total de Critérios | PASS | FAIL | WARN |
|---------|-------------------|------|------|------|
| 200 | 7 | 7 | 0 | 0 |
| 300 | 5 | 5 | 0 | 0 |
| 400 | 4 | 4 | 0 | 0 |
| 500 | 4 | 4 | 0 | 0 |
| 600 | 5 | 5 | 0 | 0 |
| 700 | 5 | 5 | 0 | 0 |

## Detalhes por Família

### Família 200 – Imagens Estáticas

| Critério | Resultado | Observação |
|----------|-----------|------------|
| ACL-200-IMG-001 | PASS | Verbos observáveis detectados. |
| ACL-200-IMG-002 | PASS | Nenhum termo de emoção encontrado. |
| ... | ... | ... |
```
