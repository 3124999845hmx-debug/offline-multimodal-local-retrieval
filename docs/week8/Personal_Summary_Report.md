# Offline Multimodal Local Retrieval System

# Personal Summary Report

## 1. Document Information

| Field | Value |
|---|---|
| Project | Offline Multimodal Local Retrieval System |
| Document Title | Personal Summary Report |
| Author | Mingxuan Huang |
| Project Duration | Week 1 to Week 8 |
| Final Revision Date | 2026/07/30 |
| Status | Final |
| Validated Platform | Windows Desktop |

---

## 2. Project Background

The objective of this project was to develop an offline-first local content retrieval system using Flutter and Dart.

The system was designed to help users search local content stored on their own computer without uploading files to a cloud service.

The original long-term vision included support for:

- TXT documents
- Markdown documents
- PDF documents
- Word documents
- Images
- Screenshots
- Scanned documents
- Text and image retrieval

During the eight-week development period, the project progressed from a text-only local retrieval prototype to a broader local retrieval prototype supporting both text and image result types.

The completed prototype supports:

```text
TXT files
Markdown files
JPG files
JPEG files
PNG files
Local text processing
Text chunking
Term-frequency vectors
Cosine-similarity search
Ranked text results
Metadata-based text-to-image retrieval
Local image thumbnails
Flutter Windows desktop interface
```

The current image-search implementation uses manually prepared image descriptions and tags.

It does not directly analyse image pixels using a neural image model.

---

## 3. Personal Responsibilities

I was responsible for the full development lifecycle of the prototype.

My main responsibilities included:

- Defining project requirements
- Setting up the Flutter and Dart development environment
- Preparing local text and image sample data
- Designing the modular project architecture
- Implementing file metadata extraction
- Implementing TXT and Markdown parsing
- Implementing text cleaning and normalisation
- Implementing keyword search
- Implementing ranked search
- Implementing text chunking
- Implementing term-frequency vector generation
- Implementing cosine-similarity search
- Creating the image metadata JSON file
- Implementing `ImageDocument`
- Implementing `ImageSearchResult`
- Implementing `ImageMetadataService`
- Implementing `ImageSearchService`
- Integrating text and image retrieval into one Flutter interface
- Displaying local image thumbnails
- Implementing Search, Clear, Reload, and keyboard interaction
- Writing command-line test scripts
- Writing image-service automated tests
- Writing Flutter widget tests
- Debugging Windows desktop and test-environment issues
- Writing weekly progress reports
- Writing the API interface definition
- Writing software test reports
- Writing the user guide
- Writing the system architecture document
- Updating the project README
- Adding an MIT licence
- Managing Git and GitHub version control

---

## 4. Final System Function

The completed prototype allows users to search supported local text documents and local images through one text query.

The text-retrieval process is:

```text
Read local text files
→ Extract text
→ Clean and normalise text
→ Divide text into chunks
→ Build a shared vocabulary
→ Generate term-frequency vectors
→ Convert the user query into a vector
→ Calculate cosine similarity
→ Rank matching text results
→ Display results in Flutter
```

The image-retrieval process is:

```text
Read local image metadata
→ Validate image files
→ Combine image descriptions and tags
→ Convert query and metadata into vectors
→ Calculate cosine similarity
→ Rank matching images
→ Display thumbnails and metadata in Flutter
```

The text-result interface displays:

- Ranking number
- Source filename
- Chunk index
- Similarity score
- Content preview
- Local file path

The image-result interface displays:

- Ranking number
- Image thumbnail
- Image filename
- Description
- Tags
- Similarity score
- Local image path

The current system can therefore be described as:

> A local-first Windows desktop prototype supporting text retrieval and metadata-based text-to-image retrieval.

---

## 5. Weekly Development Summary

## 5.1 Week 1 — Project Onboarding

Week 1 focused on preparing the project.

The main tasks were:

- Define project requirements
- Install Flutter and Dart
- Configure Android Studio
- Verify the development environment
- Create the GitHub repository
- Prepare sample data
- Record project risks
- Create initial documentation

The main outcome was a working Flutter development environment and a structured project plan.

---

## 5.2 Week 2 — Architecture and Metadata Extraction

Week 2 focused on the initial architecture and local file metadata.

The main tasks were:

- Design the system layers
- Define model and service responsibilities
- Create the `FileMetadata` model
- Create metadata extraction services
- Test filename, path, size, extension, and timestamps

This stage established the modular structure used by later retrieval functions.

