import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/embedding_vector.dart';
import '../models/similarity_result.dart';
import '../services/file_parser_service.dart';
import '../services/simple_embedding_service.dart';
import '../services/similarity_search_service.dart';
import '../services/text_chunking_service.dart';
import '../services/text_processing_service.dart';

/// Main search interface for the offline local retrieval prototype.
///
/// This screen integrates the existing parsing, text processing,
/// text chunking, embedding generation, and similarity-search modules.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const String _sampleDirectoryPath =
      'data/sample_documents';

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

  late final SimilaritySearchService _similaritySearchService;

  List<EmbeddingVector> _embeddingVectors = [];
  List<SimilarityResult> _searchResults = [];

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

  /// Loads local documents and prepares all text-chunk vectors.
  Future<void> _initialiseRetrievalPipeline() async {
    setState(() {
      _isInitialising = true;
      _initialisationError = null;
    });

    try {
      // Step 1: Parse supported local files.
      final parsedDocuments =
      await _fileParserService.parseDocumentsFromDirectory(
        _sampleDirectoryPath,
      );

      // Step 2: Convert parsed documents into searchable documents.
      final searchableDocuments =
      _textProcessingService.convertToSearchableDocuments(
        parsedDocuments,
      );

      // Step 3: Split documents into smaller text chunks.
      final textChunks = _textChunkingService.chunkDocuments(
        searchableDocuments,
        chunkSize: 40,
      );

      // Step 4: Build one shared vocabulary.
      final vocabulary = _embeddingService.buildVocabulary(
        textChunks,
      );

      // Step 5: Generate one vector for every text chunk.
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
        _parsedDocumentCount = parsedDocuments.length;
        _textChunkCount = textChunks.length;
        _vocabularySize = vocabulary.length;
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

  /// Runs cosine-similarity search using the current query.
  Future<void> _runSearch() async {
    final query = _searchController.text.trim();

    if (_isInitialising || _isSearching) {
      return;
    }

    if (query.isEmpty) {
      setState(() {
        _hasSearched = false;
        _searchResults = [];
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
      // Small asynchronous delay allows the loading state to appear.
      await Future<void>.delayed(
        const Duration(milliseconds: 150),
      );

      final results = _similaritySearchService.search(
        query: query,
        embeddings: _embeddingVectors,
        minimumScore: 0.0,
        limit: 10,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _searchResults = [];
        _isSearching = false;
        _searchError = 'Search failed.\n$error';
      });
    }
  }

  /// Clears the current query and results.
  void _clearSearch() {
    _searchController.clear();

    setState(() {
      _searchResults = [];
      _hasSearched = false;
      _searchError = null;
    });

    _searchFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: const <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.enter):
        _SearchIntent(),
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
                label: 'Reload local documents',
                child: IconButton(
                  tooltip: 'Reload local documents',
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
        label: 'Loading and indexing local documents',
        liveRegion: true,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Loading and indexing local documents...',
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
                'Unable to load local documents',
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
            'Enter keywords to search the indexed local text chunks.',
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
                  'Enter keywords such as metadata extraction',
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _runSearch(),
                    decoration: const InputDecoration(
                      labelText: 'Search query',
                      hintText:
                      'Example: metadata extraction',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                button: true,
                label: 'Search indexed local documents',
                child: FilledButton.icon(
                  onPressed: _isSearching
                      ? null
                      : _runSearch,
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
                    _isSearching ? 'Searching...' : 'Search',
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
                  color: Theme.of(context).colorScheme.error,
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
          label: 'Vectors',
          value: _embeddingVectors.length.toString(),
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
        label: Text('$label: $value'),
      ),
    );
  }

  Widget _buildResultsSection() {
    if (_isSearching) {
      return Center(
        child: Semantics(
          label: 'Searching local content',
          liveRegion: true,
          child: const CircularProgressIndicator(),
        ),
      );
    }

    if (!_hasSearched) {
      return _buildWelcomeState();
    }

    if (_searchResults.isEmpty) {
      return _buildEmptyResultState();
    }

    return _buildResultList();
  }

  Widget _buildWelcomeState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Semantics(
          label:
          'Search is ready. Enter a query to retrieve local content.',
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
                'Enter a query above to find relevant local text chunks.',
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
                'Try another keyword that appears in the indexed documents.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultList() {
    return Semantics(
      liveRegion: true,
      label:
      '${_searchResults.length} similarity results found',
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _searchResults.length,
        separatorBuilder: (_, _) =>
        const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return _buildResultCard(
            result: _searchResults[index],
            ranking: index + 1,
          );
        },
      ),
    );
  }

  Widget _buildResultCard({
    required SimilarityResult result,
    required int ranking,
  }) {
    final formattedScore =
    result.similarityScore.toStringAsFixed(4);

    return Semantics(
      container: true,
      label:
      'Result $ranking. File ${result.sourceFileName}. '
          'Chunk ${result.chunkIndex}. '
          'Similarity score $formattedScore. '
          '${result.preview}',
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            fontWeight: FontWeight.bold,
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
                    message: 'Cosine similarity score',
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
}

/// Intent used by the keyboard Enter shortcut.
class _SearchIntent extends Intent {
  const _SearchIntent();
}