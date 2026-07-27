# Offline Multimodal Local Retrieval System

# Week 6 API Interface Definition

## 1. Document Control

| Field | Value |
|---|---|
| Project | Offline Multimodal Local Retrieval System |
| Document Title | Week 6 API Interface Definition |
| Document Type | Internal Dart Service API Definition |
| Version | 0.1 Draft |
| Status | Draft |
| Author | Mingxuan Huang |
| Date | 2026/07/27 |
| Applicable Stage | Week 6 Embedding and Similarity Search |
| Intended Audience | Developer, reviewer, project supervisor |

---

## 2. Purpose

This document defines the internal Dart application programming interfaces used by the Week 6 embedding and similarity-search implementation.

It describes:

- Data models
- Public service methods
- Method signatures
- Input parameters
- Return values
- Preconditions
- Postconditions
- Error behaviour
- Dependencies
- Usage examples
- Interface traceability

The interfaces described in this document are internal Dart interfaces used between application modules.

This document does not define a REST, HTTP, or externally hosted web API.

---

## 3. Scope

The main Week 6 source files covered by this document are:

```text
lib/models/embedding_vector.dart
lib/models/similarity_result.dart
lib/services/simple_embedding_service.dart
lib/services/similarity_search_service.dart
```

The following interfaces from previous development stages are referenced because they are required by the Week 6 pipeline:

```text
lib/models/text_chunk.dart
lib/models/parsed_document.dart
lib/models/searchable_document.dart
lib/services/file_parser_service.dart
lib/services/text_processing_service.dart
lib/services/text_chunking_service.dart
```

The Week 6 pipeline is:

```text
Local files
→ ParsedDocument
→ SearchableDocument
→ TextChunk
→ EmbeddingVector
→ SimilarityResult
```

---

## 4. Interface Design Principles

The Week 6 interfaces follow these design principles:

- Strong Dart typing
- Clear separation between models and services
- Reuse of earlier project modules
- Shared vocabulary for consistent vector dimensions
- Immutable result and vector data where practical
- Explicit validation of query and vector inputs
- Safe handling of empty input
- Predictable descending result order
- Clear exceptions for inconsistent vector dimensions
- Compatibility with future Flutter UI integration

---

## 5. Naming Conventions

The project uses the following naming conventions:

| Item | Convention | Example |
|---|---|---|
| Class | PascalCase | `EmbeddingVector` |
| Public method | lowerCamelCase | `generateEmbeddings` |
| Private method | Leading underscore | `_isZeroVector` |
| Variable | lowerCamelCase | `sharedVocabulary` |
| Constant | lowerCamelCase with `const` | `maximumLength` |
| File | snake_case | `similarity_search_service.dart` |
| Interface ID | `API-W6-NNN` | `API-W6-009` |
| Requirement ID | `REQ-W6-NNN` | `REQ-W6-003` |
| Test ID | `TC-W6-NNN` | `TC-W6-007` |

---

## 6. Interface Overview

| Interface ID | Interface | Category | Source File | Status |
|---|---|---|---|---|
| API-W6-001 | `EmbeddingVector` | Data model | `lib/models/embedding_vector.dart` | Draft |
| API-W6-002 | `SimilarityResult` | Data model | `lib/models/similarity_result.dart` | Draft |
| API-W6-003 | `SimpleEmbeddingService.buildVocabulary` | Service method | `lib/services/simple_embedding_service.dart` | Draft |
| API-W6-004 | `SimpleEmbeddingService.generateEmbeddings` | Service method | `lib/services/simple_embedding_service.dart` | Draft |
| API-W6-005 | `SimpleEmbeddingService.generateEmbedding` | Service method | `lib/services/simple_embedding_service.dart` | Draft |
| API-W6-006 | `SimpleEmbeddingService.generateQueryVector` | Service method | `lib/services/simple_embedding_service.dart` | Draft |
| API-W6-007 | `SimpleEmbeddingService.generateVector` | Service method | `lib/services/simple_embedding_service.dart` | Draft |
| API-W6-008 | `SimpleEmbeddingService.tokenize` | Service method | `lib/services/simple_embedding_service.dart` | Draft |
| API-W6-009 | `SimilaritySearchService.search` | Service method | `lib/services/similarity_search_service.dart` | Draft |
| API-W6-010 | `SimilaritySearchService.calculateCosineSimilarity` | Service method | `lib/services/similarity_search_service.dart` | Draft |
| API-W6-011 | `FileParserService.parseDocumentsFromDirectory` | Referenced service method | `lib/services/file_parser_service.dart` | Existing |
| API-W6-012 | `TextProcessingService.convertToSearchableDocuments` | Referenced service method | `lib/services/text_processing_service.dart` | Existing |
| API-W6-013 | `TextChunkingService.chunkDocuments` | Referenced service method | `lib/services/text_chunking_service.dart` | Existing |

