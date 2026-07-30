# Offline Multimodal Local Retrieval System

# Week 6 Software Test Report

## 1. Document Control

| Field | Value |
|---|---|
| Project | Offline Multimodal Local Retrieval System |
| Document Title | Week 6 Software Test Report |
| Document Type | Component and Integration Test Report |
| Version | 1.1 |
| Status | Final |
| Author | Mingxuan Huang |
| Original Test Stage | Week 6 Embedding and Similarity Search |
| Original Test Date | 2026/07/14 |
| Final Revision Date | 2026/07/30 |
| Test Method | Command-line component and integration testing |
| Reference Approach | Structured with reference to ISO/IEC/IEEE 29119-3 test documentation principles |

---

## 2. Document Revision History

| Version | Date | Description | Status |
|---|---|---|---|
| 0.1 | 2026/07/27 | Initial structured test-report draft | Draft |
| 1.0 | 2026/07/27 | Finalised Week 6 test cases, results, risks, and traceability | Final |
| 1.1 | 2026/07/30 | Added module-level test summary, execution statistics, and clarified test-case implementation | Final |

---

## 3. Purpose

This document records the test scope, environment, test cases, expected results, actual results, defects, risks, traceability, and final conclusion for the Week 6 embedding and similarity-search implementation.

The report provides evidence that the Week 6 retrieval pipeline was executed and validated.

The document also provides a module-level summary showing:

- Number of planned test cases for each module
- Number of test cases actually executed
- Number of passed test cases
- Number of failed test cases
- Pass rate for each module
- Test-case identifiers associated with each module

This document does not claim formal ISO certification.

Its structure is organised with reference to ISO/IEC/IEEE 29119-3 software-test documentation principles.

---

## 4. Test Objective

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

- Supported local files are parsed successfully.
- Unsupported files do not terminate the pipeline.
- Parsed documents are converted into searchable documents.
- Searchable documents are divided into text chunks.
- A shared vocabulary is created.
- One vector is generated for each text chunk.
- Vector dimensions remain consistent.
- User queries are converted into query vectors.
- Related queries return ranked results.
- Unrelated queries return no results.
- Cosine-similarity values remain valid.
- Result limits operate correctly.
- Zero query vectors are handled safely.
- No critical unhandled runtime error remains.

---

## 5. System Under Test

The Week 6 system under test was the embedding and similarity-search pipeline of the Offline Multimodal Local Retrieval System.

The complete pipeline was:

```text
Local sample documents
→ FileParserService
→ ParsedDocument
→ TextProcessingService
→ SearchableDocument
→ TextChunkingService
→ TextChunk
→ SimpleEmbeddingService
→ EmbeddingVector
→ SimilaritySearchService
→ SimilarityResult
```

The main Week 6 source files under test were:

```text
lib/models/embedding_vector.dart
lib/models/similarity_result.dart
lib/services/simple_embedding_service.dart
lib/services/similarity_search_service.dart
tool/test_similarity_search.dart
```

The following earlier modules were also included because Week 6 depended on them:

```text
lib/services/file_parser_service.dart
lib/services/text_processing_service.dart
lib/services/text_chunking_service.dart
```

---

## 6. Test Scope

### 6.1 Included

The following areas were included in Week 6 testing:

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
- Vector-dimension consistency
- Cosine-similarity calculation
- Similarity-result creation
- Similarity-score filtering
- Descending result sorting
- Result limiting
- Zero-query-vector handling
- Empty-result handling
- Error handling in the integration test script

### 6.2 Excluded

The following areas were outside the Week 6 test scope:

- PDF content extraction
- Word document parsing
- PowerPoint parsing
- Optical character recognition
- Image embeddings
- Multimodal retrieval
- Neural semantic embeddings
- Persistent vector storage
- Database testing
- Flutter user-interface testing
- Accessibility testing
- Large-scale performance testing
- Stress testing
- Security penetration testing
- Cloud deployment
- HTTP or REST API testing

---

## 7. Test Environment

| Item | Configuration |
|---|---|
| Operating System | Microsoft Windows |
| Programming Language | Dart |
| Framework | Flutter project with Dart command-line test |
| Test Level | Component and integration testing |
| Execution Method | Command-line |
| Main Test Script | `tool/test_similarity_search.dart` |
| Test Command | `dart run tool/test_similarity_search.dart` |
| Data Directory | `data/sample_documents` |
| Supported Test File 1 | `sample1.txt` |
| Supported Test File 2 | `sample2.md` |
| Unsupported Test File | `sample3.pdf` |
| Local Storage | Local file system |
| Vector Storage | In memory |
| Network Requirement | None |
| External Model Requirement | None |

