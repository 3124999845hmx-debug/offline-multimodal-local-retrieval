# Offline Multimodal Local Retrieval System

# Week 6 API Interface Definition

## 1. Document Control

| Field | Value |
|---|---|
| Project | Offline Multimodal Local Retrieval System |
| Document Title | Week 6 API Interface Definition |
| Document Type | Internal Dart Service API Definition |
| Version | 1.0 |
| Status | Final |
| Author | Mingxuan Huang |
| Original Date | 2026/07/27 |
| Final Review Date | 2026/07/30 |
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

This document does not define:

- A REST API
- An HTTP API
- An externally hosted web service
- An OpenAPI endpoint specification

The document was reviewed during Week 8 finalisation and confirmed against the completed Week 6 implementation and test evidence.

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

The scope of this document is limited to the Week 6 text embedding and similarity-search architecture.

The metadata-based image-retrieval interfaces added during Week 8 are outside this Week 6 API scope.

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
- Compatibility with later Flutter user-interface integration
- Deterministic local execution
- No dependency on external AI services

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
| API-W6-001 | `EmbeddingVector` | Data model | `lib/models/embedding_vector.dart` | Implemented and Verified |
| API-W6-002 | `SimilarityResult` | Data model | `lib/models/similarity_result.dart` | Implemented and Verified |
| API-W6-003 | `SimpleEmbeddingService.buildVocabulary` | Service method | `lib/services/simple_embedding_service.dart` | Implemented and Verified |
| API-W6-004 | `SimpleEmbeddingService.generateEmbeddings` | Service method | `lib/services/simple_embedding_service.dart` | Implemented and Verified |
| API-W6-005 | `SimpleEmbeddingService.generateEmbedding` | Service method | `lib/services/simple_embedding_service.dart` | Implemented and Verified |
| API-W6-006 | `SimpleEmbeddingService.generateQueryVector` | Service method | `lib/services/simple_embedding_service.dart` | Implemented and Verified |
| API-W6-007 | `SimpleEmbeddingService.generateVector` | Service method | `lib/services/simple_embedding_service.dart` | Implemented and Verified |
| API-W6-008 | `SimpleEmbeddingService.tokenize` | Service method | `lib/services/simple_embedding_service.dart` | Implemented and Verified |
| API-W6-009 | `SimilaritySearchService.search` | Service method | `lib/services/similarity_search_service.dart` | Implemented and Verified |
| API-W6-010 | `SimilaritySearchService.calculateCosineSimilarity` | Service method | `lib/services/similarity_search_service.dart` | Implemented and Verified |
| API-W6-011 | `FileParserService.parseDocumentsFromDirectory` | Referenced service method | `lib/services/file_parser_service.dart` | Existing and Verified |
| API-W6-012 | `TextProcessingService.convertToSearchableDocuments` | Referenced service method | `lib/services/text_processing_service.dart` | Existing and Verified |
| API-W6-013 | `TextChunkingService.chunkDocuments` | Referenced service method | `lib/services/text_chunking_service.dart` | Existing and Verified |

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
| `isZeroVector` | `bool` | Returns `true` when every vector value is zero |

### Preconditions

- `vocabulary.length` should match `values.length`.
- The vocabulary order must remain stable.
- The supplied `TextChunk` must contain the source text represented by the vector.

### Postconditions

- The model stores a reference to the original text chunk.
- `dimension` returns `values.length`.
- `isZeroVector` reflects whether all values equal `0.0`.
- The vector remains associated with the vocabulary used to generate it.

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
| `sourceFileName` | `String` | Returns the matched source filename |
| `sourceFilePath` | `String` | Returns the matched source file path |
| `chunkIndex` | `int` | Returns the matched chunk index |
| `content` | `String` | Returns the complete matched chunk content |
| `preview` | `String` | Returns a shortened content preview |

### Behaviour

- The preview returns complete content when the content length is within the configured limit.
- Longer content is truncated and ends with `...`.
- The result does not modify the underlying embedding vector.
- The similarity score is associated with one specific query execution.

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
- Produces a deterministic vocabulary order for identical input.

