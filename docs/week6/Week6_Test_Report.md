# Offline Multimodal Local Retrieval System

# Week 6 Software Test Report

## 1. Document Control

| Field | Value |
|---|---|
| Project | Offline Multimodal Local Retrieval System |
| Document Title | Week 6 Software Test Report |
| Document Type | Component and Integration Test Report |
| Version | 0.1 Draft |
| Status | Draft |
| Author | Mingxuan Huang |
| Date | 2026/07/27 |
| Test Stage | Week 6 Embedding and Similarity Search |
| Reference Approach | Structured with reference to ISO/IEC/IEEE 29119-3 test documentation principles |

---

## 2. Purpose

This document records the test scope, environment, test cases, expected results, actual results, defects, risks, traceability, and conclusion for the Week 6 embedding and similarity-search implementation.

The report provides evidence that the Week 6 pipeline was executed and validated.

It does not claim formal ISO certification.

---

## 3. Test Objective

The main objective was to verify the complete Week 6 retrieval pipeline:

```text
Local file parsing
→ Text processing
→ Text chunking
→ Vocabulary generation
→ Embedding-vector generation
→ Query-vector generation
→ Cosine-similarity calculation
→ Result filtering
→ Result ranking
```

The testing aimed to confirm that:

- Supported local files are parsed.
- Unsupported files do not stop the pipeline.
- Searchable documents are generated.
- Documents are divided into text chunks.
- A shared vocabulary is created.
- One vector is generated for each chunk.
- Vector dimensions remain consistent.
- Related queries return ranked results.
- Unrelated queries return no result.
- Cosine-similarity values remain valid.
- Result limits and validation logic operate safely.

---

## 4. Test Scope

### 4.1 Included

The following areas were included:

- Local sample-directory access
- TXT file parsing
- Markdown file parsing
- Unsupported PDF handling
- Parsed-document conversion
- Text cleaning and normalisation
- Text chunk generation
- Shared vocabulary generation
- Term-frequency vector generation
- Query-vector generation
- Cosine-similarity calculation
- Similarity-result creation
- Similarity-score filtering
- Descending result sorting
- Result limiting
- Zero-query-vector handling
- Vector-dimension validation
- Error handling in the test script

### 4.2 Excluded

The following areas were excluded:

- PDF content extraction
- Word document parsing
- PowerPoint parsing
- Optical character recognition
- Neural semantic embeddings
- Image embeddings
- Persistent vector storage
- Database testing
- Flutter UI testing
- Accessibility testing
- Large-scale performance testing
- Security penetration testing
- Cloud or network API testing

---

## 5. Items Under Test

The main Week 6 files under test were:

```text
lib/models/embedding_vector.dart
lib/models/similarity_result.dart
lib/services/simple_embedding_service.dart
lib/services/similarity_search_service.dart
tool/test_similarity_search.dart
```

The following earlier modules were included in the integration test:

```text
lib/services/file_parser_service.dart
lib/services/text_processing_service.dart
lib/services/text_chunking_service.dart
```

---

## 6. Test Environment

| Item | Configuration |
|---|---|
| Operating System | Microsoft Windows |
| Programming Language | Dart |
| Framework | Flutter project with Dart command-line test |
| Test Type | Component and integration testing |
| Execution Method | Command-line |
| Test Command | `dart run tool/test_similarity_search.dart` |
| Data Directory | `data/sample_documents` |
| Supported Test File 1 | `sample1.txt` |
| Supported Test File 2 | `sample2.md` |
| Unsupported Test File | `sample3.pdf` |
| Storage | Local file system |
| Vector Storage | In memory |
| Network Requirement | None |

---

## 7. Test Data

### 7.1 sample1.txt

Expected content:

```text
this is a sample text file for metadata extraction testing.
```

### 7.2 sample2.md

Expected searchable content:

```text
sample markdown document this file is used to test the metadata extraction module.
```

### 7.3 sample3.pdf

The PDF is intentionally unsupported during Week 6.

Expected behaviour:

```text
Unsupported file type skipped: sample3.pdf
```

### 7.4 Queries

The following queries were tested:

```text
metadata extraction
markdown document
local search
unrelated query
```

---

## 8. Entry Criteria

Testing could begin when:

- The Week 6 source code was present.
- The project dependencies were resolved.
- The sample document directory existed.
- Earlier file parsing was functional.
- Earlier text processing was functional.
- Earlier text chunking was functional.
- The Week 6 test script compiled.
- No blocking source-code syntax error remained.

---

## 9. Exit Criteria

Testing was considered complete when:

