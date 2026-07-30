# Offline Multimodal Local Retrieval System

# System Architecture

## 1. Document Information

| Field | Value |
|---|---|
| Project | Offline Multimodal Local Retrieval System |
| Document Title | System Architecture |
| Version | 1.1 |
| Status | Final |
| Author | Mingxuan Huang |
| Original Date | 2026/07/27 |
| Final Revision Date | 2026/07/30 |
| Architecture Stage | Week 8 Final Architecture Review |
| Validated Platform | Windows Desktop |
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
- Text-retrieval workflow
- Image-retrieval workflow
- Unified query processing
- User-interface integration
- Local file-system interaction
- Testing architecture
- Error handling
- Current limitations
- Future extension points

The current system is implemented as a local-first Flutter Windows desktop prototype.

The system supports:

```text
TXT and Markdown text retrieval
+
JPG, JPEG, and PNG metadata-based image retrieval
```

The core retrieval workflow runs locally.

It does not require:

- A cloud retrieval server
- A remote search API
- Cloud vector storage
- An external database
- Internet access during normal retrieval

---

## 3. System Objective

The project aims to provide a local content-retrieval system that can:

```text
Read local files
→ Extract or load searchable information
→ Process the information
→ Generate lightweight numerical representations
→ Compare user queries with local content
→ Rank matching results
→ Display text and image results through Flutter
```

The current prototype supports two local content branches:

```text
Text branch:
TXT and Markdown content

Image branch:
JPG, JPEG, and PNG files with local descriptions and tags
```

The longer-term objective remains broader multimodal retrieval across:

- Text documents
- PDFs
- Office files
- Images
- Screenshots
- Scanned documents
- Semantic text vectors
- Visual image vectors

The current image branch does not directly analyse image pixels.

Instead, it searches manually prepared local image descriptions and tags.

---

## 4. Current System Capability

The final prototype supports one unified text query.

The query is sent to two retrieval services:

```text
User text query
├── Text retrieval branch
└── Image retrieval branch
```

The text branch returns:

- TXT results
- Markdown results
- Relevant text chunks
- Similarity scores
- Source paths

The image branch returns:

- JPG results
- JPEG results
- PNG results
- Image thumbnails
- Image descriptions
- Image tags
- Similarity scores
- Source paths

The accurate technical description of the image capability is:

> Metadata-based text-to-image retrieval using local image descriptions and tags.

The system does not currently perform direct neural image understanding.

---

## 5. Architectural Style

The system uses a layered, modular, and service-oriented architecture.

The main layers are:

```text
Presentation Layer
Application Coordination Layer
Retrieval Service Layer
Data Model Layer
Local Data Source Layer
Testing Layer
```

The architecture separates:

- User-interface logic
- Text parsing
- Text processing
- Text chunking
- Text-vector generation
- Text similarity search
- Image metadata loading
- Image search
- Data models
- Testing logic

This separation improves:

- Maintainability
- Testability
- Reusability
- Modularity
- Debugging
- Future extensibility

---

## 6. High-Level Architecture