---

## 7. Data Model Interfaces

## 7.1 API-W6-001 — EmbeddingVector

### Purpose

Stores the numerical vector representation of one text chunk.

### Source File

```text
lib/models/embedding_vector.dart
```

### Class Signature

```dart
class EmbeddingVector
```

### Constructor

```dart
EmbeddingVector({
  required TextChunk chunk,
  required List<String> vocabulary,
  required List<double> values,
  required DateTime generatedAt,
})
```

### Fields

| Field | Type | Required | Description |
|---|---|---:|---|
| `chunk` | `TextChunk` | Yes | Original text chunk represented by the vector |
| `vocabulary` | `List<String>` | Yes | Ordered vocabulary used to construct the vector |
| `values` | `List<double>` | Yes | Numerical values corresponding to vocabulary positions |
| `generatedAt` | `DateTime` | Yes | Time at which the vector was generated |

### Computed Properties

| Property | Type | Description |
|---|---|---|
| `dimension` | `int` | Returns the number of vector values |
| `isZeroVector` | `bool` | Returns true when every vector value is zero |

### Preconditions

- `vocabulary.length` should match `values.length`.
- The vocabulary order must remain stable.
- The supplied `TextChunk` must contain the source text represented by the vector.

### Postconditions

- The model stores a reference to the original chunk.
- `dimension` returns `values.length`.
- `isZeroVector` reflects whether all values equal `0.0`.

### Example

```dart
final vector = EmbeddingVector(
  chunk: textChunk,
  vocabulary: vocabulary,
  values: vectorValues,
  generatedAt: DateTime.now(),
);
```

---

## 7.2 API-W6-002 — SimilarityResult

### Purpose

Stores one ranked similarity-search result and links it to the matching embedding vector.

### Source File

```text
lib/models/similarity_result.dart
```

### Class Signature

```dart
class SimilarityResult
```

### Constructor

```dart
SimilarityResult({
  required EmbeddingVector embeddingVector,
  required String query,
  required double similarityScore,
  required DateTime searchedAt,
})
```

### Fields

| Field | Type | Required | Description |
|---|---|---:|---|
| `embeddingVector` | `EmbeddingVector` | Yes | Embedding associated with the matched text chunk |
| `query` | `String` | Yes | Original user query |
| `similarityScore` | `double` | Yes | Cosine-similarity score |
| `searchedAt` | `DateTime` | Yes | Time at which the search was executed |

### Computed Properties

| Property | Type | Description |
|---|---|---|
| `sourceFileName` | `String` | Returns the matched source file name |
| `sourceFilePath` | `String` | Returns the matched source file path |
| `chunkIndex` | `int` | Returns the matched chunk index |
| `content` | `String` | Returns the complete matched chunk content |
| `preview` | `String` | Returns a shortened content preview |

### Behaviour

- The preview returns complete content when the content length is within the configured limit.
- Longer content is truncated and ends with `...`.
- The result does not modify the underlying embedding vector.

### Example

