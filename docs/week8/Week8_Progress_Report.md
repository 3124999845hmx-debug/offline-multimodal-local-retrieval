# Offline Multimodal Local Retrieval System

# Week 8 Progress Report

**Student Name:** Mingxuan Huang  
**Project Title:** Offline Multimodal Local Retrieval System  
**Week:** Week 8  
**Final Revision Date:** 2026/07/30  
**Validated Platform:** Windows Desktop  
**Status:** Final

---

## 1. Week 8 Objectives

The main objective of Week 8 was to complete the final validation, testing, documentation, and delivery preparation for the Offline Multimodal Local Retrieval System.

Week 1 to Week 7 progressively implemented:

- Flutter project setup
- File metadata extraction
- Local text-file parsing
- Text cleaning and normalisation
- Keyword search
- Ranked keyword search
- Text chunking
- Term-frequency vector generation
- Cosine-similarity search
- Flutter Windows desktop search-interface integration

During the final Week 8 review, the project was also extended to support a second local content type: images.

The final Week 8 objectives were:

- Review the complete project from Week 1 to Week 7.
- Create the final Week 8 documentation structure.
- Run final static analysis.
- Replace the obsolete default Flutter counter test.
- Add automated widget tests for the retrieval interface.
- Resolve asynchronous file-I/O issues in widget tests.
- Resolve widget-test layout overflow.
- Add JPG and PNG image metadata support.
- Add local image metadata loading.
- Add text-to-image retrieval.
- Display local image thumbnails in the Flutter interface.
- Add image descriptions, tags, paths, rankings, and scores.
- Add automated image-retrieval tests.
- Confirm that the original text retrieval still works.
- Run the complete final automated test suite.
- Run the Windows desktop application.
- Perform final manual functional testing.
- Create and update final software documentation.
- Prepare final README and licence updates.
- Prepare the project for final GitHub delivery.

---

## 2. Week 8 Deliverable Structure

The Week 8 documentation structure is:

```text
docs/week8/
├── images/
│   ├── flutter_test_final.png
│   ├── flutter_test_with_image_retrieval.png
│   ├── github_week8_final.png
│   ├── text_retrieval_after_image_extension.png
│   ├── text_to_image_search_cat.png
│   ├── windows_app_final_initial.png
│   └── windows_app_final_search.png
├── Final_Test_Report.md
├── Personal_Summary_Report.md
├── System_Architecture.md
├── User_Guide.md
└── Week8_Progress_Report.md
```

The final automated test files are:

```text
test/widget_test.dart
test/image_search_service_test.dart
```

The final image-search command-line scripts are:

```text
tool/test_image_metadata.dart
tool/test_image_search.dart
```

---

## 3. Final Development Workflow

The finalisation and image-retrieval extension workflow was:

```text
Review project state
→ Run existing text-retrieval prototype
→ Identify missing image-retrieval capability
→ Prepare local JPG and PNG files
→ Create image_metadata.json
→ Create ImageDocument model
→ Create ImageSearchResult model
→ Create ImageMetadataService
→ Create ImageSearchService
→ Test image metadata loading
→ Test text-to-image retrieval
→ Integrate image search into SearchScreen
→ Display image thumbnails and metadata
→ Confirm original text retrieval still works
→ Add formal image-retrieval tests
→ Update widget tests
→ Run flutter analyze
→ Run flutter test
→ Run Windows application
→ Record evidence screenshots
→ Update final documentation
→ Prepare GitHub delivery
```

---

## 4. Final Project Structure Changes

The image-retrieval extension added the following files:

```text
data/sample_images/
├── car.jpg
├── cat.jpg
├── mountain.jpg
├── office.jpg
├── 微信截图.png
└── image_metadata.json
```

New models:

```text
lib/models/image_document.dart
lib/models/image_search_result.dart
```

New services:

```text
lib/services/image_metadata_service.dart
lib/services/image_search_service.dart
```

New command-line tests:

```text
tool/test_image_metadata.dart
tool/test_image_search.dart
```

New formal automated test:

```text
test/image_search_service_test.dart
```

Updated interface and widget test:

```text
lib/screens/search_screen.dart
test/widget_test.dart
```

---

## 5. Final Static Analysis

The following command was executed:

```bash
flutter analyze
```

The final result was:

```text
139 issues found
```

All 139 reported issues were information-level lint notices.