```text
┌──────────────────────────────────────────────────────────┐
│                 Flutter Presentation Layer                │
│                                                          │
│  Search field                                            │
│  Search button                                           │
│  Clear button                                            │
│  Reload button                                           │
│  Pipeline summary                                        │
│  Text-result cards                                       │
│  Image-result cards                                      │
│  Local image thumbnails                                  │
└──────────────────────────┬───────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│              SearchScreen Coordination Layer              │
│                                                          │
│  Initialises text services                               │
│  Initialises image services                              │
│  Loads local text documents                              │
│  Loads image metadata                                    │
│  Builds in-memory text index                             │
│  Stores image documents                                  │
│  Executes one query against both branches                │
│  Updates Flutter state                                   │
└───────────────┬──────────────────────────┬───────────────┘
                │                          │
                ▼                          ▼
┌───────────────────────────┐  ┌───────────────────────────┐
│   Text Retrieval Branch   │  │  Image Retrieval Branch   │
│                           │  │                           │
│ FileParserService         │  │ ImageMetadataService      │
│ TextProcessingService     │  │ ImageSearchService        │
│ TextChunkingService       │  │                           │
│ SimpleEmbeddingService    │  │ Description and tag       │
│ SimilaritySearchService   │  │ vector generation         │
└───────────────┬───────────┘  └───────────────┬───────────┘
                │                              │
                ▼                              ▼
┌───────────────────────────┐  ┌───────────────────────────┐
│     Text Data Models      │  │    Image Data Models      │
│                           │  │                           │
│ FileMetadata              │  │ ImageDocument             │
│ ParsedDocument            │  │ ImageSearchResult         │
│ SearchableDocument        │  │                           │
│ TextChunk                 │  │                           │
│ EmbeddingVector           │  │                           │
│ SimilarityResult          │  │                           │
└───────────────┬───────────┘  └───────────────┬───────────┘
                │                              │
                ▼                              ▼
┌───────────────────────────┐  ┌───────────────────────────┐
│  Local Text Data Source   │  │  Local Image Data Source  │
│                           │  │                           │
│ data/sample_documents     │  │ data/sample_images        │
│ sample1.txt               │  │ car.jpg                   │
│ sample2.md                │  │ cat.jpg                   │
│ sample3.pdf skipped       │  │ mountain.jpg              │
│                           │  │ office.jpg                │
│                           │  │ 微信截图.png              │
│                           │  │ image_metadata.json       │
└───────────────────────────┘  └───────────────────────────┘
```

---

## 7. Project Structure

The final architecture-relevant project structure is:

```text
offline_multimodal_retrieval/
├── android/
├── build/
├── data/
│   ├── sample_documents/
│   │   ├── sample1.txt
│   │   ├── sample2.md
│   │   └── sample3.pdf
│   └── sample_images/
│       ├── car.jpg
│       ├── cat.jpg
│       ├── mountain.jpg
│       ├── office.jpg
│       ├── 微信截图.png
│       └── image_metadata.json
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
│   │   ├── embedding_vector.dart
│   │   ├── file_metadata.dart
│   │   ├── image_document.dart
│   │   ├── image_search_result.dart
│   │   ├── parsed_document.dart
│   │   ├── searchable_document.dart
│   │   ├── similarity_result.dart
│   │   └── text_chunk.dart
│   ├── screens/
│   │   └── search_screen.dart
│   ├── services/
│   │   ├── file_parser_service.dart
│   │   ├── image_metadata_service.dart
│   │   ├── image_search_service.dart
│   │   ├── simple_embedding_service.dart
│   │   ├── similarity_search_service.dart
│   │   ├── text_chunking_service.dart
│   │   └── text_processing_service.dart
│   └── main.dart
├── test/
│   ├── image_search_service_test.dart
│   └── widget_test.dart
├── tool/
│   ├── test_image_metadata.dart
│   ├── test_image_search.dart
│   └── other command-line tests
├── windows/
├── analysis_options.yaml
├── pubspec.lock
├── pubspec.yaml
├── README.md
└── LICENSE
```

The most important architecture directories are:

```text
lib/models
lib/services
lib/screens
data/sample_documents
data/sample_images
test
tool
docs
```

---

## 8. Presentation Layer

The presentation layer is implemented using Flutter.

The main files are:

```text
lib/main.dart
lib/screens/search_screen.dart
```

### 8.1 Application Entry Point

The application starts from:

```text
lib/main.dart
```

Its responsibilities are:

- Initialise Flutter
- Create the root application widget
- Configure Material 3
- Remove the debug banner
- Set `SearchScreen` as the home screen

The entry point does not directly implement retrieval logic.

This preserves separation of concerns.

---

## 8.2 SearchScreen

The main interface is:

```text
lib/screens/search_screen.dart
```

`SearchScreen` is a stateful widget because it manages:

- Initialisation state
- Search state
- Text search results
- Image search results
- Loaded image documents
- Text embedding vectors
- Validation messages
- Error messages
- Pipeline counters
- Focus state