---

## 8. Test Data

### 8.1 `sample1.txt`

Expected searchable content:

```text
this is a sample text file for metadata extraction testing.
```

### 8.2 `sample2.md`

Expected searchable content:

```text
sample markdown document this file is used to test the metadata extraction module.
```

### 8.3 `sample3.pdf`

The PDF file was intentionally unsupported during Week 6.

Expected behaviour:

```text
Unsupported file type skipped: sample3.pdf
```

The unsupported file should not terminate the retrieval pipeline.

### 8.4 Search Queries

The following queries were used:

```text
metadata extraction
markdown document
local search
unrelated query
```

### 8.5 Search Configuration

The similarity-search test used:

```text
minimumScore: 0.0
limit: 3
```

The text-chunking test used a deliberately small chunk size to generate multiple chunks from the sample files.

---

## 9. Entry Criteria

Testing could begin when:

- The Week 6 source files were available.
- The project dependencies were resolved.
- The sample-document directory existed.
- Earlier file parsing was functional.
- Earlier text processing was functional.
- Earlier text chunking was functional.
- The Week 6 embedding service compiled.
- The Week 6 similarity-search service compiled.
- The integration test script could be executed.
- No blocking source-code syntax error remained.

---

## 10. Exit Criteria

Testing was considered complete when:

- All planned Week 6 test cases were executed.
- Supported files were parsed successfully.
- Unsupported PDF handling was confirmed.
- Searchable documents were generated.
- Text chunks were generated.
- A shared vocabulary was generated.
- One embedding vector was generated per chunk.
- All vectors used consistent dimensions.
- Query vectors were generated.
- Related queries returned ranked results.
- Unrelated queries returned no results.
- Result limiting was confirmed.
- Cosine-similarity scores remained valid.
- No critical unhandled runtime exception remained.
- Test results and defects were documented.
- Requirements, interfaces, and tests were traceable.

---

## 11. Test Approach

The Week 6 test used an integration-oriented command-line approach.

The complete execution sequence was:

```text
1. Load the sample-document directory
2. Parse supported local files
3. Skip unsupported files safely
4. Convert parsed documents into searchable documents
5. Divide searchable documents into text chunks
6. Build one shared vocabulary
7. Generate one vector for each text chunk
8. Validate vector dimensions
9. Generate vectors for user queries
10. Calculate cosine similarity
11. Filter results
12. Rank results in descending order
13. Apply the result limit
14. Print related and unrelated query results
```

The test command was:

```bash
dart run tool/test_similarity_search.dart
```

---

## 12. Test-Case Implementation Clarification

The Week 6 report contains 14 test cases.

These 14 test cases represent 14 separately defined functional test scenarios.

However, they were executed through one integrated command-line test script:

```text
tool/test_similarity_search.dart
```

They were not implemented as 14 separate automated test functions.

Therefore:

```text
14 test cases
≠
14 independent automated test functions
```

The accurate description is:

> The 14 test cases were verified as individual functional scenarios within the integrated Week 6 command-line test execution. They were not implemented as 14 separate automated test functions.

This distinction ensures that the report accurately describes both the test coverage and the level of test automation.

---

## 13. Module-Level Test Summary

The following table summarises the number of planned, executed, passed, and failed test cases for each tested module.

| Module | Planned Test Cases | Executed Test Cases | Passed | Failed | Blocked | Pass Rate |
|---|---:|---:|---:|---:|---:|---:|
| File Parsing and Unsupported File Handling | 2 | 2 | 2 | 0 | 0 | 100% |
| Text Processing | 1 | 1 | 1 | 0 | 0 | 100% |
| Text Chunking | 1 | 1 | 1 | 0 | 0 | 100% |
| Vocabulary Generation | 1 | 1 | 1 | 0 | 0 | 100% |
| Embedding Generation and Dimension Validation | 2 | 2 | 2 | 0 | 0 | 100% |
| Query Vector Generation | 1 | 1 | 1 | 0 | 0 | 100% |
| Similarity Search, Ranking, Filtering, and Result Limiting | 6 | 6 | 6 | 0 | 0 | 100% |
| **Total** | **14** | **14** | **14** | **0** | **0** | **100%** |