```dart
final result = SimilarityResult(
  embeddingVector: embedding,
  query: 'metadata extraction',
  similarityScore: 0.6325,
  searchedAt: DateTime.now(),
);
```

---

## 8. SimpleEmbeddingService Interfaces

## 8.1 API-W6-003 — buildVocabulary

### Purpose

Builds one shared ordered vocabulary from a list of text chunks.

### Signature

```dart
List<String> buildVocabulary(
  List<TextChunk> chunks,
)
```

### Parameters

| Name | Type | Required | Description |
|---|---|---:|---|
| `chunks` | `List<TextChunk>` | Yes | Text chunks used to generate the vocabulary |

### Return Type

```dart
List<String>
```

### Behaviour

- Tokenises every text chunk.
- Removes duplicate terms using a set.
- Sorts the vocabulary alphabetically.
- Returns an empty list when no valid tokens exist.

### Preconditions

- Each `TextChunk` should contain valid text content.
- The list may be empty.

### Postconditions

- Vocabulary entries are unique.
- Vocabulary order is stable and repeatable.
- The returned vocabulary can be reused for document and query vectors.

### Example

```dart
final vocabulary =
    embeddingService.buildVocabulary(textChunks);
```

---

## 8.2 API-W6-004 — generateEmbeddings

### Purpose

Converts multiple text chunks into embedding vectors using one shared vocabulary.

### Signature

```dart
List<EmbeddingVector> generateEmbeddings(
  List<TextChunk> chunks, {
  List<String>? vocabulary,
})
```

### Parameters

| Name | Type | Required | Description |
|---|---|---:|---|
| `chunks` | `List<TextChunk>` | Yes | Text chunks to convert |
| `vocabulary` | `List<String>?` | No | Existing shared vocabulary |

### Return Type

```dart
List<EmbeddingVector>
```

### Behaviour

- Returns an empty list when `chunks` is empty.
- Builds a vocabulary automatically when none is supplied.
- Generates one `EmbeddingVector` per text chunk.
- Reuses the same vocabulary for every vector.

### Preconditions

- Supplied vocabulary order must remain unchanged.
- Text chunks should contain processed searchable content.

### Postconditions

- The number of embeddings equals the number of input chunks.
- Every vector has the same dimension.
- Every vector is linked to its original chunk.

### Example

```dart
final embeddings =
    embeddingService.generateEmbeddings(
  textChunks,
  vocabulary: vocabulary,
);
```

---

## 8.3 API-W6-005 — generateEmbedding

### Purpose

Converts one text chunk into one term-frequency embedding vector.

### Signature

```dart
EmbeddingVector generateEmbedding(
  TextChunk chunk, {
  required List<String> vocabulary,
})
```

### Parameters

| Name | Type | Required | Description |
|---|---|---:|---|
| `chunk` | `TextChunk` | Yes | Text chunk to convert |
| `vocabulary` | `List<String>` | Yes | Ordered shared vocabulary |

### Return Type

```dart
EmbeddingVector
```

### Behaviour

- Calls `generateVector`.
- Stores an unmodifiable copy of the vocabulary.
- Stores an unmodifiable copy of the vector values.
- Records the generation time.

### Example

```dart
final embedding =
    embeddingService.generateEmbedding(
  textChunk,
  vocabulary: vocabulary,
);
```

---

## 8.4 API-W6-006 — generateQueryVector

### Purpose

Converts a user query into a numerical vector using an existing vocabulary.

### Signature

```dart
List<double> generateQueryVector(
  String query, {
  required List<String> vocabulary,
})
```

### Parameters

| Name | Type | Required | Description |
|---|---|---:|---|
| `query` | `String` | Yes | User query text |
| `vocabulary` | `List<String>` | Yes | Shared document vocabulary |

### Return Type

```dart
List<double>
```

### Behaviour

- Uses the same vector-generation method as document text.
- Returns a zero vector when no query term exists in the vocabulary.
- Returns an empty list when the vocabulary is empty.

### Example

```dart
final queryVector =
    embeddingService.generateQueryVector(
  'metadata extraction',
  vocabulary: vocabulary,
);
```