It acts as the application coordination layer between the Flutter interface and the retrieval services.

---

## 8.3 User-Interface Components

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
Initialisation-error state
Text-result section
Image-result section
Text-result cards
Image-result cards
Image thumbnails
```

The pipeline summary displays:

```text
Documents
Text chunks
Vocabulary
Text vectors
Images
```

---

## 8.4 Text Result Card

Each text-result card displays:

```text
Ranking number
Source filename
Chunk index
Cosine-similarity score
Content preview
Source file path
```

The text result is represented by:

```text
SimilarityResult
```

---

## 8.5 Image Result Card

Each image-result card displays:

```text
Ranking number
Image thumbnail
Image filename
Description
Tags
Cosine-similarity score
Local file path
```

The thumbnail is displayed using:

```dart
Image.file(...)
```

If the image cannot be rendered, the interface displays a broken-image placeholder.

The layout uses:

```dart
LayoutBuilder
```

to adapt the image card to the available width.

A wide desktop window uses a horizontal layout.

A narrow window uses a vertical layout.

---

## 9. Application Coordination Layer

The application coordination logic is located inside `SearchScreen`.

The main methods are:

```dart
_initialiseRetrievalPipeline()
_runSearch()
_clearSearch()
```

---

## 9.1 Startup Responsibilities

During startup, the screen performs two parallel logical preparation processes.

### Text Preparation

```text
Parse text files
→ Convert parsed documents
→ Generate text chunks
→ Build text vocabulary
→ Generate text vectors
```

### Image Preparation

```text
Read image_metadata.json
→ Validate image extensions
→ Validate image existence
→ Create ImageDocument objects
```

The resulting state includes:

```dart
List<EmbeddingVector> _embeddingVectors;
List<ImageDocument> _imageDocuments;
```

---

## 9.2 Search Responsibilities

During a search, the screen performs:

```text
Validate query
→ Set searching state
→ Search text branch
→ Search image branch
→ Store both result lists
→ Update Flutter interface
```

The query is sent to:

```text
SimilaritySearchService
+
ImageSearchService
```

The results are stored as:

```dart
List<SimilarityResult> _textSearchResults;
List<ImageSearchResult> _imageSearchResults;
```

---

## 9.3 Reset Responsibilities

The Clear function removes:

```text
Search field content
Text search results
Image search results
Search errors
Search-completed state
```

The Reload function rebuilds:

```text
Text index
+
Image metadata collection
```

---

## 9.4 State Management

The prototype uses local Flutter widget state.

Important state values include:

```dart
bool _isInitialising;
bool _isSearching;
bool _hasSearched;

List<EmbeddingVector> _embeddingVectors;
List<SimilarityResult> _textSearchResults;

