# Offline Multimodal Local Retrieval System

# System Architecture

## 1. Document Information

| Field | Value |
|---|---|
| Project | Offline Multimodal Local Retrieval System |
| Document Title | System Architecture |
| Version | 1.0 |
| Status | Final |
| Author | Mingxuan Huang |
| Date | 2026/07/27 |
| Architecture Stage | Week 8 Final Architecture Review |
| Intended Audience | Developer, project supervisor, evaluator, and technical reviewer |

---

## 2. Purpose

This document describes the final system architecture of the Offline Multimodal Local Retrieval System.

It explains:

- System objectives
- Architectural layers
- Core modules
- Data models
- Service dependencies
- Retrieval workflow
- User-interface integration
- File-system interaction
- Testing architecture
- Error handling
- Current limitations
- Future extension points

The current system is implemented as a local-first Flutter desktop prototype.

It does not require a cloud retrieval server or an external database for its core search functionality.

---

## 3. System Objective

The project aims to provide a local content retrieval system that can:

```text
Read local files
→ Extract searchable text
→ Process and divide the content
→ Generate lightweight numerical representations
→ Compare user queries with local content
→ Rank matching results
→ Display results through a Flutter interface
```

The longer-term objective is to support multimodal retrieval across:

- Text documents
- PDFs
- Office files
- Images
- Screenshots
- Scanned documents

The current working prototype focuses on local text retrieval.

---

## 4. Architectural Style

The system uses a layered and service-oriented architecture.

The main layers are:

```text
Presentation Layer
Application Coordination Layer
Retrieval Service Layer
Data Model Layer
Local Data Source Layer
```

The architecture separates user-interface logic from parsing, processing, vector generation, and search logic.

This improves:

- Maintainability
- Testability
- Reusability
- Modularity
- Future extensibility

---

## 5. High-Level Architecture

```text
┌──────────────────────────────────────────────┐
│              Flutter User Interface          │
│                                              │
│  Search field                                │
│  Search button                               │
│  Clear button                                │
│  Reload button                               │
│  Result cards                                │
│  Pipeline summary                            │
└──────────────────────┬───────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────┐
│          SearchScreen Coordination Layer      │
│                                              │
│  Initialises services                        │
│  Loads local documents                       │
│  Builds in-memory index                      │
│  Executes user searches                      │
│  Updates UI state                            │
└──────────────────────┬───────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────┐
│              Retrieval Services              │
│                                              │
│  FileParserService                           │
│  TextProcessingService                       │
│  TextChunkingService                         │
│  SimpleEmbeddingService                      │
│  SimilaritySearchService                     │
└──────────────────────┬───────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────┐
│                 Data Models                  │
│                                              │
│  FileMetadata                                │
│  ParsedDocument                              │
│  SearchableDocument                          │
│  TextChunk                                   │
│  EmbeddingVector                             │
│  SimilarityResult                            │
└──────────────────────┬───────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────┐
│             Local File-System Data           │
│                                              │
│  data/sample_documents                       │
│  TXT files                                   │
│  Markdown files                              │
│  Unsupported PDF safely skipped              │
└──────────────────────────────────────────────┘
```

---

## 6. Project Structure

The main project structure is:

```text
offline_multimodal_retrieval/
├── android/
├── build/
├── data/
│   └── sample_documents/
├── docs/
│   ├── week1/
│   ├── week2/
│   ├── week3/
│   ├── week4/
│   ├── week5/
│   ├── week6/
│   ├── week7/
│   └── week8/
├── lib/
│   ├── models/
│   ├── screens/
│   ├── services/
│   └── main.dart
├── test/
│   └── widget_test.dart
├── tool/
├── web/
├── windows/
├── analysis_options.yaml
├── pubspec.lock
├── pubspec.yaml
└── README.md
```

The architecture-relevant directories are:

```text
lib/models
lib/services
lib/screens
data/sample_documents
test
tool
docs
```

---

## 7. Presentation Layer

The presentation layer is implemented using Flutter.

The main files are:

```text
lib/main.dart
lib/screens/search_screen.dart
```

### 7.1 Application Entry Point

The application starts from:

```text
lib/main.dart
```

Its responsibilities are:

- Initialise Flutter bindings
- Create the root application widget
- Configure the Material 3 theme
- Remove the debug banner
- Set `SearchScreen` as the home page