---

## 5.3 Week 3 — File Parsing

Week 3 focused on reading supported local document content.

The main tasks were:

- Create the `ParsedDocument` model
- Implement TXT parsing
- Implement Markdown parsing
- Detect unsupported file formats
- Skip unsupported PDF files safely
- Integrate file parsing with metadata extraction

The main result was a pipeline that converted supported local files into parsed document objects.

---

## 5.4 Week 4 — Text Processing and Keyword Search

Week 4 focused on preparing text for retrieval.

The main tasks were:

- Convert text to lowercase
- Normalise whitespace
- Remove unsupported symbols
- Generate searchable-document objects
- Implement keyword matching
- Test related and unrelated queries

This stage created the first working local search function.

---

## 5.5 Week 5 — Text Chunking and Ranked Search

Week 5 focused on retrieval granularity.

The main tasks were:

- Divide documents into text chunks
- Assign chunk indexes
- Preserve source-file information
- Calculate relevance scores
- Rank results
- Limit returned results

This allowed the system to return relevant sections rather than only complete files.

---

## 5.6 Week 6 — Embedding and Similarity Search

Week 6 focused on numerical text representation and similarity ranking.

The main tasks were:

- Build a shared vocabulary
- Generate normalised term-frequency vectors
- Generate query vectors
- Implement cosine similarity
- Rank similarity results
- Handle zero query vectors
- Validate vector dimensions
- Test result filtering and result limits

The Week 6 pipeline produced:

```text
Parsed documents: 2
Searchable documents: 2
Text chunks: 4
Vocabulary size: 17
Embedding vectors: 4
Embedding dimension: 17
```

The Week 6 test report recorded:

```text
Planned functional scenarios: 14
Executed scenarios: 14
Passed scenarios: 14
Failed scenarios: 0
Pass rate: 100%
```

These were functional scenarios executed through an integration-oriented command-line script.

---

## 5.7 Week 7 — Flutter Search Interface

Week 7 focused on integrating the text-retrieval pipeline into a desktop interface.

The main tasks were:

- Create `SearchScreen`
- Update `main.dart`
- Add the Search button
- Add the Clear button
- Add the Reload button
- Display indexing statistics
- Display ranked result cards
- Display similarity scores
- Display source paths
- Add loading, error, and empty-result states
- Add Enter-key search
- Add basic accessibility semantics
- Configure the Windows desktop toolchain
- Run the application on Windows

The Week 7 result was a functional Windows desktop text-search interface.

---

## 5.8 Week 8 — Final Testing, Image Retrieval, and Documentation

Week 8 focused on final validation, image retrieval, and project delivery.

The main tasks were:

- Run static analysis
- Replace the obsolete Flutter counter test
- Add three widget tests
- Resolve the `pumpAndSettle()` timeout
- Resolve asynchronous local file-I/O issues
- Resolve the widget-test viewport overflow
- Add five local sample images
- Add `image_metadata.json`
- Add `ImageDocument`
- Add `ImageSearchResult`
- Add `ImageMetadataService`
- Add `ImageSearchService`
- Add metadata-based text-to-image search
- Add image thumbnails and metadata cards
- Add 11 image-related automated tests
- Confirm that the original text retrieval still worked
- Run the complete automated test suite
- Perform manual Windows checks
- Update final documentation
- Prepare GitHub delivery

The final automated test result was:

```text
14 tests passed
0 tests failed
```

The final static-analysis result was:

```text
0 errors
0 warnings
139 information-level notices
```

---

## 6. Main Technical Contributions

## 6.1 Modular Architecture

The project was divided into:

```text
Models
Services
Screens
Tests
Tools
Documentation
```

The final service structure contains two retrieval branches.

The text branch is:

```text
FileParserService
→ TextProcessingService
→ TextChunkingService
→ SimpleEmbeddingService
→ SimilaritySearchService
```

The image branch is:

```text
ImageMetadataService
→ ImageSearchService
```

Both branches are coordinated through:

```text
SearchScreen
```

This structure improves:

- Maintainability
- Testability
- Reusability
- Separation of concerns
- Future extensibility

---

## 6.2 Local File Parsing

I implemented local text-file processing for:

```text
.txt
.md
```

Unsupported PDF files are skipped safely.

The terminal displays:

```text
Unsupported file type skipped: sample3.pdf
```

This prevents one unsupported file from terminating the complete retrieval pipeline.

---

## 6.3 Text Processing and Chunking

