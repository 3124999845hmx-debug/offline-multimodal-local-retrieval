import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/embedding_vector.dart';
import '../models/image_document.dart';
import '../models/image_search_result.dart';
import '../models/similarity_result.dart';
import '../services/file_parser_service.dart';
import '../services/image_metadata_service.dart';
import '../services/image_search_service.dart';
import '../services/simple_embedding_service.dart';
import '../services/similarity_search_service.dart';
import '../services/text_chunking_service.dart';
import '../services/text_processing_service.dart';

/// Main search interface for the offline local retrieval prototype.
///
/// The screen supports:
/// 1. Text-to-text retrieval for TXT and Markdown documents.
/// 2. Metadata-based text-to-image retrieval for local images.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const String _sampleDocumentDirectoryPath =
      'data/sample_documents';

  static const String _sampleImageDirectoryPath =
      'data/sample_images';

  final TextEditingController _searchController =
  TextEditingController();

  final FocusNode _searchFocusNode = FocusNode();

  final FileParserService _fileParserService =
  FileParserService();

  final TextProcessingService _textProcessingService =
  TextProcessingService();

  final TextChunkingService _textChunkingService =
  TextChunkingService();

  final SimpleEmbeddingService _embeddingService =
  SimpleEmbeddingService();

  final ImageMetadataService _imageMetadataService =
  const ImageMetadataService();

  final ImageSearchService _imageSearchService =
  const ImageSearchService();

  late final SimilaritySearchService _similaritySearchService;

  List<EmbeddingVector> _embeddingVectors =
  <EmbeddingVector>[];

  List<SimilarityResult> _textSearchResults =
  <SimilarityResult>[];

  List<ImageDocument> _imageDocuments =
  <ImageDocument>[];

  List<ImageSearchResult> _imageSearchResults =
  <ImageSearchResult>[];

  bool _isInitialising = true;
  bool _isSearching = false;
  bool _hasSearched = false;

  String? _initialisationError;
  String? _searchError;

  int _parsedDocumentCount = 0;
  int _textChunkCount = 0;
  int _vocabularySize = 0;

  @override
  void initState() {
    super.initState();

    _similaritySearchService = SimilaritySearchService(
      embeddingService: _embeddingService,
    );

    _initialiseRetrievalPipeline();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  /// Loads and indexes both local text documents and image metadata.
  Future<void> _initialiseRetrievalPipeline() async {
    setState(() {
      _isInitialising = true;
      _initialisationError = null;
      _searchError = null;
    });

    try {
      // Load image metadata and verify that the image files exist.
      final imageDocuments =
      await _imageMetadataService.loadImageDocuments(
        imageDirectoryPath: _sampleImageDirectoryPath,
      );

      // Parse supported TXT and Markdown files.
      final parsedDocuments =
      await _fileParserService.parseDocumentsFromDirectory(
        _sampleDocumentDirectoryPath,
      );

      // Convert parsed documents into searchable documents.
      final searchableDocuments =
      _textProcessingService.convertToSearchableDocuments(
        parsedDocuments,
      );

      // Split documents into smaller text chunks.
      final textChunks =
      _textChunkingService.chunkDocuments(
        searchableDocuments,
        chunkSize: 40,
      );

      // Build one shared vocabulary for the text chunks.
      final vocabulary =
      _embeddingService.buildVocabulary(
        textChunks,
      );

      // Generate one embedding vector for each text chunk.
      final embeddingVectors =
      _embeddingService.generateEmbeddings(
        textChunks,
        vocabulary: vocabulary,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _embeddingVectors = embeddingVectors;
        _imageDocuments = imageDocuments;

        _parsedDocumentCount = parsedDocuments.length;
        _textChunkCount = textChunks.length;
        _vocabularySize = vocabulary.length;

        _textSearchResults = <SimilarityResult>[];
        _imageSearchResults = <ImageSearchResult>[];

        _hasSearched = false;
        _isInitialising = false;
      });

      _searchFocusNode.requestFocus();
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isInitialising = false;
        _initialisationError =
        'Failed to initialise the retrieval pipeline.\n$error';
      });
    }
  }

  /// Uses one query to search both text chunks and image metadata.
  Future<void> _runSearch() async {
    final query = _searchController.text.trim();

    if (_isInitialising || _isSearching) {
      return;
    }

    if (query.isEmpty) {
      setState(() {
        _hasSearched = false;
        _textSearchResults = <SimilarityResult>[];
        _imageSearchResults = <ImageSearchResult>[];
        _searchError = 'Please enter a search query.';
      });

      _searchFocusNode.requestFocus();
      return;
    }

    setState(() {
      _isSearching = true;
      _hasSearched = true;
      _searchError = null;
    });

    try {
      // Allow the loading state to appear briefly.
      await Future<void>.delayed(
        const Duration(milliseconds: 150),
      );

      final textResults =
      _similaritySearchService.search(
        query: query,
        embeddings: _embeddingVectors,
        minimumScore: 0.0,
        limit: 10,
      );

      final imageResults =
      _imageSearchService.search(
        query: query,
        imageDocuments: _imageDocuments,
        minimumScore: 0.0,
        limit: 10,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _textSearchResults = textResults;
        _imageSearchResults = imageResults;
        _isSearching = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _textSearchResults = <SimilarityResult>[];
        _imageSearchResults = <ImageSearchResult>[];

        _isSearching = false;
        _searchError = 'Search failed.\n$error';
      });
    }
  }

  /// Clears the query and both result lists.
  void _clearSearch() {
    _searchController.clear();

    setState(() {
      _textSearchResults = <SimilarityResult>[];
      _imageSearchResults = <ImageSearchResult>[];

      _hasSearched = false;
      _searchError = null;
    });

    _searchFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: const <ShortcutActivator, Intent>{
        SingleActivator(
          LogicalKeyboardKey.enter,
        ): _SearchIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          _SearchIntent: CallbackAction<_SearchIntent>(
            onInvoke: (_) {
              _runSearch();
              return null;
            },
          ),
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Offline Multimodal Local Retrieval',
            ),
            actions: [
              Semantics(
                button: true,
                label: 'Reload local documents and images',
                child: IconButton(
                  tooltip:
                  'Reload local documents and images',
                  onPressed: _isInitialising
                      ? null
                      : _initialiseRetrievalPipeline,
                  icon: const Icon(Icons.refresh),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isInitialising) {
      return _buildInitialisingState();
    }

    if (_initialisationError != null) {
      return _buildInitialisationError();
    }

    return Column(
      children: [
        _buildSearchSection(),
        const Divider(height: 1),
        Expanded(
          child: _buildResultsSection(),
        ),
      ],
    );
  }

  Widget _buildInitialisingState() {
    return Center(
      child: Semantics(
        liveRegion: true,
        label:
        'Loading and indexing local documents and images',
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Loading and indexing local documents and images...',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialisationError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Semantics(
          liveRegion: true,
          label: 'Retrieval pipeline initialisation failed',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 56,
              ),
              const SizedBox(height: 16),
              const Text(
                'Unable to load local content',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                _initialisationError ??
                    'Unknown initialisation error.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _initialiseRetrievalPipeline,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Search local content',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter keywords to search indexed text chunks and image metadata.',
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Semantics(
                  textField: true,
                  label: 'Local content search query',
                  hint:
                  'Enter metadata extraction or animal pet',
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    textInputAction:
                    TextInputAction.search,
                    onSubmitted: (_) => _runSearch(),
                    decoration: const InputDecoration(
                      labelText: 'Search query',
                      hintText:
                      'Example: metadata extraction or animal pet',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                button: true,
                label: 'Search indexed local content',
                child: FilledButton.icon(
                  onPressed:
                  _isSearching ? null : _runSearch,
                  icon: _isSearching
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : const Icon(Icons.search),
                  label: Text(
                    _isSearching
                        ? 'Searching...'
                        : 'Search',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Semantics(
                button: true,
                label: 'Clear search query and results',
                child: OutlinedButton.icon(
                  onPressed: _clearSearch,
                  icon: const Icon(Icons.clear),
                  label: const Text('Clear'),
                ),
              ),
            ],
          ),
          if (_searchError != null) ...[
            const SizedBox(height: 12),
            Semantics(
              liveRegion: true,
              child: Text(
                _searchError!,
                style: TextStyle(
                  color:
                  Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
          _buildPipelineSummary(),
        ],
      ),
    );
  }

  Widget _buildPipelineSummary() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _buildSummaryChip(
          icon: Icons.description_outlined,
          label: 'Documents',
          value: _parsedDocumentCount.toString(),
        ),
        _buildSummaryChip(
          icon: Icons.segment,
          label: 'Text chunks',
          value: _textChunkCount.toString(),
        ),
        _buildSummaryChip(
          icon: Icons.data_array,
          label: 'Vocabulary',
          value: _vocabularySize.toString(),
        ),
        _buildSummaryChip(
          icon: Icons.hub_outlined,
          label: 'Text vectors',
          value: _embeddingVectors.length.toString(),
        ),
        _buildSummaryChip(
          icon: Icons.image_outlined,
          label: 'Images',
          value: _imageDocuments.length.toString(),
        ),
      ],
    );
  }

  Widget _buildSummaryChip({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Semantics(
      label: '$label: $value',
      child: Chip(
        avatar: Icon(
          icon,
          size: 18,
        ),
        label: Text(
          '$label: $value',
        ),
      ),
    );
  }

  Widget _buildResultsSection() {
    if (_isSearching) {
      return Center(
        child: Semantics(
          liveRegion: true,
          label: 'Searching local content',
          child: const CircularProgressIndicator(),
        ),
      );
    }

    if (!_hasSearched) {
      return _buildWelcomeState();
    }

    if (_textSearchResults.isEmpty &&
        _imageSearchResults.isEmpty) {
      return _buildEmptyResultState();
    }

    return _buildCombinedResults();
  }

  Widget _buildWelcomeState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Semantics(
          label:
          'Search is ready. Enter a query to retrieve local text and images.',
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.manage_search,
                size: 72,
              ),
              SizedBox(height: 16),
              Text(
                'Ready to search',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Enter a query above to find relevant local text chunks and images.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyResultState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Semantics(
          liveRegion: true,
          label: 'No similar local content found',
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search_off,
                size: 72,
              ),
              SizedBox(height: 16),
              Text(
                'No similar content found',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Try another keyword that appears in the documents, image descriptions, or image tags.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCombinedResults() {
    return Semantics(
      liveRegion: true,
      label:
      '${_textSearchResults.length} text results and '
          '${_imageSearchResults.length} image results found',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (_textSearchResults.isNotEmpty) ...[
            _buildSectionHeader(
              icon: Icons.description_outlined,
              title: 'Text results',
              count: _textSearchResults.length,
            ),
            const SizedBox(height: 12),
            for (
            var index = 0;
            index < _textSearchResults.length;
            index++
            ) ...[
              _buildTextResultCard(
                result: _textSearchResults[index],
                ranking: index + 1,
              ),
              if (index <
                  _textSearchResults.length - 1)
                const SizedBox(height: 12),
            ],
          ],
          if (_textSearchResults.isNotEmpty &&
              _imageSearchResults.isNotEmpty)
            const SizedBox(height: 28),
          if (_imageSearchResults.isNotEmpty) ...[
            _buildSectionHeader(
              icon: Icons.image_outlined,
              title: 'Image results',
              count: _imageSearchResults.length,
            ),
            const SizedBox(height: 12),
            for (
            var index = 0;
            index < _imageSearchResults.length;
            index++
            ) ...[
              _buildImageResultCard(
                result: _imageSearchResults[index],
                ranking: index + 1,
              ),
              if (index <
                  _imageSearchResults.length - 1)
                const SizedBox(height: 12),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required int count,
  }) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 8),
        Text(
          '$title ($count)',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTextResultCard({
    required SimilarityResult result,
    required int ranking,
  }) {
    final formattedScore =
    result.similarityScore.toStringAsFixed(4);

    return Semantics(
      container: true,
      label:
      'Text result $ranking. '
          'File ${result.sourceFileName}. '
          'Chunk ${result.chunkIndex}. '
          'Similarity score $formattedScore. '
          '${result.preview}',
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Text(
                      ranking.toString(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          result.sourceFileName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Chunk ${result.chunkIndex}',
                        ),
                      ],
                    ),
                  ),
                  Tooltip(
                    message:
                    'Cosine similarity score',
                    child: Chip(
                      avatar: const Icon(
                        Icons.analytics_outlined,
                        size: 18,
                      ),
                      label: Text(formattedScore),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                result.preview,
                style: const TextStyle(
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              SelectableText(
                result.sourceFilePath,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageResultCard({
    required ImageSearchResult result,
    required int ranking,
  }) {
    final formattedScore =
    result.similarityScore.toStringAsFixed(4);

    final imageFile = File(
      result.filePath,
    );

    return Semantics(
      container: true,
      label:
      'Image result $ranking. '
          'File ${result.fileName}. '
          'Similarity score $formattedScore. '
          '${result.description}',
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final useVerticalLayout =
                  constraints.maxWidth < 650;

              final imagePreview =
              _buildImagePreview(
                imageFile,
              );

              final information =
              _buildImageInformation(
                result: result,
                ranking: ranking,
                formattedScore: formattedScore,
              );

              if (useVerticalLayout) {
                return Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    imagePreview,
                    const SizedBox(height: 16),
                    information,
                  ],
                );
              }

              return Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  imagePreview,
                  const SizedBox(width: 18),
                  Expanded(
                    child: information,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview(
      File imageFile,
      ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 180,
        height: 120,
        child: Image.file(
          imageFile,
          fit: BoxFit.cover,
          errorBuilder: (
              context,
              error,
              stackTrace,
              ) {
            return Container(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest,
              alignment: Alignment.center,
              child: const Icon(
                Icons.broken_image_outlined,
                size: 42,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildImageInformation({
    required ImageSearchResult result,
    required int ranking,
    required String formattedScore,
  }) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Text(
                ranking.toString(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                result.fileName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Tooltip(
              message: 'Cosine similarity score',
              child: Chip(
                avatar: const Icon(
                  Icons.analytics_outlined,
                  size: 18,
                ),
                label: Text(
                  formattedScore,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          result.description,
          style: const TextStyle(
            height: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: result.tags.map(
                (tag) {
              return Chip(
                visualDensity:
                VisualDensity.compact,
                label: Text(tag),
              );
            },
          ).toList(),
        ),
        const SizedBox(height: 12),
        SelectableText(
          result.filePath,
          style: Theme.of(context)
              .textTheme
              .bodySmall,
        ),
      ],
    );
  }
}

/// Intent used by the keyboard Enter shortcut.
class _SearchIntent extends Intent {
  const _SearchIntent();
}