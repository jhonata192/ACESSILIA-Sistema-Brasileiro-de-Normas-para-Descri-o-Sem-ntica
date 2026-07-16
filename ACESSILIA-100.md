# ACESSILIA‑100 – Terminologia e Princípios Fundamentais

> **RFC 2119**: Os termos **DEVE**, **NÃO DEVE**, **PODE** e **RECOMENDA‑SE** devem ser interpretados conforme [RFC 2119](https://tools.ietf.org/html/rfc2119) e [RFC 8174](https://tools.ietf.org/html/rfc8174).

## Sumário

- [1. Terminologia](#1-terminologia)
- [2. Princípios Fundamentais](#2-princípios-fundamentais)
- [3. Taxonomia de Elementos de Descrição](#3-taxonomia-de-elementos-de-descrição)
- [4. Requisitos de Auditoria](#4-requisitos-de-auditoria)
- [5. Identificadores Permanentes](#5-identificadores-permanentes)
- [6. Glossário](#6-glossário)

## 1. Terminologia

| Termo | Definição |
|-------|-----------|
| **Objetividade** | A descrição **DEVE** relatar apenas o que pode ser observado diretamente. |
| **Fidelidade** | A descrição **NÃO DEVE** conter informações sem evidência observável. |
| **Clareza** | A linguagem **DEVE** ser objetiva, livre de ambiguidade e sem juízo de valor. |
| **Consistência** | O uso de termos e estrutura **DEVE** ser uniforme em todo o documento. |
| **Reprodutibilidade** | Diferentes descritores independentes **DEVEM** chegar a resultados equivalentes (≥ 85%). |

## 2. Princípios Fundamentais

| Princípio | RFC 2119 Designação | Descrição |
|-----------|----------------------|-----------|
| Neutralidade | DEVE | A descrição **NÃO DEVE** expressar opinião ou preferência pessoal. |
| Fidelidade | DEVE | A descrição **DEVE** corresponder fielmente ao conteúdo observado. |
| Claridade | DEVE | A linguagem **DEVE** ser compreensível pelo público-alvo. |
| Consistência | DEVE | Termos e estrutura **DEVEM** ser uniformes em todas as famílias. |
| Reprodutibilidade | DEVE | Resultados equivalentes **DEVEM** ser obtidos por descritores independentes. |

## 3. Taxonomia de Elementos de Descrição

O arquivo **`manifest.yml`** atua como catálogo de famílias e controla a ordem de importação.

| Elemento | Família | Descrição |
|----------|---------|-----------|
| `ImageDescription` | 200 | Descrição de imagens estáticas. |
| `ChartDescription` | 300 | Descrição de gráficos, tabelas e diagramas. |
| `ScientificContent` | 400 | Descrição de conteúdo científico. |
| `EducationalContent` | 500 | Descrição de conteúdo educacional. |
| `MultimediaDescriptor` | 600 | Descrição de conteúdo multimídia. |
| `ValidationConformity` | 700 | Validação e conformidade. |
| `AccessibilityProfile` | 800 | Perfis de acessibilidade e conformidade. |
| `Terminology` | 100 | Identificadores de terminologia e princípios fundamentais. |

## 4. Requisitos de Auditoria

Para garantir a rastreabilidade e a auditabilidade dos requisitos, cada critério recebe um identificador permanente, um índice de importância e um ponto de verificação de validação.

| Identificador | Importância | Ponto de Verificação |
|---------------|-------------|-----------------------|
| ACL‑100‑T001 | Alta | Evidência observável em 100 % das descrições. |
| ACL‑100‑T002 | Alta | Uso de **NÃO DEVE** em todos os documentos para restrições. |
| ACL‑100‑T003 | Média | Ausência de ambiguidades na redação (validação por linter). |
| ACL‑100‑T004 | Alta | Termo consistente em todas as diretrizes (verificação cruzada). |
| ACL‑100‑T005 | Média | Conformidade de métricas de reprodutibilidade (≥ 85%). |
| ACL‑100‑T006 | Alta | Identificador permanente `ACL-<FAMÍLIA>-<TIPO>-<NÚMERO>` em todos os critérios. |
| ACL‑100‑T007 | Média | Referência a RFC 2119 em todos os documentos normativos. |

## 5. Identificadores Permanentes

Os identificadores seguem o padrão `ACL‑<FAMÍLIA>-<TIPO>-<NÚMERO>`. Exemplos:

| Família | Padrão de Identificador | Exemplo |
|---------|-------------------------|---------|
| 200 | `ACL‑200‑IMG‑NNN` | `ACL‑200‑IMG‑001` |
| 300 | `ACL‑300‑GRF‑NNN` | `ACL‑300‑GRF‑001` |
| 400 | `ACL‑400‑SCI‑NNN` | `ACL‑400‑SCI‑001` |
| 500 | `ACL‑500‑EDU‑NNN` | `ACL‑500‑EDU‑001` |
| 600 | `ACL‑600‑MDM‑NNN` | `ACL‑600‑MDM‑001` |
| 700 | `ACL‑700‑VAL‑NNN` | `ACL‑700‑VAL‑001` |
| 800 | `ACL‑800‑PRF‑NNN` | `ACL‑800‑PRF‑001` |
| 100 | `ACL‑100‑T‑NNN` | `ACL‑100‑T001` |

Estes IDs são **fixos** e não mudam entre versões.

## 6. Glossário

### 6.1 Termos Fundamentais

| Termo | Definição |
|-------|-----------|
| **Objetividade** | Princípio de relatar apenas o que pode ser observado diretamente. |
| **Fidelidade (Princípio)** | Princípio qualitativo: descrição sem informações sem evidência observável. |
| **Fidelidade Semântica (Métrica)** | Métrica quantitativa: percentual de correspondência com o conteúdo original (≥ 90%). |
| **Clareza** | Princípio de linguagem objetiva, livre de ambiguidade e sem juízo de valor. |
| **Consistência** | Princípio de uso uniforme de termos e estrutura em todo o documento. |
| **Reprodutibilidade** | Capacidade de diferentes descritores independentes chegarem a resultados equivalentes (≥ 85%). |
| **Neutralidade** | Princípio de não expressar opinião ou preferência pessoal na descrição. |

### 6.2 Termos Operacionais

| Termo | Definição |
|-------|-----------|
| **Escopo** | Delimitação do tipo de conteúdo ao qual se aplicam as regras de uma família. |
| **Diretriz** | Regra qualitativa que orienta a elaboração de descrições dentro de uma família. |
| **Evidência** | Dado observável que sustenta uma afirmação na descrição. |
| **Evidência Obrigatória** | Dado que **DEVE** estar presente para que o critério seja atendido. |
| **Ponto de Verificação** | Local ou método pelo qual se verifica a conformidade de um critério. |
| **Importância** | Nível de prioridade de um critério (Alta ou Média). |
| **Esquema** | Arquivo JSON ou XSD que define a estrutura obrigatória dos metadados. |
| **Manifesto** | Arquivo `manifest.yml` que lista famílias, ordem de importação e versão. |
| **Módulo** | Arquivo individual de uma família que pode ser incluído em contexto de uso. |
| **Rastreabilidade** | Capacidade de rastrear cada critério por seu identificador permanente. |
| **Conformidade** | Estado de atendimento a todos os critérios obrigatórios aplicáveis. |
| **Relatório de Conformidade** | Documento gerado pelo linter com resultado PASS/FAIL por critério. |
| **Validação** | Processo de verificar se conteúdo e metadados atendem aos requisitos. |
| **Auditoria** | Revisão humana independente para validar conformidade além da validação automática. |
| **Perfil** | Conjunto de critérios e requisitos específicos para um tipo de conteúdo ou cenário de uso, podendo restringir ou expandir os requisitos das famílias base. |
| **Extensão** | Mecanismo pelo qual novos perfis adicionam critérios além das famílias base, mediante documentação e revisão pelo comitê técnico. |
| **Completude** | Percentual de campos obrigatórios preenchidos no metadata em relação ao total de campos exigidos pelo esquema. |

### 6.3 Termos Técnicos

| Termo | Definição |
|-------|-----------|
| **PII** | *Personally Identifiable Information* — dados pessoais identificáveis. |
| **SPDX** | *Software Package Data Exchange* — padrão para identificação de licenças ([spdx.org](https://spdx.org/specifications)). |
| **Contraste de Luminância** | Razão mínima de luminância entre texto e fundo (≥ 4,5:1 conforme WCAG). |
| **Contraste de Cores** | Uso de cores diferenciadoras com significado textual associado. |
| **Verbo de Bloom** | Verbo de ação mensurável usado na taxonomia de Bloom para objetivos educacionais (Bloom et al., 1956; Anderson & Krathwohl, 2001). |
| **Flesch-Kincaid** | Fórmula de legibilidade que mede a compreensibilidade de textos (Flesch, 1949). Para português: índice equivalente adaptado por Costa (1998). |
| **Legenda (Gráfico)** | Texto que descreve eixos, unidades e elementos de um gráfico ou diagrama. |
| **Legenda (Vídeo)** | Texto sincronizado com o áudio que transcreve falas e sons relevantes em conteúdo multimídia (captions). |
| **Índice de Gunning** | Fórmula alternativa de legibilidade que mede a compreensibilidade de textos; alternativa ao Flesch-Kincaid para validação de Claridade. |

### 6.4 Termos Gerais

| Termo | Definição |
|-------|-----------|
| **Descrição** | Texto que representa o conteúdo de forma objetiva e observável. |
| **Metadata** | Dados estruturados (JSON/XML) que acompanham a descrição textual. |
| **Linter** | Ferramenta de validação automática que verifica conformidade com o esquema e regras. |
| **Família** | Conjunto de regras aplicáveis a um tipo específico de conteúdo (ex.: 200 para imagens). |
| **Critério** | Regra específica com identificador permanente, evidência obrigatória e ponto de verificação. |

### 6.5 Convenção de Nomenclatura

> **Convenção de Nomenclatura**: Campos de metadados JSON utilizam nomenclatura em inglês (`description`, `license`, `imageType`, etc.) independentemente do idioma da documentação do padrão.