- All planned test cases were executed.
- Supported files were parsed.
- Unsupported PDF handling was confirmed.
- Text chunks were generated.
- A shared vocabulary was generated.
- One embedding vector was generated per chunk.
- Vector dimensions were consistent.
- Related queries returned ranked results.
- Unrelated queries returned no result.
- No critical unhandled runtime exception remained.
- Test evidence was recorded.

---

## 10. Test Approach

The Week 6 test used an integration-oriented command-line approach.

The complete test sequence was:

```text
1. Load sample directory
2. Parse supported files
3. Convert parsed documents into searchable documents
4. Divide searchable documents into chunks
5. Build one shared vocabulary
6. Generate one vector per chunk
7. Print pipeline summary
8. Print generated chunks
9. Print vocabulary
10. Execute related and unrelated queries
11. Print ranked results
12. Print no-result messages
```

The test script was:

```text
tool/test_similarity_search.dart
```

The execution command was:

```bash
dart run tool/test_similarity_search.dart
```

---

## 11. Test Cases

| Test ID | Requirement ID | Interface ID | Test Case | Input | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|---|---|
| TC-W6-001 | REQ-W6-009 | API-W6-011 | Parse supported files | Sample directory | TXT and Markdown files are parsed | Two supported documents parsed | Pass |
| TC-W6-002 | REQ-W6-010 | API-W6-011 | Skip unsupported PDF | `sample3.pdf` | PDF skipped without terminating pipeline | PDF safely skipped | Pass |
| TC-W6-003 | REQ-W6-011 | API-W6-012 | Convert to searchable documents | Two parsed documents | Two searchable documents generated | Two searchable documents generated | Pass |
| TC-W6-004 | REQ-W6-001 | API-W6-003 | Build shared vocabulary | Four text chunks | Shared vocabulary generated | 17 vocabulary terms generated | Pass |
| TC-W6-005 | REQ-W6-002 | API-W6-004 | Generate vectors | Four text chunks | One vector per chunk | Four vectors generated | Pass |
| TC-W6-006 | REQ-W6-007 | API-W6-009 | Validate vector dimensions | Four vectors | All vectors use equal dimensions | All vectors use 17 dimensions | Pass |
| TC-W6-007 | REQ-W6-005 | API-W6-009 | Search related query | `metadata extraction` | Ranked relevant chunks returned | Three ranked results returned | Pass |
| TC-W6-008 | REQ-W6-005 | API-W6-009 | Search Markdown query | `markdown document` | Relevant Markdown chunk returned | Correct Markdown chunk returned | Pass |
| TC-W6-009 | REQ-W6-006 | API-W6-009 | Search out-of-vocabulary query | `local search` | Empty result returned | No similar chunks found | Pass |
| TC-W6-010 | REQ-W6-006 | API-W6-009 | Search unrelated query | `unrelated query` | Empty result returned | No similar chunks found | Pass |
| TC-W6-011 | REQ-W6-008 | API-W6-009 | Apply result limit | Limit `3` | No more than three results returned | Maximum of three returned | Pass |
| TC-W6-012 | REQ-W6-004 | API-W6-010 | Validate cosine score | Query and document vectors | Score is between `0.0` and `1.0` | Valid scores produced | Pass |
| TC-W6-013 | REQ-W6-003 | API-W6-006 | Generate zero query vector | Unknown vocabulary terms | Zero vector generated | Empty search result returned safely | Pass |
| TC-W6-014 | REQ-W6-012 | API-W6-013 | Generate text chunks | Two searchable documents | Four chunks generated with test chunk size | Four chunks generated | Pass |

---

## 12. Detailed Test Results

## 12.1 TC-W6-001 — Supported File Parsing

### Objective

Verify that supported local files are parsed.

### Input

```text
data/sample_documents
```

### Expected Result

```text
sample1.txt
sample2.md
```

should be parsed.

### Actual Result

```text
Total Parsed Documents: 2
```

### Status

```text
Pass
```

---

## 12.2 TC-W6-002 — Unsupported PDF Handling

### Objective

Verify that unsupported PDF files are skipped safely.

### Input

```text
sample3.pdf
```

### Expected Result

The PDF should be skipped without terminating the application.

### Actual Result

```text
Unsupported file type skipped: sample3.pdf
```

### Status

```text
Pass
```

---

## 12.3 TC-W6-003 — Searchable Document Conversion

### Objective

Verify that parsed documents are converted into searchable documents.

### Expected Result

Two parsed documents should produce two searchable documents.

### Actual Result

```text
Total Searchable Documents: 2
```

### Status

```text
Pass
```

---

## 12.4 TC-W6-004 — Vocabulary Generation

### Objective

Verify that one shared vocabulary is generated.

### Expected Result

A non-empty, unique, ordered vocabulary should be returned.

### Actual Result

```text
Vocabulary Size: 17
```

Generated terms:

```text
a, document, extraction, file, for, is, markdown, metadata,
module, sample, test, testing, text, the, this, to, used
```

### Status

```text
Pass
```

---

## 12.5 TC-W6-005 — Embedding Generation

### Objective

Verify that one embedding vector is generated per text chunk.

### Expected Result

Four chunks should produce four embedding vectors.

### Actual Result

```text
Total Text Chunks: 4
Total Embedding Vectors: 4
```

### Status

```text
Pass
```

---

## 12.6 TC-W6-006 — Vector Dimension Consistency

### Objective

Verify that all vectors use the same vocabulary dimension.

### Expected Result

All generated vectors should contain 17 values.

### Actual Result

```text
Embedding Dimension: 17
```

### Status

```text
Pass
```

---

## 12.7 TC-W6-007 — Related Query Search

### Query

```text
metadata extraction
```

### Expected Result

The most relevant chunks should be returned first.

### Actual Result

```text
1. sample2.md - chunk 1
   Similarity Score: 0.6325

2. sample1.txt - chunk 1
   Similarity Score: 0.5000

3. sample1.txt - chunk 0
   Similarity Score: 0.2500
```

### Interpretation

The first result contained both query terms and therefore received the highest score.

### Status

```text
Pass
```

---

## 12.8 TC-W6-008 — Markdown Query Search

### Query

```text
markdown document
```

### Expected Result

The Markdown document chunk should be returned.

### Actual Result

```text
sample2.md - chunk 0
Similarity Score: 0.5000
```

### Status

```text
Pass
```

---

## 12.9 TC-W6-009 — Unknown Vocabulary Query

### Query

```text
local search
```

### Expected Result

No result should be returned because neither query term exists in the vocabulary.

### Actual Result

```text
No similar chunks found.
```

### Status

```text
Pass
```

---

## 12.10 TC-W6-010 — Unrelated Query

### Query

```text
unrelated query
```

### Expected Result

No result should be returned.

### Actual Result

```text
No similar chunks found.
```

### Status

```text
Pass
```

---

## 12.11 TC-W6-011 — Result Limit

### Input

```text
limit: 3
```

### Expected Result

The search should return no more than three results.

### Actual Result

The `metadata extraction` search returned three results.

### Status

```text
Pass
```

---

## 12.12 TC-W6-012 — Cosine-Similarity Range

### Expected Result

For the non-negative term-frequency vectors used by the prototype, similarity scores should remain between:

```text
0.0 and 1.0
```

### Actual Result

Recorded scores included:

```text
0.6325
0.5000
0.2500
```

All values were within the expected range.

### Status

```text
Pass
```

---

## 13. Recorded Pipeline Summary

The test execution produced:

```text
Total Parsed Documents: 2
Total Searchable Documents: 2
Total Text Chunks: 4
Vocabulary Size: 17
Total Embedding Vectors: 4
Embedding Dimension: 17
```

This confirms:

- The parser returned two supported documents.
- Text processing returned two searchable documents.
- Chunking generated four text chunks.
- Vocabulary generation produced 17 unique terms.
- Embedding generation produced four vectors.
- Every embedding used 17 dimensions.

---

## 14. Test Execution Summary

| Metric | Result |
|---|---:|
| Planned test cases | 14 |
| Executed test cases | 14 |
| Passed | 14 |
| Failed | 0 |
| Blocked | 0 |
| Not executed | 0 |
| Pass rate | 100% |

### Overall Result

```text
PASS
```

---

## 15. Defects and Issues

| Issue ID | Description | Severity | Resolution | Status |
|---|---|---|---|---|
| DEF-W6-001 | The test script called a non-existent `processDocuments()` method | Medium | Replaced with the existing typed conversion method | Closed |
| DEF-W6-002 | A second attempt called a non-existent `processDocument()` method | Medium | Confirmed the correct method name | Closed |
| DEF-W6-003 | `List<dynamic>` could not be passed to `chunkDocuments()` | Medium | Used `convertToSearchableDocuments()` to preserve `List<SearchableDocument>` | Closed |
| DEF-W6-004 | PDF content extraction is unsupported | Low | Unsupported PDF is skipped safely | Open limitation |
| DEF-W6-005 | Unknown query terms produce a zero vector | Low | Zero vector is detected and returns no results | Closed by design |
| DEF-W6-006 | Current embedding is not semantically trained | Medium | Recorded as a future improvement | Open limitation |

---

## 16. Root Cause Analysis

## 16.1 Incorrect Method Names

The original test script assumed the text-processing service contained:

```text
processDocuments()
```

or:

```text
processDocument()
```

The actual interface was:

```text
convertToSearchableDocuments()
```

The issue resulted from a mismatch between the new test script and the existing service API.

