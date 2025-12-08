import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/widgets.dart';
import 'package:memoir/core/utils/utils.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/smart_search/data/datasources/smart_search_remote_datasource.dart';
import 'package:memoir/features/smart_search/data/models/search_result_model.dart';
import 'package:memoir/features/smart_search/presentation/widgets/content_result_card.dart';
import 'dart:async';

class SmartSearchModal extends StatefulWidget {
  final String initialQuery;
  final Function(ContentResult)? onResultSelected;
  final ScrollController? scrollController;

  const SmartSearchModal({
    super.key,
    required this.initialQuery,
    this.onResultSelected,
    this.scrollController,
  });

  @override
  State<SmartSearchModal> createState() => _SmartSearchModalState();
}

class _SmartSearchModalState extends State<SmartSearchModal> {
  final _searchController = TextEditingController();
  late final SmartSearchRemoteDataSource _searchDataSource;

  bool _isLoading = false;
  SmartSearchResponse? _searchResponse;
  List<ContentResult> _results = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchDataSource = SmartSearchRemoteDataSourceImpl(
      dio: DioClient.instance,
    );
    _searchController.text = widget.initialQuery;

    // Perform initial search
    if (widget.initialQuery.isNotEmpty) {
      _performSearch(widget.initialQuery);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.isNotEmpty) {
        _performSearch(value);
      } else {
        setState(() {
          _results = [];
          _searchResponse = null;
        });
      }
    });
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _searchDataSource.smartSearch(query);
      final searchResponse = SmartSearchResponse.fromJson(response);

      if (mounted) {
        setState(() {
          _searchResponse = searchResponse;
          _results = _parseResults(searchResponse);
        });
      }
    } catch (e) {
      if (mounted) {
        SnackBarUtils.showError(context, ErrorMessages.getErrorMessage(e));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<ContentResult> _parseResults(SmartSearchResponse response) {
    final results = <ContentResult>[];

    // Parse results from different sources
    response.sources.forEach((source, data) {
      if (data is List) {
        for (var item in data) {
          try {
            results.add(ContentResult.fromJson(item as Map<String, dynamic>));
          } catch (e) {
            print('Error parsing result: $e');
          }
        }
      }
    });

    return results;
  }

  Future<void> _selectResult(ContentResult result) async {
    // If it's a TMDB movie, try to fetch full details
    if (result.source == 'tmdb' && result.externalId != null) {
      try {
        final details = await _searchDataSource.getContentDetails(
          externalId: result.externalId!,
          source: result.source,
          contentType: result.type,
        );

        final detailedResult = ContentResult.fromJson(details);

        // Check if detailed result has meaningful data (non-empty title)
        // If not, use the original result from search
        final resultToReturn = (detailedResult.title.isEmpty)
            ? result
            : detailedResult;

        if (mounted) {
          // Use rootNavigator to ensure we close the modal bottom sheet
          Navigator.of(context, rootNavigator: true).pop(resultToReturn);
        }
      } catch (e) {
        if (mounted) {
          // On error, return the original result instead of showing error
          Navigator.of(context, rootNavigator: true).pop(result);
        }
      }
    } else {
      // Return the result as-is
      if (mounted) {
        if (widget.onResultSelected != null) {
          widget.onResultSelected!(result);
          Navigator.of(context, rootNavigator: true).pop();
        } else {
          // Use rootNavigator to ensure we close the modal bottom sheet
          Navigator.of(context, rootNavigator: true).pop(result);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.lightBackgroundGradient,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.08),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white30 : Colors.black26,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // Title
                Row(
                  children: [
                    GradientIcon(
                      icon: Ionicons.sparkles,
                      size: 24,
                      gradient: AppTheme.primaryGradient,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Умный поиск контента',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Ionicons.close_outline),
                      onPressed: () =>
                          Navigator.of(context, rootNavigator: true).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Search field
                CustomTextField(
                  controller: _searchController,
                  hintText: 'Введите название...',
                  prefixIcon: Ionicons.search_outline,
                  onChanged: _onSearchChanged,
                ),

                // Intent info
                if (_searchResponse != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.primaryColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _getIntentIcon(_searchResponse!.intent),
                          size: 20,
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getIntentLabel(_searchResponse!.intent),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                              Text(
                                'Уверенность: ${(_searchResponse!.confidence * 100).toInt()}%',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppTheme.primaryColor.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Results
          Expanded(child: _buildResults()),
        ],
      ),
    );
  }

  Widget _buildResults() {
    if (_isLoading) {
      return const LoadingState();
    }

    if (_searchResponse != null && !_searchResponse!.needsSearch) {
      return EmptyState(
        icon: Ionicons.create_outline,
        title: 'Просто создайте заметку',
        subtitle:
            'Для "${_searchResponse!.intent}" поиск не нужен.\nПросто сохраните как есть.',
        buttonText: 'Создать заметку',
        buttonIcon: Ionicons.checkmark_circle_outline,
        onButtonPressed: () =>
            Navigator.of(context, rootNavigator: true).pop(null),
      );
    }

    if (_results.isEmpty && _searchController.text.isNotEmpty) {
      return EmptyState(
        icon: Ionicons.search_outline,
        title: 'Ничего не найдено',
        subtitle: 'Попробуйте изменить запрос\nили создайте простую заметку',
        buttonText: 'Создать заметку',
        buttonIcon: Ionicons.create_outline,
        onButtonPressed: () =>
            Navigator.of(context, rootNavigator: true).pop(null),
      );
    }

    if (_results.isEmpty) {
      return EmptyState(
        icon: Ionicons.sparkles_outline,
        title: 'Начните поиск',
        subtitle: 'Введите название фильма, книги,\nили что хотите найти',
      );
    }

    return ListView.builder(
      controller: widget.scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: _results.length,
      itemBuilder: (context, index) {
        final result = _results[index];
        return ContentResultCard(
          result: result,
          onTap: () => _selectResult(result),
        );
      },
    );
  }

  IconData _getIntentIcon(String intent) {
    switch (intent) {
      case 'movie':
        return Ionicons.film_outline;
      case 'book':
        return Ionicons.book_outline;
      case 'recipe':
        return Ionicons.restaurant_outline;
      case 'place':
        return Ionicons.location_outline;
      case 'product':
        return Ionicons.cart_outline;
      case 'idea':
        return Ionicons.bulb_outline;
      case 'task':
        return Ionicons.checkbox_outline;
      default:
        return Ionicons.sparkles;
    }
  }

  String _getIntentLabel(String intent) {
    switch (intent) {
      case 'movie':
        return 'Обнаружен: Фильм или сериал';
      case 'book':
        return 'Обнаружена: Книга';
      case 'recipe':
        return 'Обнаружен: Рецепт';
      case 'place':
        return 'Обнаружено: Место';
      case 'product':
        return 'Обнаружен: Товар для покупки';
      case 'idea':
        return 'Обнаружена: Идея или мысль';
      case 'task':
        return 'Обнаружена: Задача';
      default:
        return 'Обнаружено: $intent';
    }
  }
}
