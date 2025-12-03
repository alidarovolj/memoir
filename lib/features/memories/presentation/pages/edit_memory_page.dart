import 'package:flutter/material.dart';
import 'package:memoir/core/core.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/features/smart_search/presentation/widgets/smart_search_modal.dart';
import 'package:memoir/features/smart_search/data/models/search_result_model.dart';

class EditMemoryPage extends StatefulWidget {
  final Map<String, dynamic> memory;

  const EditMemoryPage({super.key, required this.memory});

  @override
  State<EditMemoryPage> createState() => _EditMemoryPageState();
}

class _EditMemoryPageState extends State<EditMemoryPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _isLoading = false;
  late String _selectedSourceType;
  late AnimationController _slideController;
  Map<String, dynamic>? _selectedContent;

  final List<Map<String, dynamic>> _sourceTypes = [
    {'type': 'text', 'icon': Ionicons.text_outline, 'label': 'Текст'},
    {'type': 'link', 'icon': Ionicons.link_outline, 'label': 'Ссылка'},
    {'type': 'image', 'icon': Ionicons.image_outline, 'label': 'Фото'},
    {'type': 'voice', 'icon': Ionicons.mic_outline, 'label': 'Голос'},
  ];

  @override
  void initState() {
    super.initState();

    // Pre-fill form with existing data
    _titleController = TextEditingController(text: widget.memory['title']);
    _contentController = TextEditingController(text: widget.memory['content']);
    _selectedSourceType = widget.memory['source_type'] ?? 'text';

    // Pre-fill selected content if exists
    if (widget.memory['image_url'] != null ||
        widget.memory['backdrop_url'] != null) {
      final metadata = widget.memory['memory_metadata'];
      _selectedContent = {
        'source': widget.memory['source_url'],
        'external_id': widget.memory['source_url'],
        'type': _selectedSourceType,
        'image_url': widget.memory['image_url'],
        'backdrop_url': widget.memory['backdrop_url'],
        'metadata': (metadata is Map)
            ? Map<String, dynamic>.from(metadata)
            : <String, dynamic>{},
      };
    }

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

  void _fillFormFromSearchResult(ContentResult result) {
    setState(() {
      _titleController.text = result.title;

      final descriptionParts = <String>[];

      if (result.description != null && result.description!.isNotEmpty) {
        descriptionParts.add(result.description!);
      }

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

      _selectedContent = {
        'source': result.source,
        'external_id': result.externalId,
        'type': result.type,
        'image_url': result.imageUrl,
        'backdrop_url': result.backdropUrl,
        'metadata': result.metadata != null
            ? Map<String, dynamic>.from(result.metadata!)
            : <String, dynamic>{},
      };
    });

    SnackBarUtils.showSuccess(
      context,
      '✨ Контент обновлен! Проверьте и сохраните',
    );
  }

  Future<void> _updateMemory() async {
    print('🎯 [EDIT] Starting memory update...');

    if (!_formKey.currentState!.validate()) {
      print('❌ [EDIT] Form validation failed');
      return;
    }

    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      SnackBarUtils.showWarning(context, 'Заполните все поля');
      print('❌ [EDIT] Title or content is empty');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final memoryData = <String, dynamic>{
        'title': _titleController.text,
        'content': _contentController.text,
        'source_type': _selectedSourceType,
      };

      print('📝 [EDIT] Base memory data: $memoryData');

      // Add smart search metadata if available
      if (_selectedContent != null) {
        print('✨ [EDIT] Adding smart search metadata');

        final sourceUrl = _selectedContent!['external_id']?.toString();
        final imageUrl = _selectedContent!['image_url']?.toString();
        final backdropUrl = _selectedContent!['backdrop_url']?.toString();

        if (sourceUrl != null) memoryData['source_url'] = sourceUrl;
        if (imageUrl != null) memoryData['image_url'] = imageUrl;
        if (backdropUrl != null) memoryData['backdrop_url'] = backdropUrl;

        // metadata is already Map<String, dynamic> from _selectedContent initialization
        if (_selectedContent!.containsKey('metadata') &&
            _selectedContent!['metadata'] is Map) {
          memoryData['memory_metadata'] =
              _selectedContent!['metadata'] as Map<String, dynamic>;
          print('   - memory_metadata updated');
        }
      }

      print('✅ [EDIT] Final memory data: $memoryData');

      if (mounted) {
        Navigator.of(context).pop(memoryData);
        print('🚀 [EDIT] Popping with updated data...');
      }
    } catch (e, stackTrace) {
      print('❌ [EDIT] Error occurred: $e');
      print('📚 [EDIT] Stack trace: $stackTrace');

      if (mounted) {
        setState(() => _isLoading = false);
        final message = ErrorMessages.getErrorMessage(e);
        SnackBarUtils.showError(
          context,
          'Не удалось обновить воспоминание: $message',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: 'Редактировать',
        leading: IconButton(
          icon: const Icon(Ionicons.close_outline),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              onPressed: _isLoading ? null : _updateMemory,
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
                      'Сохранить',
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

                      // Заголовок
                      _buildSectionTitle('Заголовок'),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: _titleController,
                        hintText: 'Например: Интерстеллар',
                        prefixIcon: Ionicons.text_outline,
                        enabled: !_isLoading,
                      ),
                      const SizedBox(height: 24),

                      // Кнопка Smart Search
                      GradientButton(
                        text: '🌟 Обновить из поиска',
                        icon: Ionicons.sparkles_outline,
                        onPressed: _isLoading ? null : _openSmartSearchModal,
                        isLoading: false,
                      ),
                      const SizedBox(height: 24),

                      // Описание
                      _buildSectionTitle('Описание'),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: _contentController,
                        hintText: 'Ваши мысли и заметки...',
                        prefixIcon: Ionicons.document_text_outline,
                        maxLines: 8,
                        enabled: !_isLoading,
                      ),
                      const SizedBox(height: 24),

                      // Preview if image exists
                      if (_selectedContent?['image_url'] != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle('Изображение'),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                _selectedContent!['image_url'],
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),

                      // AI Info
                      AIInfoCard(
                        features: const [
                          AIFeature(
                            icon: Ionicons.apps_outline,
                            text: 'AI переклассифицирует автоматически',
                          ),
                          AIFeature(
                            icon: Ionicons.pricetags_outline,
                            text: 'Обновит теги и метаданные',
                          ),
                          AIFeature(
                            icon: Ionicons.search_outline,
                            text: 'Обновит поисковый индекс',
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Кнопка сохранения
                      GradientButton(
                        text: 'Сохранить изменения',
                        icon: Ionicons.checkmark_circle_outline,
                        onPressed: _updateMemory,
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

  void _openSmartSearchModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SmartSearchModal(
        initialQuery: _titleController.text.isNotEmpty
            ? _titleController.text
            : '',
        onResultSelected: _fillFormFromSearchResult,
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _sourceTypes.map((type) {
          final isSelected = _selectedSourceType == type['type'];
          return Expanded(
            child: InkWell(
              onTap: _isLoading
                  ? null
                  : () {
                      setState(() {
                        _selectedSourceType = type['type'];
                      });
                    },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: isSelected ? AppTheme.primaryGradient : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      type['icon'],
                      color: isSelected
                          ? Colors.white
                          : (isDark
                                ? Colors.white.withOpacity(0.5)
                                : Colors.black54),
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      type['label'],
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
