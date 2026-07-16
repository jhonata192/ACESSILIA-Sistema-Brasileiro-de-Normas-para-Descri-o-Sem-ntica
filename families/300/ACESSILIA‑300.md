# ACESSILIA‑300 – Gráficos, Tabelas e Diagramas

> **Família 300** · Identificador de família: `ACL-300`  
> **RFC 2119**: Os termos **DEVE**, **NÃO DEVE**, **PODE** e **RECOMENDA‑SE** devem ser interpretados conforme [RFC 2119](https://tools.ietf.org/html/rfc2119) e [RFC 8174](https://tools.ietf.org/html/rfc8174).

## 1. Escopo
Aplica‑se a todas as representações visuais de dados que podem aparecer em documentos digitais, apresentações, relatórios científicos e dashboards interativos: gráficos de barras, linhas, pizza, radar, heat‑map, gráficos de dispersão; tabelas manuscritas ou digitais; diagramas UML, ER, fluxogramas, mapas conceptuais.

## 2. Referências de Norma
Conforme [ACESSILIA‑100](../../ACESSILIA-100.md) para princípios de terminologia e auditabilidade; em adição ao [WCAG 2.2](https://www.w3.org/TR/WCAG22/), [EPUB 3](https://www.w3.org/TR/epub-33/) e [PDF/UA‑1](https://www.iso.org/standard/64599.html).

## 3. Diretrizes Principais

| Código | Diretriz | Métrica de Avaliação | Comentário |
|--------|----------|----------------------|------------|
| ACL‑300‑GRF‑001 | **Fonte de Dados** | 100 % dos gráficos **DEVEM** incluir fonte de dados. | Incluir fonte na descrição ou no metadata (campo `source`). |
| ACL‑300‑GRF‑002 | **Legendas e Rótulos** | 100 % dos eixos e unidades de medida **DEVEM** ter legendas. | Todos os eixos e unidades **DEVEM** ser rotulados. |
| ACL‑300‑GRF‑003 | **Tendências** | 0 % de inferências de tendência sem dados explícitos. | Caso tendência seja exibida, apresentar valores numéricos. |
| ACL‑300‑GRF‑004 | **Ordem Lógica** | 100 % dos elementos seguem ordem natural: cima→baixo, esquerda→direita. | Não misturar direções de leitura. |
| ACL‑300‑GRF‑005 | **Contraste de Cores** | 100 % das cores diferenciadoras **DEVEM** ter significado textual. | A descrição **DEVE** indicar a função de cada cor utilizada. |

## 4. Critérios Obrigatórios (ACL‑300‑GRF‑NNN)

| Identificador | Objetivo | Evidência Obrigatória | Importância | Ponto de Verificação |
|---------------|-----------|------------------------|-------------|-----------------------|
| ACL‑300‑GRF‑001 | Referenciar a fonte de dados em metadata ou texto. | Campo `source` no JSON, ou texto na descrição. | Alta | Presença do campo `source` ou menção textual da fonte. |
| ACL‑300‑GRF‑002 | Incluir legendas de eixos. | Texto descrevendo eixos x/y e unidades. | Alta | Presença de rótulos para todos os eixos. |
| ACL‑300‑GRF‑003 | Não inferir tendências sem prova. | Dados numéricos explícitos; evitar termos como “picos” sem valores. | Média | Busca por termos de tendência sem dados numéricos associados. |
| ACL‑300‑GRF‑004 | Seguir ordem lógica de leitura. | Sequência dos objetos segue esq→dir, cima→baixo. | Média | Verificação da sequência de referências. |
| ACL‑300‑GRF‑005 | Garantir contraste de cores com significado. | Incluir descrição textual da função da cor. | Média | Presença de mapeamento cor→significado. |

## 5. Metadados de Exemplo (JSON)

```json
{
  "id": "ACL-300-GRF-001",
  "description": "Gráfico de barras com receita anual 2017‑2023, eixo X: anos, eixo Y: valores em R$",
  "language": "pt-BR",
  "license": "https://creativecommons.org/licenses/by/4.0/",
  "standard": "ACESSILIA 1.1.0",
  "date": "2026-07-16T00:00:00Z",
  "reviewStatus": "approved",
  "familyId": 300,
  "chartType": "bar",
  "source": "Estatística Federal",
  "xAxis": {"label": "Ano", "values": [2017,2018,2019,2020,2021,2022,2023]},
  "yAxis": {"label": "Receita (R$)", "unit": "R$"},
  "colors": {"blue": "receita", "green": "lucro"}
}
```

## 6. Exemplos de Conformidade

| Exemplo | Justificativa |
|---------|-----------|
| **Conforme** – "Gráfico de barras que mostra a receita anual de 2017 a 2023; eixo X com anos, eixo Y com valores em reais; fonte: Estatística Federal; cor azul para receitas, verde para lucro." | Cumpre fonte, legendas, ordem lógica e contraste de cores. |
| **Não conforme** – "Gráfico com barras coloridas." `[viola ACL‑300‑GRF‑001, ACL‑300‑GRF‑002, ACL‑300‑GRF‑005]` | Falta fonte de dados, legendas de eixos e significado das cores. |

## 7. Estratégia de Validação

1. **Validação de esquema**: garantir que todos os campos obrigatórios (`description`, `chartType`, `source`, `xAxis`, `yAxis`) estejam presentes.
2. **Validação de conteúdo** (via linter): checar presença de legendas, ausência de inferências de tendência sem dados e conformidade de ordem lógica.
3. **Auditoria de cores**: o linter **DEVE** verificar que cada cor utilizada tenha uma descrição textual associada.
4. **Teste de acessibilidade**: garantir que o gráfico atenda aos critérios WCAG 2.2 para representações visuais de dados.

## 8. Exemplo de Execução do Lint

```bash
acessilia-lint \
  --schema schemas/acessilia.schema.json \
  --dir ./families/300 \
  --output relatorio-familia300.md
```

O relatório gerado **DEVE** indicar `PASS` ou `FAIL` para cada critério listado na Seção 4.

## 9. Limitações e Exclusões

Esta família aplica‑se a representações visuais de dados estáticas. Os seguintes tipos de conteúdo **NÃO DEVEM** ser descritos usando esta família:

- **Imagens fotográficas ou ilustrações** → usar [ACESSILIA‑200](../200/ACESSILIA‑200.md).
- **Vídeos, animações e conteúdos multimídia** → usar [ACESSILIA‑600](../600/ACESSILIA‑600.md).
- **Dashboards interativos em tempo real** → exigem extensão específica futura.
- **Dados brutos sem representação visual** → não aplicável; não há elemento visual a descrever.
- **Conteúdo científico ou educacional com gráficos** → usar também [ACESSILIA‑400](../400/ACESSILIA‑400.md) ou [ACESSILIA‑500](../500/ACESSILIA‑500.md) conforme o contexto.
- **Declaração de conformidade e perfis** → usar [ACESSILIA‑800](../800/ACESSILIA‑800.md).

Diagramas UML, ER e fluxogramas são incluídos desde que representem dados ou processos de forma visual estática.
