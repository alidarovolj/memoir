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
  final _scrollController = ScrollController();
  late final MemoryRemoteDataSource _memoryDataSource;

  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;
  bool _isSemanticSearch = false;
  String _lastQuery = '';
  final _headerOpacity = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    _memoryDataSource = MemoryRemoteDataSourceImpl(dio: DioClient.instance);

    // Добавляем слушатель для анимации header
    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      final newOpacity = (offset / 100).clamp(0.0, 1.0);
      if (_headerOpacity.value != newOpacity) {
        _headerOpacity.value = newOpacity;
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _headerOpacity.dispose();
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
    return Scaffold(
      backgroundColor: AppTheme.pageBackgroundColor,
      body: Column(
        children: [
          // Custom Header с анимацией заголовка
          Container(
            color: AppTheme.headerBackgroundColor,
            child: SafeArea(
              bottom: false,
              child: Container(
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  children: [
                    // Анимированный заголовок
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48),
                        child: ValueListenableBuilder<double>(
                          valueListenable: _headerOpacity,
                          builder: (context, opacity, child) {
                            return Opacity(
                              opacity: opacity,
                              child: const Text(
                                'Поиск',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Кнопка назад (всегда видна)
                    // Positioned(
                    //   left: 0,
                    //   top: 0,
                    //   bottom: 0,
                    //   child: Center(
                    //     child: GestureDetector(
                    //       behavior: HitTestBehavior.opaque,
                    //       onTap: () {
                    //         if (Navigator.canPop(context)) {
                    //           Navigator.of(context).pop();
                    //         }
                    //       },
                    //       child: Container(
                    //         padding: const EdgeInsets.all(8),
                    //         child: const Icon(
                    //           Ionicons.chevron_back,
                    //           color: AppTheme.primaryColor,
                    //           size: 24,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),

          // Search content
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Search header и форма
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Найти воспоминания',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(height: 20),

                        // Search field с кнопкой
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: _searchController,
                                hintText: _isSemanticSearch
                                    ? 'Искать по смыслу...'
                                    : 'Искать по тексту...',
                                prefixIcon: Ionicons.search_outline,
                                onChanged: (value) {
                                  setState(() {}); // Для обновления suffixIcon
                                },
                                onSubmitted: (value) => _performSearch(value),
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
                            ),
                            const SizedBox(width: 12),
                            // Кнопка поиска
                            Container(
                              height: 56,
                              width: 56,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: _isLoading
                                      ? null
                                      : () => _performSearch(
                                          _searchController.text,
                                        ),
                                  child: Center(
                                    child: _isLoading
                                        ? const SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    Colors.white,
                                                  ),
                                            ),
                                          )
                                        : const Icon(
                                            Ionicons.search,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Search mode toggle
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(44, 44, 44, 1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(
                                    0.15,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  _isSemanticSearch
                                      ? Ionicons.sparkles
                                      : Ionicons.text_outline,
                                  size: 20,
                                  color: AppTheme.primaryColor,
                                ),
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
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      _isSemanticSearch
                                          ? 'Поиск по смыслу с помощью AI'
                                          : 'Поиск по точному совпадению',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.6),
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
                                },
                                activeThumbColor: AppTheme.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Results
                _buildResults(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    if (_lastQuery.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyState(
          title: 'Введите запрос для поиска',
          subtitle: 'Используйте текстовый или семантический поиск',
        ),
      );
    }

    if (_searchResults.isEmpty && !_isLoading) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyState(
          title: 'Ничего не найдено',
          subtitle: 'Попробуйте изменить запрос\nили переключить режим поиска',
          buttonText: _isSemanticSearch
              ? 'Попробовать текстовый поиск'
              : 'Попробовать AI поиск',
          buttonIcon: _isSemanticSearch
              ? Ionicons.text_outline
              : Ionicons.sparkles,
          onButtonPressed: () {
            setState(() {
              _isSemanticSearch = !_isSemanticSearch;
            });
            _performSearch(_searchController.text);
          },
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Ionicons.checkmark_circle,
                      size: 20,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Найдено: ${_searchResults.length}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
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

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MemoryCard(
              memoryId: memory['id'] ?? '',
              title: memory['title'] ?? 'Без заголовка',
              content: memory['content'] ?? '',
              imageUrl: memory['image_url'],
              category: memory['category_name'],
              tags: memory['tags'] != null
                  ? List<String>.from(memory['tags'])
                  : null,
              createdAt: createdAt,
              aiConfidence: aiConfidence,
              reactionsCount: memory['reactions_count'] ?? 0,
              commentsCount: memory['comments_count'] ?? 0,
              sharesCount: memory['shares_count'] ?? 0,
              viewsCount: memory['views_count'] ?? 0,
              isReacted: memory['is_reacted'] ?? false,
              onTap: () {
                SnackBarUtils.showInfo(
                  context,
                  'Детальный просмотр - в разработке',
                );
              },
            ),
          );
        }, childCount: _searchResults.length + 1),
      ),
    );
  }
}