---

## 14. Module-to-Test-Case Mapping

### 14.1 File Parsing and Unsupported File Handling

| Test ID | Test Scenario | Result |
|---|---|---|
| TC-W6-001 | Parse supported TXT and Markdown files | Pass |
| TC-W6-002 | Skip unsupported PDF safely | Pass |

Module result:

```text
Planned: 2
Executed: 2
Passed: 2
Failed: 0
Pass rate: 100%
```

### 14.2 Text Processing

| Test ID | Test Scenario | Result |
|---|---|---|
| TC-W6-003 | Convert parsed documents into searchable documents | Pass |

Module result:

```text
Planned: 1
Executed: 1
Passed: 1
Failed: 0
Pass rate: 100%
```

### 14.3 Text Chunking

| Test ID | Test Scenario | Result |
|---|---|---|
| TC-W6-014 | Generate text chunks from searchable documents | Pass |

Module result:

```text
Planned: 1
Executed: 1
Passed: 1
Failed: 0
Pass rate: 100%
```

### 14.4 Vocabulary Generation

| Test ID | Test Scenario | Result |
|---|---|---|
| TC-W6-004 | Build one shared ordered vocabulary | Pass |

Module result:

```text
Planned: 1
Executed: 1
Passed: 1
Failed: 0
Pass rate: 100%
```

### 14.5 Embedding Generation and Dimension Validation

| Test ID | Test Scenario | Result |
|---|---|---|
| TC-W6-005 | Generate one embedding vector per text chunk | Pass |
| TC-W6-006 | Validate consistent vector dimensions | Pass |

Module result:

```text
Planned: 2
Executed: 2
Passed: 2
Failed: 0
Pass rate: 100%
```

### 14.6 Query Vector Generation

| Test ID | Test Scenario | Result |
|---|---|---|
| TC-W6-013 | Generate and handle a zero query vector | Pass |

Module result:

```text
Planned: 1
Executed: 1
Passed: 1
Failed: 0
Pass rate: 100%
```

### 14.7 Similarity Search, Ranking, Filtering, and Result Limiting

| Test ID | Test Scenario | Result |
|---|---|---|
| TC-W6-007 | Search a related metadata query | Pass |
| TC-W6-008 | Search a Markdown-related query | Pass |
| TC-W6-009 | Search an out-of-vocabulary query | Pass |
| TC-W6-010 | Search an unrelated query | Pass |
| TC-W6-011 | Apply a maximum result limit | Pass |
| TC-W6-012 | Validate cosine-similarity score range | Pass |

Module result:

```text
Planned: 6
Executed: 6
Passed: 6
Failed: 0
Pass rate: 100%
```

---

## 15. Complete Test-Case Table

| Test ID | Requirement ID | Interface ID | Module | Test Case | Input | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|---|---|---|
| TC-W6-001 | REQ-W6-009 | API-W6-011 | File Parsing | Parse supported files | Sample directory | TXT and Markdown files are parsed | Two supported documents parsed | Pass |
| TC-W6-002 | REQ-W6-010 | API-W6-011 | File Parsing | Skip unsupported PDF | `sample3.pdf` | PDF is skipped without terminating pipeline | PDF safely skipped | Pass |
| TC-W6-003 | REQ-W6-011 | API-W6-012 | Text Processing | Convert parsed documents | Two parsed documents | Two searchable documents are generated | Two searchable documents generated | Pass |
| TC-W6-004 | REQ-W6-001 | API-W6-003 | Vocabulary Generation | Build shared vocabulary | Four text chunks | Shared vocabulary is generated | 17 vocabulary terms generated | Pass |
| TC-W6-005 | REQ-W6-002 | API-W6-004 | Embedding Generation | Generate embedding vectors | Four text chunks | One vector is generated per chunk | Four vectors generated | Pass |
| TC-W6-006 | REQ-W6-007 | API-W6-009 | Embedding Validation | Validate vector dimensions | Four vectors | All vectors use equal dimensions | All vectors use 17 dimensions | Pass |
| TC-W6-007 | REQ-W6-005 | API-W6-009 | Similarity Search | Search related query | `metadata extraction` | Ranked relevant chunks are returned | Three ranked results returned | Pass |
| TC-W6-008 | REQ-W6-005 | API-W6-009 | Similarity Search | Search Markdown query | `markdown document` | Relevant Markdown chunk is returned | Correct Markdown chunk returned | Pass |
| TC-W6-009 | REQ-W6-006 | API-W6-009 | Result Handling | Search out-of-vocabulary query | `local search` | Empty result is returned | No similar chunks found | Pass |
| TC-W6-010 | REQ-W6-006 | API-W6-009 | Result Handling | Search unrelated query | `unrelated query` | Empty result is returned | No similar chunks found | Pass |
| TC-W6-011 | REQ-W6-008 | API-W6-009 | Result Limiting | Apply result limit | Limit `3` | No more than three results are returned | Maximum of three results returned | Pass |
| TC-W6-012 | REQ-W6-004 | API-W6-010 | Similarity Calculation | Validate cosine score | Query and document vectors | Score remains between `0.0` and `1.0` | Valid scores produced | Pass |
| TC-W6-013 | REQ-W6-003 | API-W6-006 | Query Vector | Generate zero query vector | Unknown vocabulary terms | Zero vector is handled safely | Empty result returned safely | Pass |
| TC-W6-014 | REQ-W6-012 | API-W6-013 | Text Chunking | Generate text chunks | Two searchable documents | Four chunks are generated | Four chunks generated | Pass |