The text-processing stage:

- Converts text to lowercase
- Normalises whitespace
- Removes unsupported characters
- Preserves searchable terms
- Prepares content for tokenisation

Documents are divided into smaller units called text chunks.

Each chunk preserves:

- Source filename
- Source path
- Chunk index
- Chunk content

This improves retrieval granularity and allows the interface to display focused previews.

---

## 6.4 Term-Frequency Vectors

The current embedding method uses normalised term frequency.

For each term:

```text
Term frequency =
Number of occurrences
÷
Total number of tokens
```

This method was selected because it is:

- Lightweight
- Deterministic
- Easy to explain
- Easy to test
- Fully offline
- Independent of external AI models

Its main limitation is weak synonym and contextual understanding.

---

## 6.5 Cosine Similarity

Cosine similarity compares the direction of the query vector with indexed content vectors.

A higher score means that the query and indexed content have stronger vocabulary overlap.

The score is not a probability.

The same principle is used for:

```text
Query versus text chunk
Query versus image description and tags
```

---

## 6.6 Image Metadata Retrieval

I added a second local content branch for images.

The system supports:

```text
.jpg
.jpeg
.png
```

The image metadata file stores:

```text
fileName
description
tags
```

The system combines the description and tags into searchable image text.

For example:

```text
A domestic cat sitting indoors.
cat animal pet indoor feline
```

The user can search:

```text
pet
```

and retrieve:

```text
cat.jpg
```

This is metadata-based text-to-image retrieval rather than direct image-pixel understanding.

---

## 6.7 Flutter Desktop Interface

The final Flutter interface provides:

- Unified query input
- Text-result section
- Image-result section
- Local image thumbnails
- Query clearing
- Text and image index reloading
- Pipeline statistics
- Validation feedback
- Loading feedback
- Empty-result feedback
- Keyboard interaction
- Basic accessibility support

This transformed the backend retrieval logic into a usable Windows desktop prototype.

---

## 7. Testing Work

The project used command-line tests, automated service tests, widget tests, and manual testing.

## 7.1 Command-Line Testing

Command-line scripts were used to test:

- Metadata extraction
- File parsing
- Keyword search
- Ranked search
- Similarity search
- Image metadata loading
- Image search

These scripts provided detailed execution output for each pipeline stage.

---

## 7.2 Week 6 Functional Testing

The Week 6 report contained 14 functional scenarios.

| Module | Scenarios | Passed |
|---|---:|---:|
| File parsing and unsupported-file handling | 2 | 2 |
| Text processing | 1 | 1 |
| Text chunking | 1 | 1 |
| Vocabulary generation | 1 | 1 |
| Embedding generation and validation | 2 | 2 |
| Query-vector generation | 1 | 1 |
| Similarity search and result handling | 6 | 6 |
| **Total** | **14** | **14** |

The pass rate was:

```text
100%
```

These were individual functional scenarios executed through one integration-oriented command-line test script.

They were not implemented as 14 separate automated test functions.

---

## 7.3 Final Image-Service Automated Testing

The following file contains the formal image-service tests:

```text
test/image_search_service_test.dart
```

It contains 11 independent automated tests.

The tests cover:

- Loading five image documents
- Building searchable image text
- Car image search
- Cat image search
- Mountain image search
- Office image search
- Website screenshot search
- Unrelated-query handling
- Empty-query handling
- Result limiting
- Descending similarity-score order

The final result was:

```text
11 passed
0 failed
```

---

## 7.4 Flutter Widget Testing

Three independent widget tests were implemented:

1. Application startup and interface display
2. Empty-query validation
3. Clear-button behaviour

The startup test also verifies:

- Updated loading text
- Text summary counters
- Image count
- Search field
- Search button
- Clear button
- Ready state

The final widget-test result was:

```text
3 passed
0 failed
```

---

## 7.5 Final Automated Test Result

The complete command was:

```bash
flutter test
```

The final result was:

```text
00:09 +14: All tests passed!
```

The final breakdown was:

```text
Image metadata tests: 2 passed
Image retrieval tests: 9 passed
Widget tests: 3 passed

Total automated tests: 14
Passed: 14
Failed: 0
Pass rate: 100%
```

---

## 7.6 Manual Testing

The Windows application was manually tested for:

- Application startup
- Text indexing
- Image metadata loading
- Text queries
- Image queries
- Local image-thumbnail display
- Image descriptions and tags
- Empty-query handling
- Unrelated-query handling
- Clear behaviour
- Reload behaviour
- Enter-key search
- Unsupported PDF handling
- Normal application exit