The final static-analysis status was:

```text
Errors: 0
Warnings: 0
Information-level notices: 139
```

The main notice categories were:

```text
avoid_print
avoid_relative_lib_imports
```

### 5.1 `avoid_print`

Several service classes and command-line test scripts use:

```dart
print(...)
```

These statements provide useful execution evidence during prototype development and command-line testing.

Examples include:

- Unsupported file messages
- Image metadata loading output
- Search-result output
- Test-stage summaries

A production implementation should replace these calls with a structured logging framework.

### 5.2 `avoid_relative_lib_imports`

Several scripts in:

```text
tool/
```

use relative paths to import project libraries.

For example:

```dart
import '../lib/services/image_search_service.dart';
```

The scripts execute correctly, but package imports are preferred for maintainability.

### 5.3 Dependency Notices

The analyzer also reported newer versions for:

```text
matcher
meta
test_api
vector_math
```

The newer versions were incompatible with the current dependency constraints.

No dependency upgrade was performed because the current versions were stable and functional, while unnecessary changes could introduce regression risk.

---

## 6. Image Retrieval Extension

The final prototype now supports two categories of local retrieval:

```text
Text query
├── TXT and Markdown content retrieval
└── JPG and PNG image metadata retrieval
```

The text-retrieval pipeline remains:

```text
Local text files
→ File parsing
→ Text processing
→ Text chunking
→ Vocabulary generation
→ Term-frequency vectors
→ Cosine similarity
→ Ranked text results
```

The new image-retrieval pipeline is:

```text
Local image files
→ Image metadata loading
→ Description and tag processing
→ Query normalisation
→ Term-frequency vectors
→ Cosine similarity
→ Ranked image results
→ Thumbnail display
```

---

## 7. Image Metadata Design

The image metadata file is:

```text
data/sample_images/image_metadata.json
```

Each image entry contains:

```text
fileName
description
tags
```

Example structure:

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

The system combines the image description and tags into searchable text:

```text
A domestic cat sitting indoors.
cat animal pet indoor feline
```

The current implementation does not directly analyse image pixels with a neural image model.

Therefore, the accurate description is:

> The current text-to-image retrieval function searches local image descriptions and tags, rather than directly interpreting image pixels.

---

## 8. ImageDocument Model

The following model was added:

```text
lib/models/image_document.dart
```

It stores:

```text
File name
File path
Description
Tags
Searchable text
```

The model converts JSON metadata into a typed Dart object.

The main conversion process is:

```text
JSON entry
→ Read fileName
→ Read description
→ Read tags
→ Construct file path
→ Generate searchableText
→ Create ImageDocument
```

This typed model improves clarity and prevents image metadata from being passed through the program as unstructured maps.

---

## 9. Image Metadata Service

The following service was added:

```text
lib/services/image_metadata_service.dart
```

Its responsibilities are:

- Locate `image_metadata.json`
- Read the JSON content
- Confirm that the JSON root is an array
- Convert entries into `ImageDocument` objects
- Validate supported extensions
- Confirm that each image file exists
- Skip invalid or missing images safely
- Return the final image-document list

The currently supported image formats are:

```text
.jpg
.jpeg
.png
```

The service successfully loaded:

```text
Total Image Documents: 5
```

The loaded files were:

```text
car.jpg
cat.jpg
mountain.jpg
office.jpg
微信截图.png
```

---

## 10. Image Metadata Command-Line Test

The image metadata was tested using:

```bash
dart run tool/test_image_metadata.dart
```

The test confirmed:

```text
Total Image Documents: 5
```

For every image, the script printed:

- File name
- File path
- Description
- Tags
- Searchable text

The execution ended with:

```text
Image metadata loading test completed successfully.
```

This confirmed the following pipeline:

```text
image_metadata.json
→ ImageMetadataService
→ Five ImageDocument objects
```

---

## 11. Image Search Service

The following service was added:

```text
lib/services/image_search_service.dart
```

The image search process is:

```text
User query
→ Lowercase conversion
→ Symbol removal
→ Tokenisation
→ Shared vocabulary generation
→ Query-vector generation
→ Image metadata-vector generation
→ Cosine-similarity calculation
→ Minimum-score filtering
→ Descending score sorting
→ Optional result limiting
```

Each returned item is stored as:

```text
ImageSearchResult
```

An image result contains:

```text
ImageDocument
+
Similarity score
```

Similarity is stored separately because the image metadata remains constant, while the score changes for each query.

---

## 12. Image Search Command-Line Verification

The following command was executed:

```bash
dart run tool/test_image_search.dart
```

The final results were:

```text
Query: vehicle road
1. car.jpg
Score: 0.4867
```

```text
Query: animal pet
1. cat.jpg
Score: 0.4082
```

```text
Query: mountain nature
1. mountain.jpg
Score: 0.4523
```

```text
Query: office computer
1. office.jpg
Score: 0.6030
```

```text
Query: video website gaming
1. 微信截图.png
Score: 0.5893
```

```text
Query: completely unrelated words
No matching images found.
```

The test ended with:

```text
Image search test completed successfully.
```

All planned image queries returned the expected top result.

---

## 13. Flutter Interface Integration

The following file was updated:

```text
lib/screens/search_screen.dart
```

The application now loads both:

```text
data/sample_documents
data/sample_images
```

The same query is sent to:

```text
SimilaritySearchService
+
ImageSearchService
```

The updated search flow is:

```text
User enters one text query
├── Search indexed text chunks
└── Search indexed image metadata
```

The updated interface displays:

```text
Documents: 2
Text chunks: 2
Vocabulary: 17
Text vectors: 2
Images: 5
```

---

## 14. Image Result Interface

Each image-result card displays:

- Ranking number
- Image thumbnail
- Image filename
- Image description
- Tags
- Cosine-similarity score
- Local file path

The result layout adapts to available width.

For a wider desktop window, the thumbnail and metadata are displayed horizontally.

For a narrower window, the result uses a vertical layout.

The interface uses:

```dart
Image.file(...)
```

to display the local image.

If an image cannot be displayed, the card shows a broken-image placeholder instead of terminating the interface.

---

## 15. Text-to-Image Search Evidence

The query:

```text
pet
```

returned:

```text
cat.jpg
```

The result displayed:

```text
Description:
A domestic cat sitting indoors.

Tags:
cat
animal
pet
indoor
feline
```

![Text-to-Image Search](images/text_to_image_search_cat.png)

**Figure 1.** Text-to-image retrieval result for the query `pet`, showing the matching local image, metadata, tags, path, and similarity score.

This confirms:

```text
Text query
→ Image-description and tag matching
→ Ranked image result
→ Local thumbnail display
```

---

## 16. Text Retrieval Regression Verification

After adding image retrieval, the original text search was tested again.

The query:

```text
metadata extraction
```

returned:

```text
sample1.txt
sample2.md
```

The results continued to display:

- Ranking
- Filename
- Chunk index
- Similarity score
- Text preview
- Local path

![Text Retrieval After Image Extension](images/text_retrieval_after_image_extension.png)

**Figure 2.** Original text retrieval working normally after the image-retrieval extension was integrated.

This confirms that the image extension did not break the earlier text-retrieval pipeline.

---

## 17. Original Widget-Test Failure

The original Flutter project template included a counter interface.

The old widget test expected:

```text
0
+
1
```

After the counter interface was replaced with the search interface, the default test became obsolete.

The failure included:

```text
Counter increments smoke test
```

The old counter test was removed and replaced with retrieval-interface tests.

---

## 18. Widget-Test Scope

The final widget tests cover:

```text
1. Application startup and retrieval-interface display
2. Empty-query validation
3. Clear-button query removal
```

The updated file is:

```text
test/widget_test.dart
```

The startup test now verifies:

- Application title
- Updated loading message
- Search interface
- Search field
- Search button
- Clear button
- Document count
- Text chunk count
- Vocabulary count
- Text-vector count
- Image count
- Ready state

---

## 19. Widget-Test Problem: Loading Text Changed

After image loading was introduced, the startup message changed from:

```text
Loading and indexing local documents...
```

to:

```text
Loading and indexing local documents and images...
```

The existing widget test still expected the old text.

### Solution

The test expectation was updated to:

```dart
find.text(
  'Loading and indexing local documents and images...',
)
```

---

## 20. Widget-Test Problem: Vector Label Changed

The previous interface displayed:

```text
Vectors: 2
```

The updated interface displays:

```text
Text vectors: 2
```

The old widget test searched for:

```text
Vectors
```

and failed.

### Solution

The test was updated to check:

```text
Text vectors:
```

