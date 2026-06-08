# Offline Multimodal Local Retrieval System

This project aims to build a free, open-source, offline-first, cross-platform, and accessible multimodal local content retrieval and viewing system.

The system is designed to help users search, retrieve, and view local files stored on their own devices, including PDFs, Word documents, TXT files, images, screenshots, and scanned documents.

## Project Focus

This system is not intended to replace office software such as WPS or Microsoft 365. Its core purpose is local content retrieval and viewing rather than document editing or cloud collaboration.

The system will combine:

- Local file import
- Metadata extraction
- Text parsing
- Image processing preparation
- Keyword search
- Semantic similarity search
- Local vector storage
- Accessible cross-platform UI

## Week 1 Deliverables

The Week 1 project onboarding documents are located in:

```text
docs/week1/
Current Week 1 documents include:

Project Requirements Document (PRD)
Environment Setup Validation Report
Dataset Preparation Report
Risk Management Plan
Week 1 Progress Report
Current Environment Status

The Flutter UI development environment has been installed and validated.

Confirmed setup:

Android Studio installed
Flutter plugin installed
Dart plugin installed
Flutter SDK installed
Android SDK configured
Android SDK licenses accepted
Test Flutter application successfully launched in Chrome
Planned Tech Stack
UI: Flutter
Language: Dart
ML Inference: TensorFlow Lite
Text Embedding: BERT-based model
Image Embedding: MobileCLIP or lightweight image embedding model
Vector Database: Chroma DB
Document Parsing: PDFium and Apache Tika
Version Control: Git and GitHub
Accessibility Validation: Google Accessibility Scanner and WAVE


Project Structure
offline_multimodal_retrieval/
├── docs/
│   └── week1/
│       ├── PRD.md
│       ├── Environment_Setup_Report.md
│       ├── Dataset_Preparation_Report.md
│       ├── Risk_Management_Plan.md
│       └── Week1_Progress_Report.md
├── data/
│   ├── sample_documents/
│   ├── sample_images/
│   └── README.md
├── lib/
├── test/
├── web/
├── windows/
├── android/
├── README.md
└── pubspec.yaml


Development Plan

The project follows an 8-week development plan.

Week 1 focuses on project onboarding, requirement definition, environment setup, dataset preparation, and risk management.

Week 2 will focus on system architecture design and the initial file parsing module.

Later stages will include multimodal embedding integration, local vector database implementation, retrieval logic, Flutter UI development, accessibility validation, testing, documentation, and final delivery.



Current Status

Current progress:

Official Flutter project initialized
Week 1 documentation prepared
Flutter development environment validated
Test Flutter application successfully launched in Chrome
Dataset preparation and risk management plans drafted


Next Step

The next step is to begin Week 2 development, including:

Designing the modular system architecture
Defining the File I/O Layer, Parsing Layer, Embedding Engine Layer, Vector Storage Layer, Retrieval Logic Layer, and UI & Accessibility Layer
Starting the core file parsing module
Preparing initial metadata extraction logic