All planned checks passed.

---

## 8. Main Problems and Solutions

## 8.1 Incorrect Service Method Names

### Problem

Some early test code called service methods that did not exist.

### Solution

The actual service interfaces were reviewed and the test scripts were updated to use the correct methods.

---

## 8.2 Dynamic List Type Error

### Problem

A mapping operation produced:

```text
List<dynamic>
```

The processing service required a typed list.

### Solution

The typed batch conversion method was used directly.

This preserved the correct Dart types.

---

## 8.3 Windows Toolchain Problem

### Problem

Flutter initially could not build the Windows desktop application.

### Cause

The required Visual Studio C++ components were missing.

### Solution

The following components were installed:

```text
Desktop development with C++
MSVC build tools
C++ CMake tools for Windows
Windows SDK
```

After configuration, the Windows application built successfully.

---

## 8.4 Obsolete Counter Widget Test

### Problem

The default Flutter counter test did not represent the retrieval interface.

### Solution

The old counter test was replaced with retrieval-interface widget tests.

---

## 8.5 `pumpAndSettle()` Timeout

### Problem

The widget tests timed out.

### Cause

The animated loading indicator continuously scheduled frames.

### Solution

A bounded waiting helper was implemented instead of using `pumpAndSettle()`.

---

## 8.6 Asynchronous File-I/O Problem

### Problem

The widget tests could not complete local document and image loading.

### Cause

The application performs real directory and file operations, while Flutter widget tests normally use a controlled clock.

### Solution

The tests used:

```dart
tester.runAsync(...)
```

This allowed the real local file-system operations to complete.

---

## 8.7 RenderFlex Overflow

### Problem

The empty-query test generated a vertical overflow error.

### Cause

The default widget-test viewport was too small for the Windows desktop interface.

### Solution

The test viewport was configured to:

```text
1280 × 900
```

The final tests passed without rendering exceptions.

---

## 8.8 Updated Loading Text

### Problem

After image support was added, the loading message changed from:

```text
Loading and indexing local documents...
```

to:

```text
Loading and indexing local documents and images...
```

### Solution

The widget-test expectation was updated.

---

## 8.9 Updated Vector Label

### Problem

The interface changed from:

```text
Vectors:
```

to:

```text
Text vectors:
```

### Solution

The test was updated and a new expectation for:

```text
Images:
```

was added.

---

## 8.10 Missing Image Test File

### Problem

The first image test command failed because the test file had not yet been created.

### Solution

The file was added at:

```text
test/image_search_service_test.dart
```

The tests then executed successfully.

---

## 8.11 Image and Metadata Mismatch

### Problem

An early sample image did not match its filename and metadata.

### Solution

The image was replaced so that:

```text
cat.jpg
```

correctly displayed a cat and matched its description and tags.

---

## 8.12 Flutter Web File-System Limitation

### Problem

The Flutter Web interface could open, but local indexing failed.

### Cause

The application uses:

```dart
dart:io
```

Browsers cannot directly scan arbitrary local folders through this architecture.

### Conclusion

The validated target is:

```text
Windows desktop
```

The web interface is not the completed retrieval target.

---

## 9. Skills and Knowledge Gained

Through this project, I developed practical knowledge in several areas.

### Flutter and Dart

- Flutter project structure
- Stateful widgets
- Material 3 interface design
- Text input
- Buttons, lists, and cards
- Local image display
- Focus management
- Keyboard shortcuts
- Asynchronous programming
- Widget testing

### Software Architecture

- Separation of concerns
- Model-service-view structure
- Parallel retrieval branches
- Typed data models
- Service dependencies
- Modular design
- Traceability

### Information Retrieval

- Text normalisation
- Tokenisation
- Text chunking
- Vocabulary generation
- Term-frequency representation
- Query vectors
- Cosine similarity
- Ranked text retrieval
- Metadata-based image retrieval

### Software Testing

- Component testing
- Integration testing
- Automated service testing
- Widget testing
- Manual testing
- Expected and actual results
- Root-cause analysis
- Regression testing
- Pass-rate reporting

### Documentation and Version Control

- Weekly progress reports
- API interface definitions
- Test reports
- User guides
- Architecture documents
- README documentation
- Git
- GitHub
- MIT licence integration

---

## 10. Project Achievements

The project successfully delivered:

```text
A functional Windows desktop local retrieval prototype
```

