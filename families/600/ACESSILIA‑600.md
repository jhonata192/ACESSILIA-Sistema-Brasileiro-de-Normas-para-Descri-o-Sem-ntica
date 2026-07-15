# ACESSILIA‑600 – Conteúdo Multimídia

> **Família 600** · Identificador de família: `ACL-600`  
> **RFC 2119**: Os termos **DEVE**, **NÃO DEVE**, **PODE** e **RECOMENDA‑SE** devem ser interpretados conforme [RFC 2119](https://tools.ietf.org/html/rfc2119) e [RFC 8174](https://tools.ietf.org/html/rfc8174).

## 1. Escopo
Aplica‑se a vídeos, animações, apresentações interativas, podcasts e conteúdos audiovisuais que demandam descrição acessível.

## 2. Referências de Norma
Conforme [ACESSILIA‑100](../../ACESSILIA-100.md) para princípios de terminologia e auditabilidade. Em adição ao [WCAG 2.2](https://www.w3.org/TR/WCAG22/), [DAISY 3.0](https://daisy.org/activities/standards/daisy-3/) e [EPUB 3](https://www.w3.org/TR/epub-33/) para multimídia acessível.

## 3. Diretrizes Principais

| Código | Diretriz | Métrica de Avaliação | Comentário |
|--------|----------|----------------------|------------|
| ACL‑600‑MDM‑001 | **Narração** | 100 % do conteúdo multimídia **DEVEM** ter descrição textual da narrativa. | A descrição **DEVE** acompanhar a progressão temporal do conteúdo. |
| ACL‑600‑MDM‑002 | **Legendas** | 100 % dos conteúdos com áudio **DEVEM** incluir legendas sincronizadas. | Legendas **DEVEM** seguir padrão WebVTT ou SRT. |
| ACL‑600‑MDM‑003 | **Áudio Descritivo** | Quando houver elementos visuais sem narração, áudio descritivo **DEVE** ser fornecido. | Campo `audioDescription` no metadata. |
| ACL‑600‑MDM‑004 | **Controle Temporal** | 100 % dos marcadores temporais **DEVEM** usar formato ISO 8601. | Formato `HH:MM:SS.mmm`. |
| ACL‑600‑MDM‑005 | **Transcrição** | Conteúdos com fala **DEVEM** fornecer transcrição completa. | Campo `transcript` com texto integral. |

## 4. Critérios Obrigatórios (ACL‑600‑MDM‑NNN)

| Identificador | Objetivo | Evidência Obrigatória | Importância | Ponto de Verificação |
|---------------|-----------|------------------------|-------------|-----------------------|
| ACL‑600‑MDM‑001 | Descrever a narrativa do conteúdo. | Campo `narrativeDescription` com texto descrevendo a progressão temporal. | Alta | Presença do campo `narrativeDescription` com mais de 50 palavras. |
| ACL‑600‑MDM‑002 | Incluir legendas sincronizadas. | Campo `subtitles` com URL para arquivo WebVTT ou SRT. | Alta | Validação de formato WebVTT/SRT no arquivo referenciado. |
| ACL‑600‑MDM‑003 | Fornecer áudio descritivo quando necessário. | Campo `audioDescription` com URL ou indicação `false`. | Média | Presença do campo `audioDescription`. |
| ACL‑600‑MDM‑004 | Usar marcadores temporais padronizados. | Todos os timestamps no formato ISO 8601. | Média | Validação de formato ISO 8601 em todos os campos temporais. |
| ACL‑600‑MDM‑005 | Fornecer transcrição completa. | Campo `transcript` com texto integral do áudio. | Alta | Presença do campo `transcript` com comprimento proporcional à duração. |

## 5. Metadados de Exemplo (JSON)

```json
{
  "description": "Vídeo tutorial sobre configuração de rede",
  "mediaType": "video/mp4",
  "duration": "PT12M30S",
  "narrativeDescription": "O instrutor demonstra passo a passo a configuração de IP estático em um roteador, iniciando pelo acesso à interface web, seguido da inserção dos dados de rede e finalizando com o teste de conectividade.",
  "subtitles": "https://exemplo.com/subtitles/tutorial-rede.vtt",
  "audioDescription": false,
  "transcript": "Bem-vindos ao tutorial de configuração de rede. Primeiro, acesse a interface do roteador pelo navegador...",
  "license": "https://creativecommons.org/licenses/by/4.0/"
}
```

## 6. Exemplos de Conformidade

| Exemplo | Justificativa |
|---------|-----------|
| **Conforme** – “Vídeo de 12 minutos demonstrando configuração de rede; inclui legendas WebVTT, transcrição completa e descrição narrativa da progressão.” | Cumpre todas as diretrizes: narração, legendas, transcrição e marcadores temporais. |
| **Não conforme** – “Vídeo sobre configuração de rede.” `[viola ACL‑600‑MDM‑001, ACL‑600‑MDM‑002, ACL‑600‑MDM‑005]` | Falta legendas, transcrição, descrição narrativa e marcadores temporais. |

## 7. Estratégia de Validação

1. **Validação de esquema**: garantir que todos os campos obrigatórios (`narrativeDescription`, `subtitles`, `transcript`, `license`) estejam presentes.
2. **Validação de legendas**: o linter **DEVE** verificar se o arquivo WebVTT/SRT é válido e está sincronizado.
3. **Validação de transcrição**: o linter **DEVE** comparar o comprimento da transcrição com a duração do vídeo.
4. **Auditoria de áudio descritivo**: quando `audioDescription` for `false`, o linter **DEVE** verificar se todos os elementos visuais são cobertos pela narração.

## 8. Exemplo de Execução do Lint

```bash
acessilia-lint \
  --schema schemas/acessilia.schema.json \
  --dir ./families/600 \
  --output relatorio-familia600.md
```

O relatório gerado **DEVE** indicar `PASS` ou `FAIL` para cada critério listado na Seção 4.

## 9. Limitações e Exclusões

Esta família aplica‑se a conteúdos audiovisuais e multimídia. Os seguintes tipos de conteúdo **NÃO DEVE** ser descritos exclusivamente usando esta família:

- **Imagens estáticas** → usar [ACESSILIA‑200](../200/ACESSILIA‑200.md).
- **Gráficos e diagramas em vídeo** → aplicar também [ACESSILIA‑300](../300/ACESSILIA‑300.md).
- **Conteúdo científico ou educacional em vídeo** → aplicar também [ACESSILIA‑400](../400/ACESSILIA‑400.md) ou [ACESSILIA‑500](../500/ACESSILIA‑500.md).
- **Conteúdo exclusivamente textual** → não requer descrição multimídia.
- **Áudio sem componente visual** → a transcrição é suficiente; descrição narrativa é opcional.

A sincronização de legendas WebVTT/SRT **DEVE** ser validada ferramentalmente; a verificação manual é impraticável para conteúdos longos.
