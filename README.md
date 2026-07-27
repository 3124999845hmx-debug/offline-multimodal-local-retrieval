# Offline Multimodal Local Retrieval System

A free, open-source, offline-first, cross-platform prototype for searching and retrieving local document content.

The current implementation focuses on local text retrieval using Flutter and Dart. It can parse supported local files, process and chunk their text, generate lightweight term-frequency vectors, calculate cosine similarity, and display ranked results through a Windows desktop interface.

---

## 1. Project Overview

The system is designed to help users search and retrieve content stored on their own devices.

The long-term project vision includes support for:

- Plain-text documents
- Markdown documents
- PDF documents
- Word documents
- PowerPoint documents
- Images
- Screenshots
- Scanned documents
- Multimodal text and image retrieval

The current working prototype supports local text retrieval for:

```text
TXT
Markdown
```

Unsupported files such as PDFs are detected and skipped safely.

---

## 2. Project Purpose

This system is not intended to replace office software such as Microsoft 365 or WPS Office.

Its core purpose is:

```text
Local content import
→ Local content processing
→ Local indexing
→ Query matching
→ Ranked result display
```

The project focuses on:

- Offline-first retrieval
- Local privacy
- Modular architecture
- Cross-platform Flutter development
- Accessible user-interface design
- Future multimodal extensibility
- Open-source software delivery

---

## 3. Current Features

The current prototype includes:

- Local file metadata extraction
- TXT file parsing
- Markdown file parsing
- Safe unsupported-file handling
- Text cleaning and normalisation
- Keyword search
- Ranked keyword search
- Text chunking
- Shared vocabulary generation
- Term-frequency vector generation
- Query-vector generation
- Cosine-similarity calculation
- Ranked similarity-search results
- Flutter Windows desktop interface
- Search query input
- Search button
- Clear button
- Reload button
- Enter-key search
- Loading state
- Ready state
- Empty-query validation
- Empty-result feedback
- Result ranking
- Similarity-score display
- Source filename display
- Chunk-index display
- Content preview
- Source-path display
- Basic accessibility semantics
- Automated Flutter widget tests
- Weekly progress documentation
- API interface documentation
- Software test reports
- User guide
- System architecture documentation

---

## 4. Current Retrieval Workflow

The current application follows this pipeline:

```text
Local files
→ File parsing
→ Parsed documents
→ Text processing
→ Searchable documents
→ Text chunking
→ Shared vocabulary
→ Term-frequency vectors
→ Query vector
→ Cosine similarity
→ Ranked results
→ Flutter desktop interface
```

---

## 5. Current Technology Stack

| Area | Technology |
|---|---|
| User Interface | Flutter |
| Programming Language | Dart |
| Desktop Target | Windows |
| Local File Access | Dart file-system APIs |
| Text Representation | Normalised term-frequency vectors |
| Similarity Method | Cosine similarity |
| Testing | `flutter_test` |
| Static Analysis | Flutter analyzer |
| Version Control | Git |
| Remote Repository | GitHub |
| Documentation | Markdown |
| Development Environment | Android Studio |
| Windows Build Toolchain | Visual Studio C++ desktop tools |

---

## 6. Planned Technology Extensions

The following technologies remain possible future directions and are not yet fully integrated:

| Area | Planned Direction |
|---|---|
| Neural Text Embedding | BERT-based or TensorFlow Lite model |
| Image Embedding | MobileCLIP or another lightweight image model |
| Local Vector Storage | SQLite, Isar, Hive, or a local vector database |
| PDF Parsing | PDFium or another local PDF parser |
| Office Parsing | Format-specific local parsers |
| OCR | Local optical character recognition |
| Multimodal Search | Combined text and image retrieval |
| Background Indexing | Local incremental indexing service |
| Folder Selection | Native folder picker |
| Packaging | Windows installer |

These items are future work rather than completed features.

---

## 7. Supported File Types