---

## 16. Detailed Test Results

### 16.1 TC-W6-001 — Supported File Parsing

**Objective**

Verify that supported TXT and Markdown files are parsed successfully.

**Input**

```text
data/sample_documents
```

**Expected result**

```text
sample1.txt
sample2.md
```

should be parsed.

**Actual result**

```text
Total Parsed Documents: 2
```

**Status**

```text
Pass
```

---

### 16.2 TC-W6-002 — Unsupported PDF Handling

**Objective**

Verify that an unsupported PDF file is skipped safely.

**Input**

```text
sample3.pdf
```

**Expected result**

The PDF should be skipped without terminating the pipeline.

**Actual result**

```text
Unsupported file type skipped: sample3.pdf
```

**Status**

```text
Pass
```

---

### 16.3 TC-W6-003 — Searchable Document Conversion

**Objective**

Verify that parsed documents are converted into searchable documents.

**Expected result**

Two parsed documents should produce two searchable documents.

**Actual result**

```text
Total Searchable Documents: 2
```

**Status**

```text
Pass
```

---

### 16.4 TC-W6-004 — Vocabulary Generation

**Objective**

Verify that one shared vocabulary is generated from all text chunks.

**Expected result**

A non-empty, unique, and consistently ordered vocabulary should be returned.

**Actual result**

```text
Vocabulary Size: 17
```

Generated terms:

```text
a, document, extraction, file, for, is, markdown, metadata,
module, sample, test, testing, text, the, this, to, used
```

**Status**

```text
Pass
```

---

### 16.5 TC-W6-005 — Embedding Generation

**Objective**

Verify that one embedding vector is generated for each text chunk.

**Expected result**

Four text chunks should produce four embedding vectors.

**Actual result**

```text
Total Text Chunks: 4
Total Embedding Vectors: 4
```

**Status**

```text
Pass
```

---

### 16.6 TC-W6-006 — Vector Dimension Consistency

**Objective**

Verify that all embedding vectors use the same dimension.

**Expected result**

Every generated vector should contain 17 values.

**Actual result**

```text
Embedding Dimension: 17
```

**Status**

```text
Pass
```

---

### 16.7 TC-W6-007 — Related Query Search

**Query**

```text
metadata extraction
```

**Expected result**

The most relevant chunks should be returned first.

**Actual result**

```text
1. sample2.md - chunk 1
   Similarity Score: 0.6325

2. sample1.txt - chunk 1
   Similarity Score: 0.5000

3. sample1.txt - chunk 0
   Similarity Score: 0.2500
```

**Interpretation**

The first result contained both query terms and therefore received the highest similarity score.

**Status**

```text
Pass
```

---

### 16.8 TC-W6-008 — Markdown Query Search

**Query**

```text
markdown document
```

**Expected result**

The Markdown document chunk should be returned as the most relevant result.

**Actual result**

```text
sample2.md - chunk 0
Similarity Score: 0.5000
```

**Status**

```text
Pass
```

---

### 16.9 TC-W6-009 — Out-of-Vocabulary Query

**Query**

```text
local search
```

**Expected result**