### Preconditions

- Each `TextChunk` should contain valid text content.
- The input list may be empty.

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
- Preserves the input chunk order.

### Preconditions

- A supplied vocabulary must use a stable order.
- Text chunks should contain processed searchable content.

### Postconditions

- The number of embeddings equals the number of input chunks.
- Every generated vector has the same dimension.
- Every generated vector is linked to its original chunk.
- Every generated vector uses the same vocabulary.

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
- Stores the vocabulary used for generation.
- Stores the generated vector values.
- Records the generation time.
- Associates the vector with its source text chunk.

### Postconditions

- The vector dimension equals the vocabulary length.
- The vector values represent the source chunk.
- The source chunk remains accessible through the result model.

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
- Preserves vocabulary order.

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
Word occurrence count
÷
Total number of tokens
```

### Behaviour

- Returns an empty list when the vocabulary is empty.
- Returns a zero-filled vector when tokenised text is empty.
- Counts token occurrences.
- Divides each count by the total token count.
- Preserves vocabulary order.
- Produces non-negative values.

### Postconditions

- Returned vector length equals vocabulary length.
- Returned values are non-negative.
- Values are normalised by the total document token count.
- The same input and vocabulary produce the same vector.

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
3. Preserve supported letters and numbers.
4. Replace repeated whitespace.
5. Trim leading and trailing spaces.
6. Split text into individual tokens.
7. Remove empty tokens.

### Behaviour

- Returns an empty list when no valid token remains.
- Does not perform stemming.
- Does not remove stop words.
- Does not resolve synonyms.
- Does not perform contextual semantic analysis.

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
- Filters results according to the configured score threshold.
- Sorts results from highest score to lowest score.
- Applies `limit` when the value is positive.

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
- A positive `limit` should be used when result limiting is required.

### Postconditions

- Returned results are sorted in descending order.
- Returned results satisfy the configured score threshold.
- Returned count does not exceed a valid positive limit.
- Each result remains linked to its source text chunk.

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
Dot product
÷
(Magnitude of first vector × Magnitude of second vector)
```

### Behaviour

- Throws `ArgumentError` when vector lengths differ.
- Returns `0.0` when vectors are empty.
- Returns `0.0` when either vector magnitude is zero.
- Clamps the final value to the valid range used by the current non-negative vector model.

### Error Behaviour

| Condition | Behaviour |
|---|---|
| Different vector lengths | Throws `ArgumentError` |
| Empty vectors | Returns `0.0` |
| Zero magnitude | Returns `0.0` |
| Floating-point value outside the expected range | Clamps result |

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

### Parameters

| Name | Type | Required | Description |
|---|---|---:|---|
| `directoryPath` | `String` | Yes | Local directory containing source files |

### Return Type

```dart
Future<List<ParsedDocument>>
```

### Week 6 Usage

```dart
final parsedDocuments =
    await fileParserService.parseDocumentsFromDirectory(
  'data/sample_documents',
);
```

### Behaviour

- Reads supported files.
- Returns parsed document objects.
- Safely skips unsupported files.
- Does not terminate the pipeline when a PDF is encountered.

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

### Parameters

| Name | Type | Required | Description |
|---|---|---:|---|
| `documents` | `List<ParsedDocument>` | Yes | Parsed documents to process |

### Return Type

```dart
List<SearchableDocument>
```

### Week 6 Usage

```dart
final searchableDocuments =
    textProcessingService.convertToSearchableDocuments(
  parsedDocuments,
);
```

### Behaviour

- Cleans and normalises document content.
- Preserves source-document information.
- Returns typed searchable-document objects.

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

### Parameters

| Name | Type | Required | Description |
|---|---|---:|---|
| `documents` | `List<SearchableDocument>` | Yes | Documents to divide |
| `chunkSize` | `int` | Yes | Maximum target chunk size |

### Return Type

```dart
List<TextChunk>
```

### Week 6 Usage

```dart
final textChunks =
    textChunkingService.chunkDocuments(
  searchableDocuments,
  chunkSize: 8,
);
```

### Behaviour

