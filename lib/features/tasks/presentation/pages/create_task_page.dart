import 'package:flutter/material.dart';
import 'package:memoir/features/tasks/data/models/task_model.dart';
import 'package:memoir/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:developer';
import 'package:memoir/features/tasks/presentation/pages/select_category_page.dart';
import 'package:memoir/features/tasks/presentation/pages/select_task_group_page.dart';
import 'package:memoir/features/tasks/presentation/widgets/ai_analysis_progress.dart';

class CreateTaskPage extends StatefulWidget {
  final TimeScope initialTimeScope;

  const CreateTaskPage({super.key, this.initialTimeScope = TimeScope.daily});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _titleFocusNode = FocusNode();
  final _scrollController = ScrollController();
  final _inputKey = GlobalKey();
  late TaskRemoteDataSource _taskDataSource;

  // UI State
  bool _isAnalyzed = false; // Прошла ли задача AI анализ
  bool _isAnalyzing = false; // Идет ли анализ
  bool _isHabit = false; // Привычка или обычная задача
  bool _showPreview = false; // Показать предпросмотр задач привычки

  // Task properties
  String _title = 'Новая задача';
  Color _selectedColor = AppTheme.primaryColor; // Primary color
  IconData _selectedIcon = Ionicons.checkbox_outline;
  TaskPriority _priority = TaskPriority.medium;
  late TimeScope _timeScope;
  DateTime? _dueDate;
  TimeOfDay? _scheduledTime;
  bool _isRecurring = false;
  String _recurrenceRule = 'FREQ=DAILY';
  bool _isLoading = false;

  // Category
  String? _categoryId;
  String? _categoryDisplayName;
  String? _categoryIcon;

  // Group
  String? _groupId;
  String? _groupName;
  String? _groupIcon;

  // Tags
  List<String> _tags = [];

  // Habit preview data
  Map<String, dynamic>? _habitAnalysis;
  List<Map<String, dynamic>> _previewSubtasks = [];
  int _subtasksCount = 5; // Количество задач для привычки

  // Available colors (like in Grit)
  final List<Color> _availableColors = [
    const Color(0xFFE91E63), // Magenta
    const Color(0xFF9C27B0), // Purple
    const Color(0xFF673AB7), // Deep Purple
    const Color(0xFF3F51B5), // Indigo
    const Color(0xFF2196F3), // Blue
    const Color(0xFF00BCD4), // Cyan
    const Color(0xFF009688), // Teal
    const Color(0xFF4CAF50), // Green
    const Color(0xFFFF9800), // Orange
    const Color(0xFFFF5722), // Deep Orange
  ];

  // Available icons
  final List<IconData> _availableIcons = [
    Ionicons.checkbox_outline,
    Ionicons.briefcase_outline,
    Ionicons.fitness_outline,
    Ionicons.book_outline,
    Ionicons.restaurant_outline,
    Ionicons.water_outline,
    Ionicons.bed_outline,
    Ionicons.pencil_outline,
    Ionicons.cart_outline,
    Ionicons.call_outline,
  ];