### Corrective Action

The test script was changed to use the existing batch conversion method.

---

## 16.2 Dynamic List Type

Using an invalid mapping expression caused Dart to infer:

```text
List<dynamic>
```

The chunking service required:

```text
List<SearchableDocument>
```

### Corrective Action

The typed batch conversion method was used directly.

---

## 17. Requirements Traceability Matrix

| Requirement ID | Requirement | Interface ID | Test ID | Result |
|---|---|---|---|---|
| REQ-W6-001 | Build a shared ordered vocabulary | API-W6-003 | TC-W6-004 | Pass |
| REQ-W6-002 | Generate one vector per text chunk | API-W6-004 | TC-W6-005 | Pass |
| REQ-W6-003 | Generate a vector for user queries | API-W6-006 | TC-W6-013 | Pass |
| REQ-W6-004 | Calculate cosine similarity | API-W6-010 | TC-W6-012 | Pass |
| REQ-W6-005 | Rank related results | API-W6-009 | TC-W6-007, TC-W6-008 | Pass |
| REQ-W6-006 | Handle unknown and unrelated queries | API-W6-009 | TC-W6-009, TC-W6-010 | Pass |
| REQ-W6-007 | Validate consistent dimensions | API-W6-009 | TC-W6-006 | Pass |
| REQ-W6-008 | Apply an optional result limit | API-W6-009 | TC-W6-011 | Pass |
| REQ-W6-009 | Parse supported files | API-W6-011 | TC-W6-001 | Pass |
| REQ-W6-010 | Skip unsupported files safely | API-W6-011 | TC-W6-002 | Pass |
| REQ-W6-011 | Generate searchable documents | API-W6-012 | TC-W6-003 | Pass |
| REQ-W6-012 | Generate smaller text chunks | API-W6-013 | TC-W6-014 | Pass |

---

## 18. Risk Assessment

| Risk ID | Risk | Impact | Likelihood | Mitigation |
|---|---|---|---|---|
| RISK-W6-001 | Small dataset may not represent realistic retrieval performance | High | High | Add larger test datasets |
| RISK-W6-002 | Exact vocabulary matching limits semantic search | High | High | Introduce trained embeddings |
| RISK-W6-003 | In-memory vectors must be regenerated | Medium | High | Add persistent vector storage |
| RISK-W6-004 | Unsupported PDF files reduce coverage | Medium | High | Add PDF parser |
| RISK-W6-005 | No automated CI test execution | Medium | Medium | Add automated unit and integration tests |
| RISK-W6-006 | No performance benchmark | Medium | Medium | Add timing and scalability tests |
| RISK-W6-007 | No image retrieval | High | High | Add image embedding pipeline |

---

## 19. Current Limitations

- The test dataset is small.
- Only TXT and Markdown content are parsed.
- PDF content is skipped.
- The current vectors use term frequency.
- Synonyms are not recognised.
- No TF-IDF weighting is used.
- No trained embedding model is used.
- No image vector is generated.
- No persistent database is used.
- No stress test was performed.
- No load test was performed.
- No memory benchmark was performed.
- No accessibility test was performed.
- No security test was performed.
- No cross-platform comparison was performed.
- No automated CI workflow was used.

---

## 20. Regression Testing Recommendation

The following test cases should be rerun after future changes:

```text
TC-W6-001
TC-W6-002
TC-W6-004
TC-W6-005
TC-W6-006
TC-W6-007
TC-W6-008
TC-W6-009
TC-W6-010
TC-W6-011
TC-W6-012
```

Regression testing is especially important after:

- Replacing term-frequency vectors
- Adding BERT or TensorFlow Lite
- Adding persistent vector storage
- Changing the tokenizer
- Changing chunk size
- Adding PDF parsing
- Adding image retrieval
- Changing result-score filtering
- Changing result limits

---

## 21. Test Conclusion

The Week 6 embedding and similarity-search implementation passed all planned component and integration test cases.

The test confirmed that the system can:

```text
Parse supported files
→ Generate searchable documents
→ Generate text chunks
→ Build a vocabulary
→ Generate vectors
→ Generate query vectors
→ Calculate cosine similarity
→ Rank related results
→ Filter unrelated queries
→ Limit result counts
```

No critical unresolved runtime defect remained in the tested Week 6 pipeline.

The unsupported PDF format and the limitations of term-frequency vectors were documented as known limitations.

The overall Week 6 test result was:

```text
PASS
```

---

## 22. Completion Status

This document is currently marked as:

```text
Version: 0.1 Draft
Status: Draft
```

The core test cases, execution results, defects, and traceability structure have been recorded.

Final screenshots, exact execution date, final reviewer information, GitHub evidence, and document approval status will be added after Week 8.