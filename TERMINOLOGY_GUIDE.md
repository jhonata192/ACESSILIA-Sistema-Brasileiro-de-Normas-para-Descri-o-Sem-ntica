# Terminology Guide — ACESSILIA

> **Version**: 1.1.0 · **Date**: 2026-07-16  
> This document ensures consistent terminology across all ACESSILIA materials.

---

## 1. Rules for Term Usage

### 1.1 Term Introduction Protocol

Every technical term **MUST** be introduced as follows:

1. **First occurrence**: term in **bold** with full definition in parentheses or an appended clause.
2. **Subsequent occurrences**: plain text (no bold, no re-definition).
3. **Glossary reference**: always cross-reference the authoritative definition in [ACESSILIA-100 §6](ACESSILIA-100.md#6-glossário).

**Example**:
> A **Família** (Family) is a set of rules applicable to a specific content type (e.g., Family 200 for images).
> Each Family is listed in the manifest and identified by a numeric code.

### 1.2 Preferred vs. Deprecated Terms

| Preferred Term (PT) | Preferred Term (EN) | Deprecated / Avoid | Reason |
|---------------------|---------------------|--------------------|----|
| **Família** | **Family** | "módulo" when referring to a family | "Módulo" has a separate meaning (individual file). |
| **Critério** | **Criterion** | "regra", "diretriz" when referring to a criterion | "Regra" is generic; "Diretriz" is a distinct hierarchy level. |
| **Metadata** | **Metadata** | "metadados" (inconsistent casing) | Use "metadata" (lowercase, singular in English; invariant in PT). |
| **Conformidade** | **Conformity** | "compatibilidade", "adequação" | "Conformidade" is the defined normative term in ACESSILIA-100. |
| **Validação** | **Validation** | "verificação" when referring to automated checks | "Verificação" is acceptable in general context but "Validação" is the defined process term. |
| **Auditoria** | **Audit** | "revisão" when referring to the formal audit process | "Revisão" is a broader term; "Auditoria" is the defined formal process. |
| **Diretriz** | **Guideline** | "regra", "norma" | "Diretriz" is a specific level in the criteria hierarchy. |
| **Escopo** | **Scope** | "âmbito", "abrangência" | "Escopo" is the defined term. |
| **Evidência** | **Evidence** | "prova", "comprovação" | "Evidência" is the defined term; avoid legal connotations. |
| **Ponto de Verificação** | **Verification Point** | "ponto de controle" | "Ponto de Verificação" is the defined term. |
| **Perfil** | **Profile** | "conjunto" when referring to a profile | "Perfil" is the defined term for specific criteria sets. |
| **Extensão** | **Extension** | "adição", "complemento" | "Extensão" is the defined mechanism term. |
| **Rastreabilidade** | **Traceability** | "rastreamento" | "Rastreabilidade" is the defined term. |
| **Completude** | **Completeness** | "totalidade" | "Completude" is the defined metric term. |
| **Linter** | **Linter** | "ferramenta de lint" (inconsistent) | Use "linter" or "ACESSILIA Lint" as a proper noun. |
| **Esquema** | **Schema** | "modelo" when referring to JSON/XSD | "Esquema" is the defined technical term. |

### 1.3 RFC 2119 Keywords

All normative documents **MUST** use the RFC 2119 keywords consistently:

| Portuguese | English | Usage |
|------------|---------|-------|
| **DEVE** | **MUST** | Absolute requirement |
| **NÃO DEVE** | **MUST NOT** | Absolute prohibition |
| **PODE** | **MAY** | Optional / permitted |
| **RECOMENDA-SE** | **SHOULD** | Recommended but not required |

> These terms **MUST** appear in **bold uppercase** (PT) or **bold uppercase** (EN) whenever used in a normative context.

---

## 2. Bilingual Convention (Portuguese / English)

### 2.1 Documentation Language

| Context | Language | Rule |
|---------|----------|------|
| Normative documents (families, criteria) | Portuguese (primary) | All narrative text in PT-BR. |
| Metadata field names (JSON) | English (invariant) | `description`, `license`, `imageType`, etc. — never translated. |
| Identifiers | Invariant | `ACL-200-IMG-001` — language-neutral. |
| Glossary terms | Portuguese (primary) | Term in PT with EN equivalent in parentheses on first use. |
| README / repository docs | Bilingual or Portuguese | PT-BR primary; EN available where indicated. |
| RFC 2119 keywords | Portuguese uppercase | **DEVE**, **NÃO DEVE**, etc. |

### 2.2 How to Present Bilingual Terms

On **first occurrence** in any document:

```
**Família** (Family)
```

On subsequent occurrences:

```
Família
```

In tables and glossaries, use two columns:

| Português | English |
|-----------|---------|
| Família | Family |
| Critério | Criterion |
| Conformidade | Conformity |

---

## 3. Abbreviations That Require Explanation

Every abbreviation **MUST** be expanded on first use. The following abbreviations appear across ACESSILIA documents:

| Abbreviation | Full Form | First-Use Context |
|--------------|-----------|-------------------|
| **ACL** | ACESSILIA (identifier prefix) | First occurrence in any document, e.g., "ACL-200-IMG-001" |
| **PII** | Personally Identifiable Information | ACESSILIA-100 §6.3, ACESSILIA-200 §4 |
| **SPDX** | Software Package Data Exchange | ACESSILIA-100 §6.3, ACESSILIA-200 §4 |
| **WCAG** | Web Content Accessibility Guidelines | Every document's references section |
| **EPUB** | Electronic Publication | References sections |
| **PDF/UA** | PDF/Universal Accessibility (ISO 14289) | References sections |
| **DAISY** | Digital Accessible Information System | ACESSILIA-600 references |
| **UML** | Unified Modeling Language | ACESSILIA-300 |
| **ER** | Entity-Relationship | ACESSILIA-300 |
| **JSON** | JavaScript Object Notation | Throughout |
| **XML** | Extensible Markup Language | Throughout |
| **XSD** | XML Schema Definition | ACESSILIA-Base §7 |
| **ISO** | International Organization for Standardization | References |
| **WCAG SC** | WCAG Success Criteria | ACESSILIA-800 §4.4 |
| **CI** | Continuous Integration | ACESSILIA-Base §7.1 |
| **PS** | PowerShell | ACESSILIA-Index infrastructure table |
| **EN** | European Norm | ACESSILIA-Index conformidade externa |
| **HTTPS** | Hypertext Transfer Protocol Secure | URLs throughout |
| **UUID** | Universally Unique Identifier | ACESSILIA_SPEC_CH01 §16 |

---

## 4. ACESSILIA-100 Core Terminology

The following terms are **authoritatively defined** in [ACESSILIA-100 §6](ACESSILIA-100.md#6-glossário). All ACESSILIA documents **MUST** use these definitions without paraphrase.

### 4.1 Fundamental Terms

| Term (PT) | Term (EN) | Definition (from ACESSILIA-100) |
|-----------|-----------|--------------------------------|
| **Objetividade** | Objectivity | Principle of reporting only what can be directly observed. |
| **Fidelidade (Princípio)** | Fidelity (Principle) | Qualitative principle: description without information lacking observable evidence. |
| **Fidelidade Semântica (Métrica)** | Semantic Fidelity (Metric) | Quantitative metric: percentage of correspondence with original content (>= 90%). |
| **Clareza** | Clarity | Principle of objective language, free of ambiguity and value judgments. |
| **Consistência** | Consistency | Principle of uniform use of terms and structure throughout the document. |
| **Reprodutibilidade** | Reproducibility | Ability of different independent descriptors to reach equivalent results (>= 85%). |
| **Neutralidade** | Neutrality | Principle of not expressing personal opinion or preference in the description. |

### 4.2 Operational Terms

| Term (PT) | Term (EN) | Definition (from ACESSILIA-100) |
|-----------|-----------|--------------------------------|
| **Escopo** | Scope | Delimitation of the content type to which the rules of a family apply. |
| **Diretriz** | Guideline | Qualitative rule that guides the elaboration of descriptions within a family. |
| **Evidência** | Evidence | Observable data that supports a statement in the description. |
| **Evidência Obrigatória** | Mandatory Evidence | Data that MUST be present for the criterion to be met. |
| **Ponto de Verificação** | Verification Point | Location or method by which criterion conformity is verified. |
| **Importância** | Importance | Priority level of a criterion (Alta/High or Média/Medium). |
| **Esquema** | Schema | JSON or XSD file that defines the mandatory structure of metadata. |
| **Manifesto** | Manifest | `manifest.yml` file listing families, import order, and version. |
| **Módulo** | Module | Individual file of a family that can be included in usage context. |
| **Rastreabilidade** | Traceability | Ability to trace each criterion by its permanent identifier. |
| **Conformidade** | Conformity | State of meeting all applicable mandatory criteria. |
| **Relatório de Conformidade** | Conformity Report | Document generated by the linter with PASS/FAIL result per criterion. |
| **Validação** | Validation | Process of verifying whether content and metadata meet requirements. |
| **Auditoria** | Audit | Independent human review to validate conformity beyond automatic validation. |
| **Perfil** | Profile | Set of criteria and specific requirements for a content type or usage scenario. |
| **Extensão** | Extension | Mechanism by which new profiles add criteria beyond base families. |
| **Completude** | Completeness | Percentage of mandatory fields filled in metadata relative to total required by the schema. |

### 4.3 Technical Terms

| Term (PT) | Term (EN) | Definition (from ACESSILIA-100) |
|-----------|-----------|--------------------------------|
| **PII** | PII | Personally Identifiable Information. |
| **SPDX** | SPDX | Software Package Data Exchange — standard for license identification. |
| **Contraste de Luminância** | Luminance Contrast | Minimum luminance ratio between text and background (>= 4.5:1 per WCAG). |
| **Contraste de Cores** | Color Contrast | Use of differentiating colors with associated textual meaning. |
| **Verbo de Bloom** | Bloom Verb | Measurable action verb used in Bloom's taxonomy for educational objectives. |
| **Flesch-Kincaid** | Flesch-Kincaid | Readability formula measuring text comprehensibility. |
| **Legenda (Gráfico)** | Chart Legend | Text describing axes, units, and elements of a chart or diagram. |
| **Legenda (Video)** | Caption (Video) | Text synchronized with audio that transcribes speech and relevant sounds. |
| **Indice de Gunning** | Gunning Index | Alternative readability formula for measuring text comprehensibility. |

---

## 5. Criteria Hierarchy

The ACESSILIA criteria hierarchy **MUST** be referenced in this exact order and with these exact terms:

```
Principio > Diretriz > Criterio > Metodo > Tecnica > Falha > Exemplo
(Principle) (Guideline) (Criterion) (Method) (Technique) (Failure) (Example)
```

**Do NOT** use synonyms or reorder these terms when describing the hierarchy.

---

## 6. Identifier Convention

All permanent identifiers follow the pattern:

```
ACL-<FAMILIA>-<TIPO>-<NUMERO>
```

| Family | Type Code | Example |
|--------|-----------|---------|
| 100 | T | `ACL-100-T001` |
| 200 | IMG | `ACL-200-IMG-001` |
| 300 | GRF | `ACL-300-GRF-001` |
| 400 | SCI | `ACL-400-SCI-001` |
| 500 | EDU | `ACL-500-EDU-001` |
| 600 | MDM | `ACL-600-MDM-001` |
| 700 | VAL | `ACL-700-VAL-001` |
| 800 | PRF | `ACL-800-PRF-001` |

> These IDs are **fixed** and do not change between versions.

---

## 7. Conformance Level Names

| Level | Full Name (PT) | Full Name (EN) |
|-------|----------------|----------------|
| **A** | ACESSILIA-A | ACESSILIA-A |
| **AA** | ACESSILIA-AA | ACESSILIA-AA |
| **AAA** | ACESSILIA-AAA | ACESSILIA-AAA |

> Do **NOT** use "Básico", "Intermediário", "Avançado" as substitutes for the level designations. Those are descriptive labels, not formal names.

---

## 8. Versioning Terms

| Term (PT) | Term (EN) | Usage |
|-----------|-----------|-------|
| **MAJOR** | MAJOR | Structural change or new family introduction. |
| **MINOR** | MINOR | Addition or alteration of a criterion within a family. |
| **PATCH** | PATCH | Editorial correction or minor redaction improvements. |

---

## 9. Review Phase Terms

| Term (PT) | Term (EN) |
|-----------|-----------|
| **Draft** | Draft |
| **Working Draft** | Working Draft |
| **Candidate Recommendation** | Candidate Recommendation |
| **Recommendation** | Recommendation |

> These phase names are **invariant** — they are not translated.

---

## 10. Checklist for Terminology Review

Before publishing any ACESSILIA document, verify:

- [ ] All technical terms are bold on first occurrence with definition.
- [ ] Abbreviations are expanded on first use.
- [ ] RFC 2119 keywords are in bold uppercase.
- [ ] Metadata field names are in English (lowercase).
- [ ] Identifiers follow the `ACL-<FAM>-<TYPE>-<NUM>` pattern.
- [ ] Conformance levels use A/AA/AAA (not descriptive labels).
- [ ] No deprecated terms from Section 1.2 are used.
- [ ] Cross-reference to ACESSILIA-100 glossary is present.
- [ ] Bilingual terms follow the convention in Section 2.2.
- [ ] Criteria hierarchy follows Section 5 order.
