# Offline Multimodal Local Retrieval System

# User Guide

## 1. Document Information

| Field | Value |
|---|---|
| Project | Offline Multimodal Local Retrieval System |
| Document Title | User Guide |
| Version | 1.0 |
| Status | Final |
| Author | Mingxuan Huang |
| Date | 2026/07/27 |
| Intended Users | Project supervisor, developer, evaluator, and demonstration users |
| Supported Platform | Windows desktop |

---

## 2. Purpose

This guide explains how to install, run, and use the Offline Multimodal Local Retrieval System.

The application is a local-first Flutter desktop prototype that allows users to search indexed text content stored on the local device.

The current version supports:

- TXT document parsing
- Markdown document parsing
- Local text processing
- Text chunking
- Shared vocabulary generation
- Term-frequency vector generation
- Cosine-similarity search
- Ranked search results
- Flutter Windows desktop interface
- Offline execution

The current version does not require a cloud service or external search server.

---

## 3. Main Application Features

The application provides the following user-facing features:

- Automatic loading of local sample documents
- Automatic local text indexing
- Search query input
- Search button
- Clear button
- Reload button
- Search-result ranking
- Similarity-score display
- Source filename display
- Chunk-index display
- Content preview
- Local file-path display
- Empty-query validation
- Empty-result feedback
- Keyboard Enter search
- Basic accessibility semantics

---

## 4. System Requirements

### 4.1 Operating System

The current tested environment is:

```text
Microsoft Windows
```

The project includes additional Flutter platform folders, but Week 8 final validation was performed on Windows desktop.

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

### 4.3 Recommended Commands

Use the following command to verify the environment:

```bash
flutter doctor -v
```

A correctly configured environment should display:

```text
No issues found!
```

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

The current sample documents are stored in:

```text
data/sample_documents
```

The main application source files are:

```text
lib/main.dart
lib/screens/search_screen.dart
```

---

## 6. Supported File Types

The current parser supports:

| File Type | Extension | Status |
|---|---|---|
| Plain text | `.txt` | Supported |
| Markdown | `.md` | Supported |
| PDF | `.pdf` | Safely skipped |
| Word document | `.docx` | Not implemented |
| PowerPoint | `.pptx` | Not implemented |
| Image | `.png`, `.jpg` | Not indexed |
| Scanned document | Various | OCR not implemented |

Unsupported file types do not terminate the application.

For example:

```text
Unsupported file type skipped: sample3.pdf
```

This message is informational rather than a runtime error.

---

## 7. Preparing Local Documents

The current prototype reads documents from:

```text
data/sample_documents
```

To test the application:

1. Open the project directory.
2. Open `data/sample_documents`.
3. Add a TXT or Markdown file.
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

## 8. Installing Project Dependencies

Open a terminal in the project root.

Run:

```bash
flutter pub get
```

This command downloads the dependencies defined in:

```text
pubspec.yaml
```

The output may show that newer package versions are available.

This does not necessarily indicate an error.

During Week 8 final validation, some newer versions were incompatible with the current dependency constraints.

The working versions were retained to avoid introducing final-stage instability.

---

## 9. Running the Windows Application

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

To exit the running application from the terminal, press:

```text
q
```

---

## 10. Initial Application Screen

After startup, the application automatically scans the local sample directory.

During indexing, the application displays:

```text
Loading and indexing local documents...
```

After indexing completes, the main interface displays:

- Application title
- Search query field
- Search button
- Clear button
- Reload button
- Document count
- Text chunk count
- Vocabulary size
- Vector count
- Ready state

![Final Initial Application Screen](images/windows_app_final_initial.png)

**Figure 1.** Final Windows desktop application after local document indexing.

For the current sample dataset, the application may display:

```text
Documents: 2
Text chunks: 2
Vocabulary: 17
Vectors: 2
```

These values depend on the files and chunk size used by the application.

---

## 11. Searching Local Content

### 11.1 Entering a Query

Click the search field.

Enter a query such as:

```text
metadata extraction
```

Then either:

- Click the Search button, or
- Press Enter

### 11.2 Search Processing

The application performs:

```text
Query text
→ Tokenisation
→ Query vector generation
→ Cosine-similarity calculation
→ Result filtering
→ Descending ranking
```