A new expectation was also added for:

```text
Images:
```

---

## 21. Widget-Test Problem: `pumpAndSettle()` Timeout

The first replacement widget tests used:

```dart
pumpAndSettle()
```

The tests timed out.

### Cause

The application displays an animated:

```dart
CircularProgressIndicator()
```

during startup indexing.

The animation continuously schedules frames, preventing `pumpAndSettle()` from reaching a fully settled state.

### Solution

A bounded waiting helper was created.

The helper repeatedly checked whether:

```text
Search local content
```

had appeared.

---

## 22. Widget-Test Problem: Local File I/O

The bounded waiting helper initially failed to find the search interface.

The application performs real asynchronous operations:

```text
Directory listing
File reading
Document parsing
Image metadata loading
Image-file validation
```

Widget tests normally use a controlled clock.

### Solution

The final helper used:

```dart
tester.runAsync(...)
```

This allowed real file-system operations to complete.

After each asynchronous delay, the test called:

```dart
tester.pump()
```

to rebuild the interface.

---

## 23. Widget-Test Problem: RenderFlex Overflow

The empty-query test previously reported:

```text
A RenderFlex overflowed by 20 pixels on the bottom.
```

### Cause

The default widget-test viewport was too small for the Windows desktop layout.

### Solution

The test viewport was configured to:

```text
1280 × 900
```

with a device pixel ratio of:

```text
1.0
```

The viewport was reset after each test.

---

## 24. Image Retrieval Automated Test Scope

The following formal test file was added:

```text
test/image_search_service_test.dart
```

It contains 11 separate automated test functions.

### 24.1 Image Metadata Tests

| Test | Expected Result |
|---|---|
| Load supported image documents | Five image documents loaded |
| Build searchable text | Description and tags included |

### 24.2 Text-to-Image Retrieval Tests

| Query or Function | Expected Result |
|---|---|
| `vehicle road` | `car.jpg` |
| `pet` | `cat.jpg` |
| `mountain nature` | `mountain.jpg` |
| `office computer` | `office.jpg` |
| `video website gaming` | `微信截图.png` |
| Unrelated query | Empty result |
| Empty query | Empty result |
| Result limit | Limit applied |
| Sorting | Descending similarity order |

These are 11 independent automated tests, rather than 11 manually interpreted scenarios in one script.

---

## 25. Final Automated Test Result

The full command was:

```bash
flutter test
```

The final result was:

```text
00:09 +14: All tests passed!
```

The final automated-test statistics were:

| Test Group | Passed | Failed |
|---|---:|---:|
| Image metadata tests | 2 | 0 |
| Image retrieval tests | 9 | 0 |
| Flutter widget tests | 3 | 0 |
| **Total** | **14** | **0** |

The final pass rate was:

```text
100%
```

![Flutter Tests with Image Retrieval](images/flutter_test_with_image_retrieval.png)

**Figure 3.** Final complete Flutter test suite showing 14 passed automated tests and no failures.

The terminal also displayed:

```text
Unsupported file type skipped: sample3.pdf
```

This is expected and confirms that unsupported PDF files are skipped safely.

---

## 26. Automated Test Coverage

The final automated tests cover:

- Local image metadata loading
- Image-file validation
- Searchable image text
- Expected image retrieval
- Empty query handling
- Unrelated query handling
- Result limiting
- Similarity-score sorting
- Application startup
- Loading state
- Local file indexing
- Search interface
- Search controls
- Summary counters
- Empty-query validation
- Clear-button behaviour
- Desktop layout compatibility
- Absence of rendering exceptions

---

## 27. Windows Desktop Execution

The final Windows desktop command was:

```bash
flutter run -d windows
```

The output included:

```text
Launching lib\main.dart on Windows in debug mode...
Building Windows application...
Built build\windows\x64\runner\Debug\offline_multimodal_retrieval.exe
Syncing files to device Windows...
```

The Windows application built and launched successfully.

The generated executable was:

```text
build/windows/x64/runner/Debug/offline_multimodal_retrieval.exe
```

---

## 28. Final Windows Initial State

After startup, the application:

- Loaded image metadata
- Verified five local images
- Scanned the local document directory
- Parsed supported text files
- Skipped the unsupported PDF
- Processed text
- Generated chunks
- Generated a text vocabulary
- Generated text vectors
- Displayed the ready state

