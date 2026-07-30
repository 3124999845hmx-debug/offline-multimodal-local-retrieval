# Offline Multimodal Local Retrieval System

# User Guide

## 1. Document Information

| Field | Value |
|---|---|
| Project | Offline Multimodal Local Retrieval System |
| Document Title | User Guide |
| Version | 1.1 |
| Status | Final |
| Author | Mingxuan Huang |
| Original Date | 2026/07/27 |
| Final Revision Date | 2026/07/30 |
| Intended Users | Project supervisor, developer, evaluator, and demonstration users |
| Validated Platform | Windows desktop |

---

## 2. Purpose

This guide explains how to install, run, and use the Offline Multimodal Local Retrieval System.

The application is a local-first Flutter Windows desktop prototype that allows users to search:

```text
Local TXT and Markdown content
+
Local JPG, JPEG, and PNG images
```

The current version supports:

- TXT document parsing
- Markdown document parsing
- Local text processing
- Text chunking
- Shared vocabulary generation
- Term-frequency vector generation
- Cosine-similarity search
- Ranked text search results
- JPG, JPEG, and PNG image loading
- Image metadata loading
- Metadata-based text-to-image retrieval
- Ranked image results
- Local image-thumbnail display
- Flutter Windows desktop interface
- Offline execution

The current version does not require a cloud service, external retrieval server, or remote vector database.

---

## 3. Main Application Features

The application provides the following user-facing features:

- Automatic loading of local sample documents
- Automatic loading of local image metadata
- Automatic local text indexing
- Unified text query input
- Text-result retrieval
- Image-result retrieval
- Search button
- Clear button
- Reload button
- Ranked result display
- Cosine-similarity score display
- Text source filename display
- Text chunk-index display
- Text preview display
- Image-thumbnail display
- Image filename display
- Image description display
- Image tag display
- Local file-path display
- Empty-query validation
- Empty-result feedback
- Keyboard Enter search
- Basic accessibility semantics

---

## 4. System Requirements

### 4.1 Operating System

The final validated environment is:

```text
Microsoft Windows
```

The project includes other Flutter platform folders, but the final retrieval functionality was tested on Windows desktop.

### 4.2 Required Software

To run the project from source, install:

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

### 4.3 Environment Verification

Use:

```bash
flutter doctor -v
```

A correctly configured environment should not report any blocking Windows desktop toolchain error.

---

## 5. Project Directory

The project root is:

```text
offline_multimodal_retrieval
```

Important directories include:

```text
data/
docs/
lib/
test/
tool/
windows/
```

The local text files are stored in:

```text
data/sample_documents
```

The local images and image metadata are stored in:

```text
data/sample_images
```

The main application source files are:

```text
lib/main.dart
lib/screens/search_screen.dart
```

---

## 6. Supported File Types

The final prototype supports the following types.

| File Type | Extension | Status |
|---|---|---|
| Plain text | `.txt` | Supported |
| Markdown | `.md` | Supported |
| JPG image | `.jpg` | Supported |
| JPEG image | `.jpeg` | Supported |
| PNG image | `.png` | Supported |
| PDF | `.pdf` | Safely skipped |
| Word document | `.docx` | Not implemented |
| PowerPoint | `.pptx` | Not implemented |
| Scanned document | Various | OCR not implemented |

Unsupported text-file types do not terminate the application.

For example:

```text
Unsupported file type skipped: sample3.pdf
```

This message is informational rather than a runtime error.

---

## 7. Preparing Local Text Documents

The prototype reads text documents from:

```text
data/sample_documents
```

To add a supported text file:

1. Open the project directory.
2. Open `data/sample_documents`.
3. Add a `.txt` or `.md` file.
4. Ensure the file contains readable text.
5. Start or reload the application.

Example TXT content:

```text
This document explains local metadata extraction and offline retrieval.
```

Example Markdown content:

```markdown
# Local Retrieval

This Markdown document describes text chunking and similarity search.
```

The current prototype does not provide a graphical folder-selection dialog.

---

## 8. Preparing Local Images

The prototype reads images and image metadata from:

```text
data/sample_images
```

The current sample files are:

```text
car.jpg
cat.jpg
mountain.jpg
office.jpg
微信截图.png
image_metadata.json
```

### 8.1 Adding an Image

To add another image:

1. Copy a `.jpg`, `.jpeg`, or `.png` file into `data/sample_images`.
2. Open `image_metadata.json`.
3. Add a matching metadata entry.
4. Save the JSON file.
5. Press Reload or restart the application.

### 8.2 Image Metadata Format

Each image must have:

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

The value of `fileName` must exactly match the actual image filename.

The description and tags are used as the image's searchable text.

### 8.3 Important Limitation

The current system does not directly analyse image pixels.

It performs:

```text
User text query
→ Compare with image description and tags
→ Return ranked image results
```

Therefore, image search quality depends on the accuracy of the metadata.

---

## 9. Installing Project Dependencies

Open a terminal in the project root.

Run:

```bash
flutter pub get
```

This downloads the dependencies defined in:

```text
pubspec.yaml
```

The output may show that newer package versions are available.

For example:

```text
packages have newer versions incompatible with dependency constraints
```

This does not necessarily indicate an error.

The final working dependency versions were retained to reduce regression risk.

---

## 10. Running the Windows Application

From the project root, run:

```bash
flutter run -d windows
```

Flutter will:

```text
Resolve dependencies
→ Build the Windows application
→ Start the executable
→ Open the desktop interface
```

A successful build displays output similar to:

```text
Launching lib\main.dart on Windows in debug mode...
Building Windows application...
Built build\windows\x64\runner\Debug\offline_multimodal_retrieval.exe
Syncing files to device Windows...
```

The executable is generated under:

```text
build/windows/x64/runner/Debug/
```

To stop the running application from the terminal, press:

```text
q
```

---

## 11. Initial Application Screen

After startup, the application automatically loads:

```text
Local text documents
+
Local image metadata
```

During initialisation, the application displays:

```text
Loading and indexing local documents and images...
```

After loading completes, the interface displays:

- Application title
- Search query field
- Search button
- Clear button
- Reload button
- Document count
- Text chunk count
- Vocabulary size
- Text vector count
- Image count
- Ready state

![Final Initial Application Screen](images/windows_app_final_initial.png)

**Figure 1.** Windows desktop application after local text and image initialisation.

For the current sample dataset, the interface displays:

```text
Documents: 2
Text chunks: 2
Vocabulary: 17
Text vectors: 2
Images: 5
```

These values change if the local sample data changes.

---

## 12. Searching Local Content

### 12.1 Entering a Query

Click the search field.

Enter a query such as:

```text
metadata extraction
```

Then either:

- Click Search, or
- Press Enter

### 12.2 Unified Search Processing

The same query is sent to both retrieval branches.

```text
User query
├── Search text chunks
└── Search image descriptions and tags
```

The application then displays:

```text
Text results
+
Image results
```

depending on what matches the query.

---

## 13. Text Search

The text branch performs:

```text
Query text
→ Tokenisation
→ Query vector generation
→ Cosine-similarity calculation
→ Result filtering
→ Descending ranking
```

Each text-result card displays:

- Ranking number
- Source filename
- Chunk index
- Similarity score
- Text preview
- Local source path

![Text Retrieval Result](images/text_retrieval_after_image_extension.png)

**Figure 2.** Text retrieval for the query `metadata extraction` after the image-retrieval extension was added.

---

## 14. Image Search

The image branch compares the query against:

```text
Image description
+
Image tags
```

Each image-result card displays:

- Ranking number
- Image thumbnail
- Image filename
- Description
- Tags
- Similarity score
- Local source path

![Text-to-Image Search Result](images/text_to_image_search_cat.png)

**Figure 3.** Metadata-based text-to-image retrieval for the query `pet`.

---

## 15. Text Search Examples

### 15.1 Metadata Query

```text
metadata extraction
```

Expected result:

```text
sample1.txt
sample2.md
```

The results are ordered by similarity score.

### 15.2 Markdown Query

```text
markdown document
```

Expected result:

```text
sample2.md
```

### 15.3 Unrelated Text Query

```text
completely unrelated words
```

Expected result:

```text
No similar content found
```

---

## 16. Image Search Examples