| File Type | Extension | Current Status |
|---|---|---|
| Plain text | `.txt` | Supported |
| Markdown | `.md` | Supported |
| PDF | `.pdf` | Detected and safely skipped |
| Word document | `.docx` | Not implemented |
| PowerPoint | `.pptx` | Not implemented |
| Images | `.png`, `.jpg`, `.jpeg` | Not indexed |
| Scanned documents | Various | OCR not implemented |

When an unsupported PDF is detected, the terminal may display:

```text
Unsupported file type skipped: sample3.pdf
```

This is expected behaviour and does not indicate an application failure.

---

## 8. Project Structure

```text
offline_multimodal_retrieval/
├── android/
├── data/
│   ├── sample_documents/
│   ├── sample_images/
│   └── README.md
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
│   ├── test_file_parsing.dart
│   ├── test_keyword_search.dart
│   ├── test_metadata_extraction.dart
│   ├── test_ranked_search.dart
│   └── test_similarity_search.dart
├── web/
├── windows/
├── analysis_options.yaml
├── pubspec.lock
├── pubspec.yaml
├── LICENSE
└── README.md
```

---

## 9. Main Source Files

### Application Entry Point

```text
lib/main.dart
```

Responsibilities:

- Initialise Flutter
- Configure the application theme
- Launch the search interface
- Set the application title
- Remove the debug banner

### Search Interface

```text
lib/screens/search_screen.dart
```

Responsibilities:

- Initialise retrieval services
- Load and index local documents
- Accept user queries
- Run similarity search
- Display summary statistics
- Display ranked results
- Handle loading and error states
- Support keyboard interaction
- Provide basic accessibility semantics

### Data Models

```text
lib/models/
```

Main models include:

- `FileMetadata`
- `ParsedDocument`
- `SearchableDocument`
- `TextChunk`
- `EmbeddingVector`
- `SimilarityResult`

### Retrieval Services

```text
lib/services/
```

Main services include:

- `MetadataService`
- `FileParserService`
- `TextProcessingService`
- `KeywordSearchService`
- `RankedSearchService`
- `TextChunkingService`
- `SimpleEmbeddingService`
- `SimilaritySearchService`

---

## 10. System Requirements

The final tested environment is Windows.

Required software:

```text
Flutter SDK
Dart SDK
Git
Android Studio or Visual Studio Code
Visual Studio with Desktop development with C++
```

The Windows toolchain should include:

```text
MSVC build tools
C++ CMake tools for Windows
Windows SDK
```

Verify the environment using:

```bash
flutter doctor -v
```

A correctly configured environment should report:

```text
No issues found!
```

---

## 11. Installation

Clone the repository:

```bash
git clone https://github.com/3124999845hmx-debug/offline-multimodal-local-retrieval.git
```

Open the project directory:

```bash
cd offline-multimodal-local-retrieval
```

Install Flutter dependencies:

```bash
flutter pub get
```

Check the environment:

```bash
flutter doctor -v
```

---

## 12. Running the Windows Application

Run:

```bash
flutter run -d windows
```

A successful build should display output similar to:

```text
Launching lib\main.dart on Windows in debug mode...
Building Windows application...
Built build\windows\x64\runner\Debug\offline_multimodal_retrieval.exe
Syncing files to device Windows...
```

The debug executable is generated under:

```text
build/windows/x64/runner/Debug/
```

To stop the running application from the terminal, press:

```text
q
```

---

## 13. Using the Application

### 13.1 Prepare Local Documents

Place supported files in:

```text
data/sample_documents
```

Supported content files are currently:

```text
.txt
.md
```

### 13.2 Start the Application

Run:

```bash
flutter run -d windows
```

The application automatically scans and indexes the local sample directory.

### 13.3 Enter a Query

Example:

```text
metadata extraction
```

Then either:

- Click `Search`, or
- Press Enter

### 13.4 Review Results

Each result card displays:

- Ranking number
- Source filename
- Chunk index
- Cosine-similarity score
- Text preview
- Local source path

### 13.5 Clear a Search

Click:

```text
Clear
```

This removes:

- Current query
- Current results
- Validation messages

### 13.6 Reload Local Files

Click the reload icon in the application bar.

Reload performs:

```text
Rescan local directory
→ Reparse supported files
→ Reprocess text
→ Rebuild chunks
→ Rebuild vocabulary
→ Regenerate vectors
```

---

## 14. Example Queries

### Metadata Query

```text
metadata extraction
```

Expected behaviour:

- Relevant TXT and Markdown content is returned.
- Results are ordered by similarity score.

### Markdown Query

```text
markdown document
```

Expected behaviour:

- The Markdown sample document is returned.

### Unrelated Query

```text
unrelated query
```

Expected behaviour:

```text
No similar content found
```

### Empty Query

Pressing Search without entering text displays:

```text
Please enter a search query.
```

---

## 15. Similarity Model

The current application uses normalised term-frequency vectors.

For each vocabulary term:

```text
Term frequency =
Number of occurrences of the term
÷
Total number of tokens
```

The query vector and document vectors use the same shared vocabulary.

Similarity is calculated using cosine similarity:

```text
Cosine similarity =
Dot product
÷
Product of vector magnitudes
```

The current non-negative vectors generally produce scores between:

```text
0.0 and 1.0
```

A higher score indicates stronger vocabulary overlap.

The score is not a probability.

---

## 16. Testing

### 16.1 Static Analysis

Run:

```bash
flutter analyze
```

The final Week 8 state recorded:

```text
0 errors
0 warnings
100 information-level lint notices
```

The main notice categories were:

```text
avoid_print
avoid_relative_lib_imports
```

These notices do not prevent compilation or execution.

### 16.2 Automated Widget Tests

Run:

```bash
flutter test
```

The final Week 8 test result was:

```text
3 tests passed
0 failed
```

The tests cover:

- Application startup
- Retrieval-interface display
- Empty-query validation
- Clear-button behaviour

### 16.3 Command-Line Integration Tests

Earlier service and pipeline tests are stored under:

```text
tool/
```

Examples:

```bash
dart run tool/test_metadata_extraction.dart
dart run tool/test_file_parsing.dart
dart run tool/test_keyword_search.dart
dart run tool/test_ranked_search.dart
dart run tool/test_similarity_search.dart
```

---

## 17. Final Validation Status

| Area | Status |
|---|---|
| Flutter environment | Passed |
| Windows toolchain | Passed |
| Dependency resolution | Passed |
| Static analysis | Passed with info notices |
| Automated widget tests | Passed |
| Windows build | Passed |
| Windows launch | Passed |
| Local indexing | Passed |
| Ranked search | Passed |
| Empty-query validation | Passed |
| Empty-result handling | Passed |
| Clear control | Passed |
| Reload control | Passed |
| Enter-key search | Passed |
| Unsupported-file handling | Passed |

Overall current prototype result:

```text
PASS
```

---

## 18. Documentation

The project contains weekly and final documentation under:

```text
docs/
```

### Week 1

Project onboarding and setup documentation.

### Week 2

Architecture and metadata-extraction development.

### Week 3

File parsing implementation.

### Week 4

Text processing and keyword search.

### Week 5

Text chunking and ranked search.

### Week 6

Embedding and cosine-similarity search.

Important Week 6 documents include:

```text
docs/week6/Week6_Progress_Report.md
docs/week6/Week6_API_Interface_Definition.md
docs/week6/Week6_Test_Report.md
```

### Week 7

Flutter desktop search-interface integration.

Important file:

```text
docs/week7/Week7_Progress_Report.md
```

### Week 8

Final validation, testing, architecture, and delivery documentation.

Important files:

```text
docs/week8/Final_Test_Report.md
docs/week8/User_Guide.md
docs/week8/System_Architecture.md
docs/week8/Week8_Progress_Report.md
```

---

## 19. Development Timeline

The project followed an eight-week development process.

### Week 1 — Project Onboarding

- Requirement definition
- Environment setup
- Dataset preparation
- Risk planning
- Flutter project validation

### Week 2 — Architecture and Metadata

- Modular architecture
- File metadata model
- Metadata extraction service
- Initial Flutter integration

### Week 3 — File Parsing

- TXT parsing
- Markdown parsing
- Unsupported-file handling
- Parsed-document model