  @override
  void initState() {
    super.initState();
    _timeScope = widget.initialTimeScope;
    _taskDataSource = TaskRemoteDataSourceImpl(dio: DioClient.instance);

    _titleController.addListener(() {
      setState(() {
        _title = _titleController.text.isEmpty
            ? 'Новая задача'
            : _titleController.text;
      });
    });

    // Слушаем изменения фокуса для автоматической прокрутки
    _titleFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_titleFocusNode.hasFocus) {
      // Небольшая задержка для того, чтобы клавиатура успела появиться
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!_isAnalyzed) {
          // Прокручиваем к инпуту, чтобы он был виден над клавиатурой
          final context = _inputKey.currentContext;
          if (context != null) {
            Scrollable.ensureVisible(
              context,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              alignment:
                  0.0, // Прокручиваем так, чтобы инпут был вверху видимой области
            );
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _titleFocusNode.removeListener(_onFocusChange);
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Map<String, dynamic>? _aiAnalysisResult;

  Future<void> _analyzeWithAI() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Введите название ${_isHabit ? "привычки" : "задачи"}'),
        ),
      );
      return;
    }

    setState(() => _isAnalyzing = true);

    try {
      if (_isHabit) {
        // Анализ привычки (передаем null, чтобы AI сам решил количество)
        final response = await _taskDataSource.analyzeHabit(
          _titleController.text.trim(),
          subtasksCount: null, // AI сам определяет оптимальное количество
        );

        log('✨ [HABIT_AI] Habit analysis: $response');

        // Сохраняем результат и показываем превью для редактирования
        if (mounted) {
          setState(() {
            _habitAnalysis = response;
            _previewSubtasks = List<Map<String, dynamic>>.from(
              response['subtasks'] as List,
            );
            _isAnalyzing = false;
            _showPreview = true;
          });
        }
      } else {
        // Анализ обычной задачи
        final response = await _taskDataSource.analyzeTask(
          _titleController.text.trim(),
        );

        log('✨ [AI] Task analysis: $response');

        // Сохраняем результат и сразу применяем
        _aiAnalysisResult = response;

        // Сразу применяем результаты
        if (mounted) {
          _applyAIResults();
        }
      }
    } catch (e) {
      log('❌ [AI] Error analyzing ${_isHabit ? "habit" : "task"}: $e');
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
          _isAnalyzed = true; // Все равно показываем форму
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка AI анализа: $e')));
      }
    }
  }

  Future<void> _saveHabitWithPreview() async {
    if (_habitAnalysis == null) return;

    setState(() => _isLoading = true);

    try {
      // Используем отредактированные задачи из превью
      final habitData = {
        'habit_name': _habitAnalysis!['group_name'],
        'group_name': _habitAnalysis!['group_name'],
        'group_icon': _habitAnalysis!['group_icon'],
        'subtasks': _previewSubtasks,
      };

      await _taskDataSource.createHabitWithSubtasks(habitData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✨ Привычка успешно создана!')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      log('❌ [HABIT] Error creating habit: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка создания привычки: $e')));
      }
    }
  }

  void _applyAIResults() {
    if (_aiAnalysisResult == null) return;

    final response = _aiAnalysisResult!;

    if (mounted) {
      setState(() {
        _isAnalyzing = false;
        _isAnalyzed = true;

        // Применяем рекомендации AI
        _priority = _parsePriority(response['priority']);
        _timeScope = _parseTimeScope(response['time_scope']);

        // Применяем is_recurring из AI анализа
        _isRecurring = response['is_recurring'] ?? false;

        // Устанавливаем цвет и иконку на основе приоритета
        _selectedColor = _getColorForPriority(_priority);
        _selectedIcon = _getIconForTask(
          _titleController.text.trim(),
          _priority,
        );

        // Предлагаемое время
        if (response['suggested_time'] != null) {
          final parts = (response['suggested_time'] as String).split(':');
          if (parts.length == 2) {
            _scheduledTime = TimeOfDay(
              hour: int.parse(parts[0]),
              minute: int.parse(parts[1]),
            );
          }
        }

        // Категория (если есть)
        if (response['category'] != null) {
          _categoryDisplayName = response['category'];
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '✨ AI рекомендует: ${_getPriorityLabel(_priority)}, ${_getTimeScopeLabel(_timeScope)}',
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  TaskPriority _parsePriority(String priority) {
    switch (priority.toLowerCase()) {
      case 'low':
        return TaskPriority.low;
      case 'medium':
        return TaskPriority.medium;
      case 'high':
        return TaskPriority.high;
      case 'urgent':
        return TaskPriority.urgent;
      default:
        return TaskPriority.medium;
    }
  }

  TimeScope _parseTimeScope(String scope) {
    switch (scope.toLowerCase()) {
      case 'daily':
        return TimeScope.daily;
      case 'weekly':
        return TimeScope.weekly;
      case 'monthly':
        return TimeScope.monthly;
      case 'long_term':
        return TimeScope.longTerm;
      default:
        return TimeScope.daily;
    }
  }

  Future<void> _createTask() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Введите название задачи')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      String? scheduledTimeStr;
      if (_scheduledTime != null) {
        scheduledTimeStr =
            '${_scheduledTime!.hour.toString().padLeft(2, '0')}:${_scheduledTime!.minute.toString().padLeft(2, '0')}';
      }

      // Для ежедневных задач ОБЯЗАТЕЛЬНО нужен due_date
      DateTime effectiveDueDate = _dueDate ?? DateTime.now();

      // Если это повторяющаяся задача и не указана дата, ставим сегодня
      if (_isRecurring && _dueDate == null) {
        effectiveDueDate = DateTime.now();
      }

      final taskData = {
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim().isNotEmpty
            ? _descriptionController.text.trim()
            : null,
        'priority': _getPriorityString(_priority),
        'time_scope': _getTimeScopeString(_timeScope),
        'due_date': effectiveDueDate.toIso8601String(),
        'scheduled_time': scheduledTimeStr,
        'status': 'pending',
        'is_recurring': _isRecurring,
        'recurrence_rule': _isRecurring ? _recurrenceRule : null,
        'category_id': _categoryId,
        'task_group_id': _groupId,
        'tags': _tags.isNotEmpty ? _tags : null,
        'color':
            '#${_selectedColor.value.toRadixString(16).substring(2).toUpperCase()}',
        'icon': _getIconName(_selectedIcon),
      };

      log('📋 [CREATE_TASK] Creating task: $taskData');

      if (mounted) {
        Navigator.of(context).pop(taskData);
      }
    } catch (e, stackTrace) {
      log('❌ [CREATE_TASK] Error: $e', error: e, stackTrace: stackTrace);
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
      }
    }
  }

  String _getPriorityString(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return 'low';
      case TaskPriority.medium:
        return 'medium';
      case TaskPriority.high:
        return 'high';
      case TaskPriority.urgent:
        return 'urgent';
    }
  }

  String _getTimeScopeString(TimeScope scope) {
    switch (scope) {
      case TimeScope.daily:
        return 'daily';
      case TimeScope.weekly:
        return 'weekly';
      case TimeScope.monthly:
        return 'monthly';
      case TimeScope.longTerm:
        return 'long_term';
    }
  }

  String _getIconName(IconData icon) {
    // Mapping icons to their names
    if (icon == Ionicons.checkbox_outline) return 'checkbox_outline';
    if (icon == Ionicons.briefcase_outline) return 'briefcase_outline';
    if (icon == Ionicons.fitness_outline) return 'fitness_outline';
    if (icon == Ionicons.book_outline) return 'book_outline';
    if (icon == Ionicons.restaurant_outline) return 'restaurant_outline';
    if (icon == Ionicons.water_outline) return 'water_outline';
    if (icon == Ionicons.bed_outline) return 'bed_outline';
    if (icon == Ionicons.pencil_outline) return 'pencil_outline';
    if (icon == Ionicons.cart_outline) return 'cart_outline';
    if (icon == Ionicons.call_outline) return 'call_outline';
    if (icon == Ionicons.sparkles_outline) return 'sparkles_outline';
    if (icon == Ionicons.flash_outline) return 'flash_outline';
    if (icon == Ionicons.alert_circle_outline) return 'alert_circle_outline';
    if (icon == Ionicons.ellipse_outline) return 'ellipse_outline';
    return 'checkbox_outline'; // default
  }

  Color _getColorForPriority(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.urgent:
        return const Color(0xFFEF4444); // Red
      case TaskPriority.high:
        return const Color(0xFFF97316); // Orange
      case TaskPriority.medium:
        return const Color(0xFFE91E63); // Magenta
      case TaskPriority.low:
        return const Color(0xFF8B5CF6); // Purple
    }
  }

  IconData _getIconForTask(String title, TaskPriority priority) {
    final titleLower = title.toLowerCase();

    // Определяем иконку по ключевым словам
    if (titleLower.contains('постель') ||
        titleLower.contains('кровать') ||
        titleLower.contains('сон')) {
      return Ionicons.bed_outline;
    } else if (titleLower.contains('зуб') || titleLower.contains('чист')) {
      return Ionicons.sparkles_outline;
    } else if (titleLower.contains('работ') || titleLower.contains('офис')) {
      return Ionicons.briefcase_outline;
    } else if (titleLower.contains('спорт') ||
        titleLower.contains('трениров') ||
        titleLower.contains('зал')) {
      return Ionicons.fitness_outline;
    } else if (titleLower.contains('еда') ||
        titleLower.contains('завтрак') ||
        titleLower.contains('обед') ||
        titleLower.contains('ужин')) {
      return Ionicons.restaurant_outline;
    } else if (titleLower.contains('вода') || titleLower.contains('пить')) {
      return Ionicons.water_outline;
    } else if (titleLower.contains('чита') || titleLower.contains('книг')) {
      return Ionicons.book_outline;
    } else if (titleLower.contains('звон') || titleLower.contains('позвон')) {
      return Ionicons.call_outline;
    } else if (titleLower.contains('магазин') || titleLower.contains('покуп')) {
      return Ionicons.cart_outline;
    } else if (titleLower.contains('душ')) {
      return Ionicons.water_outline;
    }

    // По умолчанию - иконка в зависимости от приоритета
    switch (priority) {
      case TaskPriority.urgent:
        return Ionicons.flash_outline;
      case TaskPriority.high:
        return Ionicons.alert_circle_outline;
      case TaskPriority.medium:
        return Ionicons.checkbox_outline;
      case TaskPriority.low:
        return Ionicons.ellipse_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Расфокус при тапе вне инпута
        _titleFocusNode.unfocus();
        FocusScope.of(context).unfocus();
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: AppTheme.whiteColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Дрэг-индикатор
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.darkColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppTheme.lightGrayColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Ionicons.close,
                        color: AppTheme.darkColor,
                        size: 20,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (_showPreview)
                    Text(
                      'Предпросмотр',
                      style: TextStyle(
                        color: AppTheme.darkColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const Spacer(),
                  if (_showPreview)
                    GestureDetector(
                      onTap: _isLoading ? () {} : _saveHabitWithPreview,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: _isLoading
                              ? AppTheme.lightGrayColor
                              : AppTheme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Ionicons.checkmark,
                          color: _isLoading
                              ? AppTheme.darkColor.withOpacity(0.38)
                              : AppTheme.whiteColor,
                          size: 20,
                        ),
                      ),
                    )
                  else if (_isAnalyzed)
                    GestureDetector(
                      onTap: _isLoading ? () {} : _createTask,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: _isLoading
                              ? AppTheme.lightGrayColor
                              : AppTheme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Ionicons.checkmark,
                          color: _isLoading
                              ? AppTheme.darkColor.withOpacity(0.38)
                              : AppTheme.whiteColor,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Контент с автоматической прокруткой
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.only(
                  left: 20,
                  top: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom > 0
                      ? MediaQuery.of(context).viewInsets.bottom + 100
                      : 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_showPreview) ...[
                      // ЭТАП ПРЕВЬЮ: Показываем задачи привычки для редактирования
                      _buildHabitPreview(),
                    ] else if (!_isAnalyzed) ...[
                      // ЭТАП 1: Только название и AI анализ
                      _buildInitialStage(),
                    ] else ...[
                      // ЭТАП 2: Полная форма после AI анализа
                      _buildPreviewCard(),

                      const SizedBox(height: 32),

                      // Appearance Section
                      _buildSectionHeader('Внешний вид'),
                      const SizedBox(height: 12),
                      _buildAppearanceSection(),

                      const SizedBox(height: 32),

                      // General Section
                      _buildSectionHeader('Общее'),
                      const SizedBox(height: 12),
                      _buildGeneralSection(),

                      const SizedBox(height: 32),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialStage() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: _isAnalyzing
          ? Center(
              key: const ValueKey('analyzing'),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: const AIAnalysisProgress(),
              ),
            )
          : Column(
              key: const ValueKey('input'),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Заголовок
                Text(
                  _isHabit
                      ? 'Какую привычку хотите сформировать?'
                      : 'Что нужно сделать?',
                  style: const TextStyle(
                    color: AppTheme.darkColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _isHabit
                      ? 'AI разобьет привычку на ежедневные шаги'
                      : 'AI поможет определить приоритет и время выполнения',
                  style: TextStyle(
                    color: AppTheme.darkColor.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 24),

                // Переключатель типа: Задача/Привычка
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.lightGrayColor,
                    borderRadius: BorderRadius.circular(12),
                    // Без границ для glassmorphism
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isHabit = false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: !_isHabit
                                  ? AppTheme.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Ionicons.checkbox_outline,
                                  color: !_isHabit
                                      ? AppTheme.whiteColor
                                      : AppTheme.darkColor,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Задача',
                                  style: TextStyle(
                                    color: !_isHabit
                                        ? AppTheme.whiteColor
                                        : AppTheme.darkColor,
                                    fontSize: 14,
                                    fontWeight: !_isHabit
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isHabit = true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _isHabit
                                  ? AppTheme.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Ionicons.sparkles,
                                  color: _isHabit
                                      ? AppTheme.whiteColor
                                      : AppTheme.darkColor,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Привычка',
                                  style: TextStyle(
                                    color: _isHabit
                                        ? AppTheme.whiteColor
                                        : AppTheme.darkColor,
                                    fontSize: 14,
                                    fontWeight: _isHabit
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Поле ввода и кнопка AI в одном ряду
                SizedBox(
                  height: 56,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          key: _inputKey,
                          decoration: BoxDecoration(
                            color: AppTheme.lightGrayColor,
                            borderRadius: BorderRadius.circular(16),
                            // Без границ для glassmorphism
                          ),
                          child: Center(
                            child: TextField(
                              controller: _titleController,
                              focusNode: _titleFocusNode,
                              autofocus: false,
                              style: const TextStyle(
                                color: AppTheme.darkColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: _isHabit
                                    ? 'Например: Бросить курить, Начать бегать...'
                                    : 'Например: Почистить зубы, Посмотреть фильм...',
                                hintStyle: TextStyle(
                                  color: AppTheme.darkColor.withOpacity(0.3),
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Кнопка AI анализа
                      GestureDetector(
                        onTap: _analyzeWithAI,
                        child: Container(
                          width: 56,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Ionicons.sparkles,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Информация для привычек
                if (_isHabit) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.primaryColor.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Ionicons.sparkles,
                          color: AppTheme.primaryColor,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'AI автоматически определит оптимальное количество задач',
                            style: TextStyle(
                              color: AppTheme.darkColor.withOpacity(0.8),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Кнопка пропустить AI
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isAnalyzed = true;
                    });
                  },
                  child: Text(
                    'Пропустить и заполнить вручную',
                    style: TextStyle(
                      color: AppTheme.darkColor.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        color: AppTheme.darkColor.withOpacity(0.5),
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildPreviewCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _selectedColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _selectedColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(_selectedIcon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  _getTimeScopeLabel(_timeScope),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Ionicons.checkmark, color: _selectedColor, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildAppearanceSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightGrayColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Title input
          _buildSettingTile(
            icon: Ionicons.text_outline,
            iconColor: AppTheme.primaryColor,
            title: 'Название',
            trailing: Expanded(
              child: TextField(
                controller: _titleController,
                style: const TextStyle(color: AppTheme.darkColor, fontSize: 15),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите название',
                  hintStyle: TextStyle(
                    color: AppTheme.darkColor.withOpacity(0.38),
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            onTap: null,
          ),

          Divider(height: 1, color: AppTheme.darkColor.withOpacity(0.1)),

          // Color picker
          _buildSettingTile(
            icon: Ionicons.color_palette_outline,
            iconColor: Colors.red,
            title: 'Цвет',
            trailing: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: _selectedColor,
                shape: BoxShape.circle,
              ),
            ),
            onTap: _showColorPicker,
          ),

          Divider(height: 1, color: AppTheme.darkColor.withOpacity(0.1)),

          // Icon picker
          _buildSettingTile(
            icon: Ionicons.happy_outline,
            iconColor: Colors.orange,
            title: 'Иконка',
            trailing: Icon(
              _selectedIcon,
              color: AppTheme.darkColor.withOpacity(0.7),
              size: 20,
            ),
            onTap: _showIconPicker,
          ),

          Divider(height: 1, color: AppTheme.darkColor.withOpacity(0.1)),

          // Description
          _buildSettingTile(
            icon: Ionicons.document_text_outline,
            iconColor: Colors.amber,
            title: 'Описание',
            trailing: Text(
              _descriptionController.text.isEmpty
                  ? 'Пусто'
                  : _descriptionController.text,
              style: TextStyle(
                color: AppTheme.darkColor.withOpacity(0.5),
                fontSize: 15,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: _showDescriptionDialog,
          ),

          Divider(height: 1, color: AppTheme.darkColor.withOpacity(0.1)),

          // Tags
          _buildSettingTile(
            icon: Ionicons.pricetag_outline,
            iconColor: Colors.pink,
            title: 'Теги',
            trailing: Text(
              _tags.isEmpty
                  ? 'Нет тегов'
                  : _tags.length == 1
                  ? _tags[0]
                  : '${_tags.length} тегов',
              style: TextStyle(
                color: AppTheme.darkColor.withOpacity(0.5),
                fontSize: 15,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: _showTagsDialog,
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightGrayColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Priority
          _buildSettingTile(
            icon: Ionicons.flag_outline,
            iconColor: Colors.blue,
            title: 'Приоритет',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getPriorityColor(_priority).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _getPriorityLabel(_priority),
                style: TextStyle(
                  color: _getPriorityColor(_priority),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            onTap: _showPriorityPicker,
          ),

          Divider(height: 1, color: AppTheme.darkColor.withOpacity(0.1)),

          // Category
          _buildSettingTile(
            icon: Ionicons.folder_outline,
            iconColor: Colors.blue,
            title: 'Категория',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_categoryIcon != null)
                  Text(_categoryIcon!, style: const TextStyle(fontSize: 16)),
                if (_categoryIcon != null) const SizedBox(width: 8),
                Text(
                  _categoryDisplayName ?? 'Не выбрана',
                  style: TextStyle(
                    color: AppTheme.darkColor.withOpacity(0.5),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            onTap: _selectCategory,
          ),

          Divider(height: 1, color: AppTheme.darkColor.withOpacity(0.1)),

          // Group
          _buildSettingTile(
            icon: Ionicons.albums_outline,
            iconColor: Colors.teal,
            title: 'Группа',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_groupIcon != null)
                  Text(_groupIcon!, style: const TextStyle(fontSize: 16)),
                if (_groupIcon != null) const SizedBox(width: 8),
                Text(
                  _groupName ?? 'Не выбрана',
                  style: TextStyle(
                    color: AppTheme.darkColor.withOpacity(0.5),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            onTap: _selectGroup,
          ),

          Divider(height: 1, color: AppTheme.darkColor.withOpacity(0.1)),

          // Time Scope
          _buildSettingTile(
            icon: Ionicons.time_outline,
            iconColor: Colors.purple,
            title: 'Временной масштаб',
            trailing: Text(
              _getTimeScopeLabel(_timeScope),
              style: TextStyle(
                color: AppTheme.darkColor.withOpacity(0.5),
                fontSize: 15,
              ),
            ),
            onTap: _showTimeScopePicker,
          ),

          Divider(height: 1, color: AppTheme.darkColor.withOpacity(0.1)),

          // Scheduled Time
          _buildSettingTile(
            icon: Ionicons.alarm_outline,
            iconColor: Colors.green,
            title: 'Время выполнения',
            trailing: Text(
              _scheduledTime != null
                  ? _scheduledTime!.format(context)
                  : 'Не указано',
              style: TextStyle(
                color: AppTheme.darkColor.withOpacity(0.5),
                fontSize: 15,
              ),
            ),
            onTap: _pickScheduledTime,
          ),

          Divider(height: 1, color: AppTheme.darkColor.withOpacity(0.1)),

          // Due Date
          _buildSettingTile(
            icon: Ionicons.calendar_outline,
            iconColor: Colors.orange,
            title: 'Дата',
            trailing: Text(
              _dueDate != null
                  ? '${_dueDate!.day}.${_dueDate!.month}.${_dueDate!.year}'
                  : _timeScope == TimeScope.daily
                  ? 'Сегодня'
                  : 'Не указана',
              style: TextStyle(
                color: AppTheme.darkColor.withOpacity(0.5),
                fontSize: 15,
              ),
            ),
            onTap: _pickDueDate,
          ),

          Divider(height: 1, color: AppTheme.darkColor.withOpacity(0.1)),

          // Repeat
          _buildSettingTile(
            icon: Ionicons.repeat_outline,
            iconColor: Colors.cyan,
            title: 'Повторение',
            trailing: Text(
              _isRecurring ? _getRecurrenceLabel(_recurrenceRule) : 'Нет',
              style: TextStyle(
                color: AppTheme.darkColor.withOpacity(0.5),
                fontSize: 15,
              ),
            ),
            onTap: _showRecurrencePicker,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Widget trailing,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppTheme.darkColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            trailing is Expanded
                ? trailing
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      trailing,
                      if (onTap != null) ...[
                        const SizedBox(width: 8),
                        Icon(
                          Ionicons.chevron_forward,
                          color: AppTheme.darkColor.withOpacity(0.3),
                          size: 16,
                        ),
                      ],
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  void _showColorPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppTheme.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Выберите цвет',
              style: TextStyle(
                color: AppTheme.darkColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _availableColors.map((color) {
                final isSelected = color == _selectedColor;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = color;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Colors.white, width: 3)
                          : null,
                    ),
                    child: isSelected
                        ? const Icon(
                            Ionicons.checkmark,
                            color: AppTheme.whiteColor,
                            size: 28,
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showIconPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppTheme.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Выберите иконку',
              style: TextStyle(
                color: AppTheme.darkColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _availableIcons.map((icon) {
                final isSelected = icon == _selectedIcon;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIcon = icon;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? _selectedColor
                          : Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: AppTheme.whiteColor, size: 28),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showDescriptionDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1C1C1E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Описание',
                style: TextStyle(
                  color: AppTheme.darkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                style: const TextStyle(color: AppTheme.darkColor),
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Добавьте описание...',
                  hintStyle: TextStyle(
                    color: AppTheme.darkColor.withOpacity(0.38),
                  ),
                  filled: true,
                  fillColor: AppTheme.lightGrayColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) => setState(() {}),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Готово',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPriorityPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppTheme.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Приоритет',
              style: TextStyle(
                color: AppTheme.darkColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...TaskPriority.values.map((priority) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _getPriorityColor(priority).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Ionicons.flag,
                    color: _getPriorityColor(priority),
                    size: 18,
                  ),
                ),
                title: Text(
                  _getPriorityLabel(priority),
                  style: const TextStyle(
                    color: AppTheme.darkColor,
                    fontSize: 16,
                  ),
                ),
                trailing: _priority == priority
                    ? Icon(
                        Ionicons.checkmark_circle,
                        color: AppTheme.primaryColor,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    _priority = priority;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showTimeScopePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppTheme.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Временной масштаб',
              style: TextStyle(
                color: AppTheme.darkColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...TimeScope.values.map((scope) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  _getTimeScopeLabel(scope),
                  style: const TextStyle(
                    color: AppTheme.darkColor,
                    fontSize: 16,
                  ),
                ),
                trailing: _timeScope == scope
                    ? Icon(
                        Ionicons.checkmark_circle,
                        color: AppTheme.primaryColor,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    _timeScope = scope;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Future<void> _pickScheduledTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _scheduledTime ?? const TimeOfDay(hour: 9, minute: 0),
    );
    if (time != null) {
      setState(() {
        _scheduledTime = time;
      });
    }
  }

  Future<void> _pickDueDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        _dueDate = date;
      });
    }
  }

  void _showRecurrencePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppTheme.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Повторение',
              style: TextStyle(
                color: AppTheme.darkColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Нет',
                style: TextStyle(color: AppTheme.darkColor, fontSize: 16),
              ),
              trailing: !_isRecurring
                  ? Icon(
                      Ionicons.checkmark_circle,
                      color: AppTheme.primaryColor,
                    )
                  : null,
              onTap: () {
                setState(() {
                  _isRecurring = false;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Ежедневно',
                style: TextStyle(color: AppTheme.darkColor, fontSize: 16),
              ),
              trailing: _isRecurring && _recurrenceRule == 'FREQ=DAILY'
                  ? Icon(
                      Ionicons.checkmark_circle,
                      color: AppTheme.primaryColor,
                    )
                  : null,
              onTap: () {
                setState(() {
                  _isRecurring = true;
                  _recurrenceRule = 'FREQ=DAILY';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'По будням',
                style: TextStyle(color: AppTheme.darkColor, fontSize: 16),
              ),
              trailing:
                  _isRecurring &&
                      _recurrenceRule == 'FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR'
                  ? Icon(
                      Ionicons.checkmark_circle,
                      color: AppTheme.primaryColor,
                    )
                  : null,
              onTap: () {
                setState(() {
                  _isRecurring = true;
                  _recurrenceRule = 'FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Еженедельно',
                style: TextStyle(color: AppTheme.darkColor, fontSize: 16),
              ),
              trailing: _isRecurring && _recurrenceRule == 'FREQ=WEEKLY'
                  ? Icon(
                      Ionicons.checkmark_circle,
                      color: AppTheme.primaryColor,
                    )
                  : null,
              onTap: () {
                setState(() {
                  _isRecurring = true;
                  _recurrenceRule = 'FREQ=WEEKLY';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Ежемесячно',
                style: TextStyle(color: AppTheme.darkColor, fontSize: 16),
              ),
              trailing: _isRecurring && _recurrenceRule == 'FREQ=MONTHLY'
                  ? Icon(
                      Ionicons.checkmark_circle,
                      color: AppTheme.primaryColor,
                    )
                  : null,
              onTap: () {
                setState(() {
                  _isRecurring = true;
                  _recurrenceRule = 'FREQ=MONTHLY';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getPriorityLabel(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return 'Низкий';
      case TaskPriority.medium:
        return 'Средний';
      case TaskPriority.high:
        return 'Высокий';
      case TaskPriority.urgent:
        return 'Срочно';
    }
  }

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return Colors.grey;
      case TaskPriority.medium:
        return Colors.blue;
      case TaskPriority.high:
        return Colors.orange;
      case TaskPriority.urgent:
        return Colors.red;
    }
  }

  String _getTimeScopeLabel(TimeScope scope) {
    switch (scope) {
      case TimeScope.daily:
        return 'Каждый день';
      case TimeScope.weekly:
        return 'Каждую неделю';
      case TimeScope.monthly:
        return 'Каждый месяц';
      case TimeScope.longTerm:
        return 'Долгосрочно';
    }
  }

  String _getRecurrenceLabel(String rule) {
    if (rule == 'FREQ=DAILY') return 'Ежедневно';
    if (rule == 'FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR') return 'По будням';
    if (rule == 'FREQ=WEEKLY') return 'Еженедельно';
    if (rule == 'FREQ=MONTHLY') return 'Ежемесячно';
    return rule;
  }

  Future<void> _selectCategory() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            SelectCategoryPage(selectedCategoryId: _categoryId),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _categoryId = result['id'];
        _categoryDisplayName = result['display_name'];
        _categoryIcon = result['icon'];
      });
    }
  }

  Future<void> _selectGroup() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SelectTaskGroupPage(selectedGroupId: _groupId),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _groupId = result['id'];
        _groupName = result['name'];
        _groupIcon = result['icon'];
      });
    }
  }

  void _showTagsDialog() {
    final tagController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1C1C1E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Теги',
                  style: TextStyle(
                    color: AppTheme.darkColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Текущие теги
                if (_tags.isNotEmpty) ...[
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _selectedColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              tag,
                              style: TextStyle(
                                color: _selectedColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _tags.remove(tag);
                                });
                                setModalState(() {});
                              },
                              child: Icon(
                                Ionicons.close_circle,
                                color: _selectedColor,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],

                // Поле ввода нового тега
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: tagController,
                        style: const TextStyle(color: AppTheme.darkColor),
                        decoration: InputDecoration(
                          hintText: 'Добавить тег...',
                          hintStyle: TextStyle(
                            color: AppTheme.darkColor.withOpacity(0.38),
                          ),
                          filled: true,
                          fillColor: AppTheme.lightGrayColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(
                            Ionicons.pricetag_outline,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        onSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            setState(() {
                              if (!_tags.contains(value.trim())) {
                                _tags.add(value.trim());
                              }
                            });
                            setModalState(() {});
                            tagController.clear();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Ionicons.add,
                          color: AppTheme.whiteColor,
                        ),
                        onPressed: () {
                          if (tagController.text.trim().isNotEmpty) {
                            setState(() {
                              if (!_tags.contains(tagController.text.trim())) {
                                _tags.add(tagController.text.trim());
                              }
                            });
                            setModalState(() {});
                            tagController.clear();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Готово',
                      style: TextStyle(
                        color: AppTheme.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHabitPreview() {
    if (_habitAnalysis == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Заголовок привычки
        Row(
          children: [
            Text(
              _habitAnalysis!['group_icon'] ?? '🎯',
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _habitAnalysis!['group_name'] ?? 'Привычка',
                style: const TextStyle(
                  color: AppTheme.darkColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Text(
          'Задачи (${_previewSubtasks.length})',
          style: const TextStyle(
            color: AppTheme.darkColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 16),

        // Список задач
        ...List.generate(_previewSubtasks.length, (index) {
          final task = _previewSubtasks[index];
          return _buildSubtaskPreviewCard(task, index);
        }),

        const SizedBox(height: 16),

        // Кнопка добавить задачу
        GestureDetector(
          onTap: _addNewSubtask,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: AppTheme.lightGrayColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.primaryColor.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Ionicons.add_circle_outline,
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Добавить задачу',
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildSubtaskPreviewCard(Map<String, dynamic> task, int index) {
    final color = _parseColor(task['color'] as String?);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.lightGrayColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Иконка с цветом
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _parseIcon(task['icon'] as String?),
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              // Название и время
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task['title'] ?? 'Без названия',
                      style: const TextStyle(
                        color: AppTheme.darkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (task['suggested_time'] != null)
                      Text(
                        '🕐 ${task['suggested_time']}',
                        style: TextStyle(
                          color: AppTheme.darkColor.withOpacity(0.6),
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
              ),
              // Кнопки действий
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _editSubtask(index),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Ionicons.create_outline,
                        color: AppTheme.primaryColor,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _removeSubtask(index),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Ionicons.trash_outline,
                        color: Colors.red,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (task['description'] != null &&
              (task['description'] as String).isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              task['description'],
              style: TextStyle(
                color: AppTheme.darkColor.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ],
          
          // Вложенные сабтаски
          if (task['subtasks'] != null && (task['subtasks'] as List).isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.whiteColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: color.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Шаги:',
                    style: TextStyle(
                      color: AppTheme.darkColor.withOpacity(0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...(task['subtasks'] as List).asMap().entries.map((entry) {
                    final stepIndex = entry.key;
                    final stepTitle = entry.value as String;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${stepIndex + 1}',
                                style: TextStyle(
                                  color: color,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              stepTitle,
                              style: TextStyle(
                                color: AppTheme.darkColor.withOpacity(0.8),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
          
          // Приоритет
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getPriorityColorFromString(task['priority'] as String?),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              _getPriorityLabelFromString(
                task['priority'] as String? ?? 'medium',
              ),
              style: const TextStyle(
                color: AppTheme.whiteColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _parseColor(String? colorString) {
    if (colorString == null) return AppTheme.primaryColor;
    try {
      return Color(int.parse(colorString.replaceFirst('#', '0xFF')));
    } catch (e) {
      return AppTheme.primaryColor;
    }
  }

  IconData _parseIcon(String? iconString) {
    if (iconString == null) return Ionicons.checkbox_outline;
    // Простой парсинг - можно расширить
    if (iconString.contains('water')) return Ionicons.water_outline;
    if (iconString.contains('medical')) return Ionicons.medical_outline;
    if (iconString.contains('leaf')) return Ionicons.leaf_outline;
    if (iconString.contains('walk')) return Ionicons.walk_outline;
    if (iconString.contains('create')) return Ionicons.create_outline;
    if (iconString.contains('body')) return Ionicons.body_outline;
    if (iconString.contains('fitness')) return Ionicons.fitness_outline;
    return Ionicons.checkbox_outline;
  }

  Color _getPriorityColorFromString(String? priority) {
    switch (priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getPriorityLabelFromString(String priority) {
    switch (priority) {
      case 'high':
        return 'Высокий';
      case 'medium':
        return 'Средний';
      case 'low':
        return 'Низкий';
      default:
        return 'Средний';
    }
  }

  void _removeSubtask(int index) {
    setState(() {
      _previewSubtasks.removeAt(index);
    });
  }

  void _editSubtask(int index) {
    final task = _previewSubtasks[index];
    _showEditSubtaskDialog(task, index);
  }

  void _addNewSubtask() {
    final newTask = {
      'title': '',
      'description': '',
      'priority': 'medium',
      'suggested_time': '09:00',
      'color': '#3B82F6',
      'icon': 'Ionicons.checkbox_outline',
      'is_recurring': true,
    };
    _showEditSubtaskDialog(newTask, null);
  }

  void _showEditSubtaskDialog(Map<String, dynamic> task, int? index) {
    final titleController = TextEditingController(text: task['title'] ?? '');
    final descriptionController = TextEditingController(
      text: task['description'] ?? '',
    );
    String selectedPriority = task['priority'] ?? 'medium';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: AppTheme.whiteColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              // Заголовок
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(
                      index == null ? 'Новая задача' : 'Редактировать задачу',
                      style: const TextStyle(
                        color: AppTheme.darkColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppTheme.lightGrayColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Ionicons.close,
                          color: AppTheme.darkColor,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Название
                      const Text(
                        'Название',
                        style: TextStyle(
                          color: AppTheme.darkColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: titleController,
                        style: const TextStyle(color: AppTheme.darkColor),
                        decoration: InputDecoration(
                          hintText: 'Введите название',
                          hintStyle: TextStyle(
                            color: AppTheme.darkColor.withOpacity(0.38),
                          ),
                          filled: true,
                          fillColor: AppTheme.lightGrayColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Описание
                      const Text(
                        'Описание',
                        style: TextStyle(
                          color: AppTheme.darkColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: descriptionController,
                        style: const TextStyle(color: AppTheme.darkColor),
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Введите описание',
                          hintStyle: TextStyle(
                            color: AppTheme.darkColor.withOpacity(0.38),
                          ),
                          filled: true,
                          fillColor: AppTheme.lightGrayColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Приоритет
                      const Text(
                        'Приоритет',
                        style: TextStyle(
                          color: AppTheme.darkColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: ['low', 'medium', 'high'].map((priority) {
                          final isSelected = selectedPriority == priority;
                          return GestureDetector(
                            onTap: () {
                              setModalState(() {
                                selectedPriority = priority;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppTheme.primaryColor
                                    : AppTheme.lightGrayColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _getPriorityLabelFromString(priority),
                                style: TextStyle(
                                  color: isSelected
                                      ? AppTheme.whiteColor
                                      : AppTheme.darkColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),

              // Кнопка сохранить
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      final updatedTask = {
                        ...task,
                        'title': titleController.text,
                        'description': descriptionController.text,
                        'priority': selectedPriority,
                      };

                      setState(() {
                        if (index == null) {
                          _previewSubtasks.add(updatedTask);
                        } else {
                          _previewSubtasks[index] = updatedTask;
                        }
                      });

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Сохранить',
                      style: TextStyle(
                        color: AppTheme.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
