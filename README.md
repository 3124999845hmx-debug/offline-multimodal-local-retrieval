# Offline Multimodal Local Retrieval System

A free, open-source, offline-first Flutter prototype for searching local text content and retrieving local images through metadata-based text queries.

The validated implementation runs on Windows desktop and supports:

```text
TXT and Markdown text retrieval
+
JPG, JPEG, and PNG metadata-based image retrieval
```

The image-search branch uses local image descriptions and tags.

It does not directly analyse image pixels using CLIP, CNN, or another neural image model.

---

## 1. Project Overview

The system helps users search content stored on their own devices without uploading files to a cloud retrieval service.

The final prototype supports two retrieval branches.

### Text Retrieval Branch

```text
TXT and Markdown files
→ File parsing
→ Text processing
→ Text chunking
→ Term-frequency vectors
→ Cosine similarity
→ Ranked text results
```

### Image Retrieval Branch

```text
JPG, JPEG, and PNG files
→ image_metadata.json
→ Image descriptions and tags
→ Term-frequency vectors
→ Cosine similarity
→ Ranked image results
→ Local image thumbnails
```

One user query can return both text and image results.

Unsupported PDF files are detected and skipped safely.

---

## 2. Project Purpose

The project is not intended to replace Microsoft 365, WPS Office, or a complete document-management platform.

Its core purpose is:

```text
Local content loading
→ Local content processing
→ Local indexing
→ Query matching
→ Ranked text and image result display
```

The project focuses on:

- Offline-first retrieval
- Local privacy
- Modular architecture
- Flutter Windows desktop development
- Deterministic retrieval behaviour
- Accessible user-interface design
- Future multimodal extensibility
- Open-source software delivery

---

## 3. Current Features

### 3.1 Text Retrieval

The text-retrieval branch includes:

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
- Ranked text-result display

### 3.2 Image Retrieval

The image-retrieval branch includes:

- JPG image support
- JPEG image support
- PNG image support
- Local image metadata loading
- Image-file existence validation
- Image description and tag processing
- Metadata-based text-to-image retrieval
- Ranked image-result display
- Local image-thumbnail display
- Image filename display
- Image description display
- Image tag display
- Local image-path display

### 3.3 Flutter User Interface

The Flutter interface includes:

- Unified query field
- Search button
- Clear button
- Reload button
- Enter-key search
- Loading state
- Ready state
- Empty-query validation
- Empty-result feedback
- Text-result section
- Image-result section
- Result ranking
- Similarity-score display
- Local source-path display
- Basic accessibility semantics

### 3.4 Testing and Documentation

The project includes:

- Command-line pipeline tests
- Eleven image-related automated tests
- Three Flutter widget tests
- Fourteen final automated tests
- Weekly progress reports
- API interface documentation
- Software test reports
- User guide
- System architecture document
- Personal summary report
- MIT licence

---

## 4. Current Retrieval Workflow

The final application uses one text query.

```text
User query
├── Text retrieval
│   ├── TXT results
│   └── Markdown results
└── Image retrieval
    ├── JPG results
    ├── JPEG results
    └── PNG results
```

The complete workflow is:

```text
Local files
→ Content or metadata loading
→ Text normalisation
→ Vector generation
→ Cosine-similarity calculation
→ Ranked text and image results
→ Flutter Windows interface
```

---

## 5. Technology Stack

| Area | Technology |
|---|---|
| User Interface | Flutter |
| Programming Language | Dart |
| Validated Target | Windows desktop |
| Local File Access | `dart:io` |
| Text Representation | Normalised term-frequency vectors |
| Similarity Method | Cosine similarity |
| Image Representation | Description and tags |
| Testing | `flutter_test` |
| Static Analysis | Flutter analyzer |
| Version Control | Git |
| Remote Repository | GitHub |
| Documentation | Markdown |
| Development Environment | Android Studio |
| Windows Toolchain | Visual Studio C++ desktop tools |

---

## 6. Supported File Types

| File Type | Extension | Current Status |
|---|---|---|
| Plain text | `.txt` | Supported |
| Markdown | `.md` | Supported |
| JPG image | `.jpg` | Supported |
| JPEG image | `.jpeg` | Supported |
| PNG image | `.png` | Supported |
| PDF | `.pdf` | Detected and safely skipped |
| Word document | `.docx` | Not implemented |
| PowerPoint | `.pptx` | Not implemented |
| Scanned document | Various | OCR not implemented |

