# Offline Multimodal Local Retrieval System

# Final Software Test Report

## 1. Document Control

| Field | Value |
|---|---|
| Project | Offline Multimodal Local Retrieval System |
| Document Title | Final Software Test Report |
| Document Type | Final Functional, Integration, Widget, and Execution Test Report |
| Version | 1.0 |
| Status | Final |
| Author | Mingxuan Huang |
| Date | 2026/07/27 |
| Test Stage | Week 8 Final Validation |
| Reference Approach | Structured with reference to ISO/IEC/IEEE 29119-3 test documentation principles |

---

## 2. Purpose

This document records the final software testing performed for the Offline Multimodal Local Retrieval System.

The final test phase validates the complete prototype developed from Week 1 to Week 8, including:

- Local file parsing
- Metadata extraction
- Text processing
- Text chunking
- Vocabulary generation
- Term-frequency vector generation
- Query-vector generation
- Cosine-similarity calculation
- Ranked retrieval
- Flutter user-interface integration
- Windows desktop execution
- Widget-level interaction testing
- Error and empty-result handling

This report does not claim formal ISO certification.

Its structure is organised with reference to recognised software-test documentation principles.

---

## 3. Test Objectives

The final test phase had the following objectives:

1. Confirm that the project source code contains no compile-blocking error.
2. Confirm that the Flutter application builds successfully for Windows.
3. Confirm that the Windows desktop application starts successfully.
4. Confirm that supported local documents are loaded and indexed.
5. Confirm that unsupported files are skipped safely.
6. Confirm that the search interface is displayed correctly.
7. Confirm that valid queries return ranked results.
8. Confirm that unrelated queries return an empty-result state.
9. Confirm that an empty query displays a validation message.
10. Confirm that the Clear button removes the current query.
11. Confirm that the existing asynchronous file-processing pipeline works in widget tests.
12. Confirm that the final project remains functional after Week 7 UI integration.
13. Record known lint notices, defects, limitations, and resolutions.

---

## 4. System Under Test

The system under test is a local-first Flutter desktop retrieval prototype.

The main workflow is:

```text
Local document directory
→ File parsing
→ Parsed documents
→ Text processing
→ Searchable documents
→ Text chunking
→ Shared vocabulary
→ Term-frequency vectors
→ User query vector
→ Cosine similarity
→ Ranked results
→ Flutter desktop interface
```

The current local test directory is:

```text
data/sample_documents
```

The current supported content types are:

```text
TXT
Markdown
```

The current unsupported test type is:

```text
PDF
```

Unsupported PDF files are skipped safely.

---

## 5. Test Scope

### 5.1 Included

The final test scope included:

- Flutter environment validation
- Windows desktop toolchain validation
- Dependency resolution
- Static source-code analysis
- Widget tests
- Asynchronous local file access during widget tests
- Search-interface startup
- Search-field rendering
- Search button rendering
- Clear button rendering
- Pipeline-summary rendering
- Empty-query validation
- Query-clearing behaviour
- Windows desktop build
- Windows desktop execution
- Local file parsing
- Unsupported file handling
- Retrieval-pipeline initialisation
- Manual search verification
- Empty-result verification
- Reload behaviour
- Enter-key search behaviour
- Git status verification

### 5.2 Excluded

The following areas were outside the current final test scope:

- PDF content extraction
- Word document parsing
- PowerPoint parsing
- OCR
- Image embedding
- Text-to-image retrieval
- Neural semantic embeddings
- Persistent vector-database storage
- Cloud deployment
- REST API testing
- OpenAPI endpoint testing
- Mobile-device testing
- Large-scale load testing
- Formal security penetration testing
- Formal WCAG certification
- Production packaging and digital signing

---

## 6. Test Environment

| Item | Configuration |
|---|---|
| Operating System | Microsoft Windows |
| Development Framework | Flutter |
| Programming Language | Dart |
| Desktop Target | Windows x64 |
| IDE | Android Studio |
| Source Control | Git |
| Remote Repository | GitHub |
| Main Branch | `main` |
| Test Framework | `flutter_test` |
| Static Analysis Command | `flutter analyze` |
| Automated Test Command | `flutter test` |
| Desktop Execution Command | `flutter run -d windows` |
| Test Data Directory | `data/sample_documents` |
| Supported Test Files | `sample1.txt`, `sample2.md` |
| Unsupported Test File | `sample3.pdf` |
| Network Requirement | None for retrieval functionality |

---

## 7. Test Evidence Files

