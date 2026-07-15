# ACESSILIA‑800 – Perfis de Acessibilidade e Conformidade

> **Família 800** · Identificador de família: `ACL-800`  
> **RFC 2119**: Os termos **DEVE**, **NÃO DEVE**, **PODE** e **RECOMENDA‑SE** devem ser interpretados conforme [RFC 2119](https://tools.ietf.org/html/rfc2119) e [RFC 8174](https://tools.ietf.org/html/rfc8174).

## 1. Escopo
Define níveis de conformidade, perfis de acessibilidade e mecanismos de extensão do padrão ACESSILIA. Estabelece como implementações devem declarar conformidade e como novos perfis podem ser criados.

## 2. Referências de Norma
Conforme [ACESSILIA‑100](../../ACESSILIA-100.md) para princípios de terminologia e auditabilidade. Em adição ao [WCAG 2.2](https://www.w3.org/TR/WCAG22/), [EPUB 3](https://www.w3.org/TR/epub-33/), [PDF/UA‑1](https://www.iso.org/standard/54268.html), [EN 301 549](https://www.etsi.org/deliver/etsi_en/301500_301599/301549/03.02.01_60/en_301549v030201p.pdf) e [Section 508](https://www.section508.gov/) para requisitos de acessibilidade.

## 3. Níveis de Conformidade

### 3.1 Definição dos Níveis

| Nível | Escopo | Descrição |
|-------|--------|-----------|
| **ACESSILIA‑A** | Básico | Todos os critérios obrigatórios das famílias 200–600. |
| **ACESSILIA‑AA** | Intermediário | Critérios obrigatórios + critérios de importância alta de todas as famílias. |
| **ACESSILIA‑AAA** | Avançado | Todos os critérios (obrigatórios e recomendados) de todas as famílias. |

### 3.2 Requisitos por Nível

| Nível | Família 200 | Família 300 | Família 400 | Família 500 | Família 600 | Família 700 |
|-------|-------------|-------------|-------------|-------------|-------------|-------------|
| **A** | Obrigatórios | Obrigatórios | Obrigatórios | Obrigatórios | Obrigatórios | Obrigatórios |
| **AA** | Obrigatórios + Alta | Obrigatórios + Alta | Obrigatórios + Alta | Obrigatórios + Alta | Obrigatórios + Alta | Obrigatórios + Alta |
| **AAA** | Todos | Todos | Todos | Todos | Todos | Todos |

### 3.3 Declaração de Conformidade

Uma implementação **DEVE** atender integralmente aos critérios do nível declarado para usar a designação ACESSILIA‑A, ACESSILIA‑AA ou ACESSILIA‑AAA.

> Implementações que não atendam integralmente ao nível declarado **NÃO DEVEM** declarar conformidade. Podem informar os critérios implementados individualmente para fins de avaliação técnica.

## 4. Perfis de Acessibilidade

### 4.1 Conceito de Perfil

Um perfil de acessibilidade é um conjunto de critérios e requisitos específicos para um tipo de conteúdo ou cenário de uso. Perfis podem restringir ou expandir os requisitos das famílias base.

### 4.2 Perfis Definidos

| Perfil | Identificador | Família(s) Aplicável(is) | Descrição |
|--------|---------------|--------------------------|-----------|
| **Livro Digital** | `ACL-PRF-001` | 200, 300, 400, 500 | Requisitos para EPUB e PDF acessíveis. |
| **Fotografia** | `ACL-PRF-002` | 200 | Requisitos específicos para descrição de fotografias. |
| **Conteúdo Matemático** | `ACL-PRF-003` | 400 | Requisitos para equações e notação matemática. |
| **Gráfico Científico** | `ACL-PRF-004` | 300, 400 | Requisitos para gráficos de dados e diagramas científicos. |
| **Captura de Tela** | `ACL-PRF-005` | 200 | Requisitos para descrição de interfaces e capturas de tela. |
| **Conteúdo STEM** | `ACL-PRF-006` | 300, 400, 500 | Requisitos para ciência, tecnologia, engenharia e matemática. |

### 4.3 Estrutura de um Perfil

Cada perfil **DEVE** conter:

| Campo | Tipo | Obrigatório | Descrição |
|-------|------|-------------|-----------|
| `id` | string | Sim | Identificador único do perfil (ex.: `ACL-PRF-001`). |
| `name` | string | Sim | Nome do perfil em inglês. |
| `namePt` | string | Sim | Nome do perfil em português. |
| `description` | string | Sim | Descrição do escopo do perfil. |
| `mediaTypes` | array | Sim | Tipos MIME aplicáveis. |
| `requiredMetadata` | array | Sim | Campos de metadados obrigatórios. |
| `families` | array | Sim | Famílias ACESSILIA aplicáveis. |
| `conformanceLevel` | string | Sim | Nível mínimo de conformidade (A, AA, AAA). |
| `criteria` | array | Não | Critérios específicos do perfil (além dos da família). |

## 5. Critérios Obrigatórios (ACL‑800‑PRF‑NNN)

| Identificador | Objetivo | Evidência Obrigatória | Importância | Ponto de Verificação |
|---------------|-----------|------------------------|-------------|-----------------------|
| ACL‑800‑PRF‑001 | Declarar nível de conformidade. | Campo `conformanceLevel` no metadata com valor válido (A, AA ou AAA). | Alta | Presença do campo `conformanceLevel` com valor válido. |
| ACL‑800‑PRF‑002 | Listar famílias aplicáveis. | Campo `families` contendo lista de famílias incluídas no perfil. | Alta | Todas as famílias referenciadas existem no manifesto. |
| ACL‑800‑PRF‑003 | Definir tipos MIME. | Campo `mediaTypes` com pelo menos 1 tipo MIME válido. | Média | Formato MIME válido em todas as entradas. |
| ACL‑800‑PRF‑004 | Especificar metadados obrigatórios. | Campo `requiredMetadata` com lista de campos exigidos. | Média | Campos listados são válidos conforme schema. |
| ACL‑800‑PRF‑005 | Documentar extensões. | Quando o perfil adicionar critérios além das famílias, estes **DEVEM** ser documentados com identificador `ACL-PRF-XXX-NNN`. | Alta | Todos os critérios de extensão possuem identificador, evidência e ponto de verificação. |

## 6. Metadados de Exemplo (JSON)

### 6.1 Exemplo de Perfil — Livro Digital

```json
{
  "id": "ACL-PRF-001",
  "name": "Accessibility Profile - Livro Digital",
  "namePt": "Perfil de Acessibilidade - Livro Digital",
  "description": "Requisitos para livros digitais acessíveis em EPUB e PDF.",
  "mediaTypes": [
    "application/epub+zip",
    "application/pdf"
  ],
  "requiredMetadata": [
    "title",
    "language",
    "description",
    "conformsTo",
    "accessMode",
    "accessibilityFeature",
    "accessibilitySummary"
  ],
  "families": [200, 300, 400, 500],
  "conformanceLevel": "AA",
  "license": "https://creativecommons.org/licenses/by/4.0/"
}
```

### 6.2 Exemplo de Perfil — Fotografia

```json
{
  "id": "ACL-PRF-002",
  "name": "Accessibility Profile - Fotografia",
  "namePt": "Perfil de Acessibilidade - Fotografia",
  "description": "Requisitos específicos para descrição de fotografias e imagens estáticas.",
  "mediaTypes": [
    "image/jpeg",
    "image/png",
    "image/webp"
  ],
  "requiredMetadata": [
    "title",
    "description",
    "imageType",
    "resolution"
  ],
  "families": [200],
  "conformanceLevel": "A",
  "license": "https://creativecommons.org/licenses/by/4.0/"
}
```

## 7. Exemplos de Conformidade

| Exemplo | Justificativa |
|---------|-----------|
| **Conforme** – Implementação declarando `conformanceLevel: "AA"` e atendendo a todos os critérios obrigatórios e de alta importância das famílias 200–600. | Declaração válida com conformidade verificável. |
| **Não conforme** – Implementação declarando `conformanceLevel: "AAA"` mas sem documentar critérios de extensão. `[viola ACL‑800‑PRF‑005]` | Nível declarado sem suporte documentado. |
| **Não conforme** – Implementação declarando `conformanceLevel: "AA"` mas sem campo `conformanceLevel` no metadata. `[viola ACL‑800‑PRF‑001]` | Falta declaração obrigatória. |

## 8. Estratégia de Validação

1. **Validação de esquema**: garantir que todos os campos obrigatórios do perfil estejam presentes.
2. **Validação de nível**: o linter **DEVE** verificar se o nível declarado corresponde aos critérios atendidos.
3. **Validação de famílias**: o linter **DEVE** verificar se todas as famílias referenciadas existem no manifesto.
4. **Validação de extensões**: quando o perfil adicionar critérios, o linter **DEVE** verificar se possuem identificador válido e evidência documentada.

## 9. Exemplo de Execução do Lint

```bash
acessilia-lint \
  --schema schemas/acessilia.schema.json \
  --dir ./families/800 \
  --output relatorio-familia800.md
```

O relatório gerado **DEVE** indicar `PASS` ou `FAIL` para cada critério listado na Seção 5.

## 10. Limitações e Exclusões

Esta família define perfis de conformidade e mecanismos de extensão. Os seguintes tipos de conteúdo **NÃO DEVEM** ser descritos usando apenas esta família:

- **Conteúdo específico** → usar a família correspondente (200–600) para descrição do conteúdo.
- **Validação de conteúdo** → usar [ACESSILIA‑700](../700/ACESSILIA‑700.md) para critérios de validação.

A criação de novos perfis **DEVE** ser documentada e revisada pelo comitê técnico antes da publicação.

## 11. Modelo de Extensão

O padrão ACESSILIA pode ser estendido por perfis específicos. O processo de extensão **DEVE** seguir:

1. **Proposta**: Documento descrevendo o novo perfil, seu escopo e critérios.
2. **Revisão**: Análise pelo comitê técnico e stakeholders.
3. **Publicação**: Inclusão no catálogo de perfis com identificador `ACL-PRF-XXX`.

Perfis existentes podem ser referenciados por implementações que desejem atender a requisitos específicos além das famílias base.