The entry point does not directly implement retrieval logic.

This preserves separation of concerns.

---

## 7.2 SearchScreen

The main user interface is:

```text
lib/screens/search_screen.dart
```

`SearchScreen` is a stateful widget because it manages:

- Initialisation state
- Search state
- Search results
- Validation messages
- Pipeline counters
- Error messages
- Focus state

The screen acts as the application coordination layer between the UI and backend retrieval services.

---

## 7.3 UI Components

The screen includes:

```text
Application bar
Search query field
Search button
Clear button
Reload button
Pipeline summary chips
Loading state
Ready state
Empty-result state
Error state
Ranked result list
Result cards
```

Each result card displays:

```text
Ranking
Source filename
Chunk index
Similarity score
Preview
Source path
```

---

## 8. Application Coordination Layer

The coordination logic is located inside `SearchScreen`.

The main startup method is:

```dart
_initialiseRetrievalPipeline()
```

The main search method is:

```dart
_runSearch()
```

The main reset method is:

```dart
_clearSearch()
```

### 8.1 Startup Responsibilities

During startup, the screen performs:

```text
Parse local files
→ Convert documents
→ Generate text chunks
→ Build vocabulary
→ Generate vectors
→ Update UI counters
```

### 8.2 Search Responsibilities

During search, the screen performs:

```text
Validate query
→ Set searching state
→ Call SimilaritySearchService
→ Store ranked results
→ Update result UI
```

### 8.3 State Management

The current prototype uses local Flutter widget state.

Examples include:

```dart
bool _isInitialising;
bool _isSearching;
bool _hasSearched;
List<EmbeddingVector> _embeddingVectors;
List<SimilarityResult> _searchResults;
```

No external state-management framework is currently required because the application scope is small.

Future versions may use:

- Provider
- Riverpod
- Bloc
- Redux

if the application becomes more complex.

---

## 9. Data Model Layer

The model layer defines structured data transferred between services.

The main models are:

```text
FileMetadata
ParsedDocument
SearchableDocument
TextChunk
EmbeddingVector
SimilarityResult
```

---

## 9.1 FileMetadata

`FileMetadata` represents basic local file information.

Typical fields include:

- File name
- File path
- File extension
- File size
- Creation time
- Modification time

This model supports local file identification before content parsing.

---

## 9.2 ParsedDocument

`ParsedDocument` represents content extracted from a supported local file.

It links:

```text
File metadata
+
Parsed text content
```

This model acts as the output of the file-parsing layer.

---

## 9.3 SearchableDocument

`SearchableDocument` represents cleaned and normalised document content.

It is produced after text processing.

Typical transformations include:

- Lowercase conversion
- Whitespace normalisation
- Removal of unsupported symbols
- Preservation of searchable text

---

## 9.4 TextChunk

`TextChunk` represents a smaller section of a searchable document.

Typical fields include:

- Source filename
- Source path
- Chunk index
- Chunk content
- Word range or chunk metadata

Text chunking improves retrieval granularity.

Instead of ranking only complete files, the system can rank smaller content sections.

---

## 9.5 EmbeddingVector

`EmbeddingVector` represents one text chunk numerically.

It contains:

```text
TextChunk
Shared vocabulary
Vector values
Generation time
```

The current vector model uses normalised term frequency.

Each vector dimension corresponds to one vocabulary term.

---

## 9.6 SimilarityResult

`SimilarityResult` represents one ranked search result.

It contains:

```text
Embedding vector
Original query
Similarity score
Search time
```

It also provides convenient access to:

- Source filename
- Source path
- Chunk index
- Full content
- Preview

---

## 10. Retrieval Service Layer

The retrieval service layer contains the main functional modules.

The services are:

```text
FileParserService
TextProcessingService
TextChunkingService
SimpleEmbeddingService
SimilaritySearchService
```

Each service has a focused responsibility.

---

## 10.1 FileParserService

The file parser reads supported local files.

Main responsibility:

```text
Local file
→ ParsedDocument
```

Supported formats:

```text
.txt
.md
```

Unsupported formats are skipped safely.

Example message:

```text
Unsupported file type skipped: sample3.pdf
```

The parser prevents one unsupported file from terminating the full indexing pipeline.

---