The following evidence files are stored in:

```text
docs/week8/images/
```

Current evidence includes:

```text
flutter_test_final.png
```

The following screenshots are also planned or recorded during final validation:

```text
flutter_analyze_initial.png
flutter_test_initial.png
flutter_test_pump_timeout.png
flutter_test_io_timeout.png
windows_app_final_initial.png
windows_app_final_search.png
week8_project_structure.png
git_status_before_finalisation.png
```

---

## 8. Static Analysis

The following command was executed:

```bash
flutter analyze
```

The result was:

```text
0 errors
0 warnings
100 info-level lint notices
```

The analysis completed successfully without compile-blocking errors.

The 100 notices were mainly:

```text
avoid_print
avoid_relative_lib_imports
```

### 8.1 `avoid_print`

This notice identifies the use of:

```dart
print(...)
```

in service classes and command-line test scripts.

The notices do not prevent compilation or execution.

For a production release, a structured logging framework would be preferred.

### 8.2 `avoid_relative_lib_imports`

Some files under:

```text
tool/
```

import project libraries using relative paths.

The current scripts still run, but package imports are preferred for maintainability.

### 8.3 Dependency Notices

The analysis also reported that some package updates were available:

```text
matcher
meta
test_api
vector_math
```

The newer versions were incompatible with the current dependency constraints.

No upgrade was performed during finalisation because unnecessary dependency changes could introduce compatibility risk.

---

## 9. Automated Widget Testing

The final widget-test file is:

```text
test/widget_test.dart
```

Three widget tests were implemented:

1. Application startup and retrieval-interface display
2. Empty-search-query validation
3. Clear-button query removal

The final command was:

```bash
flutter test
```

The final result was:

```text
00:05 +3: All tests passed!
```

The output also displayed:

```text
Unsupported file type skipped: sample3.pdf
```

This is expected behaviour and confirms that unsupported PDF files are skipped without terminating the retrieval pipeline.

---

## 10. Automated Test Cases

| Test ID | Test Case | Expected Result | Actual Result | Status |
|---|---|---|---|---|
| FT-W8-001 | Start the Flutter application in a widget test | Application title appears | Title displayed | Pass |
| FT-W8-002 | Display initial loading state | Loading message appears | Loading message displayed | Pass |
| FT-W8-003 | Complete asynchronous local indexing | Search interface appears | Search interface displayed | Pass |
| FT-W8-004 | Render query field | One `TextField` is displayed | One field displayed | Pass |
| FT-W8-005 | Render Search button | Search button is available | Button displayed | Pass |
| FT-W8-006 | Render Clear button | Clear button is available | Button displayed | Pass |
| FT-W8-007 | Render pipeline summary | Documents, chunks, vocabulary, and vectors are displayed | All summary items displayed | Pass |
| FT-W8-008 | Render ready state | `Ready to search` appears | Ready state displayed | Pass |
| FT-W8-009 | Submit empty query | Validation message appears | Validation message displayed | Pass |
| FT-W8-010 | Enter query text | Query appears in text field | Query displayed | Pass |
| FT-W8-011 | Press Clear | Query field becomes empty | Query removed | Pass |
| FT-W8-012 | Clear search state | Ready state returns | Ready state displayed | Pass |
| FT-W8-013 | Skip unsupported PDF | Pipeline continues without failure | PDF skipped safely | Pass |
| FT-W8-014 | Detect rendering exception after desktop viewport configuration | No exception occurs | No rendering exception | Pass |

---

## 11. Widget-Test Implementation Strategy

The application performs local file-system operations during startup.

This required special handling in widget tests.

### 11.1 Real Asynchronous File I/O

The retrieval pipeline uses:

```text
Directory listing
File reading
Document parsing
```

Flutter widget tests normally use a controlled test clock.

The final test implementation therefore used:

```dart
tester.runAsync(...)
```

This allowed real asynchronous file operations to complete.

### 11.2 Bounded Waiting

The final tests used a helper that repeatedly checked for a specific widget.

The helper waited for:

```text
Search local content
```

to appear.

This prevented unlimited waiting and produced a clear test failure when initialisation did not complete.

### 11.3 Desktop Viewport

The widget-test viewport was configured to:

```text
1280 × 900
```

This represents a realistic desktop window and prevents artificial layout overflows caused by Flutter’s smaller default widget-test viewport.

---

## 12. Initial Test Failure: Obsolete Counter Test

### Problem

The original Flutter template test was:

```text
Counter increments smoke test
```

It expected to find:

