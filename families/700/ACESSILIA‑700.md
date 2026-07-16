# ACESSILIA‑700 – Validação e Conformidade

> **Família 700** · Identificador de família: `ACL-700`  
> **RFC 2119**: Os termos **DEVE**, **NÃO DEVE**, **PODE** e **RECOMENDA‑SE** devem ser interpretados conforme [RFC 2119](https://tools.ietf.org/html/rfc2119) e [RFC 8174](https://tools.ietf.org/html/rfc8174).

## 1. Escopo
Define métricas de avaliação, procedimentos de validação e requisitos de conformidade para todos os conteúdos descritos pelo padrão ACESSILIA.

## 2. Referências de Norma
Conforme [ACESSILIA‑100](../../ACESSILIA-100.md) para princípios de terminologia e auditabilidade. Em adição ao [WCAG 2.2](https://www.w3.org/TR/WCAG22/). Aplica‑se a todas as famílias de conteúdo: [200](../200/ACESSILIA‑200.md), [300](../300/ACESSILIA‑300.md), [400](../400/ACESSILIA‑400.md), [500](../500/ACESSILIA‑500.md), [600](../600/ACESSILIA‑600.md) e [800](../800/ACESSILIA‑800.md) para perfis de conformidade.

## 3. Diretrizes Principais

| Código | Diretriz | Métrica de Avaliação | Comentário |
|--------|----------|----------------------|------------|
| ACL‑700‑VAL‑001 | **Fidelidade Semântica** | Percentual de correspondência com o conteúdo original ≥ 90 %. | Medida por comparação entre descrição e conteúdo fonte. |
| ACL‑700‑VAL‑002 | **Claridade** | Pontuação em avaliação de legibilidade (Flesch-Kincaid ou equivalente para português) ≥ 80 %. | Aplicável a textos em português e inglês. |
| ACL‑700‑VAL‑003 | **Reprodutibilidade** | Percentual de concordância entre descritores independentes ≥ 85 %. | Teste com pelo menos 2 descritores independentes. |
| ACL‑700‑VAL‑004 | **Validação de Esquema** | 100 % dos campos obrigatórios preenchidos no metadata. | Verificação automática via linter. |
| ACL‑700‑VAL‑005 | **Relatório de Conformidade** | 100 % dos critérios avaliados no relatório. | Geração de relatório Markdown. |

## 4. Métricas de Qualidade

| Métrica | Métrica de Avaliação | Critério de Aprovação | Comentário |
|---------|----------------------|------------------------|------------|
| **Fidelidade Semântica** | Percentual de correspondência com o conteúdo original. | ≥ 90 % de fidelidade semântica. | Medida por comparação entre descrição e conteúdo fonte. |
| **Claridade** | Pontuação em avaliação de legibilidade (Flesch-Kincaid ou equivalente para português). | ≥ 80 % de pontuação. | Aplicável a textos em português e inglês. |
| **Reprodutibilidade** | Percentual de concordância entre descritores independentes. | ≥ 85 % de concordância. | Teste com pelo menos 2 descritores independentes. |
| **Objetividade** | Percentual de frases com verbos observáveis. | 100 % de frases objetivas. | Verificação automática via linter. |
| **Completude** | Percentual de campos obrigatórios preenchidos no metadata. | 100 % dos campos obrigatórios. | Validação de esquema JSON. |

## 5. Procedimento de Validação

### 5.1 Revisão Humana
- Checklist de critérios ACL‑<FAMÍLIA>‑<TIPO> conforme família aplicável.
- Avaliação por pelo menos 2 revisores independentes.
- Registro de discordâncias e resolução documentada.

### 5.2 Validação Automática
- Ferramentas que consomem `acessilia.schema.json` e `acessilia.xsd`.
- Linter ACESSILIA com regras por família.
- Geração de relatório Markdown com resultado `PASS`/`FAIL` por critério.

### 5.3 Fluxo de Conformidade

```
┌─────────────┐     ┌──────────────┐     ┌───────────────┐     ┌──────────────┐
│  Conteúdo   │ ──► │  Lint Auto   │ ──► │  Revisão      │ ──► │  Publicação  │
│  Produzido  │     │  (schema+regras)│    │  Humana       │     │  Aprovada    │
└─────────────┘     └──────────────┘     └───────────────┘     └──────────────┘
```

## 6. Critérios Obrigatórios (ACL‑700‑VAL‑NNN)

| Identificador | Objetivo | Evidência Obrigatória | Importância | Ponto de Verificação |
|---------------|-----------|------------------------|-------------|-----------------------|
| ACL‑700‑VAL‑001 | Garantir fidelidade ≥ 90 %. | Relatório de comparação semântica entre descrição e conteúdo fonte. | Alta | Percentual de fidelidade no relatório. |
| ACL‑700‑VAL‑002 | Garantir Claridade ≥ 80 %. | Pontuação de legibilidade (Flesch-Kincaid ou equivalente para português). | Alta | Pontuação ≥ 80 % no relatório. |
| ACL‑700‑VAL‑003 | Garantir reprodutibilidade ≥ 85 %. | Relatório de concordância entre descritores independentes. | Alta | Percentual de concordância ≥ 85 %. |
| ACL‑700‑VAL‑004 | Validar esquema de metadata. | Relatório de validação JSON contra `acessilia.schema.json`. | Alta | Ausência de erros de esquema. |
| ACL‑700‑VAL‑005 | Gerar relatório de conformidade. | Arquivo Markdown com resultado `PASS`/`FAIL` para cada critério. | Média | Presença do relatório gerado pelo linter. |

## 7. Exemplo de Relatório de Conformidade

```markdown
# Relatório de Conformidade – Conteúdo X

| Critério | Resultado | Observação |
|----------|-----------|------------|
| ACL‑700‑VAL‑001 (Fidelidade Semântica) | PASS (92%) | Acima do mínimo de 90%. |
| ACL‑700‑VAL‑002 (Claridade) | PASS (85%) | Acima do mínimo de 80%. |
| ACL‑700‑VAL‑003 (Reprodutibilidade) | PASS (88%) | Acima do mínimo de 85%. |
| ACL‑700‑VAL‑004 (Esquema JSON) | PASS | Todos os campos obrigatórios preenchidos. |
| ACL‑700‑VAL‑005 (Relatório) | PASS | Relatório gerado com sucesso. |
```

## 8. Exemplo de Execução do Lint

```bash
acessilia-lint \
  --schema schemas/acessilia.schema.json \
  --dir ./families \
  --output relatorio-conformidade.md
```

O relatório gerado **DEVE** indicar `PASS` ou `FAIL` para cada critério listado na Seção 6.

## 9. Limitações e Exclusões

Esta família fornece os critérios de validação para todos os conteúdos ACESSILIA. As seguintes limitações se aplicam:

- **Idiomas não suportados** → a validação de legibilidade (Flesch‑Kincaid) é aplicável apenas a textos em português e inglês. Outros idiomas exigem ferramentas equivalentes adaptadas.
- **Conteúdo em tempo real** → a validação automática não suporta conteúdos transmitidos ao vivo; a conformidade **DEVE** ser verificada retroativamente.
- **Conteúdo dinâmico gerado por algoritmos** → descrições geradas automaticamente podem atender aos critérios de esquema, mas a validação humana continua obrigatória.
- **Formatos não normatizados** → conteúdos em formatos não cobertos pelas famílias 200–600 requerem extensão do padrão antes da validação.
- **Serviços externos** → a validação de DOIs, URLs e repositórios depende de disponibilidade de APIs externas e pode falhar temporariamente.

A conformidade parcial (reprovação em critérios de baixa importância) **PODE** ser aceita mediante justificativa documentada no relatório.