List<ImageDocument> _imageDocuments;
List<ImageSearchResult> _imageSearchResults;
```

An external state-management framework is not required for the current project size.

Future versions may use:

- Provider
- Riverpod
- Bloc
- Redux

if the application grows.

---

## 10. Data Model Layer

The model layer defines typed data transferred between services.

The final models are divided into text and image groups.

### Text Models

```text
FileMetadata
ParsedDocument
SearchableDocument
TextChunk
EmbeddingVector
SimilarityResult
```

### Image Models

```text
ImageDocument
ImageSearchResult
```

---

## 10.1 FileMetadata

`FileMetadata` stores basic local file information.

Typical fields include:

- Filename
- File path
- File extension
- File size
- Creation time
- Modification time

This model identifies a local file before its content is parsed.

---

## 10.2 ParsedDocument

`ParsedDocument` represents text extracted from a supported local file.

It links:

```text
File metadata
+
Parsed text content
```

It is the output of `FileParserService`.

---

## 10.3 SearchableDocument

`SearchableDocument` represents cleaned and normalised text.

It is produced after text processing.

Typical transformations include:

- Lowercase conversion
- Whitespace normalisation
- Removal of unsupported symbols
- Preparation for chunking

---

## 10.4 TextChunk

`TextChunk` represents a smaller document section.

Typical fields include:

- Source filename
- Source file path
- Chunk index
- Chunk content

Text chunking improves retrieval precision.

Instead of returning only a complete file, the system can return a relevant section.

---

## 10.5 EmbeddingVector

`EmbeddingVector` represents one text chunk numerically.

It contains:

```text
TextChunk
Vocabulary
Vector values
Generation time
```

The current vector model uses normalised term frequency.

Each vector dimension corresponds to one vocabulary term.

---

## 10.6 SimilarityResult

`SimilarityResult` represents one ranked text result.

It contains:

```text
Embedding vector
Original query
Similarity score
Search time
```

It provides access to:

- Source filename
- Source path
- Chunk index
- Full content
- Preview

---

## 10.7 ImageDocument

`ImageDocument` represents one locally searchable image.

The model stores:

```text
Filename
File path
Description
Tags
Searchable text
```

The model is created from one JSON object.

Example:

```json
{
  "fileName": "cat.jpg",
  "description": "A domestic cat sitting indoors.",
  "tags": [
    "cat",
    "animal",
    "pet",
    "indoor",
    "feline"
  ]
}
```

The model combines:

```text
Description
+
Tags
```

into:

```text
searchableText
```

Example:

```text
A domestic cat sitting indoors.
cat animal pet indoor feline
```

---

## 10.8 ImageSearchResult

`ImageSearchResult` represents one ranked image result.

It stores:

```text
ImageDocument
+
Similarity score
```

It provides direct access to:

- Filename
- File path
- Description
- Tags
- Similarity score

The score is not stored permanently inside `ImageDocument` because it changes for every query.

---

## 11. Retrieval Service Layer

The final retrieval service layer includes:

### Text Services

```text
FileParserService
TextProcessingService
TextChunkingService
SimpleEmbeddingService
SimilaritySearchService
```

### Image Services

```text
ImageMetadataService
ImageSearchService
```

Each service has a focused responsibility.

---

## 11.1 FileParserService

The file parser reads supported local text files.

Main responsibility:

```text
Local text file
→ ParsedDocument
```

Supported formats:

```text
.txt
.md
```

Unsupported formats are skipped safely.

Example:

```text
Unsupported file type skipped: sample3.pdf
```

One unsupported file does not terminate the whole pipeline.

---

## 11.2 TextProcessingService

The text-processing service converts parsed documents into searchable documents.

Main responsibility:

```text
ParsedDocument
→ SearchableDocument
```

Its tasks include:

- Lowercase conversion
- Whitespace cleaning
- Content normalisation
- Preparation for tokenisation

---

## 11.3 TextChunkingService

The chunking service divides searchable documents into smaller text units.

Main responsibility:

```text
SearchableDocument
→ List<TextChunk>
```

The current interface uses:

```dart
chunkSize: 40
```

Because the sample documents are short, each currently produces one text chunk.

---

## 11.4 SimpleEmbeddingService

The embedding service converts text chunks and queries into numerical vectors.

Main responsibilities:

```text
Build vocabulary
Tokenise text
Generate text vectors
Generate query vectors
Normalise term frequencies
```

The current implementation is:

- Lightweight
- Deterministic
- Offline
- Inspectable
- Easy to test

It does not require:

- Model downloads
- GPU acceleration
- Cloud inference
- Neural-network execution

---

## 11.5 SimilaritySearchService

The text similarity-search service compares the user query with indexed text vectors.

Main responsibilities:

```text
Validate query
Generate query vector
Calculate cosine similarity
Filter zero scores
Sort results
Apply result limit
Return SimilarityResult objects
```

Results are returned in descending score order.

---

## 11.6 ImageMetadataService

The image metadata service loads local image metadata.

Main responsibilities:

```text
Locate image_metadata.json
→ Read JSON
→ Decode JSON array
→ Convert entries to ImageDocument
→ Validate extensions
→ Check image files exist
→ Skip invalid entries
→ Return image list
```

Supported image formats are:

```text
.jpg
.jpeg
.png
```

The service currently loads five images.

---

## 11.7 ImageSearchService

The image-search service compares a text query with each image's searchable metadata.

Main responsibilities:

```text
Normalise query
Tokenise query
Build shared vocabulary
Generate query vector
Generate image metadata vectors
Calculate cosine similarity
Filter results
Sort descending
Apply result limit
Return ImageSearchResult objects
```

The image branch uses:

```text
description
+
tags
```

as the searchable representation.

It does not directly inspect image pixels.

---

## 12. Text Retrieval Pipeline

The complete text pipeline is:

```text
1. Application starts
2. SearchScreen initialises
3. FileParserService scans data/sample_documents
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
14. SearchScreen displays text-result cards
```

---

## 13. Image Retrieval Pipeline

The complete image pipeline is:

```text
1. Application starts
2. SearchScreen calls ImageMetadataService
3. image_metadata.json is loaded
4. JSON entries become ImageDocument objects
5. File extensions are validated
6. Local image files are checked
7. Valid images are stored in memory
8. User enters a text query
9. ImageSearchService normalises the query
10. Description and tags become searchable text
11. Query and image metadata become term-frequency vectors
12. Cosine similarity is calculated
13. Positive image results are ranked
14. SearchScreen displays image-result cards
15. Image.file displays the local thumbnail
```

---

## 14. Unified Search Pipeline

The final application uses one query field.

The unified search sequence is:

```text
User enters query
→ Validate query
→ Set loading state
→ Run text search
→ Run image search
→ Store text results
→ Store image results
→ Display both sections
```

The output structure is:

```text
Search results
├── Text results
│   ├── TXT result cards
│   └── Markdown result cards
└── Image results
    ├── JPG result cards
    └── PNG result cards