---

## 8.5 API-W6-007 — generateVector

### Purpose

Generates a normalised term-frequency vector from arbitrary text.

### Signature

```dart
List<double> generateVector(
  String text, {
  required List<String> vocabulary,
})
```

### Parameters

| Name | Type | Required | Description |
|---|---|---:|---|
| `text` | `String` | Yes | Text to convert |
| `vocabulary` | `List<String>` | Yes | Ordered vocabulary defining vector positions |

### Return Type

```dart
List<double>
```

### Calculation

Each value is calculated as:

```text
Term frequency =
word occurrence count / total number of tokens
```

### Behaviour

- Returns an empty list when vocabulary is empty.
- Returns a zero-filled vector when tokenised text is empty.
- Counts token occurrences.
- Divides each count by total token count.
- Preserves vocabulary order.

### Postconditions

- Returned vector length equals vocabulary length.
- Values are non-negative.
- Values are normalised by document token count.

---

## 8.6 API-W6-008 — tokenize

### Purpose

Converts arbitrary text into normalised searchable tokens.

### Signature

```dart
List<String> tokenize(
  String text,
)
```

### Parameters

| Name | Type | Required | Description |
|---|---|---:|---|
| `text` | `String` | Yes | Input text |

### Return Type

```dart
List<String>
```

### Processing Steps

1. Convert text to lowercase.
2. Remove unsupported punctuation and symbols.
3. Preserve Unicode letters and numbers.
4. Replace multiple whitespace characters.
5. Trim leading and trailing spaces.
6. Split text into individual tokens.
7. Remove empty tokens.

### Behaviour

- Returns an empty list when no valid token remains.
- Does not perform stemming.
- Does not remove stop words.
- Does not resolve synonyms.

---

## 9. SimilaritySearchService Interfaces

## 9.1 API-W6-009 — search

### Purpose

Searches stored text-chunk vectors using cosine similarity and returns ranked matching results.

### Signature

```dart
List<SimilarityResult> search({
  required String query,
  required List<EmbeddingVector> embeddings,
  double minimumScore = 0.0,
  int? limit,
})
```

### Parameters

| Name | Type | Required | Default | Description |
|---|---|---:|---|---|
| `query` | `String` | Yes | None | User search query |
| `embeddings` | `List<EmbeddingVector>` | Yes | None | Indexed text-chunk vectors |
| `minimumScore` | `double` | No | `0.0` | Minimum accepted similarity score |
| `limit` | `int?` | No | `null` | Maximum number of returned results |

### Return Type

```dart
List<SimilarityResult>
```

### Behaviour

- Trims the query.
- Returns an empty list for an empty query.
- Returns an empty list for empty embeddings.
- Reads the shared vocabulary from the first embedding.
- Validates embedding dimensions.
- Generates a query vector.
- Returns an empty list for a zero query vector.
- Calculates cosine similarity against every embedding.
- Filters scores using `minimumScore`.
- Sorts results from highest score to lowest score.
- Applies `limit` when it is positive.

### Error Behaviour

| Condition | Behaviour |
|---|---|
| Empty query | Returns empty list |
| Empty embeddings | Returns empty list |
| Empty vocabulary | Returns empty list |
| Zero query vector | Returns empty list |
| Inconsistent vector dimension | Throws `StateError` |
| Vocabulary length mismatch | Throws `StateError` |

### Preconditions

- All embeddings should use a shared vocabulary.
- All embedding vectors should have equal dimensions.
- `minimumScore` should normally be between `0.0` and `1.0`.

### Postconditions

- Returned results are sorted in descending order.
- Returned results satisfy the score threshold.
- Returned count does not exceed a valid positive limit.

### Example

```dart
final results = similaritySearchService.search(
  query: 'metadata extraction',
  embeddings: embeddingVectors,
  minimumScore: 0.0,
  limit: 3,
);
```

---

## 9.2 API-W6-010 — calculateCosineSimilarity