### 16.1 Cat Search

```text
pet
```

Expected image:

```text
cat.jpg
```

### 16.2 Car Search

```text
vehicle road
```

Expected image:

```text
car.jpg
```

### 16.3 Mountain Search

```text
mountain nature
```

Expected image:

```text
mountain.jpg
```

### 16.4 Office Search

```text
office computer
```

Expected image:

```text
office.jpg
```

### 16.5 Website Screenshot Search

```text
video website gaming
```

Expected image:

```text
微信截图.png
```

---

## 17. Understanding Similarity Scores

The system uses cosine similarity.

The current vectors contain non-negative term-frequency values.

Typical scores range from:

```text
0.0 to 1.0
```

| Score | General Meaning |
|---:|---|
| Close to `1.0` | Strong term overlap |
| Medium positive value | Partial overlap |
| Close to `0.0` | Weak overlap |
| `0.0` | No shared vocabulary |

The score is not a probability.

A score of `0.60` does not mean a 60% certainty.

It only indicates the relative overlap produced by the current vector model.

---

## 18. Understanding Text Results

Each text result contains the following information.

### 18.1 Ranking

A numbered marker shows the result order.

### 18.2 Source Filename

Example:

```text
sample1.txt
```

### 18.3 Chunk Index

Example:

```text
Chunk 0
```

A longer document may be divided into multiple chunks.

### 18.4 Similarity Score

Example:

```text
0.4472
```

### 18.5 Preview

A shortened section of matching text is displayed.

### 18.6 Source Path

The local path is displayed as selectable text.

The current application does not open the source file when the card is clicked.

---

## 19. Understanding Image Results

Each image result contains the following information.

### 19.1 Ranking

A numbered marker shows the result order.

### 19.2 Thumbnail

The actual local image is displayed using:

```dart
Image.file(...)
```

### 19.3 Filename

Example:

```text
cat.jpg
```

### 19.4 Description

Example:

```text
A domestic cat sitting indoors.
```

### 19.5 Tags

Example:

```text
cat
animal
pet
indoor
feline
```

### 19.6 Similarity Score

The score shows how strongly the query overlaps with the image metadata.

### 19.7 File Path

The local image path is displayed.

The current interface does not open the image file when the result card is clicked.

---

## 20. Empty Query Validation

Clicking Search without entering text displays:

```text
Please enter a search query.
```

The application does not execute either retrieval branch for an empty query.

---

## 21. Using the Clear Button

The Clear button performs:

```text
Clear query field
→ Remove text results
→ Remove image results
→ Remove validation messages
→ Return to ready state
→ Return focus to query field
```

Use Clear before starting a new query.

---

## 22. Using the Reload Button

The Reload button is located in the application bar.

Pressing Reload performs:

```text
Rescan local text directory
→ Reparse supported text files
→ Rebuild text chunks
→ Rebuild vocabulary
→ Regenerate text vectors
→ Reload image_metadata.json
→ Revalidate local image files
→ Update interface counters
```

Use Reload after:

- Adding a text file
- Editing a text file
- Adding an image
- Replacing an image
- Editing `image_metadata.json`

The terminal may display the PDF skip message again.

This is expected.

---

## 23. Keyboard Interaction

The application supports Enter-key search.

After entering a query, press:

```text
Enter
```

This triggers the same action as clicking Search.

The interface returns focus to the search field after:

- Startup
- Clear
- Reload completion

---

## 24. Running Automated Tests

Run:

```bash
flutter test
```

The final test suite contains:

```text
2 image metadata tests
9 image retrieval tests
3 Flutter widget tests
```

The total is:

```text
14 automated tests
```

The expected result is:

```text
00:09 +14: All tests passed!
```

![Final Automated Tests](images/flutter_test_with_image_retrieval.png)

**Figure 4.** Final test suite showing 14 passed tests and no failures.

The terminal may also display:

```text
Unsupported file type skipped: sample3.pdf
```

This is expected.

---

## 25. Running Static Analysis

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

The main notices were:

```text
avoid_print
avoid_relative_lib_imports
```

These are code-quality notices and do not prevent execution.

---

## 26. Troubleshooting

### 26.1 Windows Build Toolchain Error