```text
0
1
```

and a counter button.

### Root Cause

The Week 2 counter demonstration interface had already been replaced by the Week 7 retrieval interface.

The old test no longer represented the actual application.

### Resolution

The obsolete counter test was replaced with tests for:

- Retrieval-interface startup
- Empty-query validation
- Clear-button behaviour

### Result

The obsolete test was removed successfully.

---

## 13. Second Test Failure: `pumpAndSettle()` Timeout

### Problem

The first replacement tests used:

```dart
pumpAndSettle()
```

All three tests timed out.

### Root Cause

The interface displayed an animated:

```dart
CircularProgressIndicator()
```

during asynchronous indexing.

`pumpAndSettle()` waits for the widget tree to stop scheduling frames.

The continuously animated progress indicator prevented the tree from becoming fully settled.

### Resolution

`pumpAndSettle()` was replaced with a bounded widget-search helper.

### Result

The animation-related timeout was removed.

---

## 14. Third Test Failure: File I/O Did Not Complete

### Problem

The bounded helper still could not find:

```text
Search local content
```

after 30 attempts.

### Root Cause

Repeated calls to:

```dart
tester.pump()
```

advance Flutter’s test frames but do not automatically complete real local file-system operations.

The application required directory scanning and file reading.

### Resolution

The helper was changed to use:

```dart
tester.runAsync(...)
```

combined with:

```dart
tester.pump()
```

### Result

The real local file I/O completed and the first and third tests passed.

---

## 15. Fourth Test Failure: RenderFlex Overflow

### Problem

The empty-query validation test produced:

```text
A RenderFlex overflowed by 20 pixels on the bottom.
```

### Root Cause

Flutter widget tests use a relatively small default viewport.

After the validation message appeared, the available height for the lower ready-state area became too small.

The issue occurred in the artificial test viewport rather than the normal Windows desktop window.

### Resolution

The widget-test viewport was configured to:

```text
1280 × 900
```

The device pixel ratio was configured to:

```text
1.0
```

The values were reset after each test.

### Result

The artificial overflow disappeared and all three tests passed.

---

## 16. Final Automated Test Result

The final automated test summary was:

| Metric | Result |
|---|---:|
| Planned widget tests | 3 |
| Executed widget tests | 3 |
| Passed | 3 |
| Failed | 0 |
| Blocked | 0 |
| Pass rate | 100% |

Overall automated result:

```text
PASS
```

![Final Widget Test Result](images/flutter_test_final.png)

**Figure 1.** Final Flutter widget-test execution showing three completed tests and `All tests passed!`.

---

## 17. Windows Desktop Build Test

The following command was executed:

```bash
flutter run -d windows
```

The project resolved its dependencies and successfully built the Windows application.

The output included:

```text
Launching lib\main.dart on Windows in debug mode...
Building Windows application...
Built build\windows\x64\runner\Debug\offline_multimodal_retrieval.exe
Syncing files to device Windows...
```

The generated executable was:

```text
build/windows/x64/runner/Debug/offline_multimodal_retrieval.exe
```

The desktop application started successfully.

---

## 18. Windows Execution Test

The final Windows execution confirmed that:

- The application launched.
- The retrieval screen rendered.
- The local sample directory was scanned.
- Supported files were indexed.
- Unsupported PDF files were skipped.
- Search controls were available.
- Search results could be displayed.
- Empty results were handled.
- Clear worked.
- Reload worked.
- Enter-key search worked.
- The application exited normally.

The terminal ended with:

```text
Application finished.
```

### Overall Windows Result

```text
PASS
```

---

## 19. Manual Functional Test Cases

| Test ID | Function | Test Action | Expected Result | Result |
|---|---|---|---|---|
| MF-W8-001 | Application startup | Run Windows application | Interface opens successfully | Pass |
| MF-W8-002 | Pipeline initialisation | Wait for startup indexing | Summary values appear | Pass |
| MF-W8-003 | Metadata query | Search `metadata extraction` | Relevant ranked results appear | Pass |
| MF-W8-004 | Markdown query | Search `markdown document` | Markdown result appears | Pass |
| MF-W8-005 | Unrelated query | Search `unrelated query` | Empty-result state appears | Pass |
| MF-W8-006 | Clear control | Enter text and press Clear | Query and results are removed | Pass |
| MF-W8-007 | Reload control | Press Reload | Local index is rebuilt | Pass |
| MF-W8-008 | Keyboard search | Enter query and press Enter | Search starts | Pass |
| MF-W8-009 | Unsupported file | Include `sample3.pdf` | File is skipped safely | Pass |
| MF-W8-010 | Normal exit | Press `q` in terminal | Application terminates normally | Pass |

