import 'package:flutter/material.dart';
import 'package:memoir/core/core.dart';
import 'package:ionicons/ionicons.dart';

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
  late AnimationController _slideController;

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

  Future<void> _createMemory() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      SnackBarUtils.showWarning(context, 'Заполните все поля');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final memoryData = {
        'title': _titleController.text,
        'content': _contentController.text,
        'source_type': _selectedSourceType,
      };

      if (mounted) {
        Navigator.of(context).pop(memoryData);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        final message = ErrorMessages.getErrorMessage(e);
        SnackBarUtils.showError(context, 'Не удалось создать воспоминание: $message');
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
            position: Tween<Offset>(
              begin: const Offset(0, 0.1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: _slideController,
              curve: Curves.easeOutCubic,
            )),
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
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
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