```

If both lists are empty, the interface displays:

```text
No similar content found
```

---

## 15. Vocabulary Architecture

The text branch builds a shared vocabulary from all text chunks.

The image branch builds a shared vocabulary from:

```text
Current query
+
All image descriptions
+
All image tags
```

In both branches, vocabulary order determines vector dimensions.

Example:

```text
Vocabulary:
[animal, cat, office, pet]
```

Query:

```text
pet
```

may produce:

```text
[0.0, 0.0, 0.0, 1.0]
```

The same vocabulary must be used for both vectors being compared.

---

## 16. Term-Frequency Vector Architecture

The system uses normalised term frequency.

For each term:

```text
Term frequency =
Number of occurrences
÷
Total number of tokens
```

Example:

```text
Text:
cat animal pet pet
```

Total tokens:

```text
4
```

Term frequencies:

```text
cat = 1 / 4
animal = 1 / 4
pet = 2 / 4
```

Advantages:

- Lightweight
- Deterministic
- Offline
- Easy to inspect
- Easy to test
- No external model required

Limitations:

- No reliable synonym understanding
- Limited semantic meaning
- No contextual understanding
- Strong dependence on exact words
- Image quality depends on metadata quality

---

## 17. Cosine-Similarity Architecture

Cosine similarity compares the direction of two vectors.

The system calculates:

```text
Cosine similarity =
Dot product
÷
Product of vector magnitudes
```

The current non-negative vectors usually produce values between:

```text
0.0 and 1.0
```

Interpretation:

```text
Higher score
→ Stronger term overlap

Middle score
→ Partial overlap