The interface displays:

```text
Documents: 2
Text chunks: 2
Vocabulary: 17
Text vectors: 2
Images: 5
```

![Final Windows Initial State](images/windows_app_final_initial.png)

**Figure 4.** Windows desktop application after local text and image indexing.

---

## 29. Manual Functional Validation

The following functions were manually checked:

| Test ID | Function | Result |
|---|---|---|
| MF-W8-001 | Windows application starts | Pass |
| MF-W8-002 | Loading state appears | Pass |
| MF-W8-003 | Text indexing completes | Pass |
| MF-W8-004 | Image metadata loading completes | Pass |
| MF-W8-005 | Summary counters appear | Pass |
| MF-W8-006 | `metadata extraction` returns text results | Pass |
| MF-W8-007 | `markdown document` returns Markdown result | Pass |
| MF-W8-008 | `pet` returns `cat.jpg` | Pass |
| MF-W8-009 | `vehicle road` returns `car.jpg` | Pass |
| MF-W8-010 | `mountain nature` returns `mountain.jpg` | Pass |
| MF-W8-011 | `office computer` returns `office.jpg` | Pass |
| MF-W8-012 | `video website gaming` returns screenshot | Pass |
| MF-W8-013 | Unrelated query displays empty state | Pass |
| MF-W8-014 | Empty query displays validation | Pass |
| MF-W8-015 | Clear removes query and results | Pass |
| MF-W8-016 | Reload rebuilds text and image indexes | Pass |
| MF-W8-017 | Enter key triggers search | Pass |
| MF-W8-018 | Unsupported PDF is skipped | Pass |
| MF-W8-019 | Image thumbnails display | Pass |
| MF-W8-020 | Application exits normally | Pass |

---

## 30. Repeated PDF Skip Messages

During execution and testing, the terminal displayed:

```text
Unsupported file type skipped: sample3.pdf
```

multiple times.

This occurred because the indexing pipeline was executed during:

- Application startup
- Reload testing
- Widget tests
- Manual validation

The message is expected and confirms safe unsupported-file handling.

---

## 31. Final Test Documentation

A separate final test document is available at:

```text
docs/week8/Final_Test_Report.md
```

It records:

- Test scope
- Test environment
- Static-analysis results
- Automated test cases
- Manual test cases
- Root-cause analysis
- Corrective actions
- Final pass result
- Known limitations
- Regression recommendations

The document should be updated to include the new image-retrieval extension and the final 14-test result.

---

## 32. User Guide

The final user guide is:

```text
docs/week8/User_Guide.md
```

The updated guide should explain:

- Supported text formats
- Supported image formats
- Image metadata requirements
- Local execution
- Text search
- Text-to-image search
- Result interpretation
- Image thumbnails
- Clear and Reload controls
- Privacy and offline behaviour
- Current limitations

---

## 33. System Architecture Document

The final architecture document is:

```text
docs/week8/System_Architecture.md
```

The final architecture now includes:

```text
Text branch:
TXT / Markdown
→ Parsing
→ Processing
→ Chunking
→ Text vectors
→ Text search

Image branch:
JPG / PNG
→ Metadata loading
→ Description and tags
→ Image metadata vectors
→ Image search

Shared interface:
Text query
→ Text results and/or image results
```

The project uses internal Dart service interfaces and does not implement HTTP or REST APIs.

---

## 34. Week 6 Documentation

The project includes:

```text
docs/week6/Week6_API_Interface_Definition.md
docs/week6/Week6_Test_Report.md
```

The Week 6 documents cover the original text embedding and similarity-search implementation.

The Week 6 report records:

```text
14 planned functional scenarios
14 executed
14 passed
0 failed
100% pass rate
```

These Week 6 scenarios are separate from the final Week 8 automated tests.

The distinction is:

```text
Week 6:
14 functional scenarios verified through an integration-oriented script

Final Week 8:
14 independent flutter test functions
```

---

## 35. Current Final Documentation Set

The project includes:

```text
Week 1–8 progress reports
Week 6 API interface definition
Week 6 software test report
Week 7 Flutter UI progress report
Week 8 final test report
Week 8 user guide
Week 8 system architecture
Week 8 personal summary
Week 8 progress report
README.md
LICENSE
```

The repository is distributed under the MIT License.

---

## 36. Current Technical Status