### 11.3 Search Results

Each result card displays:

- Ranking number
- Source file name
- Chunk index
- Similarity score
- Text preview
- Local source path

![Final Search Result](images/windows_app_final_search.png)

**Figure 2.** Final Windows desktop result for a local similarity-search query.

---

## 12. Understanding Similarity Scores

The score is generated using cosine similarity.

The current application uses non-negative term-frequency vectors.

Typical scores range from:

```text
0.0 to 1.0
```

Interpretation:

| Score | General Meaning |
|---:|---|
| Close to `1.0` | Strong vocabulary overlap |
| Medium positive value | Partial overlap |
| Close to `0.0` | Very weak overlap |
| `0.0` | No matching vocabulary |

The score is not a probability.

A higher score only indicates stronger similarity under the current vector model.

---

## 13. Example Queries

### 13.1 Metadata Query

```text
metadata extraction
```

Expected result:

- TXT and Markdown files containing both terms may appear.
- Results are ordered by score.

### 13.2 Markdown Query

```text
markdown document
```

Expected result:

- The Markdown sample file should appear as the most relevant result.

### 13.3 Unrelated Query

```text
unrelated query
```

Expected result:

```text
No similar content found
```

This occurs because the query terms do not exist in the current vocabulary.

---

## 14. Empty Query Validation

Clicking Search without entering text displays:

```text
Please enter a search query.
```

The application does not execute a search for an empty query.

This prevents unnecessary processing and provides clear user feedback.

---

## 15. Using the Clear Button

The Clear button performs the following actions:

```text
Clear query field
→ Remove previous search results
→ Remove previous error messages
→ Return to ready state
→ Return focus to the query field
```

Use Clear when starting a new search.

---

## 16. Using the Reload Button

The reload button is located in the application bar.

Pressing Reload performs:

```text
Rescan sample directory
→ Reparse supported files
→ Reprocess text
→ Rebuild text chunks
→ Rebuild vocabulary
→ Regenerate vectors
```

Use Reload after adding or modifying files under:

```text
data/sample_documents
```

The terminal may display the PDF skip message again after each reload.

This is expected.

---

## 17. Keyboard Interaction

The application supports Enter-key search.

After typing a query, press:

```text
Enter
```

This triggers the same action as clicking the Search button.

The interface also returns focus to the search field after:

- Application startup
- Clear
- Reload completion

---

## 18. Search Result Information

Each result contains:

### Ranking

A numbered circle indicates the result order.

### Source Filename

Example:

```text
sample1.txt
```

### Chunk Index

Example:

```text
Chunk 0
```

A document may be divided into multiple chunks.

### Similarity Score

Example:

```text
0.4472
```

The score is calculated using cosine similarity.

### Preview

A shortened section of the matching text is displayed.

### Source Path

The local file path is displayed as selectable text.

The current version does not open the source file when the result card is clicked.

---

## 19. Troubleshooting

## 19.1 Windows Build Toolchain Error

### Error

```text
Unable to find suitable Visual Studio toolchain.
```

### Cause

Required C++ desktop-development components are missing.

### Solution

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

## 19.2 Unsupported PDF Message

### Message

```text
Unsupported file type skipped: sample3.pdf
```

### Meaning

The current parser does not extract PDF content.

### Action

No action is required.

The application continues processing supported files.

---

## 19.3 No Similar Content Found

### Message

```text
No similar content found
```

### Possible Causes

- Query words are absent from indexed documents.
- Query uses synonyms not present in the source text.
- Query contains spelling differences.
- Relevant file type is unsupported.
- The source file has not been reloaded.

### Suggested Actions

- Use exact terms from the document.
- Try a shorter query.
- Check the local file content.
- Press Reload after changing files.
- Confirm that the file is TXT or Markdown.

---

## 19.4 Empty Query Message

### Message

```text
Please enter a search query.
```

### Solution

Enter one or more search terms before pressing Search.

---

## 19.5 Application Remains on Loading Screen

### Possible Causes

- Sample directory is unavailable.
- A local file cannot be read.
- File permissions prevent access.
- The configured directory path is incorrect.

### Checks

Confirm that this directory exists:

```text
data/sample_documents
```

Run:

```bash
flutter run -d windows
```