0.0
→ No shared searchable terms
```

The score is not a probability.

The same principle is used for:

- Text query versus text chunk
- Text query versus image metadata

---

## 18. Result Ranking

Both retrieval services perform:

```text
Calculate scores
→ Filter results
→ Sort descending
→ Apply optional limit
```

Example:

```text
Result 1: 0.6030
Result 2: 0.3015
Result 3: 0.2041
```

The Flutter layer receives already ranked objects.

This keeps ranking logic outside the presentation layer.

---

## 19. Local Storage Architecture

The current text files are stored in:

```text
data/sample_documents
```

The current images and image metadata are stored in:

```text
data/sample_images
```

The text index and image objects are stored in application memory.

Current behaviour:

```text
Application starts
→ Text index generated
→ Image metadata loaded
→ Data stored in memory
→ Application closes
→ In-memory state is discarded
```

Advantages:

- Simple
- No database setup
- Easy to demonstrate
- Fully local
- Strong privacy

Limitations:

- Index rebuilt every startup
- Image metadata reloaded every startup
- No persistent vectors
- No cached index
- No search history

Future options include:

- SQLite
- Isar
- Hive
- Serialized vector files
- Local vector database

---

## 20. Offline-First Architecture

The core retrieval workflow is local.

The system:

- Reads local text files
- Reads local image metadata
- Checks local image files
- Processes text locally
- Builds vocabularies locally
- Generates vectors locally
- Calculates similarity locally
- Displays local results

No text content, image metadata, or image file is uploaded during retrieval.

Internet access may still be required for:

- Flutter dependency installation
- Dart package downloads
- GitHub source control

Normal search operation does not require internet access.

---

## 21. Error-Handling Architecture

The architecture includes several error-handling strategies.

### 21.1 Unsupported Text File

Unsupported text files are skipped.

Example:

```text
Unsupported file type skipped: sample3.pdf
```

### 21.2 Missing Image Metadata File

If `image_metadata.json` does not exist, the service throws a clear file-system exception.

### 21.3 Invalid JSON Root

The JSON root must be an array.

Otherwise, the service throws a `FormatException`.

### 21.4 Unsupported Image Type

Files outside:

```text
.jpg
.jpeg
.png
```

are skipped.

### 21.5 Missing Image File

If metadata references a missing image, the entry is skipped.

### 21.6 Empty Query

An empty query displays:

```text
Please enter a search query.
```

### 21.7 Zero Query Vector

If no query term exists in a searchable vocabulary:

```text
Query vector = all zeros
```

The service returns an empty list.

### 21.8 Empty Result

If both result lists are empty, the interface displays:

```text
No similar content found
```

### 21.9 Initialisation Error

If startup loading fails, the interface displays:

- An error message
- A retry button

### 21.10 Image Rendering Error

If an image thumbnail cannot be rendered, the result card displays a broken-image icon.

### 21.11 Vector Validation

The similarity services validate vector dimensions.

Invalid dimensions produce an explicit exception.

---

## 22. Accessibility Architecture

The interface includes initial accessibility support through Flutter `Semantics`.

Semantic support is applied to:

- Search field
- Search button
- Clear button
- Reload button
- Loading state
- Empty-result state
- Summary chips
- Text results
- Image results
- Result cards

Additional support includes:

- Tooltips
- Enter-key search
- Automatic search-field focus
- Live-region messages
- Selectable local paths

The implementation is not a formally certified WCAG product.

---

## 23. Keyboard Interaction Architecture

Keyboard input is handled using:

```text
Shortcuts
Actions
Intent
```

A custom intent maps Enter to:

```dart
_runSearch()
```

The search field also uses:

```dart
onSubmitted
```

This provides redundant keyboard activation.

---

## 24. Testing Architecture

The project contains three main testing approaches.

### 24.1 Command-Line Pipeline Tests

Scripts under:

```text
tool/
```

test individual pipeline stages.

Examples include:

```text
test_metadata_extraction.dart
test_file_parsing.dart
test_keyword_search.dart
test_ranked_search.dart
test_similarity_search.dart
test_image_metadata.dart
test_image_search.dart
```

These scripts print detailed execution evidence.

### 24.2 Image Service Automated Tests

The file:

```text
test/image_search_service_test.dart
```

contains:

```text
11 independent automated tests
```

They cover:

- Image loading
- Searchable metadata
- Expected image ranking
- Empty query
- Unrelated query
- Result limiting
- Descending sorting

### 24.3 Flutter Widget Tests

The file:

```text
test/widget_test.dart
```

contains:

```text
3 independent widget tests
```

They validate:

- Application startup
- Updated loading message
- Text and image counters
- Search interface
- Empty-query validation
- Clear-button behaviour

The full final test suite contains:

```text
14 passed
0 failed
```

---

## 25. Widget-Test Technical Design

The application performs real local file-system operations during startup.

The widget tests therefore use:

```dart
tester.runAsync(...)
```

This allows:

- Directory listing
- File reading
- Text parsing
- JSON reading
- Image-file validation
- Asynchronous indexing

The tests use a bounded helper that waits for:

```text
Search local content
```

to appear.

This prevents indefinite waiting.

---

## 26. Desktop Test Viewport

The widget tests use:

```text
1280 × 900
Device pixel ratio: 1.0
```

This reflects the Windows desktop target.

The larger viewport prevents artificial overflow errors caused by Flutter's smaller default test viewport.

The viewport is reset after every test.

---

## 27. Build Architecture

The Windows application is built using Flutter's Windows desktop target.

The command is:

```bash
flutter run -d windows
```

The generated debug executable is:

```text
build/windows/x64/runner/Debug/offline_multimodal_retrieval.exe
```

The Windows directory contains generated C++, CMake, and runner infrastructure.

These files support execution but do not contain the main retrieval logic.

---

## 28. Dependency Architecture

Dependencies are managed through:

```text
pubspec.yaml
pubspec.lock
```

The current dependency versions are compatible with the active Flutter environment.

Newer but incompatible versions are not automatically installed.

This reduces regression risk during finalisation.

---

## 29. Source-Control Architecture

The project uses Git and GitHub.

The main branch is:

```text
main
```

The development workflow is:

```text
Implement
→ Run command-line test
→ Run automated tests
→ Run Windows application
→ Capture screenshots
→ Update documentation
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