- Divides searchable content into chunks.
- Preserves source filename and path.
- Assigns a chunk index.
- Returns a typed list of `TextChunk` objects.

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
| `parseDocumentsFromDirectory` | Local file system, `ParsedDocument` |
| `convertToSearchableDocuments` | `ParsedDocument`, `SearchableDocument` |
| `chunkDocuments` | `SearchableDocument`, `TextChunk` |

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
| VAL-W6-011 | Unsupported source file | API-W6-011 | Skips file and continues |
| VAL-W6-012 | Empty document collection | API-W6-012 | Returns empty list |
| VAL-W6-013 | Empty searchable-document collection | API-W6-013 | Returns empty list |

---

## 13. Complete Usage Example

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

The expected sequence is:

```text
Parse local documents
→ Clean text
→ Create chunks
→ Build vocabulary
→ Generate embeddings
→ Execute similarity search
→ Return ranked SimilarityResult objects
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

The traceability identifiers should remain consistent with:

```text
docs/week6/Week6_Test_Report.md
```

---

## 15. Versioning and Compatibility

The current interface-document version is:

```text
1.0 Final
```

The Week 6 interfaces were implemented for the current Dart and Flutter project structure.

They were later reused by the Week 7 Flutter interface and remained functional after the Week 8 image-retrieval extension.

Potential future changes include:

- Replacing term-frequency vectors with neural text embeddings
- Replacing in-memory vectors with persistent vector storage
- Adding asynchronous model inference
- Adding folder selection
- Adding an external REST interface
- Adding OpenAPI documentation after real HTTP endpoints are implemented

Future interface changes should:

- Preserve method names where practical
- Record breaking changes
- Update test traceability
- Update usage examples
- Provide a migration strategy

---

## 16. Known Limitations

The Week 6 interface scope has the following limitations:

- Interfaces are internal Dart APIs only.
- No HTTP endpoint is implemented.
- No OpenAPI YAML file is required.
- Embeddings use term-frequency vectors.
- Semantic synonyms are not reliably recognised.
- Contextual language meaning is limited.
- Vector storage is in memory.
- PDF content extraction is not implemented.
- Performance for large datasets is not defined.
- Thread safety is not evaluated.
- Concurrent indexing is not evaluated.
- Automated API documentation generation is not configured.
- Week 8 image-retrieval interfaces are not included in this Week 6 document.

Image retrieval was not included in the Week 6 interface scope.

A separate metadata-based image-retrieval extension was implemented later during Week 8.

---

## 17. Future REST and OpenAPI Mapping

A future REST service could expose interfaces such as:

```text
POST /index
POST /search
GET /documents
GET /status
DELETE /index
```

For example, the internal method:

```dart
SimilaritySearchService.search(...)
```

could later be mapped to:

```text
POST /search
```

A possible future request body could contain:

```json
{
  "query": "metadata extraction",
  "minimumScore": 0.0,
  "limit": 3
}
```

However:

- No REST interface currently exists.
- No HTTP server is currently implemented.
- No OpenAPI specification is currently required.

An OpenAPI document should only be added after real HTTP endpoints are implemented.

---

## 18. Week 8 Relationship

The Week 6 API defined the text embedding and similarity-search foundation.

This foundation was reused during later stages:

```text
Week 6:
Text vectors and cosine similarity

Week 7:
Flutter desktop interface integration

Week 8:
Final testing and metadata-based image-retrieval extension
```

The Week 8 image extension added separate models and services:

```text
ImageDocument
ImageSearchResult
ImageMetadataService
ImageSearchService
```

Those interfaces are outside the historical scope of this Week 6 API document.

This separation preserves accurate weekly traceability.

---

## 19. Completion Status

This document is marked as:

```text
Version: 1.0
Status: Final
```

The interface definitions were reviewed during Week 8 finalisation and confirmed against:

- Completed Week 6 source code
- Week 6 test evidence
- Week 6 screenshots
- Week 6 progress documentation
- Later Flutter interface integration
- Final project version history

The document is suitable for final project submission as the internal Dart API definition for the Week 6 text embedding and similarity-search stage.