No result should be returned because the query terms are absent from the shared vocabulary.

**Actual result**

```text
No similar chunks found.
```

**Status**

```text
Pass
```

---

### 16.10 TC-W6-010 — Unrelated Query

**Query**

```text
unrelated query
```

**Expected result**

No result should be returned.

**Actual result**

```text
No similar chunks found.
```

**Status**

```text
Pass
```

---

### 16.11 TC-W6-011 — Result Limit

**Input**

```text
limit: 3
```

**Expected result**

The search should return no more than three results.

**Actual result**

The `metadata extraction` query returned a maximum of three results.

**Status**

```text
Pass
```

---

### 16.12 TC-W6-012 — Cosine-Similarity Range

**Expected result**

For the non-negative term-frequency vectors used by the prototype, similarity scores should remain between:

```text
0.0 and 1.0
```

**Actual result**

Recorded scores included:

```text
0.6325
0.5000
0.2500
```

All values remained within the expected range.

**Status**

```text
Pass
```

---

### 16.13 TC-W6-013 — Zero Query Vector

**Input**

A query containing only terms that do not exist in the shared vocabulary.

**Expected result**

A zero query vector should be generated and handled safely.

**Actual result**

The search returned an empty result list without throwing an exception.

**Status**

```text
Pass
```

---

### 16.14 TC-W6-014 — Text Chunk Generation

**Input**

Two searchable documents using the Week 6 test chunk size.

**Expected result**

Four text chunks should be generated.

**Actual result**

```text
Total Text Chunks: 4
```

**Status**

```text
Pass
```

---

## 17. Recorded Pipeline Summary

The test execution produced:

```text
Total Parsed Documents: 2
Total Searchable Documents: 2
Total Text Chunks: 4
Vocabulary Size: 17
Total Embedding Vectors: 4
Embedding Dimension: 17
```

This confirms that:

- Two supported documents were parsed.
- Two searchable documents were generated.
- Four text chunks were produced.
- The shared vocabulary contained 17 unique terms.
- Four embedding vectors were generated.
- Every embedding vector used 17 dimensions.

---

## 18. Overall Test Execution Summary

| Metric | Result |
|---|---:|
| Planned test cases | 14 |
| Executed test cases | 14 |
| Passed test cases | 14 |
| Failed test cases | 0 |
| Blocked test cases | 0 |
| Not executed | 0 |
| Overall pass rate | 100% |

### Overall Result

```text
PASS
```

---

## 19. Module Test Result Summary

| Module | Planned | Executed | Passed | Failed | Result |
|---|---:|---:|---:|---:|---|
| File Parsing and Unsupported File Handling | 2 | 2 | 2 | 0 | Pass |
| Text Processing | 1 | 1 | 1 | 0 | Pass |
| Text Chunking | 1 | 1 | 1 | 0 | Pass |
| Vocabulary Generation | 1 | 1 | 1 | 0 | Pass |
| Embedding Generation and Validation | 2 | 2 | 2 | 0 | Pass |
| Query Vector Generation | 1 | 1 | 1 | 0 | Pass |
| Similarity Search and Result Handling | 6 | 6 | 6 | 0 | Pass |
| **Total** | **14** | **14** | **14** | **0** | **Pass** |

---

## 20. Defects and Issues

| Issue ID | Description | Severity | Resolution | Status |
|---|---|---|---|---|
| DEF-W6-001 | The test script called a non-existent `processDocuments()` method | Medium | Replaced with the existing typed conversion method | Closed |
| DEF-W6-002 | A second attempt called a non-existent `processDocument()` method | Medium | Confirmed and used the correct method name | Closed |
| DEF-W6-003 | `List<dynamic>` could not be passed to `chunkDocuments()` | Medium | Used `convertToSearchableDocuments()` to preserve `List<SearchableDocument>` | Closed |
| DEF-W6-004 | PDF content extraction is unsupported | Low | Unsupported PDF is skipped safely | Open limitation |
| DEF-W6-005 | Unknown query terms produce a zero vector | Low | Zero vector is detected and returns no results | Closed by design |
| DEF-W6-006 | The current embedding model is not semantically trained | Medium | Recorded as a future improvement | Open limitation |

---

## 21. Root Cause Analysis

### 21.1 Incorrect Method Names

The original test script assumed that the text-processing service contained:

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

The issue resulted from a mismatch between the new test script and the existing text-processing API.

**Corrective action**