Review the terminal output for parsing errors.

---

## 19.6 Package Update Notices

### Message

```text
packages have newer versions incompatible with dependency constraints
```

### Meaning

New package versions exist, but the project currently uses compatible versions defined by its dependency constraints.

### Action

No immediate action is required.

Future upgrades should be tested in a separate development branch.

---

## 19.7 Static Analysis Info Notices

The command:

```bash
flutter analyze
```

may report:

```text
avoid_print
avoid_relative_lib_imports
```

These are code-quality notices.

They do not prevent the application from running.

---

## 20. Running Automated Tests

Run:

```bash
flutter test
```

The final Week 8 test suite includes:

- Application startup
- Retrieval-interface display
- Empty-query validation
- Clear-button behaviour

The expected result is:

```text
All tests passed!
```

The PDF skip message may appear during each test because the retrieval pipeline is initialised separately for every widget test.

---

## 21. Running Static Analysis

Run:

```bash
flutter analyze
```

The final Week 8 state had:

```text
0 errors
0 warnings
100 info-level lint notices
```

Compile-blocking issues were not present.

---

## 22. Current Retrieval Limitations

The current search implementation uses:

```text
Normalised term-frequency vectors
```

This means:

- Exact shared terms are recognised.
- Term occurrence frequency affects score.
- Synonyms are not understood.
- Contextual meaning is limited.
- Semantically related words may not match.

For example:

```text
car
```

may not match:

```text
automobile
```

unless both terms exist in the indexed vocabulary.

---

## 23. Privacy and Offline Behaviour

The current retrieval pipeline operates locally.

The application:

- Reads local files.
- Processes local text.
- Stores vectors in memory.
- Does not upload document contents.
- Does not require a retrieval server.
- Does not require a cloud database.

This supports the project’s offline-first objective.

The current development environment may still use internet access for downloading Flutter dependencies.

---

## 24. Accessibility Features

The application includes initial accessibility support:

- Semantic label for search field
- Semantic label for Search button
- Semantic label for Clear button
- Semantic label for Reload button
- Semantic descriptions for summary values
- Semantic descriptions for result cards
- Live-region feedback
- Keyboard Enter search
- Tooltips

The current application has not received formal WCAG certification.

---

## 25. Safely Closing the Application

To close the application window:

```text
Use the standard Windows close button
```

To stop the Flutter debug process from the terminal:

```text
Press q
```

The terminal should display:

```text
Application finished.
```

---

## 26. Recommended User Workflow

The recommended sequence is:

```text
1. Place TXT or Markdown files in data/sample_documents
2. Run flutter run -d windows
3. Wait for indexing to complete
4. Enter exact search terms
5. Click Search or press Enter
6. Review ranked results
7. Press Clear before another search
8. Press Reload after changing files
9. Press q in the terminal to stop the application
```

---

## 27. Known Limitations

The current prototype does not yet support:

- PDF content extraction
- Microsoft Word parsing
- PowerPoint parsing
- OCR
- Image search
- Neural semantic embeddings
- Persistent indexing
- User-selected folders
- Opening result files
- Search history
- User settings
- Production installer
- Digital signing
- Large-scale performance validation

---

## 28. Future Improvements

Potential future improvements include:

- Add PDF parsing.
- Add Word and PowerPoint parsing.
- Add OCR.
- Add image embeddings.
- Add multimodal text-to-image retrieval.
- Add TensorFlow Lite or BERT embeddings.
- Add persistent local vector storage.
- Add a graphical folder picker.
- Add source-file opening.
- Add search history.
- Add relevance filters.
- Add result-type filters.
- Add automated CI testing.
- Replace debug prints with structured logging.
- Package a Windows installer.

---

## 29. User Guide Summary

The Offline Multimodal Local Retrieval System can be run on Windows using:

```bash
flutter run -d windows
```

The application automatically indexes supported local files and provides ranked local search results.

The current prototype is designed for offline-first text retrieval and supports TXT and Markdown documents.

Its main user workflow is:

```text
Run application
→ Wait for local indexing
→ Enter query
→ Search
→ Review ranked results
→ Clear or reload
```

The system is a functional prototype and provides a foundation for future multimodal, semantic, and persistent local retrieval.