When an unsupported PDF is detected, the terminal may display:

```text
Unsupported file type skipped: sample3.pdf
```

This is expected behaviour and does not indicate application failure.

---

## 7. Project Structure

```text
offline_multimodal_retrieval/
├── android/
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
│   │   ├── image_document.dart
│   │   ├── image_search_result.dart
│   │   └── other text models
│   ├── screens/
│   │   └── search_screen.dart
│   ├── services/
│   │   ├── image_metadata_service.dart
│   │   ├── image_search_service.dart
│   │   └── other text services
│   └── main.dart
├── test/
│   ├── image_search_service_test.dart
│   └── widget_test.dart
├── tool/
│   ├── test_image_metadata.dart
│   ├── test_image_search.dart
│   └── other pipeline tests
├── web/
├── windows/
├── analysis_options.yaml
├── pubspec.lock
├── pubspec.yaml
├── LICENSE
└── README.md
```

---

## 8. Main Source Files

### 8.1 Application Entry Point

```text
lib/main.dart
```

Responsibilities:

- Initialise Flutter
- Configure the application theme
- Launch `SearchScreen`
- Set the application title
- Remove the debug banner

### 8.2 Search Interface

```text
lib/screens/search_screen.dart
```

Responsibilities:

- Initialise text services
- Initialise image services
- Load local text documents
- Load local image metadata
- Build the text index
- Execute unified searches
- Display summary counters
- Display text results
- Display image results
- Display local thumbnails
- Handle loading and errors
- Support keyboard interaction

### 8.3 Text Models

```text
lib/models/
```

The text-related models include:

- `FileMetadata`
- `ParsedDocument`
- `SearchableDocument`
- `TextChunk`
- `EmbeddingVector`
- `SimilarityResult`

### 8.4 Image Models

```text
lib/models/image_document.dart
lib/models/image_search_result.dart
```

`ImageDocument` stores:

- Filename
- File path
- Description
- Tags
- Searchable text

`ImageSearchResult` stores:

- Image document
- Similarity score

### 8.5 Text Services

The text services include:

- `MetadataService`
- `FileParserService`
- `TextProcessingService`
- `KeywordSearchService`
- `RankedSearchService`
- `TextChunkingService`
- `SimpleEmbeddingService`
- `SimilaritySearchService`

### 8.6 Image Services

```text
lib/services/image_metadata_service.dart
lib/services/image_search_service.dart
```

`ImageMetadataService`:

- Reads `image_metadata.json`
- Validates JSON structure
- Validates supported extensions
- Checks that image files exist
- Returns `ImageDocument` objects

`ImageSearchService`:

- Normalises queries
- Tokenises metadata
- Generates term-frequency vectors
- Calculates cosine similarity
- Ranks image results
- Applies optional result limits

---

## 9. Image Metadata Format

Image metadata is stored in:

```text
data/sample_images/image_metadata.json
```

Each image entry requires:

```text
fileName
description
tags
```

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

The value of `fileName` must exactly match the physical image filename.

The system searches:

```text
description
+
tags
```

Incorrect or incomplete metadata can reduce image-search quality.

---

## 10. System Requirements

The final validated environment is Microsoft Windows.

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

A correctly configured environment should not report a blocking Windows desktop toolchain error.

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

## 13. Preparing Local Text Documents

Place supported text files in:

```text
data/sample_documents
```

Supported text extensions are:

```text
.txt
.md
```

Example TXT content:

```text
This document explains local metadata extraction and offline retrieval.
```

Example Markdown content:

```markdown
# Local Retrieval

This document explains text chunking and cosine-similarity search.
```

After adding or editing a file, restart the application or press Reload.

---

## 14. Preparing Local Images

Place supported image files in:

```text
data/sample_images
```

Supported image extensions are:

```text
.jpg
.jpeg
.png
```

Every image must also have a matching entry in:

```text
data/sample_images/image_metadata.json
```

After adding, removing, renaming, or editing images or metadata, restart the application or press Reload.

---

## 15. Using the Application

### 15.1 Start the Application

Run:

```bash
flutter run -d windows
```

During startup, the interface displays:

```text
Loading and indexing local documents and images...
```

The current sample-data summary is:

```text
Documents: 2
Text chunks: 2
Vocabulary: 17
Text vectors: 2
Images: 5
```

### 15.2 Enter a Query

Example queries:

```text
metadata extraction
pet
vehicle road
office computer
```

Then either:

- Click `Search`, or
- Press Enter

### 15.3 Review Text Results

Text results display:

- Ranking number
- Source filename
- Chunk index
- Cosine-similarity score
- Text preview
- Local source path

### 15.4 Review Image Results

Image results display:

- Ranking number
- Local thumbnail
- Image filename
- Description
- Tags
- Cosine-similarity score
- Local source path

### 15.5 Clear a Search

Click:

```text
Clear
```

This removes:

- Current query
- Current text results
- Current image results
- Validation messages

### 15.6 Reload Local Content

Click the Reload button.

Reload performs:

```text
Rescan local text files
→ Reparse supported documents
→ Rebuild text chunks
→ Rebuild vocabulary
→ Regenerate text vectors
→ Reload image metadata
→ Revalidate image files
```

---

## 16. Example Queries

### 16.1 Text Query

```text
metadata extraction
```

Expected results:

```text
sample1.txt
sample2.md
```

### 16.2 Markdown Query

```text
markdown document
```

Expected result:

```text
sample2.md
```

### 16.3 Cat Image Query

```text
pet
```

Expected result:

```text
cat.jpg
```

### 16.4 Car Image Query

```text
vehicle road
```

Expected result:

```text
car.jpg
```

### 16.5 Mountain Image Query

```text
mountain nature
```

Expected result:

```text
mountain.jpg
```

### 16.6 Office Image Query

```text
office computer
```

Expected result:

```text
office.jpg
```

### 16.7 Screenshot Query

```text
video website gaming
```

Expected result:

```text
微信截图.png
```

### 16.8 Empty Query

Pressing Search with an empty field displays:

```text
Please enter a search query.
```

### 16.9 Unrelated Query

An unrelated query displays:

```text
No similar content found
```

---

## 17. Similarity Model

The current application uses normalised term-frequency vectors.

For each vocabulary term:

```text
Term frequency =
Number of occurrences
÷
Total number of tokens
```

The query vector and indexed-content vectors use the same vocabulary for each comparison.

Similarity is calculated using cosine similarity:

```text
Cosine similarity =
Dot product
÷
Product of vector magnitudes
```

The current non-negative vectors normally produce scores between:

```text
0.0 and 1.0
```

A higher score indicates stronger vocabulary overlap.

The score is not a probability.

---

## 18. Testing

### 18.1 Static Analysis

Run:

```bash
flutter analyze
```

The final recorded state was:

```text
0 errors
0 warnings
139 information-level notices
```

The main notice categories were:

```text
avoid_print
avoid_relative_lib_imports
```

These notices do not prevent compilation or execution.

### 18.2 Automated Tests

Run:

```bash
flutter test
```

The final result was:

```text
00:09 +14: All tests passed!
```

The final test breakdown was:

```text
Image metadata tests: 2
Image retrieval tests: 9
Flutter widget tests: 3

Total automated tests: 14
Passed: 14
Failed: 0
Pass rate: 100%
```

### 18.3 Image Command-Line Tests

Run:

```bash
dart run tool/test_image_metadata.dart
dart run tool/test_image_search.dart
```

The image metadata test validates that five supported image documents are loaded.

The image search test validates planned image queries and unrelated-query handling.

### 18.4 Earlier Pipeline Tests

Earlier command-line scripts under:

```text
tool/
```

test:

- File metadata extraction
- File parsing
- Keyword search
- Ranked search
- Text similarity search

---

## 19. Final Validation Status

| Area | Status |
|---|---|
| Flutter environment | Passed |
| Windows toolchain | Passed |
| Dependency resolution | Passed |
| Static analysis | Passed with information notices |
| Image metadata tests | Passed |
| Image retrieval tests | Passed |
| Widget tests | Passed |
| Windows build | Passed |
| Windows launch | Passed |
| Text indexing | Passed |
| Image loading | Passed |
| Ranked text retrieval | Passed |
| Ranked image retrieval | Passed |
| Image thumbnails | Passed |
| Empty-query validation | Passed |
| Empty-result handling | Passed |
| Clear control | Passed |
| Reload control | Passed |
| Enter-key search | Passed |
| Unsupported-file handling | Passed |

