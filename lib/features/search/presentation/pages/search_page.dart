import 'package:flutter/material.dart';
import 'package:memoir/core/core.dart';
import 'package:memoir/features/memories/presentation/widgets/widgets.dart';
import 'package:memoir/features/memories/data/datasources/memory_remote_datasource.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:ionicons/ionicons.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  late final MemoryRemoteDataSource _memoryDataSource;

  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;
  bool _isSemanticSearch = false;
  String _lastQuery = '';

  @override
  void initState() {
    super.initState();
    _memoryDataSource = MemoryRemoteDataSourceImpl(dio: DioClient.instance);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _lastQuery = '';
      });
      return;
    }

    if (query == _lastQuery) return;

    setState(() {
      _isLoading = true;
      _lastQuery = query;
    });

    try {
      final results = await _memoryDataSource.searchMemories(
        query: query,
        isSemanticSearch: _isSemanticSearch,
      );

      if (mounted) {
        setState(() {
          _searchResults = results;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        SnackBarUtils.showError(context, ErrorMessages.getErrorMessage(e));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Ionicons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.lightBackgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Search header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Поиск',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Search field
                    CustomTextField(
                      controller: _searchController,
                      hintText: _isSemanticSearch
                          ? 'Искать по смыслу...'
                          : 'Искать по тексту...',
                      prefixIcon: Ionicons.search_outline,
                      onChanged: (value) {
                        // Debounced search
                        Future.delayed(const Duration(milliseconds: 500), () {
                          if (_searchController.text == value) {
                            _performSearch(value);
                          }
                        });
                      },
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Ionicons.close_circle),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchResults = [];
                                  _lastQuery = '';
                                });
                              },
                            )
                          : null,
                    ),
                    const SizedBox(height: 12),

                    // Search mode toggle
                    GlassCard(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(
                            _isSemanticSearch
                                ? Ionicons.sparkles
                                : Ionicons.text_outline,
                            size: 20,
                            color: AppTheme.primaryColor,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _isSemanticSearch
                                      ? 'Семантический поиск'
                                      : 'Текстовый поиск',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  _isSemanticSearch
                                      ? 'Поиск по смыслу с помощью AI'
                                      : 'Поиск по точному совпадению',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark
                                        ? Colors.white60
                                        : Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _isSemanticSearch,
                            onChanged: (value) {
                              setState(() {
                                _isSemanticSearch = value;
                              });
                              if (_searchController.text.isNotEmpty) {
                                _performSearch(_searchController.text);
                              }
                            },
                            activeTrackColor: AppTheme.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Results
              Expanded(child: _buildResults()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResults() {
    if (_isLoading) {
      return const LoadingState(message: 'Поиск...');
    }

    if (_lastQuery.isEmpty) {
      return const EmptyState(
        icon: Ionicons.search_outline,
        title: 'Введите запрос для поиска',
        subtitle: 'Используйте текстовый или семантический поиск',
      );
    }

    if (_searchResults.isEmpty) {
      return EmptyState(
        icon: Ionicons.sad_outline,
        title: 'Ничего не найдено',
        subtitle: 'Попробуйте изменить запрос\nили переключить режим поиска',
        buttonText: _isSemanticSearch
            ? 'Текстовый поиск'
            : 'Семантический поиск',
        buttonIcon: _isSemanticSearch
            ? Ionicons.text_outline
            : Ionicons.sparkles,
        onButtonPressed: () {
          setState(() {
            _isSemanticSearch = !_isSemanticSearch;
          });
          _performSearch(_searchController.text);
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _searchResults.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Icon(
                  Ionicons.checkmark_circle,
                  size: 20,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Найдено: ${_searchResults.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }

        final memory = _searchResults[index - 1];
        final createdAt = memory['created_at'] != null
            ? DateTime.parse(memory['created_at'])
            : DateTime.now();

        final aiConfidence = memory['ai_confidence'] != null
            ? (memory['ai_confidence'] as num).toDouble()
            : null;

        return MemoryCard(
          title: memory['title'] ?? 'Без заголовка',
          content: memory['content'] ?? '',
          category: memory['category_name'],
          tags: memory['tags'] != null
              ? List<String>.from(memory['tags'])
              : null,
          createdAt: createdAt,
          aiConfidence: aiConfidence,
          onTap: () {
            SnackBarUtils.showInfo(
              context,
              'Детальный просмотр - в разработке',
            );
          },
        );
      },
    );
  }
}
