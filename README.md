# ACESSILIA — Sistema Brasileiro de Normas para Descricao Semantica

> **Versao**: 1.1.0 · **Data**: 2026-07-16  
> **RFC 2119/8174**: Os termos **DEVE**, **NAO DEVE**, **PODE** e **RECOMENDA-SE** seguem [RFC 2119](https://tools.ietf.org/html/rfc2119) e [RFC 8174](https://tools.ietf.org/html/rfc8174).

---

## Sumario

- [1. O Que e ACESSILIA](#1-o-que-e-acessilia)
- [2. Por Que ACESSILIA](#2-por-que-acessilia)
- [3. Arquitetura do Padrao](#3-arquitetura-do-padrao)
- [4. Terminologia Resumida](#4-terminologia-resumida)
- [5. Famlias de Conteudo](#5-famlias-de-conteudo)
- [6. Niveis de Conformidade](#6-niveis-de-conformidade)
- [7. Identificadores Permanentes](#7-identificadores-permanentes)
- [8. Como Comecar](#8-como-comecar)
- [9. Validacao e Ferramentas](#9-validacao-e-ferramentas)
- [10. Conformidade com Pardoes Externos](#10-conformidade-com-pardoes-externos)
- [11. Estrutura do Repositorio](#11-estrutura-do-repositorio)
- [12. Fluxo de Revisao](#12-fluxo-de-revisao)
- [13. Contribuindo](#13-contribuindo)
- [14. Licenca](#14-licenca)
- [15. Contato](#15-contato)

---

## 1. O Que e ACESSILIA

**ACESSILIA** (*Sistema Brasileiro de Normas para Descricao Semantica*) e um padrao tecnico brasileiro que define regras para a elaboracao de descricoes semanticas acessiveis de conteudos visuais, graficos, cientificos, educacionais e multimidia.

O padrao fornece:

- **Descricoes objetivas**: texte que relata apenas o que e observavel diretamente no conteudo.
- **Metadata estruturados**: dados em JSON/XML que acompanham a descricao textual.
- **Validacao automatizada**: ferramentas de lint que verificam conformidade com o esquema e regras.
- **Auditoria**: procedimentos de revisao humana para garantir qualidade.

> O objetivo do ACESSILIA e assegurar que descricoes semanticas sejam objetivas, reproduziveis, verificaveis, consistentes e livres de vieses, sendo compativeis tanto com revisao humana quanto automatizada.

---

## 2. Por Que ACESSILIA

| Problema | Solucao ACESSILIA |
|----------|-------------------|
| Descricoes subjetivas e com inferencias | Regras de **Objetividade** e **Fidelidade** (ACESSILIA-100) |
| Inconsistencia entre descritores | Padronizacao de **terminologia** e **estrutura** |
| Ausencia de metadata | **Esquemas JSON/XSD** com campos obrigatorios |
| Dificuldade de verificacao automatizada | **acessilia-lint** com regras por familia |
| Falta de rastreabilidade | **Identificadores permanentes** (`ACL-<FAM>-<TIPO>-<NUM>`) |
| Incompatibilidade com normas externas | Mapeamento para **WCAG 2.2**, **EPUB 3**, **PDF/UA-1** |

---

## 3. Arquitetura do Padrao

O ACESSILIA e modular. Cada **Família** (Family) e um modulo independente com regras especificas para um tipo de conteudo:

```
ACESSILIA-Base (arquitetura central)
    │
    ├── ACESSILIA-100 (terminologia e principios)
    ├── ACESSILIA-200 (imagens estaticas)
    ├── ACESSILIA-300 (graficos, tabelas e diagramas)
    ├── ACESSILIA-400 (conteudo cientifico)
    ├── ACESSILIA-500 (conteudo educacional)
    ├── ACESSILIA-600 (conteudo multimidia)
    ├── ACESSILIA-700 (validacao e conformidade)
    └── ACESSILIA-800 (perfis de acessibilidade)
```

O arquivo **`manifest.yml`** atua como catalogo de familias e controla a ordem de importacao.

---

## 4. Terminologia Resumida

> Para o glossario completo, consulte [ACESSILIA-100 Secao 6](ACESSILIA-100.md#6-glossario).  
> Para o guia completo de terminologia, consulte [TERMINOLOGY_GUIDE.md](TERMINOLOGY_GUIDE.md).

### 4.1 Termos Fundamentais

| Termo | Definicao Resumida |
|-------|-------------------|
| **Família** (Family) | Conjunto de regras aplicaveis a um tipo especifico de conteudo (ex.: 200 para imagens). |
| **Critério** (Criterion) | Regra especifica com identificador permanente, evidencia obrigatoria e ponto de verificacao. |
| **Metadata** | Dados estruturados (JSON/XML) que acompanham a descricao textual. |
| **Conformidade** (Conformity) | Estado de atendimento a todos os criterios obrigatorios aplicaveis. |
| **Validação** (Validation) | Processo de verificar se conteudo e metadata atendem aos requisitos. |
| **Auditoria** (Audit) | Revisao humana independente para validar conformidade alem da validacao automatica. |

### 4.2 Principios

| Principio | Descricao |
|-----------|-----------|
| **Objetividade** | Relatar apenas o que e observavel diretamente. |
| **Fidelidade** | Descricao sem informacoes sem evidencia observavel. |
| **Clareza** | Linguagem objetiva, livre de ambiguidade e sem juizo de valor. |
| **Consistencia** | Uso uniforme de termos e estrutura em todo o documento. |
| **Reprodutibilidade** | Descritores independentes chegam a resultados equivalentes (>= 85%). |
| **Neutralidade** | Nao expressar opiniao ou preferencia pessoal na descricao. |

### 4.3 Termos Operacionais

| Termo | Definicao Resumida |
|-------|-------------------|
| **Escopo** (Scope) | Delimitacao do tipo de conteudo ao qual se aplicam as regras. |
| **Diretriz** (Guideline) | Regra qualitativa que orienta a elaboracao de descricoes. |
| **Evidência** (Evidence) | Dado observavel que sustenta uma afirmacao na descricao. |
| **Perfil** (Profile) | Conjunto de criterios especificos para um tipo de conteudo ou cenario. |
| **Extensão** (Extension) | Mecanismo pelo qual novos perfis adicionam criterios. |
| **Rastreabilidade** (Traceability) | Capacidade de rastrear cada criterio por seu identificador permanente. |

> **Convencoes de Nomenclatura**: Campos de metadata JSON utilizam nomenclatura em ingles (`description`, `license`, `imageType`, etc.) independentemente do idioma da documentacao.

---

## 5. Familias de Conteudo

| Familia | Titulo | Descricao | Caminho |
|---------|--------|-----------|---------|
| **100** | Terminologia e Principios Fundamentais | Glossario, principios e taxonomia | [ACESSILIA-100.md](ACESSILIA-100.md) |
| **200** | Descricao de Imagens Estaticas | JPEG, PNG, SVG, GIF, TIFF, WebP | [families/200/](families/200/ACESSILIA%E2%80%91200.md) |
| **300** | Graficos, Tabelas e Diagramas | Representacoes visuais de dados | [families/300/](families/300/ACESSILIA%E2%80%91300.md) |
| **400** | Conteudo Cientifico | Artigos, teses, relatorios tecnicos | [families/400/](families/400/ACESSILIA%E2%80%91400.md) |
| **500** | Conteudo Educacional | Materiais didaticos e recursos pedagogicos | [families/500/](families/500/ACESSILIA%E2%80%91500.md) |
| **600** | Conteudo Multimidia | Videos, animacoes, podcasts | [families/600/](families/600/ACESSILIA%E2%80%91600.md) |
| **700** | Validacao e Conformidade | Metricas e procedimentos de validacao | [families/700/](families/700/ACESSILIA%E2%80%91700.md) |
| **800** | Perfis de Acessibilidade e Conformidade | Niveis de conformidade e extensoes | [families/800/](families/800/ACESSILIA%E2%80%91800.md) |

### 5.1 Dependencias entre Familias

```
100 (base obrigatoria)
 ├── 200 (imagens)
 ├── 300 (graficos)
 ├── 400 (cientifico)
 ├── 500 (educacional)
 ├── 600 (multimidia)
 ├── 700 (validacao) ──── requer 100, 200-600
 └── 800 (perfis) ─────── requer 100, 200-700
```

---

## 6. Niveis de Conformidade

| Nivel | Escopo | Descricao |
|-------|--------|-----------|
| **ACESSILIA-A** | Basico | Todos os criterios obrigatorios das familias 200-700. |
| **ACESSILIA-AA** | Intermediario | Criterios obrigatorios + criterios de importancia alta de todas as familias. |
| **ACESSILIA-AAA** | Avancado | Todos os criterios (obrigatorios e recomendados) de todas as familias. |

### 6.1 Requisitos por Nivel

| Nivel | Fam. 200 | Fam. 300 | Fam. 400 | Fam. 500 | Fam. 600 | Fam. 700 |
|-------|----------|----------|----------|----------|----------|----------|
| **A** | Obrigatorios | Obrigatorios | Obrigatorios | Obrigatorios | Obrigatorios | Obrigatorios |
| **AA** | Obr. + Alta | Obr. + Alta | Obr. + Alta | Obr. + Alta | Obr. + Alta | Obr. + Alta |
| **AAA** | Todos | Todos | Todos | Todos | Todos | Todos |

### 6.2 Mapeamento com WCAG 2.2

| Nivel ACESSILIA | WCAG 2.2 | EPUB Accessibility | PDF/UA-1 | EN 301 549 | Section 508 |
|-----------------|----------|-------------------|----------|------------|-------------|
| **A** | Level A | WCAG Level A conformance | Secoes 7.1-7.5 basicos | Clausulas 5-6 | Secao 1194.41 |
| **AA** | Level AA | WCAG Level AA conformance | Conformidade completa | Clausulas 5-9 | Secao 1194.41-42 |
| **AAA** | Level AAA | WCAG Level AAA conformance | Excedente | Clausulas 5-12 | Excedente |

> Implementacoes que nao atendam integralmente ao nivel declarado **NAO DEVEM** declarar conformidade.

---

## 7. Identificadores Permanentes

Os identificadores seguem o padrao `ACL-<FAMILIA>-<TIPO>-<NUMERO>`:

| Familia | Padrao | Exemplo |
|---------|--------|---------|
| 100 | `ACL-100-T-NNN` | `ACL-100-T001` |
| 200 | `ACL-200-IMG-NNN` | `ACL-200-IMG-001` |
| 300 | `ACL-300-GRF-NNN` | `ACL-300-GRF-001` |
| 400 | `ACL-400-SCI-NNN` | `ACL-400-SCI-001` |
| 500 | `ACL-500-EDU-NNN` | `ACL-500-EDU-001` |
| 600 | `ACL-600-MDM-NNN` | `ACL-600-MDM-001` |
| 700 | `ACL-700-VAL-NNN` | `ACL-700-VAL-001` |
| 800 | `ACL-800-PRF-NNN` | `ACL-800-PRF-001` |

> Estes IDs sao **fixos** e nao mudam entre versoes.

---

## 8. Como Comecar

### 8.1 Para Descritores

1. Leia [ACESSILIA-Base](ACESSILIA-Base.md) para entender a arquitetura.
2. Estude [ACESSILIA-100](ACESSILIA-100.md) para dominar terminologia e principios.
3. Consulte a familia correspondente ao tipo de conteudo que voce ira descrever.
4. Siga os criterios obrigatorios e gere metadata em JSON.
5. Valide com `acessilia-lint` antes de submeter.

### 8.2 Para Implementadores

1. Implemente validacao de esquema com `schemas/acessilia.schema.json`.
2. Integre `acessilia-lint` no seu fluxo de CI/CD.
3. Gere relatorios de conformidade para cada familia.
4. Declare o nivel de conformidade (A, AA ou AAA) nos metadata.

### 8.3 Para Revisores

1. Use a [Familia 700](families/700/ACESSILIA%E2%80%91700.md) como referencia para metricas de qualidade.
2. Aplique revisao humana para criterios de importancia alta.
3. Documente discordancias e resolucoes no relatorio.

---

## 9. Validacao e Ferramentas

### 9.1 acessilia-lint

O `acessilia-lint` e a ferramenta oficial de validacao automatizada:

```bash
# Validar todas as familias
acessilia-lint \
  --schema schemas/acessilia.schema.json \
  --dir ./families \
  --output relatorio-conformidade.md

# Validar uma familia especifica
acessilia-lint \
  --schema schemas/acessilia.schema.json \
  --dir ./families/200 \
  --output relatorio-familia200.md

# Validacao com modo verboso
acessilia-lint \
  --schema schemas/acessilia.schema.json \
  --dir ./families \
  --verbose \
  --output relatorio-detalhado.md
```

### 9.2 Integracao em CI (GitHub Actions)

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
      - name: Run ACESSILIA Lint
        run: |
          chmod +x scripts/lint_demo.sh
          ./scripts/lint_demo.sh ./families ./schemas/acessilia.schema.json ./relatorio-conformidade.md
      - name: Upload Report
        uses: actions/upload-artifact@v4
        with:
          name: acessilia-report
          path: relatorio-conformidade.md
```

### 9.3 Formato do Relatorio

O relatorio gerado **DEVE** seguir o formato:

```markdown
# Relatorio de Conformidade ACESSILIA

**Data**: YYYY-MM-DD
**Versao do padrao**: X.Y.Z
**Familias analisadas**: 200, 300, 400, 500, 600, 700

## Resumo

| Familia | Total de Criterios | PASS | FAIL | WARN |
|---------|-------------------|------|------|------|
| 200 | 7 | 7 | 0 | 0 |
| ... | ... | ... | ... | ... |

## Detalhes por Familia

### Familia 200 - Imagens Estaticas

| Criterio | Resultado | Observacao |
|----------|-----------|------------|
| ACL-200-IMG-001 | PASS | Verbos observaveis detectados. |
| ... | ... | ... |
```

### 9.4 Scripts de Demo

- **PowerShell**: [scripts/lint_demo.ps1](scripts/lint_demo.ps1)
- **Bash**: [scripts/lint_demo.sh](scripts/lint_demo.sh)

---

## 10. Conformidade com Pardoes Externos

| Padrao | Escopo | Familia(s) Aplicavel(is) |
|--------|--------|--------------------------|
| [WCAG 2.2](https://www.w3.org/TR/WCAG22/) | Acessibilidade web | 200, 300, 400, 500, 600 |
| [EPUB 3](https://www.w3.org/TR/epub-33/) | Publicacoes acessiveis | 200, 300, 400, 500, 600 |
| [PDF/UA-1](https://www.iso.org/standard/64599.html) | Documentos PDF acessiveis | 200, 300, 400, 500 |
| [EN 301 549 v3.2.1](https://www.etsi.org/deliver/etsi_en/301500_301599/301549/03.02.01_60/en_301549v030201p.pdf) | Requisitos europeus | Todas |
| [Section 508](https://www.section508.gov/) | Acessibilidade governamental (EUA) | Todas |

---

## 11. Estrutura do Repositorio

```
ACESSILIA/
├── ACESSILIA-Base.md          # Arquitetura central e versionamento
├── ACESSILIA-100.md           # Terminologia e principios fundamentais
├── ACESSILIA-Index.md         # Indice de navegacao
├── ACESSILIA_SPEC_CH01.txt    # Especificacao tecnica original (draft)
├── TERMINOLOGY_GUIDE.md       # Guia de terminologia
├── manifest.yml               # Catalogo de familias
├── schemas/
│   ├── acessilia.schema.json  # Esquema JSON para validacao
│   ├── acessilia.xsd          # Esquema XSD
│   └── elementTypes.schema.json
├── scripts/
│   ├── lint_demo.ps1          # Script PowerShell de demo
│   └── lint_demo.sh           # Script Bash de demo
└── families/
    ├── 200/
    │   └── ACESSILIA-200.md   # Imagens estaticas
    ├── 300/
    │   └── ACESSILIA-300.md   # Graficos, tabelas e diagramas
    ├── 400/
    │   └── ACESSILIA-400.md   # Conteudo cientifico
    ├── 500/
    │   └── ACESSILIA-500.md   # Conteudo educacional
    ├── 600/
    │   └── ACESSILIA-600.md   # Conteudo multimidia
    ├── 700/
    │   └── ACESSILIA-700.md   # Validacao e conformidade
    └── 800/
        ├── ACESSILIA-800.md   # Perfis de acessibilidade
        └── ACESSILIA-800.yml  # Perfis definidos em formato YAML
```

---

## 12. Fluxo de Revisao

```
Draft -> Working Draft -> Candidate Recommendation -> Recommendation
```

| Fase | Descricao |
|------|-----------|
| **Draft** | Proposta nao oficial. |
| **Working Draft** | Revisao interna pelo comite tecnico. |
| **Candidate Recommendation** | Comentarios de stakeholders externos. |
| **Recommendation** | Apto para publicacao oficial. |

### 12.1 Versionamento

| Categoria | Descricao | Exemplo |
|-----------|-----------|---------|
| **MAJOR** | Mudanca de estrutura ou introducao de nova familia. | Adicao de nova familia (ex.: familia 900 quando disponivel). |
| **MINOR** | Adicao ou alteracao de criterio dentro de uma familia. | Novo criterio `ACL-200-IMG-008`. |
| **PATCH** | Correcao editorial ou pequenas melhorias de redacao. | Correcao de tipografia. |

---

## 13. Contribuindo

1. Abra uma issue no repositorio para discutir a proposta.
2. Fork o repositorio e crie uma branch para sua alteracao.
3. Siga as convencoes de terminologia do [TERMINOLOGY_GUIDE.md](TERMINOLOGY_GUIDE.md).
4. Execute `acessilia-lint` para verificar conformidade.
5. Envie um Pull Request com descricao clara da alteracao.

> Para sugestoes de terminologia, consulte a secao [1.2 Termos Preferidos vs. Depreciados](TERMINOLOGY_GUIDE.md#12-preferred-vs-deprecated-terms) do Guia de Terminologia.

---

## 14. Licenca

Este documento pode ser utilizado gratuitamente para implementacao, pesquisa e ensino, mantendo referencia ao projeto ACESSILIA.

---

## 15. Contato

Para sugestoes, abra uma issue no repositorio ou contate o comite tecnico ACESSILIA.