---

## 20. Final Test Summary

| Test Category | Passed | Failed | Result |
|---|---:|---:|---|
| Static analysis | Completed | No blocking errors | Pass |
| Widget tests | 3 | 0 | Pass |
| Windows build | 1 | 0 | Pass |
| Windows launch | 1 | 0 | Pass |
| Manual functional checks | 10 | 0 | Pass |
| Unsupported-file handling | 1 | 0 | Pass |

Overall final result:

```text
PASS
```

---

## 21. Defects and Resolutions

| Defect ID | Description | Severity | Resolution | Status |
|---|---|---|---|---|
| DEF-W8-001 | Default counter test no longer matched the application | Medium | Replaced with retrieval-interface tests | Closed |
| DEF-W8-002 | `pumpAndSettle()` timed out | Medium | Added bounded widget waiting | Closed |
| DEF-W8-003 | Real file I/O did not complete under controlled test clock | High | Added `tester.runAsync()` | Closed |
| DEF-W8-004 | Default test viewport caused vertical overflow | Medium | Configured 1280 × 900 desktop viewport | Closed |
| DEF-W8-005 | PDF parsing unsupported | Low | PDF safely skipped | Open limitation |
| DEF-W8-006 | Static analysis reports 100 info notices | Low | Documented for future cleanup | Open improvement |
| DEF-W8-007 | Four dependencies have newer incompatible versions | Low | Deferred upgrade to avoid final-stage instability | Open improvement |

---

## 22. Known Limitations

The final prototype still has the following limitations:

- PDF content extraction is not implemented.
- Word document parsing is not implemented.
- PowerPoint parsing is not implemented.
- OCR is not implemented.
- Image retrieval is not implemented.
- Embeddings are based on term frequency.
- Semantic synonyms are not recognised.
- Search index data is stored in memory.
- The sample directory is fixed.
- Users cannot select a directory from the interface.
- Result cards do not open source files.
- Large-scale performance has not been evaluated.
- Automated continuous integration has not been configured.
- Production logging has not replaced all `print()` calls.
- Some command-line scripts use relative imports.
- Formal accessibility certification has not been performed.

---

## 23. Risk Assessment

| Risk ID | Risk | Impact | Likelihood | Mitigation |
|---|---|---|---|---|
| RISK-W8-001 | Small test dataset may hide performance problems | High | High | Add larger document collections |
| RISK-W8-002 | Exact-term matching limits semantic retrieval | High | High | Add neural embeddings |
| RISK-W8-003 | In-memory indexing increases startup time | Medium | High | Add persistent local vector storage |
| RISK-W8-004 | Unsupported document formats reduce usability | High | High | Add PDF and Office parsers |
| RISK-W8-005 | Lint notices may reduce maintainability | Medium | Medium | Replace prints and update imports |
| RISK-W8-006 | Dependency upgrades may break compatibility | Medium | Medium | Upgrade and test in a separate branch |
| RISK-W8-007 | Desktop-only final testing limits cross-platform confidence | Medium | Medium | Add Android, web, and additional desktop testing |

---

## 24. Regression Test Recommendation

The following commands should be rerun after future code changes:

```bash
flutter analyze
flutter test
flutter run -d windows
```

The following behaviours should always be rechecked:

- Startup indexing
- Unsupported-file handling
- Search-field rendering
- Empty-query validation
- Clear-button behaviour
- Ranked-result display
- Empty-result display
- Reload behaviour
- Keyboard search
- Windows build

Regression testing is especially important after:

- Changing the file parser
- Changing the tokenizer
- Changing chunk size
- Replacing term-frequency vectors
- Adding neural embeddings
- Adding a persistent vector database
- Adding PDF support
- Adding image retrieval
- Changing the search UI

---

## 25. Test Conclusion

The final Week 8 test phase successfully validated the current Offline Multimodal Local Retrieval System prototype.

The system completed:

```text
Static analysis
→ Automated widget testing
→ Local file I/O testing
→ Windows desktop building
→ Windows desktop execution
→ Manual retrieval verification
```

The final automated result was:

```text
3 tests passed
0 tests failed
```

The Windows application built and launched successfully.

All planned final functional checks passed.

The remaining issues are documented limitations and improvement opportunities rather than critical execution failures.

The overall final software-test result is:

```text
PASS
```