### Week 4 — Text Processing and Keyword Search

- Text cleaning
- Normalisation
- Searchable-document model
- Keyword search

### Week 5 — Text Chunking and Ranked Search

- Text chunking
- Ranked keyword search
- Search-result scoring
- Retrieval integration

### Week 6 — Embedding and Similarity Search

- Shared vocabulary
- Term-frequency vectors
- Query vectors
- Cosine similarity
- Ranked similarity results
- API interface definition
- Software test report

### Week 7 — Flutter Search Interface

- Windows desktop search UI
- Search and Clear controls
- Reload control
- Pipeline statistics
- Ranked result cards
- Accessibility semantics
- Windows toolchain configuration

### Week 8 — Finalisation

- Final static analysis
- Automated widget tests
- Test failure diagnosis and correction
- Windows execution validation
- Final test report
- User guide
- System architecture
- README update
- Licence preparation
- Final repository delivery

---

## 20. Accessibility

The application includes initial accessibility support through Flutter semantics.

Current accessibility features include:

- Search-field semantic label
- Search-button semantic label
- Clear-button semantic label
- Reload-button semantic label
- Pipeline-summary semantic descriptions
- Result-card semantic descriptions
- Loading-state live region
- Empty-result live region
- Keyboard Enter search
- Tooltips
- Automatic input focus

The current prototype has not undergone formal WCAG certification.

---

## 21. Privacy and Offline Behaviour

The retrieval pipeline operates locally.

The application:

- Reads local files
- Processes text locally
- Builds vocabulary locally
- Generates vectors locally
- Calculates similarity locally
- Stores vectors in memory
- Does not upload document content
- Does not require a cloud retrieval service
- Does not require a remote vector database

Internet access may still be needed for:

- Flutter dependency installation
- Package downloads
- GitHub version control

The core retrieval workflow itself is offline.

---

## 22. Known Limitations

The current prototype does not yet support:

- PDF content extraction
- Word document parsing
- PowerPoint parsing
- OCR
- Image indexing
- Image embeddings
- Text-to-image retrieval
- Neural semantic embeddings
- Persistent vector storage
- Incremental indexing
- Background indexing
- User-selected folders
- Opening source files from result cards
- Search history
- Production logging
- Automated continuous integration
- Formal accessibility certification
- Windows installer packaging
- Large-scale performance validation

---

## 23. Future Development

Potential future improvements include:

- Add PDF parsing.
- Add Word and PowerPoint parsing.
- Add OCR.
- Add local image processing.
- Add image embeddings.
- Add multimodal retrieval.
- Add BERT or TensorFlow Lite text embeddings.
- Add persistent local vector storage.
- Add hybrid keyword and semantic search.
- Add a graphical folder picker.
- Add file-change monitoring.
- Add incremental indexing.
- Add source-file opening.
- Add search-history storage.
- Add metadata filters.
- Add result-type filters.
- Add automated CI workflows.
- Replace debug `print()` calls with structured logging.
- Package a Windows installer.

---

## 24. Open-Source Status

The project is intended to be free and open source.

A licence file should be included in the repository root:

```text
LICENSE
```

The licence defines the conditions under which the project may be used, modified, and redistributed.

---

## 25. Current Project Status

The current project status is:

```text
Working local text-retrieval prototype
Windows desktop interface completed
Automated widget tests passing
Final documentation completed
Ready for final repository packaging
```

The current system successfully demonstrates:

```text
Local file import
→ Text extraction
→ Text processing
→ Text chunking
→ Vector generation
→ Similarity ranking
→ Desktop result display
```

---

## 26. Summary

The Offline Multimodal Local Retrieval System is a functional Flutter desktop prototype for local document retrieval.

It currently supports:

```text
TXT and Markdown parsing
+
Text processing
+
Text chunking
+
Term-frequency vectors
+
Cosine-similarity search
+
Ranked Flutter results
```

The project also includes:

```text
Automated tests
Weekly reports
API documentation
Test documentation
User guide
System architecture
Final validation evidence
```

The current implementation provides a stable foundation for future semantic, persistent, and multimodal local retrieval.