### Purpose

Calculates cosine similarity between two numerical vectors.

### Signature

```dart
double calculateCosineSimilarity(
  List<double> firstVector,
  List<double> secondVector,
)
```

### Parameters

| Name | Type | Required | Description |
|---|---|---:|---|
| `firstVector` | `List<double>` | Yes | First vector |
| `secondVector` | `List<double>` | Yes | Second vector |

### Return Type

```dart
double
```

### Calculation

```text
Cosine similarity =
dot product /
(magnitude of first vector × magnitude of second vector)
```

### Behaviour

- Throws `ArgumentError` when vector lengths differ.
- Returns `0.0` when vectors are empty.
- Returns `0.0` when either magnitude is zero.
- Clamps the final score between `0.0` and `1.0`.

### Error Behaviour

| Condition | Behaviour |
|---|---|
| Different vector lengths | Throws `ArgumentError` |
| Empty vectors | Returns `0.0` |
| Zero magnitude | Returns `0.0` |
| Floating-point overflow outside valid range | Clamps result |

### Example

```dart
final score =
    similaritySearchService.calculateCosineSimilarity(
  queryVector,
  documentVector,
);
```

---

## 10. Referenced Earlier Interfaces

## 10.1 API-W6-011 — parseDocumentsFromDirectory

### Purpose

Parses supported files from a local directory.

### Signature

```dart
Future<List<ParsedDocument>>
    parseDocumentsFromDirectory(
  String directoryPath,
)
```

### Week 6 Usage

```dart
final parsedDocuments =
    await fileParserService.parseDocumentsFromDirectory(
  'data/sample_documents',
);
```

---

## 10.2 API-W6-012 — convertToSearchableDocuments

### Purpose

Converts parsed documents into cleaned searchable documents.

### Signature

```dart
List<SearchableDocument>
    convertToSearchableDocuments(
  List<ParsedDocument> documents,
)
```

### Week 6 Usage

```dart
final searchableDocuments =
    textProcessingService.convertToSearchableDocuments(
  parsedDocuments,
);
```

---

## 10.3 API-W6-013 — chunkDocuments

### Purpose

Divides searchable documents into smaller text chunks.

### Signature

```dart
List<TextChunk> chunkDocuments(
  List<SearchableDocument> documents, {
  required int chunkSize,
})
```

### Week 6 Usage

```dart
final textChunks =
    textChunkingService.chunkDocuments(
  searchableDocuments,
  chunkSize: 8,
);
```

---

## 11. Interface Dependencies

```text
FileParserService
        ↓
ParsedDocument
        ↓
TextProcessingService
        ↓
SearchableDocument
        ↓
TextChunkingService
        ↓
TextChunk
        ↓
SimpleEmbeddingService
        ↓
EmbeddingVector
        ↓
SimilaritySearchService
        ↓
SimilarityResult
```

### Dependency Table

| Interface | Depends On |
|---|---|
| `EmbeddingVector` | `TextChunk` |
| `SimilarityResult` | `EmbeddingVector` |
| `buildVocabulary` | `TextChunk`, `tokenize` |
| `generateEmbeddings` | `EmbeddingVector`, `generateEmbedding` |
| `generateEmbedding` | `generateVector`, `TextChunk` |
| `generateQueryVector` | `generateVector` |
| `search` | `EmbeddingVector`, `SimilarityResult`, `generateQueryVector` |
| `calculateCosineSimilarity` | `dart:math` |

---

## 12. Error and Validation Behaviour