## 10.2 TextProcessingService

The text-processing service converts parsed documents into searchable documents.

Main responsibility:

```text
ParsedDocument
→ SearchableDocument
```

Typical tasks include:

- Lowercase conversion
- Whitespace cleaning
- Content normalisation
- Preparation for chunking and tokenisation

---

## 10.3 TextChunkingService

The chunking service divides searchable documents into smaller units.

Main responsibility:

```text
SearchableDocument
→ List<TextChunk>
```

The chunk size is configurable.

Week 6 used a small chunk size for demonstration.

Week 7 used:

```dart
chunkSize: 40
```

This produced one chunk for each short sample document.

---

## 10.4 SimpleEmbeddingService

The embedding service converts text into numerical vectors.

Main responsibilities:

```text
Build vocabulary
Generate document vectors
Generate query vectors
Tokenise text
Normalise term frequencies
```

The current model is deterministic and lightweight.

It does not require:

- Model downloads
- GPU acceleration
- Cloud inference
- Neural-network execution

---

## 10.5 SimilaritySearchService

The similarity-search service compares a query vector with indexed text vectors.

Main responsibilities:

```text
Validate query
Generate query vector
Calculate cosine similarity
Filter zero or low scores
Sort results
Apply result limit
Return SimilarityResult objects
```

The service returns results in descending score order.

---

## 11. Retrieval Pipeline

The complete retrieval pipeline is:

```text
1. Application starts
2. SearchScreen initialises
3. FileParserService scans local directory
4. Supported files become ParsedDocument objects
5. TextProcessingService creates SearchableDocument objects
6. TextChunkingService creates TextChunk objects
7. SimpleEmbeddingService builds one shared vocabulary
8. Text chunks become EmbeddingVector objects
9. Vectors are stored in memory
10. User enters a query
11. Query becomes a vector using the same vocabulary
12. SimilaritySearchService calculates cosine similarity
13. Positive results are ranked
14. SearchScreen displays result cards
```

---

## 12. Vocabulary Architecture

The vocabulary is built from all indexed text chunks.

Example:

```text
document
extraction
file
markdown
metadata
sample
search
text
```

The vocabulary order determines vector dimensions.

For example:

```text
Vocabulary:
[document, extraction, file, metadata]

Text:
metadata extraction
```

may produce:

```text
[0.0, 0.5, 0.0, 0.5]
```

The same vocabulary must be used for:

- Document vectors
- Query vectors
- Similarity calculation

---

## 13. Term-Frequency Vector Architecture

The current system uses normalised term frequency.

For each term:

```text
Term frequency =
Number of occurrences of the term
÷
Total number of tokens
```

Example:

```text
Text:
metadata extraction metadata
```

Total tokens:

```text
3
```

Term frequencies:

```text
metadata = 2 / 3
extraction = 1 / 3
```

Advantages:

- Lightweight
- Deterministic
- Offline
- Easy to inspect
- Easy to test
- No external model required

Limitations:

- No synonym understanding
- Limited semantic meaning
- No contextual understanding
- Vocabulary-dependent matching

---

## 14. Cosine-Similarity Architecture

Cosine similarity compares the direction of two vectors.

The service calculates:

```text
Cosine similarity =
Dot product
÷
Product of vector magnitudes
```

The current non-negative vectors normally produce values between:

```text
0.0 and 1.0
```

Interpretation:

```text
1.0
→ Very strong overlap

Positive middle value
→ Partial overlap

0.0
→ No shared vocabulary
```

The score is not a probability.

---

## 15. Result Ranking

The search service:

```text
Calculates all scores
→ Filters results
→ Sorts descending
→ Applies optional limit
```

Example:

```text
Result 1: 0.6325
Result 2: 0.5000
Result 3: 0.2500
```

The UI receives already ranked `SimilarityResult` objects.

This keeps ranking logic outside the presentation layer.

---

## 16. Local Storage Architecture

The current system reads files from:

```text
data/sample_documents
```

The index is stored only in application memory.

Current storage behaviour:

```text
Application starts
→ Index generated
→ Vectors stored in memory
→ Application closes
→ Index is discarded
```

Advantages:

- Simple
- No database setup
- Easy demonstration
- Strong local privacy

Limitations:

- Index rebuilt on every startup
- No large-scale persistence
- No cached vectors
- No search history