#### Error

```text
Unable to find suitable Visual Studio toolchain.
```

#### Cause

Required Windows C++ desktop components are missing.

#### Solution

Open Visual Studio Installer.

Enable:

```text
Desktop development with C++
```

Ensure the following are installed:

```text
MSVC build tools
C++ CMake tools for Windows
Windows SDK
```

Then run:

```bash
flutter doctor -v
```

---

### 26.2 Unsupported PDF Message

#### Message

```text
Unsupported file type skipped: sample3.pdf
```

#### Meaning

The current parser does not extract PDF content.

#### Action

No action is required.

The application continues processing supported files.

---

### 26.3 No Similar Content Found

#### Message

```text
No similar content found
```

#### Possible Causes

- Query terms do not appear in the text data.
- Query terms do not appear in image descriptions or tags.
- Synonyms were used instead of exact indexed terms.
- A file was added but Reload was not pressed.
- Image metadata is incomplete.
- The relevant file type is unsupported.

#### Suggested Actions

- Use exact terms found in the source content.
- Use shorter queries.
- Check spelling.
- Review the image tags.
- Press Reload.
- Confirm the file extension is supported.

---

### 26.4 Image Does Not Appear in Search

#### Possible Causes

- The image is not listed in `image_metadata.json`.
- `fileName` does not match the physical file.
- The image extension is unsupported.
- Description and tags do not include useful search terms.
- The image file is missing.
- JSON syntax is invalid.

#### Checks

Confirm that:

```text
data/sample_images/image_metadata.json
```

contains a valid entry.

Confirm that:

```text
fileName
```

exactly matches the real filename.

---

### 26.5 Image Thumbnail Does Not Display

#### Possible Causes

- The file path is incorrect.
- The image is corrupted.
- The image was renamed without updating JSON.
- The file does not exist.

#### Action

Check the image in:

```text
data/sample_images
```

Then confirm that the metadata filename matches it exactly.

---

### 26.6 Invalid JSON Error

#### Possible Cause

`image_metadata.json` contains invalid JSON.

Common mistakes include:

- Missing comma
- Extra comma
- Missing quotation mark
- Missing square bracket
- Invalid field name

#### Action

Check that the root structure is an array:

```json
[
  {
    "fileName": "cat.jpg",
    "description": "A domestic cat sitting indoors.",
    "tags": ["cat", "animal", "pet"]
  }
]
```

---

### 26.7 Metadata Does Not Match Image

#### Problem

The displayed image is unrelated to its description or tags.

#### Cause

The image file and metadata entry do not describe the same content.

#### Action

Either:

- Replace the image, or
- Correct the description and tags

The retrieval service cannot detect this semantic mismatch automatically.

---

### 26.8 Empty Query Message

#### Message

```text
Please enter a search query.
```

#### Solution

Enter at least one search term.

---

### 26.9 Application Remains on Loading Screen

#### Possible Causes

- Text directory is missing.
- Image directory is missing.
- `image_metadata.json` cannot be read.
- JSON format is invalid.
- Local file permissions prevent access.
- A configured path is incorrect.

#### Checks

Confirm that these directories exist:

```text
data/sample_documents
data/sample_images
```

Run:

```bash
flutter run -d windows
```

Review terminal errors.

---

### 26.10 Package Update Notices

#### Message

```text
packages have newer versions incompatible with dependency constraints
```

#### Meaning

Newer versions exist, but the current project uses compatible constrained versions.

#### Action

No immediate action is required.

Test future upgrades in a separate branch.

---

### 26.11 Static Analysis Notices

The analyzer may report:

```text
avoid_print
avoid_relative_lib_imports
```

These notices do not block execution.

---

## 27. Windows and Web Behaviour

The final validated platform is:

```text
Windows desktop
```

The application uses:

```dart
dart:io
```

for local file-system access.

Because of this, the browser version cannot use the same local directory workflow without additional architecture changes.

The final project should therefore be demonstrated using:

```bash
flutter run -d windows
```

The web interface may open, but the current local retrieval pipeline is not the validated web target.

---

## 28. Current Retrieval Limitations

The current system uses:

```text
Normalised term-frequency vectors
```

This means:

- Exact shared terms are recognised.
- Repeated terms affect score.
- Synonyms are not reliably understood.
- Contextual meaning is limited.
- Semantically related terms may not match.

For example:

```text
vehicle
```

and:

```text
automobile
```

will only be connected when those terms are included in the searchable metadata or content.

---

## 29. Image Retrieval Limitations

The current image retrieval is metadata-based.

It uses:

```text
description
+
tags
```

It does not use:

- CLIP
- MobileCLIP
- CNN feature extraction
- Image embeddings
- OCR
- Direct image recognition
- Image-to-image search

Therefore:

- Incorrect metadata can produce incorrect results.
- Missing tags can prevent relevant images from appearing.
- Visual similarity is not measured.
- Two visually similar images may not match unless their text metadata overlaps.

---

## 30. Privacy and Offline Behaviour

The retrieval pipeline operates locally.

The application:

- Reads local text files.
- Reads local image files.
- Reads local image metadata.
- Processes text locally.
- Stores vectors in memory.
- Does not upload text content.
- Does not upload image content.
- Does not require a cloud retrieval server.
- Does not require a cloud database.

Internet access may still be needed for:

- Flutter dependency downloads
- Dart package downloads
- GitHub operations

Normal retrieval itself is local.

---

## 31. Accessibility Features

The application includes initial accessibility support:

- Semantic labels for search controls
- Semantic descriptions for summary values
- Semantic descriptions for text results
- Semantic descriptions for image results
- Keyboard Enter search
- Tooltips
- Live-region messages
- Automatic focus behaviour

The application has not received formal WCAG certification.

---

## 32. Safely Closing the Application

To close the desktop window:

```text
Use the standard Windows close button
```

To stop the Flutter debug process:

```text
Press q in the terminal
```

The terminal should display:

```text
Application finished.
```

---

## 33. Recommended User Workflow

The recommended sequence is:

```text
1. Place TXT or Markdown files in data/sample_documents
2. Place JPG, JPEG, or PNG images in data/sample_images
3. Add image entries to image_metadata.json
4. Run flutter run -d windows
5. Wait for text and image loading to complete
6. Enter a query
7. Click Search or press Enter
8. Review Text results
9. Review Image results
10. Press Clear before another search
11. Press Reload after changing local data
12. Press q to stop the application
```

---

## 34. Known Limitations

The current prototype does not yet support:

- PDF content extraction
- Microsoft Word parsing
- PowerPoint parsing
- OCR
- Direct image-pixel understanding
- Image-to-image search
- Neural semantic embeddings
- CLIP or MobileCLIP
- Persistent indexing
- User-selected folders
- Opening result files
- Search history
- User settings
- Production installer
- Digital signing
- Large-scale performance validation
- Fully supported web retrieval

---

## 35. Future Improvements

Potential future improvements include:

- Add PDF parsing.
- Add Word and PowerPoint parsing.
- Add OCR.
- Add neural text embeddings.
- Add CLIP or MobileCLIP image embeddings.
- Add direct image-pixel analysis.
- Add image-to-image retrieval.
- Add persistent local vector storage.
- Add a graphical folder picker.
- Add source-file opening.
- Add result-type filters.
- Add text-only and image-only search modes.
- Add search history.
- Add automatic image caption generation.
- Add metadata editing through the interface.
- Add automated CI testing.
- Replace debug prints with structured logging.
- Package a Windows installer.

---

## 36. User Guide Summary

The Offline Multimodal Local Retrieval System can be run on Windows using:

```bash
flutter run -d windows
```

The application automatically loads:

```text
TXT and Markdown documents
+
JPG, JPEG, and PNG image metadata
```

The main workflow is:

```text
Run application
→ Wait for local loading
→ Enter one text query
→ Search text content
→ Search image descriptions and tags
→ Review ranked text and image results
→ Clear or reload
```

The final prototype supports:

```text
Local text retrieval
+
Metadata-based text-to-image retrieval
```

The image-retrieval function should be described accurately as:

> Metadata-based text-to-image retrieval using local image descriptions and tags.

The system is a functional local-first Windows prototype and provides a foundation for future semantic, persistent, and neural multimodal retrieval.