The completed text workflow is:

```text
Local text files
→ Parsing
→ Text processing
→ Chunking
→ Vector generation
→ Similarity ranking
→ Ranked text results
```

The completed image workflow is:

```text
Local image files
→ Metadata loading
→ Description and tag processing
→ Vector comparison
→ Ranked image results
→ Thumbnail display
```

The project also delivered:

- Eight weeks of progress documentation
- Week 6 API interface definition
- Week 6 software test report
- Week 7 interface report
- Week 8 final test report
- User guide
- System architecture document
- Personal summary report
- Updated README
- MIT licence
- GitHub repository
- Fourteen passing automated tests
- Final Windows validation evidence

---

## 11. Current Limitations

The completed prototype still has several limitations:

- PDF content extraction is not implemented.
- Word document parsing is not implemented.
- PowerPoint parsing is not implemented.
- OCR is not implemented.
- Image pixels are not analysed directly.
- CLIP or MobileCLIP is not implemented.
- Image-to-image retrieval is not implemented.
- Neural semantic text embeddings are not implemented.
- Synonyms are not reliably recognised.
- The index is stored only in memory.
- The local directories are fixed.
- Users cannot select folders through the interface.
- Result cards cannot open source files.
- Large-scale performance has not been tested.
- A Windows installer has not been created.
- Web local-folder retrieval is not supported.

These limitations do not prevent the completed Windows prototype from functioning.

---

## 12. Future Improvements

The most important future improvements are:

1. Add a graphical folder-selection function.
2. Add PDF content extraction.
3. Add Word and PowerPoint parsing.
4. Add OCR.
5. Add neural text embeddings.
6. Add CLIP or MobileCLIP.
7. Add direct image-pixel analysis.
8. Add image-to-image retrieval.
9. Add persistent local vector storage.
10. Add incremental indexing.
11. Add background file monitoring.
12. Add result-type filters.
13. Add source-file opening.
14. Add search history.
15. Add performance tests.
16. Add automated continuous integration.
17. Create a Windows installer.

---

## 13. Personal Reflection

This project helped me understand that software development is not only about writing code.

A complete project also requires:

```text
Requirement definition
Architecture
Implementation
Testing
Debugging
Documentation
Version control
Delivery
```

The development process progressed through clear layers:

```text
Files
→ Text
→ Search
→ Ranking
→ Vectors
→ Interface
→ Images
→ Testing
→ Delivery
```

I also learned that a working prototype must be described accurately.

The current system processes both text documents and images, but the image branch is metadata-based.

Therefore, the accurate project description is:

> A functional local-first Windows desktop prototype supporting text retrieval and metadata-based text-to-image retrieval.

This wording reflects the completed implementation without overstating direct visual understanding.

---

## 14. Final Project Status

| Area | Status |
|---|---|
| Project requirements | Completed |
| Development environment | Completed |
| Metadata extraction | Completed |
| TXT parsing | Completed |
| Markdown parsing | Completed |
| Text processing | Completed |
| Keyword search | Completed |
| Ranked search | Completed |
| Text chunking | Completed |
| Term-frequency vectors | Completed |
| Cosine similarity | Completed |
| JPG/JPEG/PNG loading | Completed |
| Image metadata loading | Completed |
| Metadata-based image retrieval | Completed |
| Image thumbnails | Completed |
| Flutter Windows interface | Completed |
| Image-service tests | Completed |
| Widget tests | Completed |
| Manual Windows testing | Completed |
| Final documentation | Completed |
| README | Completed |
| MIT licence | Completed |
| GitHub delivery | In final update |
| PDF parsing | Future work |
| OCR | Future work |
| Direct neural image understanding | Future work |
| Persistent indexing | Future work |

---

## 15. Conclusion

The eight-week project successfully produced a working local-first retrieval prototype for Windows desktop.

The system can:

```text
Read supported text files
→ Process and chunk text
→ Generate vectors
→ Compare queries
→ Rank text results
```

It can also:

```text
Read image metadata
→ Compare queries with descriptions and tags
→ Rank images
→ Display local thumbnails
```

The final test results were:

```text
Week 6 functional scenarios:
14 passed
0 failed

Final Week 8 automated tests:
14 passed
0 failed

Windows build:
Passed

Windows execution:
Passed
```

The project was tested, documented, and prepared for GitHub delivery.

The completed prototype provides a structured foundation for future PDF, OCR, neural text, direct image, persistent, and larger-scale multimodal retrieval development.