Future options include:

- SQLite
- Isar
- Hive
- Local vector database
- Serialized vector files

---

## 17. Offline-First Architecture

The core retrieval workflow is local.

The system:

- Reads local files
- Processes text locally
- Builds vocabulary locally
- Generates vectors locally
- Calculates similarity locally
- Displays results locally

No document content is uploaded during retrieval.

Internet access may still be required for:

- Initial dependency installation
- Flutter package downloads
- GitHub source control

The retrieval process itself does not require internet access.

---

## 18. Error-Handling Architecture

The architecture includes several error-handling strategies.

### 18.1 Unsupported File Handling

Unsupported files are skipped.

The rest of the directory continues processing.

### 18.2 Empty Query Handling

An empty query produces:

```text
Please enter a search query.
```

No search is executed.

### 18.3 Zero Query Vector

When no query term exists in the vocabulary:

```text
Query vector = all zeros
```

The search service returns an empty result list.

### 18.4 Empty Result Handling

The UI displays:

```text
No similar content found
```

### 18.5 Initialisation Error

If startup indexing fails, the interface displays an error state and a retry button.

### 18.6 Vector Validation

The similarity service validates vector dimensions.

Inconsistent dimensions produce an explicit exception rather than an incorrect score.

---

## 19. Accessibility Architecture

The UI includes initial accessibility support.

The architecture uses Flutter `Semantics` for:

- Search field
- Search button
- Clear button
- Reload button
- Loading state
- Empty-result state
- Summary chips
- Result list
- Result cards

Additional support includes:

- Tooltips
- Enter-key search
- Automatic focus
- Live-region messages

The current implementation is not a formal WCAG-certified product.

---

## 20. Keyboard Interaction Architecture

Keyboard input is handled using:

```text
Shortcuts
Actions
Intent
```

A custom search intent maps the Enter key to:

```dart
_runSearch()
```

The `TextField` also supports:

```dart
onSubmitted
```

This provides redundant keyboard activation.

---

## 21. Testing Architecture

The project contains two main testing approaches.

### 21.1 Command-Line Integration Tests

Files under:

```text
tool/
```

test earlier pipeline stages.

Examples include:

```text
test_metadata_extraction.dart
test_file_parsing.dart
test_keyword_search.dart
test_ranked_search.dart
test_similarity_search.dart
```

These scripts print detailed execution results.

### 21.2 Flutter Widget Tests

The final widget tests are in:

```text
test/widget_test.dart
```

They validate:

- Application startup
- Search-interface display
- Empty-query validation
- Clear-button behaviour

---

## 22. Widget-Test Technical Design

The application performs real local file-system operations.

The widget test therefore uses:

```dart
tester.runAsync(...)
```

This allows:

- Directory listing
- File reading
- Parsing
- Asynchronous indexing

The test also uses a bounded helper that waits for:

```text
Search local content
```

to appear.

This avoids indefinite waiting.

---

## 23. Desktop Test Viewport

The widget tests use:

```text
1280 × 900
Device pixel ratio: 1.0
```

This reflects the Windows desktop use case.

The size prevents artificial overflow errors caused by Flutter’s smaller default widget-test viewport.

The viewport is reset after every test.

---

## 24. Build Architecture

The Windows application is built using Flutter’s Windows desktop target.

The command is:

```bash
flutter run -d windows
```

The generated debug executable is:

```text
build/windows/x64/runner/Debug/offline_multimodal_retrieval.exe
```

The Windows project contains generated C++ and CMake files required by Flutter desktop.

These files are infrastructure rather than retrieval logic.

---

## 25. Dependency Architecture

Dependencies are managed using:

```text
pubspec.yaml
pubspec.lock
```

The project retains dependency versions compatible with the current Flutter environment.

Available but incompatible newer versions are not automatically installed during finalisation.

This reduces regression risk.

---

## 26. Source-Control Architecture

The project uses Git and GitHub.

The primary branch is:

```text
main
```

The development process includes:

```text
Implement
→ Test
→ Capture evidence
→ Document
→ Commit
→ Push
```

Weekly documentation is stored under:

```text
docs/week1
docs/week2
docs/week3
docs/week4
docs/week5
docs/week6
docs/week7
docs/week8
```

---

## 27. Current Architecture Strengths