## 30. Current Architecture Strengths

The final architecture provides:

- Clear text and image branches
- Unified query interface
- Typed data models
- Model-service-UI separation
- Reusable backend services
- Offline-first processing
- Local privacy
- Deterministic behaviour
- Explicit error handling
- Testable service boundaries
- Windows desktop integration
- Image thumbnail display
- Easy future extension points

---

## 31. Current Architecture Limitations

The current architecture does not yet include:

- Persistent text vectors
- Persistent image vectors
- User-selected folders
- PDF parsing
- Word parsing
- PowerPoint parsing
- OCR
- Direct image-pixel analysis
- CLIP or MobileCLIP
- Image-to-image retrieval
- Neural semantic text embeddings
- Unified neural multimodal vector space
- Background indexing
- Incremental indexing
- File watching
- Search history
- User settings persistence
- Installer packaging
- Continuous integration

The current image branch depends on manually written:

```text
description
tags
```

Incorrect metadata can produce inaccurate image results.

---

## 32. Current Multimodal Status

The current system processes two content types:

```text
Text documents
+
Images
```

The interface can return both text and image results.

However, the image branch is metadata-based.

Current behaviour:

```text
Text query
→ Compare with image description and tags
→ Return image
```

Not currently implemented:

```text
Image pixels
→ Neural image encoder
→ Visual-semantic vector
```

Therefore, the current system should be described as:

> A local multimodal retrieval prototype supporting text retrieval and metadata-based text-to-image retrieval.

This wording accurately reflects the implemented architecture.

---

## 33. Future Target Architecture

A future architecture could be:

```text
Flutter UI
   ↓
Application Controller
   ↓
Document and Image Import Service
   ↓
Format-Specific Parsers
   ├── TXT Parser
   ├── Markdown Parser
   ├── PDF Parser
   ├── Word Parser
   ├── PowerPoint Parser
   ├── OCR Service
   └── Image Loader
   ↓
Text and Image Processing
   ↓
Multimodal Embedding Layer
   ├── Neural Text Encoder
   └── Neural Image Encoder
   ↓
Unified Vector Space
   ↓
Persistent Local Vector Store
   ↓
Hybrid Retrieval Service
   ├── Keyword Search
   ├── Semantic Text Search
   ├── Text-to-Image Search
   ├── Image-to-Image Search
   └── Metadata Filtering
   ↓
Ranked Multimodal Results
```