The test script was changed to use the existing batch conversion method.

---

### 21.2 Dynamic List Type

An incorrect mapping expression caused Dart to infer:

```text
List<dynamic>
```

The text-chunking service required:

```text
List<SearchableDocument>
```

**Corrective action**

The typed batch conversion method was used directly.

---

### 21.3 Unsupported PDF Content

The parser detected the PDF file but did not extract its content.

**Root cause**

PDF content extraction had not yet been implemented.

**Corrective action**

The parser was designed to skip unsupported file formats safely and continue processing supported files.

**Status**

```text
Open limitation
```

---

## 22. Requirements Traceability Matrix

| Requirement ID | Requirement | Interface ID | Test ID | Result |
|---|---|---|---|---|
| REQ-W6-001 | Build a shared ordered vocabulary | API-W6-003 | TC-W6-004 | Pass |
| REQ-W6-002 | Generate one vector per text chunk | API-W6-004 | TC-W6-005 | Pass |
| REQ-W6-003 | Generate a vector for user queries | API-W6-006 | TC-W6-013 | Pass |
| REQ-W6-004 | Calculate cosine similarity | API-W6-010 | TC-W6-012 | Pass |
| REQ-W6-005 | Rank related results | API-W6-009 | TC-W6-007, TC-W6-008 | Pass |
| REQ-W6-006 | Handle unknown and unrelated queries | API-W6-009 | TC-W6-009, TC-W6-010 | Pass |
| REQ-W6-007 | Validate consistent vector dimensions | API-W6-009 | TC-W6-006 | Pass |
| REQ-W6-008 | Apply an optional result limit | API-W6-009 | TC-W6-011 | Pass |
| REQ-W6-009 | Parse supported files | API-W6-011 | TC-W6-001 | Pass |
| REQ-W6-010 | Skip unsupported files safely | API-W6-011 | TC-W6-002 | Pass |
| REQ-W6-011 | Generate searchable documents | API-W6-012 | TC-W6-003 | Pass |
| REQ-W6-012 | Generate smaller text chunks | API-W6-013 | TC-W6-014 | Pass |

---

## 23. Interface-to-Test Traceability

| Interface ID | Interface | Test Cases |
|---|---|---|
| API-W6-003 | `SimpleEmbeddingService.buildVocabulary` | TC-W6-004 |
| API-W6-004 | `SimpleEmbeddingService.generateEmbeddings` | TC-W6-005 |
| API-W6-006 | `SimpleEmbeddingService.generateQueryVector` | TC-W6-013 |
| API-W6-009 | `SimilaritySearchService.search` | TC-W6-006, TC-W6-007, TC-W6-008, TC-W6-009, TC-W6-010, TC-W6-011 |
| API-W6-010 | `SimilaritySearchService.calculateCosineSimilarity` | TC-W6-012 |
| API-W6-011 | `FileParserService.parseDocumentsFromDirectory` | TC-W6-001, TC-W6-002 |
| API-W6-012 | `TextProcessingService.convertToSearchableDocuments` | TC-W6-003 |
| API-W6-013 | `TextChunkingService.chunkDocuments` | TC-W6-014 |

---

## 24. Test Coverage Summary

The Week 6 tests covered the following pipeline stages:

| Pipeline Stage | Covered | Test Evidence |
|---|---|---|
| Local file loading | Yes | TC-W6-001 |
| Supported file parsing | Yes | TC-W6-001 |
| Unsupported file handling | Yes | TC-W6-002 |
| Searchable-document conversion | Yes | TC-W6-003 |
| Text chunking | Yes | TC-W6-014 |
| Vocabulary generation | Yes | TC-W6-004 |
| Embedding generation | Yes | TC-W6-005 |
| Vector-dimension validation | Yes | TC-W6-006 |
| Query-vector generation | Yes | TC-W6-013 |
| Related-query search | Yes | TC-W6-007, TC-W6-008 |
| Unrelated-query handling | Yes | TC-W6-009, TC-W6-010 |
| Result limiting | Yes | TC-W6-011 |
| Cosine-similarity validation | Yes | TC-W6-012 |
| Flutter UI | No | Tested during Week 7 and Week 8 |
| PDF content extraction | No | Not implemented |
| Image retrieval | No | Not implemented |
| Persistent vector storage | No | Not implemented |

---

## 25. Risk Assessment