The current architecture provides:

- Clear model-service-UI separation
- Reusable backend services
- Offline-first processing
- Strong local privacy
- Deterministic retrieval behaviour
- Modular weekly development
- Testable service boundaries
- Explicit error handling
- Windows desktop integration
- Simple future extension points

---

## 28. Current Architecture Limitations

The current architecture does not yet include:

- Persistent vector storage
- Folder-selection service
- PDF parser
- Office parser
- OCR service
- Image embedding service
- Neural text embedding model
- Multimodal ranking service
- Background indexing
- Incremental indexing
- File-watching service
- Search history
- User settings persistence
- Installer packaging
- Continuous integration

---

## 29. Future Target Architecture

A future architecture could be:

```text
Flutter UI
   ↓
Application Controller
   ↓
Document Import Service
   ↓
Format-Specific Parsers
   ├── TXT Parser
   ├── Markdown Parser
   ├── PDF Parser
   ├── Word Parser
   ├── PowerPoint Parser
   ├── OCR Service
   └── Image Metadata Parser
   ↓
Text and Image Processing
   ↓
Multimodal Embedding Layer
   ├── Text Embedding Model
   └── Image Embedding Model
   ↓
Persistent Local Vector Store
   ↓
Hybrid Retrieval Service
   ├── Keyword Search
   ├── Semantic Search
   └── Metadata Filtering
   ↓
Ranked Multimodal Results
```

---

## 30. Future API Architecture

The current system uses internal Dart interfaces.

A future backend could expose:

```text
POST /index
POST /search
GET /documents
GET /status
DELETE /index
```

An OpenAPI document would be appropriate only after real HTTP endpoints are implemented.

The current internal architecture should not be incorrectly described as an existing REST API.

---

## 31. Security and Privacy Considerations

The current architecture supports privacy by:

- Keeping document processing local
- Avoiding document-content uploads
- Avoiding cloud vector storage
- Avoiding external retrieval services
- Keeping vectors in memory

Future production work should address:

- File permission checks
- Path traversal protection
- Malformed file handling
- Local database encryption
- Secure deletion
- Log redaction
- Dependency vulnerability scanning

---

## 32. Performance Considerations

The current sample dataset is small.

Current startup complexity includes:

```text
Read all supported files
→ Process all text
→ Rebuild all chunks
→ Rebuild vocabulary
→ Rebuild all vectors
```

This is acceptable for demonstration data.

For larger datasets, the architecture should add:

- Incremental indexing
- Cached vectors
- Background processing
- Persistent storage
- File-change detection
- Batch processing
- Pagination
- Search-result virtualization

---

## 33. Scalability Considerations

Current limitations affecting scale include:

- Full index rebuild
- In-memory vector storage
- Linear comparison against all vectors
- Single local directory
- No batching
- No indexing queue

Potential improvements include:

- Approximate nearest-neighbour search
- Vector database indexing
- Hierarchical document indexing
- Metadata prefilters
- Parallel parsing
- Lazy loading
- Cached tokenisation

---

## 34. Traceability

| Requirement | Architectural Component |
|---|---|
| Parse local files | `FileParserService` |
| Clean text | `TextProcessingService` |
| Divide documents | `TextChunkingService` |
| Build vocabulary | `SimpleEmbeddingService` |
| Generate vectors | `SimpleEmbeddingService` |
| Compare query and content | `SimilaritySearchService` |
| Rank results | `SimilaritySearchService` |
| Display interface | `SearchScreen` |
| Handle errors | Services and `SearchScreen` |
| Run offline | Local file system and in-memory services |
| Test UI | `test/widget_test.dart` |
| Test backend stages | `tool/` scripts |

---

## 35. Architecture Summary

The final system architecture is a modular local-first Flutter desktop architecture.

Its core structure is:

```text
Local files
→ Parser
→ Text processor
→ Chunker
→ Vocabulary and vectors
→ Similarity search
→ Ranked Flutter results
```

The architecture successfully separates:

```text
Data
Models
Services
Application coordination
Presentation
Testing
Documentation
```

This structure is appropriate for the current prototype and provides a clear foundation for future:

- Semantic retrieval
- PDF and Office support
- Image retrieval
- Persistent vector storage
- Multimodal ranking
- Larger-scale local indexing