---

## 34. Future API Architecture

The current project uses internal Dart service interfaces.

It does not currently implement REST endpoints.

A future backend might expose:

```text
POST /index
POST /search
POST /search/images
GET /documents
GET /images
GET /status
DELETE /index
```

An OpenAPI document would be appropriate only after real HTTP endpoints are implemented.

The current system should not be described as having an existing REST API.

---

## 35. Security and Privacy Considerations

The current architecture supports privacy by:

- Keeping text processing local
- Keeping image metadata local
- Avoiding file uploads
- Avoiding cloud vector storage
- Avoiding external retrieval services
- Keeping indexes in memory

Future production work should address:

- File-permission checks
- Path-traversal protection
- Malformed JSON handling
- Malformed image handling
- Local database encryption
- Secure deletion
- Log redaction
- Dependency vulnerability scanning
- Metadata integrity checks

---

## 36. Performance Considerations

The current dataset is small:

```text
2 supported text documents
5 supported images
```

Current startup work includes:

```text
Read all text files
→ Parse all text
→ Rebuild text chunks
→ Rebuild text vocabulary
→ Rebuild text vectors
→ Read image metadata
→ Check all image files
```

This is acceptable for demonstration data.

For a larger dataset, the architecture should add:

- Incremental indexing
- Cached vectors
- Background processing
- Persistent storage
- File-change detection
- Batch processing
- Pagination
- Image lazy loading
- Result virtualization

---

## 37. Scalability Considerations

Current limitations affecting scale include:

- Full text-index rebuild
- Image metadata reload
- In-memory vector storage
- Linear comparison against all text vectors
- Linear comparison against all image metadata
- Fixed local directories
- No indexing queue
- No batching

Potential improvements include:

- Approximate nearest-neighbour search
- Vector database indexing
- Metadata prefilters
- Parallel parsing
- Lazy image loading
- Cached tokenisation
- Cached embeddings
- Background workers

---

## 38. Traceability

| Requirement | Architectural Component |
|---|---|
| Parse TXT and Markdown | `FileParserService` |
| Clean text | `TextProcessingService` |
| Divide documents | `TextChunkingService` |
| Build text vocabulary | `SimpleEmbeddingService` |
| Generate text vectors | `SimpleEmbeddingService` |
| Compare query with text | `SimilaritySearchService` |
| Rank text results | `SimilaritySearchService` |
| Load image metadata | `ImageMetadataService` |
| Validate image files | `ImageMetadataService` |
| Represent images | `ImageDocument` |
| Represent image results | `ImageSearchResult` |
| Compare query with images | `ImageSearchService` |
| Rank image results | `ImageSearchService` |
| Display unified interface | `SearchScreen` |
| Display thumbnails | `SearchScreen` and `Image.file` |
| Handle errors | Services and `SearchScreen` |
| Run offline | Local file system and in-memory services |
| Test image services | `test/image_search_service_test.dart` |
| Test UI | `test/widget_test.dart` |
| Test backend stages | `tool/` scripts |

---

## 39. Architecture Summary

The final architecture is a modular local-first Flutter Windows desktop architecture.

Its core structure is:

```text
Local text files
→ Text parser
→ Text processor
→ Text chunker
→ Text vectors
→ Text similarity search
→ Ranked text results
```

and:

```text
Local image files
→ Image metadata loader
→ Description and tags
→ Image metadata vectors
→ Image similarity search
→ Ranked image results
→ Local thumbnail display
```

Both branches are coordinated through:

```text
SearchScreen
```

The unified architecture is:

```text
One text query
├── Text retrieval
└── Image retrieval
```

The architecture successfully separates:

```text
Local data
Models
Services
Application coordination
Presentation
Testing
Documentation
```

The current structure is suitable for the completed prototype and provides a clear foundation for future:

- PDF and Office support
- OCR
- Neural text embeddings
- Direct image understanding
- CLIP or MobileCLIP
- Image-to-image search
- Persistent vector storage
- Larger-scale local indexing
- True unified multimodal retrieval