| Area | Status | Notes |
|---|---|---|
| Flutter project setup | Completed | Windows validated |
| Metadata extraction | Completed | Local file metadata |
| TXT parsing | Completed | Supported |
| Markdown parsing | Completed | Supported |
| JPG loading | Completed | Supported |
| JPEG loading | Completed | Supported |
| PNG loading | Completed | Supported |
| Image metadata JSON | Completed | Description and tags |
| PDF parsing | Pending | Safely skipped |
| Word parsing | Future work | Not implemented |
| PowerPoint parsing | Future work | Not implemented |
| Text processing | Completed | Cleaning and normalisation |
| Text chunking | Completed | Configurable chunk size |
| Shared text vocabulary | Completed | Generated locally |
| Term-frequency vectors | Completed | Lightweight vector model |
| Text query vectors | Completed | Shared vocabulary |
| Text cosine similarity | Completed | Ranked results |
| Image metadata vectors | Completed | Description and tags |
| Text-to-image retrieval | Completed | Metadata-based |
| Image thumbnails | Completed | Local file display |
| Image result tags | Completed | Displayed |
| Image result paths | Completed | Displayed |
| Image pixel understanding | Future work | No CLIP or CNN |
| OCR | Future work | Not implemented |
| Flutter search UI | Completed | Text and image results |
| Loading state | Completed | Text and images |
| Empty-query validation | Completed | User feedback |
| Empty-result state | Completed | Safe handling |
| Clear button | Completed | Clears both result types |
| Reload button | Completed | Reloads text and images |
| Enter-key search | Completed | Supported |
| Accessibility semantics | Completed | Initial support |
| Static analysis | Completed | 0 errors, 0 warnings |
| Automated tests | Completed | 14 passed |
| Windows build | Completed | Successful |
| Windows execution | Completed | Successful |
| Final documentation | Completed | Week 8 |
| Persistent storage | Future work | In-memory |
| Neural embeddings | Future work | Not implemented |
| Image-to-image retrieval | Future work | Not implemented |

---

## 37. Problems and Solutions

### 37.1 Obsolete Counter Test

**Problem**

The default Flutter counter test failed.

**Cause**

The counter interface had been replaced.

**Solution**

The old test was replaced with retrieval-interface tests.

---

### 37.2 Animated Loading Timeout

**Problem**

`pumpAndSettle()` timed out.

**Cause**

The progress indicator continuously scheduled frames.

**Solution**

A bounded widget-search helper was introduced.

---

### 37.3 File-System I/O in Widget Tests

**Problem**

The search interface did not appear during testing.

**Cause**

Real file and directory operations did not complete under the normal controlled test clock.

**Solution**

`tester.runAsync()` was used.

---

### 37.4 Desktop Viewport Overflow

**Problem**

The empty-query test produced a RenderFlex overflow.

**Cause**

The default viewport was too small.

**Solution**

The viewport was set to:

```text
1280 × 900
```

---

### 37.5 Missing Test File

**Problem**

The first image-test command reported:

```text
Does not exist
```

### Cause

The image test file had not yet been created inside:

```text
test/
```

### Solution

The file was created at:

```text
test/image_search_service_test.dart
```

The tests then loaded successfully.

---

### 37.6 Outdated Widget-Test Text

**Problem**

The startup widget test still expected:

```text
Loading and indexing local documents...
```

### Solution

The test was updated to:

```text
Loading and indexing local documents and images...
```

---

### 37.7 Outdated Vector Label

**Problem**

The widget test searched for:

```text
Vectors:
```

The interface displayed:

```text
Text vectors:
```

### Solution

The expectation was updated and a new `Images:` expectation was added.

---

### 37.8 Image and Metadata Consistency

**Problem**

An early sample image did not match its filename and description.

### Solution**

The image was replaced so that:

```text
cat.jpg
```

correctly displayed a cat and matched its metadata.

This improved the clarity and credibility of the final demonstration.

---

## 38. Current Limitations

The final prototype does not yet include:

- PDF content extraction
- Word parsing
- PowerPoint parsing
- OCR
- Direct image-pixel analysis
- CLIP or MobileCLIP embeddings
- Image-to-image retrieval
- Neural semantic text embeddings
- Persistent vector storage
- User-selected folders
- Incremental indexing
- Background indexing
- File opening from result cards
- Search history
- Production logging
- Automated CI
- Formal accessibility certification
- Windows installer packaging
- Web local-folder retrieval

