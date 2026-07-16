# ACESSILIA‑400 – Conteúdo Científico

> **Família 400** · Identificador de família: `ACL-400`  
> **RFC 2119**: Os termos **DEVE**, **NÃO DEVE**, **PODE** e **RECOMENDA‑SE** devem ser interpretados conforme [RFC 2119](https://tools.ietf.org/html/rfc2119) e [RFC 8174](https://tools.ietf.org/html/rfc8174).

## 1. Escopo
Aplica‑se a artigos científicos, teses, relatórios técnicos e revistas acadêmicas, independentemente do formato (PDF, HTML, LaTeX). Inclui abstracts, figuras, tabelas e compilações de dados.

## 2. Referências de Norma
Principais referências: [ACESSILIA‑100](../../ACESSILIA-100.md), [ACM Digital Library](https://dl.acm.org/), DOI de obras, WG for metadata ([Dublin Core](https://www.dublincore.org/), [COAR](https://www.coar-repositories.org/)). As verificações **DEVEM** seguir [WCAG 2.2](https://www.w3.org/TR/WCAG22/) e [PDF/UA‑1](https://www.iso.org/standard/64599.html).

## 3. Diretrizes Principais

| Código | Diretriz | Métrica de Avaliação | Comentário |
|--------|----------|----------------------|------------|
| ACL‑400‑SCI‑001 | **Resultados Físicos** | 100 % dos resultados **DEVEM** ser objetivos. | Apresentar resultados sem interpretação ou inferência extra. |
| ACL‑400‑SCI‑002 | **Referências** | 100 % das referências **DEVEM** incluir DOI ou URL válida. | Incluir bibliografia em formato DOI ou URL e permitir validação automática. |
| ACL‑400‑SCI‑003 | **Evidência de Dados** | 100 % dos estudos **DEVEM** fornecer acesso direto aos dados. | Links para repositórios, FTP ou outras fontes acessíveis. |
| ACL‑400‑SCI‑004 | **Rastreabilidade** | 100 % das publicações **DEVEM** documentar versão e regras de revisão. | Campo `citationMetadata` com DOI, versão, data e autor. |

## 4. Critérios Obrigatórios (ACL‑400‑SCI‑NNN)

| Identificador | Objetivo | Evidência Obrigatória | Importância | Ponto de Verificação |
|---------------|-----------|------------------------|-------------|-----------------------|
| ACL‑400‑SCI‑001 | Apresentar resultados sem inferência. | Seção de resultados contendo somente valores numéricos e descrição de análises estatísticas. | Alta | Ausência de termos interpretativos na seção de resultados. |
| ACL‑400‑SCI‑002 | Bibliografia completa e validável. | Metadado `bibliography` contendo lista de referências com DOI ou URL. | Alta | Formato DOI válido em todas as entradas de `bibliography`. |
| ACL‑400‑SCI‑003 | Dados de apoio acessíveis. | Metadado `dataAvailability` com URL ou repositório acessível. | Alta | URL retornando status HTTP 200 ou DOI resolvido. |
| ACL‑400‑SCI‑004 | Rastreabilidade da publicação. | Campo `citationMetadata` com DOI, versão, data e autor. | Média | Presença de todos os subcampos obrigatórios em `citationMetadata`. |

## 5. Metadados de Exemplo (JSON)

```json
{
  "title": "Estudo de Eficácia no Uso de X em Y",
  "language": "pt-BR",
  "author": ["João Silva"],
  "doi": "10.1234/abcd.efgh",
  "bibliography": ["10.1111/abcd.2015"],
  "dataAvailability": "https://doi.org/10.5281/zenodo.79455",
  "license": "https://creativecommons.org/licenses/by/4.0/",
  "citationMetadata": {
    "publisher": "Journal of X",
    "version": "1.0",
    "datePublished": "2026-05-01",
    "author": "João Silva"
  }
}
```

## 6. Exemplos de Conformidade

| Exemplo | Justificativa |
|---------|-----------|
| **Conforme** – “Resultados: taxa de eficácia de 87,3 % (IC 95 %: 82,1‑91,4). Fonte: ensaio clínico registrado em REBEC.” | Apresenta dados numéricos objetivos, sem interpretação, com fonte verificável. |
| **Não conforme** – “O estudo demonstrou excelentes resultados.” `[viola ACL‑400‑SCI‑001]` | Contém inferência subjetiva (“excelentes”) sem dados numéricos. |

## 7. Estratégia de Validação

1. **Validação de esquema**: garantir que todos os campos obrigatórios (`title`, `author`, `doi`, `bibliography`, `dataAvailability`, `citationMetadata`) estejam presentes.
2. **Validação de DOI**: o linter **DEVE** verificar se os DOIs informados são resolvíveis via API do CrossRef ou DataCite.
3. **Validação de dados**: o campo `dataAvailability` **DEVE** conter URL acessível (status HTTP 200).
4. **Auditoria de linguagem**: o linter **DEVE** sinalizar termos interpretativos na seção de resultados.

## 8. Exemplo de Execução do Lint

```bash
acessilia-lint \
  --schema schemas/acessilia.schema.json \
  --dir ./families/400 \
  --output relatorio-familia400.md
```

O relatório gerado **DEVE** indicar `PASS` ou `FAIL` para cada critério listado na Seção 4.

## 9. Limitações e Exclusões

Esta família aplica‑se a publicações científicas e técnicas revisadas por pares. Os seguintes tipos de conteúdo **NÃO DEVEM** ser descritos exclusivamente usando esta família:

- **Conteúdo jornalístico ou de divulgação científica** → usar diretiva editorial geral.
- **Materiais didáticos** → usar [ACESSILIA‑500](../500/ACESSILIA‑500.md).
- **Gráficos e tabelas científicas** → aplicar também [ACESSILIA‑300](../300/ACESSILIA‑300.md).
- **Figuras e imagens de artigos** → aplicar também [ACESSILIA‑200](../200/ACESSILIA‑200.md).
- **Conteúdo multimídia** (vídeos explicativos, podcasts) → usar [ACESSILIA‑600](../600/ACESSILIA‑600.md).
- **Declaração de conformidade e perfis** → usar [ACESSILIA‑800](../800/ACESSILIA‑800.md).

A validação de DOI e acesso a dados **DEVE** depender de serviços externos (CrossRef, DataCite, Zenodo) e pode falhar por indisponibilidade temporária.