Overall result:

```text
PASS
```

---

## 20. Documentation

The project contains weekly and final documentation under:

```text
docs/
```

Important final files include:

```text
docs/week8/Week8_Progress_Report.md
docs/week8/Final_Test_Report.md
docs/week8/System_Architecture.md
docs/week8/User_Guide.md
docs/week8/Personal_Summary_Report.md
```

Earlier weekly documentation remains under:

```text
docs/week1
docs/week2
docs/week3
docs/week4
docs/week5
docs/week6
docs/week7
```

---

## 21. Accessibility

The application includes initial accessibility support through Flutter semantics.

Current support includes:

- Search-field semantic label
- Search-button semantic label
- Clear-button semantic label
- Reload-button semantic label
- Pipeline-summary semantic descriptions
- Text-result semantic descriptions
- Image-result semantic descriptions
- Keyboard Enter search
- Tooltips
- Live-region messages
- Automatic input focus

The current prototype has not undergone formal WCAG certification.

---

## 22. Privacy and Offline Behaviour

The core retrieval workflow operates locally.

The application:

- Reads local text files
- Reads local image files
- Reads local image metadata
- Processes content locally
- Builds vectors locally
- Calculates similarity locally
- Stores index data in memory
- Does not upload document contents
- Does not upload image contents
- Does not require a cloud search service
- Does not require a remote vector database

Internet access may still be needed for:

- Flutter dependency installation
- Dart package downloads
- GitHub version control

The retrieval workflow itself is local.

---

## 23. Windows and Web Behaviour

The validated target is:

```text
Windows desktop
```

The application uses:

```dart
dart:io
```

for local file-system access.

The same local-folder workflow is not supported in Flutter Web without architectural changes.

For final testing and demonstration, use:

```bash
flutter run -d windows
```

---

## 24. Known Limitations

The current prototype does not yet support:

- PDF content extraction
- Word document parsing
- PowerPoint parsing
- OCR
- Direct image-pixel understanding
- CLIP or MobileCLIP
- Image-to-image retrieval
- Neural semantic text embeddings
- Persistent vector storage
- Incremental indexing
- Background indexing
- User-selected folders
- Opening source files
- Search history
- Production logging
- Automated continuous integration
- Formal accessibility certification
- Windows installer packaging
- Large-scale performance validation
- Fully supported web retrieval

The current image branch depends on manually prepared descriptions and tags.

Incorrect or incomplete metadata can reduce retrieval accuracy.

---

## 25. Future Development

Potential future improvements include:

- Add PDF parsing.
- Add Word and PowerPoint parsing.
- Add OCR.
- Add neural text embeddings.
- Add CLIP or MobileCLIP.
- Add direct image-pixel analysis.
- Add image-to-image retrieval.
- Add persistent local vector storage.
- Add hybrid keyword and semantic search.
- Add a graphical folder picker.
- Add file-change monitoring.
- Add incremental indexing.
- Add source-file opening.
- Add search history.
- Add metadata filters.
- Add result-type filters.
- Add automated CI workflows.
- Replace debug `print()` calls with structured logging.
- Package a Windows installer.

---

## 26. Open-Source Status

The project is distributed under the MIT License.

The repository root contains:

```text
LICENSE
```

The licence defines the conditions under which the project may be used, modified, and redistributed.

---

## 27. Current Project Status

The final project status is:

```text
Working Windows local retrieval prototype
Text retrieval completed
Metadata-based image retrieval completed
Five local images validated
Fourteen automated tests passing
Final documentation updated
Ready for final GitHub commit and push
```

---

## 28. Summary

The Offline Multimodal Local Retrieval System is a functional Flutter Windows desktop prototype.

It supports:

```text
TXT and Markdown text retrieval
+
JPG, JPEG, and PNG metadata-based image retrieval
```

The image capability should be described accurately as:

> Metadata-based text-to-image retrieval using local image descriptions and tags.

The final implementation provides a stable foundation for future:

- PDF and Office parsing
- OCR
- Neural text embeddings
- Direct image understanding
- Persistent vector storage
- Larger-scale multimodal retrieval