| Risk ID | Risk | Impact | Likelihood | Mitigation |
|---|---|---|---|---|
| RISK-W6-001 | Small dataset may not represent realistic retrieval performance | High | High | Add larger test datasets |
| RISK-W6-002 | Exact vocabulary matching limits semantic search | High | High | Introduce trained embeddings |
| RISK-W6-003 | In-memory vectors must be regenerated | Medium | High | Add persistent vector storage |
| RISK-W6-004 | Unsupported PDF files reduce retrieval coverage | Medium | High | Add a PDF parser |
| RISK-W6-005 | No automated CI test execution | Medium | Medium | Add automated unit and integration tests |
| RISK-W6-006 | No performance benchmark | Medium | Medium | Add timing and scalability tests |
| RISK-W6-007 | No image retrieval | High | High | Add an image-embedding pipeline |
| RISK-W6-008 | Integrated scenarios are not separate automated test functions | Medium | Medium | Convert test scenarios into formal automated unit and integration tests |

---

## 26. Current Limitations

- The test dataset is small.
- Only TXT and Markdown content are parsed.
- PDF content is skipped.
- The current vectors use normalised term frequency.
- Synonyms are not recognised.
- No TF-IDF weighting is used.
- No trained embedding model is used.
- No image vector is generated.
- No persistent vector database is used.
- No stress test was performed.
- No load test was performed.
- No memory benchmark was performed.
- No formal security test was performed.
- No cross-platform retrieval comparison was performed.
- No automated continuous-integration workflow was used.
- The 14 functional scenarios were executed through one integration script rather than 14 separate automated test functions.

---

## 27. Regression Testing Recommendation

The following test cases should be rerun after future source-code changes:

```text
TC-W6-001
TC-W6-002
TC-W6-003
TC-W6-004
TC-W6-005
TC-W6-006
TC-W6-007
TC-W6-008
TC-W6-009
TC-W6-010
TC-W6-011
TC-W6-012
TC-W6-013
TC-W6-014
```

Regression testing is especially important after:

- Replacing term-frequency vectors
- Adding BERT or TensorFlow Lite
- Adding persistent vector storage
- Changing the tokenizer
- Changing the vocabulary-building method
- Changing the chunk size
- Adding PDF parsing
- Adding image retrieval
- Changing score filtering
- Changing result limits
- Refactoring service interfaces

---

## 28. Recommended Future Automated Test Structure

A future version should convert the current functional scenarios into separate automated test groups.

Suggested structure:

```text
test/
├── file_parser_service_test.dart
├── text_processing_service_test.dart
├── text_chunking_service_test.dart
├── simple_embedding_service_test.dart
├── similarity_search_service_test.dart
└── widget_test.dart
```

Suggested distribution:

| Future Test File | Recommended Test Cases |
|---|---:|
| `file_parser_service_test.dart` | 2 |
| `text_processing_service_test.dart` | 1 |
| `text_chunking_service_test.dart` | 1 |
| `simple_embedding_service_test.dart` | 4 |
| `similarity_search_service_test.dart` | 6 |
| **Total** | **14** |

This would preserve the same test coverage while increasing automation, repeatability, and maintainability.

---

## 29. Test Conclusion

The Week 6 embedding and similarity-search implementation passed all planned component and integration test scenarios.

The test confirmed that the system can:

```text
Parse supported files
→ Skip unsupported files safely
→ Generate searchable documents
→ Generate text chunks
→ Build a shared vocabulary
→ Generate embedding vectors
→ Validate vector dimensions
→ Generate query vectors
→ Calculate cosine similarity
→ Rank related results
→ Handle unrelated queries
→ Limit result counts
```

The module-level test summary confirmed:

```text
Planned test cases: 14
Executed test cases: 14
Passed test cases: 14
Failed test cases: 0
Overall pass rate: 100%
```

No critical unresolved runtime defect remained in the tested Week 6 pipeline.

The unsupported PDF format, small test dataset, term-frequency representation, and integrated rather than fully separated automated-test structure were documented as known limitations.

The overall Week 6 test result was:

```text
PASS
```

---

## 30. Completion Status

This document is currently marked as:

```text
Version: 1.1
Status: Final
```

The document was revised on 2026/07/30 to include the module-level test summary requested during the final project review.

The test cases, module statistics, execution results, defect records, risks, interface traceability, and requirement traceability were reviewed against the completed Week 6 source code and available test evidence.