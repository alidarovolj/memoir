import 'package:flutter/material.dart';
import 'package:memoir/core/core.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/features/smart_search/presentation/widgets/smart_search_modal.dart';
import 'package:memoir/features/smart_search/data/models/search_result_model.dart';

class CreateMemoryPage extends StatefulWidget {
  const CreateMemoryPage({super.key});

  @override
  State<CreateMemoryPage> createState() => _CreateMemoryPageState();
}

class _CreateMemoryPageState extends State<CreateMemoryPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isLoading = false;
  String _selectedSourceType = 'text';
  bool _publishAsStory = false; // Toggle для публикации в историях
  late AnimationController _slideController;
  Map<String, dynamic>?
  _selectedContent; // Store selected content from smart search

  final List<Map<String, dynamic>> _sourceTypes = [
    {'type': 'text', 'icon': Ionicons.text_outline, 'label': 'Текст'},
    {'type': 'link', 'icon': Ionicons.link_outline, 'label': 'Ссылка'},
    {'type': 'image', 'icon': Ionicons.image_outline, 'label': 'Фото'},
    {'type': 'voice', 'icon': Ionicons.mic_outline, 'label': 'Голос'},
  ];

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Future<void> _openSmartSearch() async {
    final query = _titleController.text.trim();
    if (query.isEmpty) {
      SnackBarUtils.showWarning(context, 'Введите заголовок для поиска');
      return;
    }

    final result = await showModalBottomSheet<ContentResult?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return SmartSearchModal(initialQuery: query);
        },
      ),
    );

    if (result != null) {
      _fillFormFromSearchResult(result);
    }
  }

  void _fillFormFromSearchResult(ContentResult result) {
    setState(() {
      _titleController.text = result.title;

      // Build rich description
      final descriptionParts = <String>[];

      if (result.description != null && result.description!.isNotEmpty) {
        descriptionParts.add(result.description!);
      }

      // Add metadata
      if (result.director != null) {
        descriptionParts.add('\n🎬 Режиссер: ${result.director}');
      }

      if (result.actors != null && result.actors!.isNotEmpty) {
        descriptionParts.add('🎭 Актеры: ${result.actors!.take(3).join(", ")}');
      }

      if (result.authors != null && result.authors!.isNotEmpty) {
        descriptionParts.add('✍️ Автор: ${result.authors!.join(", ")}');
      }

      if (result.year != null) {
        descriptionParts.add('📅 Год: ${result.year}');
      }

      if (result.rating != null) {
        descriptionParts.add('⭐ Рейтинг: ${result.rating!.toStringAsFixed(1)}');
      }

      if (result.genres != null && result.genres!.isNotEmpty) {
        descriptionParts.add('🎭 Жанры: ${result.genres!.join(", ")}');
      }

      _contentController.text = descriptionParts.join('\n');

      // Store the full result with metadata
      _selectedContent = {
        'source': result.source,
        'external_id': result.externalId,
        'type': result.type,
        'image_url': result.imageUrl,
        'backdrop_url': result.backdropUrl,
        'metadata': result.metadata ?? {},
      };
    });

    SnackBarUtils.showSuccess(
      context,
      '✨ Контент найден! Проверьте и сохраните',
    );
  }

  Future<void> _createMemory() async {
    print('🎯 [CREATE] Starting memory creation...');

    if (!_formKey.currentState!.validate()) {
      print('❌ [CREATE] Form validation failed');
      return;
    }

    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      print('❌ [CREATE] Title or content is empty');
      SnackBarUtils.showWarning(context, 'Заполните все поля');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final memoryData = <String, dynamic>{
        'title': _titleController.text,
        'content': _contentController.text,
        'source_type': _selectedSourceType,
      };

      print('📝 [CREATE] Base memory data: $memoryData');

      // Add smart search metadata if available
      if (_selectedContent != null) {
        print('✨ [CREATE] Adding smart search metadata');
        print('   - external_id: ${_selectedContent!['external_id']}');
        print('   - metadata: ${_selectedContent!['metadata']}');

        memoryData['source_url'] = _selectedContent!['external_id']?.toString();
        memoryData['image_url'] = _selectedContent!['image_url']?.toString();
        memoryData['backdrop_url'] = _selectedContent!['backdrop_url']
            ?.toString();

        print('   - image_url: ${memoryData['image_url']}');
        print('   - backdrop_url: ${memoryData['backdrop_url']}');

        // Merge smart search metadata - keep as Map, don't convert to JSON string
        if (_selectedContent!['metadata'] != null) {
          // Convert to mutable Map (freezed returns immutable Map)
          final metadata = _selectedContent!['metadata'];
          if (metadata is Map) {
            // Keep as Map - backend accepts JSONB which is a Map
            memoryData['memory_metadata'] = Map<String, dynamic>.from(metadata);
            print(
              '   - memory_metadata added as Map: ${memoryData['memory_metadata']}',
            );
          } else {
            print('   ⚠️ metadata is not a Map: ${metadata.runtimeType}');
          }
        }
      } else {
        print('ℹ️ [CREATE] No smart search metadata');
      }

      print('✅ [CREATE] Final memory data: $memoryData');

      // Add story flag to memory data
      memoryData['publish_as_story'] = _publishAsStory;
      print(
        '🚀 [CREATE] Popping with data (publish_as_story: $_publishAsStory)...',
      );

      if (mounted) {
        Navigator.of(context).pop(memoryData);
        print('✅ [CREATE] Navigation completed');
      }
    } catch (e, stackTrace) {
      print('❌ [CREATE] Error occurred: $e');
      print('📚 [CREATE] Stack trace: $stackTrace');

      if (mounted) {
        setState(() => _isLoading = false);
        final message = ErrorMessages.getErrorMessage(e);
        SnackBarUtils.showError(
          context,
          'Не удалось создать воспоминание: $message',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: 'Новое воспоминание',
        leading: IconButton(
          icon: const Icon(Ionicons.close_outline),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              onPressed: _isLoading ? null : _createMemory,
              style: TextButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Создать',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.lightBackgroundGradient,
        ),
        child: SafeArea(
          child: SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0, 0.1),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _slideController,
                    curve: Curves.easeOutCubic,
                  ),
                ),
            child: FadeTransition(
              opacity: _slideController,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Тип источника
                      _buildSectionTitle('Тип контента'),
                      const SizedBox(height: 12),
                      _buildSourceTypeSelector(),
                      const SizedBox(height: 24),

                      // Заголовок с кнопкой Smart Search
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSectionTitle('Заголовок'),
                          TextButton.icon(
                            onPressed: _isLoading ? null : _openSmartSearch,
                            icon: GradientIcon(
                              icon: Ionicons.sparkles,
                              size: 18,
                              gradient: AppTheme.primaryGradient,
                            ),
                            label: ShaderMask(
                              shaderCallback: (bounds) =>
                                  AppTheme.primaryGradient.createShader(
                                    Rect.fromLTWH(
                                      0,
                                      0,
                                      bounds.width,
                                      bounds.height,
                                    ),
                                  ),
                              child: const Text(
                                'Искать контент',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: _titleController,
                        hintText: 'Например: Интерстеллар',
                        prefixIcon: Ionicons.text_outline,
                        enabled: !_isLoading,
                      ),
                      const SizedBox(height: 12),
                      // Hint about smart search
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppTheme.primaryColor.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Ionicons.information_circle_outline,
                              size: 18,
                              color: AppTheme.primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Введите название и нажмите "Искать контент" для автозаполнения',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.primaryColor,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Описание
                      _buildSectionTitle('Описание'),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: _contentController,
                        hintText:
                            'Фильм Кристофера Нолана про космос и путешествия во времени...',
                        prefixIcon: Ionicons.document_text_outline,
                        maxLines: 8,
                        enabled: !_isLoading,
                      ),
                      const SizedBox(height: 24),

                      // Переключатель "Опубликовать в историях"
                      _buildPublishAsStoryToggle(),
                      const SizedBox(height: 24),

                      // AI Info Card
                      AIInfoCard(
                        features: const [
                          AIFeature(
                            icon: Ionicons.apps_outline,
                            text: 'Определит категорию автоматически',
                          ),
                          AIFeature(
                            icon: Ionicons.pricetags_outline,
                            text: 'Создаст релевантные теги',
                          ),
                          AIFeature(
                            icon: Ionicons.cube_outline,
                            text: 'Извлечёт ключевые метаданные',
                          ),
                          AIFeature(
                            icon: Ionicons.search_outline,
                            text: 'Добавит в семантический поиск',
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Кнопка создания (дополнительная)
                      GradientButton(
                        text: 'Создать воспоминание',
                        icon: Ionicons.add_circle_outline,
                        onPressed: _createMemory,
                        isLoading: _isLoading,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: isDark ? Colors.white : Colors.black87,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildPublishAsStoryToggle() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppTheme.surfaceColor.withOpacity(0.5)
            : Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _publishAsStory
              ? AppTheme.primaryColor
              : (isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.1)),
          width: _publishAsStory ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: _publishAsStory
                  ? AppTheme.primaryGradient
                  : LinearGradient(
                      colors: [Colors.grey.shade300, Colors.grey.shade400],
                    ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Ionicons.book_outline, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Опубликовать в историях',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _publishAsStory
                      ? 'Будет видна всем пользователям 7 дней'
                      : 'Только вы сможете видеть это воспоминание',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? Colors.white.withOpacity(0.6)
                        : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Switch(
            value: _publishAsStory,
            onChanged: _isLoading
                ? null
                : (value) {
                    setState(() {
                      _publishAsStory = value;
                    });
                  },
            activeColor: AppTheme.primaryColor,
            activeTrackColor: AppTheme.primaryColor.withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceTypeSelector() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppTheme.surfaceColor.withOpacity(0.5)
            : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.1),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: _sourceTypes.map((source) {
          final isSelected = _selectedSourceType == source['type'];
          return Expanded(
            child: GestureDetector(
              onTap: _isLoading
                  ? null
                  : () {
                      setState(() {
                        _selectedSourceType = source['type'] as String;
                      });
                    },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: isSelected ? AppTheme.primaryGradient : null,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppTheme.primaryColor.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 0,
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  children: [
                    Icon(
                      source['icon'] as IconData,
                      color: isSelected
                          ? Colors.white
                          : (isDark
                                ? Colors.white.withOpacity(0.5)
                                : Colors.black54),
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      source['label'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : (isDark
                                  ? Colors.white.withOpacity(0.5)
                                  : Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
