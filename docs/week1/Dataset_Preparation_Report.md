# Dataset Preparation Report

## Project Title

Offline Accessible Multimodal Local Content Retrieval System

## 1. Purpose of This Report

This report documents the initial dataset preparation plan for Week 1 of the project. The purpose is to identify suitable datasets and local sample files that can be used later to validate text retrieval, image retrieval, scanned document retrieval, and system performance.

At this stage, the project does not need to download or process the complete large-scale datasets immediately. Instead, the Week 1 goal is to confirm the dataset sources, understand their purposes, define how they will be used, and prepare a small local sample structure for early development and testing.

## 2. Dataset Preparation Strategy

The system is designed to retrieve multiple types of local content, including documents, images, screenshots, and scanned files. Therefore, the dataset preparation should cover both text-based and image-based content.

The dataset preparation strategy is divided into two parts:

1. Official open-source datasets
   These datasets will be used for later model validation, retrieval accuracy testing, and performance benchmarking.

2. Small local sample files
   These files will be used during early development to test file importing, metadata extraction, text parsing, and basic retrieval logic.

This approach avoids unnecessary complexity in Week 1. Large datasets such as Google Natural Questions, COCO, RVL-CDIP, and Wikipedia dumps can be very large, so only small validation subsets or selected samples should be used during the early stages.

## 3. Approved Dataset Sources

The project brief identifies several open-source datasets suitable for validation and benchmarking. These datasets are not the main user data of the system. They are used only for testing and evaluating whether the retrieval system works correctly.

| Dataset Name                     | Main Use Case                                                                      | Planned Usage                                                               |
| -------------------------------- | ---------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| Google Natural Questions (NQ)    | Text embedding accuracy validation and long-document retrieval benchmarking        | Use selected validation samples for text retrieval testing                  |
| COCO (Common Objects in Context) | Image embedding accuracy validation and multimodal retrieval testing               | Use a small image subset for image retrieval experiments                    |
| RVL-CDIP                         | Scanned document and image retrieval testing; OCR and embedding validation         | Use selected samples to test scanned document handling                      |
| Wikipedia Text Corpus            | Long-form document retrieval benchmarking and batch processing performance testing | Use small text subsets for long-document retrieval and batch indexing tests |

## 4. Dataset Roles in This Project

### 4.1 Google Natural Questions (NQ)

Google Natural Questions can be used to validate whether the text embedding and retrieval pipeline can return relevant results for natural language queries. This is useful because the project aims to support semantic search, not only exact keyword matching.

Possible use cases:

* Testing whether a user query can retrieve relevant text passages.
* Evaluating whether the embedding model captures semantic meaning.
* Comparing keyword search results with semantic search results.
* Testing long-document retrieval behavior.

For Week 1, the complete dataset does not need to be downloaded. The planned approach is to start with a small validation subset or manually selected sample records.

### 4.2 COCO Dataset

The COCO dataset can be used to test image-related retrieval. Since this project includes multimodal retrieval, the system should be able to process image content in addition to text documents.

Possible use cases:

* Testing image embedding generation.
* Testing whether visually similar images can be retrieved.
* Testing image metadata storage.
* Evaluating basic multimodal retrieval behavior.

For Week 1, the full COCO dataset is not required because it is large. A small number of sample images will be enough for early validation.

### 4.3 RVL-CDIP Dataset

RVL-CDIP contains scanned document images and is useful for testing document image retrieval. This is relevant because many users may store scanned documents, screenshots, forms, or image-based PDFs.

Possible use cases:

* Testing scanned document classification or retrieval.
* Testing whether image-based documents can be indexed.
* Preparing for possible OCR integration.
* Evaluating retrieval performance on non-standard document formats.

For Week 1, the project will only record the dataset source and planned usage. Selected samples may be used later when the image retrieval or OCR-related pipeline becomes available.

### 4.4 Wikipedia Text Corpus

The Wikipedia Text Corpus can be used for long-form text retrieval and batch processing performance testing. This is useful because the final system may need to process large local file libraries.

Possible use cases:

* Testing indexing of long documents.
* Benchmarking batch processing speed.
* Testing search performance across larger text collections.
* Evaluating whether the system can handle large-scale text data.

For Week 1, only small text subsets will be considered. The complete Wikipedia dump is unnecessary for early-stage development.

## 5. Local Sample Dataset Plan

In addition to official datasets, a small local sample dataset will be created for early testing. This is important because the system first needs to validate the basic workflow before processing large benchmark datasets.

The local sample dataset should include:

| Sample Type    | Example Files                        | Purpose                                 |
| -------------- | ------------------------------------ | --------------------------------------- |
| TXT documents  | short notes, project descriptions    | Test simple text parsing                |
| PDF documents  | small reports, academic sample files | Test PDF import and metadata extraction |
| DOCX documents | Word-style sample documents          | Test document parsing                   |
| PNG images     | screenshots, UI images               | Test image import                       |
| JPG images     | scanned pages, photos                | Test image metadata extraction          |
| Mixed files    | documents and images in one folder   | Test batch file ingestion               |

The planned local folder structure is:

```text
data/
├── sample_documents/
│   ├── sample_note.txt
│   ├── sample_report.pdf
│   └── sample_document.docx
│
├── sample_images/
│   ├── sample_screenshot.png
│   └── sample_scan.jpg
│
└── README.md
```

## 6. Data Processing Plan

The future data processing pipeline is expected to follow these steps:

1. Collect or select sample files.
2. Extract file metadata, such as file name, path, type, size, and modified date.
3. Parse text from supported document formats.
4. Split long text into smaller chunks, such as pages or paragraphs.
5. Generate text embeddings for text chunks.
6. Generate image embeddings for image files.
7. Store embeddings and metadata in a local vector database.
8. Use the prepared data to test keyword search and semantic similarity search.

The early-stage focus should be on small files to reduce complexity and make debugging easier.

## 7. Data Storage Considerations

Since the project is offline-first, all sample files, extracted metadata, parsed text, and embeddings should be stored locally during development. User files should not be uploaded to external cloud services.

The local data storage may include:

* Original file references
* Extracted metadata
* Parsed text chunks
* Image references
* Embedding vectors
* Vector IDs
* Search result mappings

The system should keep a clear relationship between vectors and original files. For example, a vector result should be linked back to a file path, page number, text chunk, or image ID through metadata.

## 8. Dataset Risks and Mitigation

| Risk                                         | Explanation                                                                 | Mitigation Strategy                                             |
| -------------------------------------------- | --------------------------------------------------------------------------- | --------------------------------------------------------------- |
| Dataset size is too large                    | Datasets such as COCO and Wikipedia dumps can be very large                 | Use small validation subsets or selected samples first          |
| Dataset download may take too long           | Large public datasets may require long download time                        | Record official sources in Week 1 and download only when needed |
| Dataset format may be complex                | Different datasets may use JSON, images, text dumps, or structured metadata | Start with simple local sample files before using full datasets |
| Image retrieval may be difficult to validate | Image relevance can be harder to evaluate than text relevance               | Begin with small labelled samples and clear test queries        |
| Scanned documents may require OCR            | Image-based documents may not contain directly extractable text             | Treat OCR as an optional extension unless required              |
| Licensing may need review                    | Open-source datasets may have different usage conditions                    | Record dataset source and review license before final use       |

## 9. Week 1 Dataset Preparation Status

For Week 1, the dataset preparation work focuses on planning and structure rather than full dataset processing.

Current status:

* Official dataset sources have been identified.
* Main use cases of each dataset have been clarified.
* A small local sample dataset structure has been planned.
* Large-scale dataset download is deferred to later stages.
* Small validation subsets will be preferred for early development.
* Dataset-related risks have been identified.

## 10. Conclusion

The dataset preparation plan supports the project’s multimodal retrieval goal by covering both text and image data. The project will use official open-source datasets for later validation and benchmarking, while relying on small local sample files during early development.

This staged approach helps reduce technical risk, save time, and keep the Week 1 work focused on preparation, planning, and environment readiness. The next step is to create the local sample dataset folder and add representative files for early file parsing and metadata extraction tests.