The current image search depends on manually prepared:

```text
description
tags
```

Therefore, incorrect metadata can produce incorrect search results even when the program itself operates correctly.

---

## 39. Key Week 8 Achievements

Week 8 completed the following major tasks:

1. Created the Week 8 documentation structure.
2. Ran final static analysis.
3. Recorded zero errors and zero warnings.
4. Replaced the obsolete default Flutter test.
5. Added three retrieval-interface widget tests.
6. Added realistic desktop viewport testing.
7. Added real asynchronous file-I/O support.
8. Resolved loading-animation timeout.
9. Resolved file-I/O waiting failure.
10. Resolved RenderFlex overflow.
11. Added five local image samples.
12. Added image metadata JSON.
13. Added `ImageDocument`.
14. Added `ImageSearchResult`.
15. Added `ImageMetadataService`.
16. Added `ImageSearchService`.
17. Added image metadata command-line testing.
18. Added image search command-line testing.
19. Added text-to-image retrieval.
20. Added image thumbnails.
21. Added image descriptions and tags.
22. Added image paths and similarity scores.
23. Added 11 image-related automated tests.
24. Updated the widget test for image indexing.
25. Achieved 14 passing automated tests.
26. Achieved a 100% automated-test pass rate.
27. Confirmed original text retrieval still works.
28. Built the Windows application successfully.
29. Verified text and image retrieval manually.
30. Captured final evidence screenshots.
31. Updated final documentation.
32. Prepared final GitHub delivery.

---

## 40. Final Test Summary

The final validation result was:

```text
Static analysis:
0 errors
0 warnings
139 information-level notices

Image metadata tests:
2 passed
0 failed

Image retrieval tests:
9 passed
0 failed

Widget tests:
3 passed
0 failed

Total automated tests:
14 passed
0 failed

Windows build:
Passed

Windows execution:
Passed

Manual functional checks:
Passed
```

The overall final result is:

```text
PASS
```

---

## 41. Finalisation Checklist

The final checklist is:

```text
1. Local text retrieval verified
2. Local image retrieval verified
3. Image metadata checked
4. Image thumbnails checked
5. flutter analyze executed
6. flutter test executed
7. Fourteen tests passed
8. Windows application executed
9. Text regression screenshot saved
10. Image retrieval screenshot saved
11. Final test screenshot saved
12. Week 8 documentation updated
13. README to be updated
14. User guide to be updated
15. Architecture document to be updated
16. Final test report to be updated
17. Personal summary to be updated
18. Git status to be reviewed
19. Final changes to be committed
20. Final changes to be pushed
```

---

## 42. Week 8 Summary

Week 8 transformed the existing local text-retrieval prototype into a broader local content-retrieval prototype.

The final Windows application supports:

```text
Text query
├── TXT and Markdown content retrieval
└── JPG and PNG metadata-based retrieval
```

The completed system performs:

```text
Local files
→ Content or metadata loading
→ Text normalisation
→ Vector generation
→ Query comparison
→ Cosine-similarity calculation
→ Ranked text and image results
→ Windows interface display
```

The project now includes:

```text
Working Windows desktop application
+
Text retrieval
+
Metadata-based text-to-image retrieval
+
Local image thumbnails
+
Fourteen automated tests
+
Manual functional validation
+
Technical documentation
+
Open-source licensing
+
GitHub delivery structure
```

The final image capability should be described accurately as:

> Metadata-based text-to-image retrieval using local image descriptions and tags.

It should not be described as direct neural image understanding.

The final project is functional, testable, reproducible, documented, and capable of retrieving two different local content types through one unified query interface.

---

## 43. Final GitHub Delivery

The final delivery should include:

```text
data/sample_images/
lib/models/image_document.dart
lib/models/image_search_result.dart
lib/services/image_metadata_service.dart
lib/services/image_search_service.dart
lib/screens/search_screen.dart
test/image_search_service_test.dart
test/widget_test.dart
tool/test_image_metadata.dart
tool/test_image_search.dart
docs/week8/
README.md
LICENSE
```

Recommended final commit message:

```text
Add local image retrieval and final automated tests
```

After committing, the changes should be pushed to:

```text
main
```

The final repository should then be checked with:

```bash
git status
```

The expected final result is:

```text
nothing to commit, working tree clean
```