| Validation ID | Condition | Interface | Behaviour |
|---|---|---|---|
| VAL-W6-001 | Empty query | API-W6-009 | Returns empty result |
| VAL-W6-002 | Empty embedding list | API-W6-009 | Returns empty result |
| VAL-W6-003 | Empty vocabulary | API-W6-009 | Returns empty result |
| VAL-W6-004 | Zero query vector | API-W6-009 | Returns empty result |
| VAL-W6-005 | Inconsistent embedding dimensions | API-W6-009 | Throws `StateError` |
| VAL-W6-006 | Vocabulary and vector mismatch | API-W6-009 | Throws `StateError` |
| VAL-W6-007 | Different cosine vector lengths | API-W6-010 | Throws `ArgumentError` |
| VAL-W6-008 | Zero vector magnitude | API-W6-010 | Returns `0.0` |
| VAL-W6-009 | Empty tokenised text | API-W6-007 | Returns zero-filled vector |
| VAL-W6-010 | Empty vocabulary | API-W6-007 | Returns empty vector |

---

## 13. Usage Example

The complete Week 6 service sequence is:

```dart
final parsedDocuments =
    await fileParserService.parseDocumentsFromDirectory(
  'data/sample_documents',
);

final searchableDocuments =
    textProcessingService.convertToSearchableDocuments(
  parsedDocuments,
);

final textChunks =
    textChunkingService.chunkDocuments(
  searchableDocuments,
  chunkSize: 8,
);

final vocabulary =
    embeddingService.buildVocabulary(
  textChunks,
);

final embeddingVectors =
    embeddingService.generateEmbeddings(
  textChunks,
  vocabulary: vocabulary,
);

final results =
    similaritySearchService.search(
  query: 'metadata extraction',
  embeddings: embeddingVectors,
  minimumScore: 0.0,
  limit: 3,
);
```

---

## 14. Requirements Traceability

| Requirement ID | Requirement | Interface ID | Test ID |
|---|---|---|---|
| REQ-W6-001 | Build a shared vocabulary | API-W6-003 | TC-W6-004 |
| REQ-W6-002 | Generate one vector per text chunk | API-W6-004 | TC-W6-005 |
| REQ-W6-003 | Generate a query vector | API-W6-006 | TC-W6-007 |
| REQ-W6-004 | Calculate cosine similarity | API-W6-010 | TC-W6-010 |
| REQ-W6-005 | Rank relevant results | API-W6-009 | TC-W6-007 |
| REQ-W6-006 | Filter unrelated queries | API-W6-009 | TC-W6-009 |
| REQ-W6-007 | Validate vector dimensions | API-W6-009 | TC-W6-006 |
| REQ-W6-008 | Limit returned results | API-W6-009 | TC-W6-011 |

---

## 15. Versioning and Compatibility

The current interface version is:

```text
0.1 Draft
```

The Week 6 interfaces are designed for the current Dart and Flutter project structure.

Potential future changes include:

- Replacing term-frequency vectors with BERT embeddings
- Replacing in-memory vectors with persistent vector storage
- Adding asynchronous model inference
- Adding image embeddings
- Adding folder selection
- Adding an external REST interface
- Adding OpenAPI documentation if HTTP endpoints are introduced

Future interface changes should preserve method names where possible or use a documented migration strategy.

---

## 16. Known Limitations

- Interfaces are internal Dart APIs only.
- No HTTP endpoint is currently implemented.
- No OpenAPI YAML file is required at this stage.
- Embeddings use term-frequency vectors.
- Semantic synonyms are not recognised.
- Vector storage is in memory.
- PDF content extraction is not implemented.
- Image retrieval is not implemented.
- Performance under large datasets is not defined.
- Thread safety and concurrent indexing are not evaluated.
- Automated API documentation generation is not configured.

---

## 17. Future REST and OpenAPI Mapping

A future REST service could expose interfaces such as:

```text
POST /index
POST /search
GET /documents
GET /status
```

For example, the internal method:

```dart
SimilaritySearchService.search(...)
```

could later be mapped to:

```text
POST /search
```

However, no REST interface currently exists.

An OpenAPI specification should only be added after actual HTTP endpoints are implemented.

---

## 18. Completion Status

This document is currently marked as:

```text
Version: 1.0
Status: Final
```

The detailed interface definitions were reviewed during Week 8 finalisation and confirmed against the completed Week 6 source code, test evidence, screenshots, and version history.