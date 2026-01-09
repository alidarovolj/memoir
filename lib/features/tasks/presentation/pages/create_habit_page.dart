import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/glass_button.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:memoir/features/tasks/presentation/widgets/ai_analysis_progress.dart';
import 'dart:developer';

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({super.key});

  @override
  State<CreateHabitPage> createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  final TextEditingController _titleController = TextEditingController();
  final TaskRemoteDataSourceImpl _taskDataSource;

  bool _isAnalyzing = false;
  bool _isAnalyzed = false;
  bool _isCreating = false;

  // AI результаты
  String? _groupName;
  String? _groupIcon;
  List<Map<String, dynamic>> _subtasks = [];
  Map<String, dynamic>? _aiAnalysisResult;

  _CreateHabitPageState()
      : _taskDataSource = TaskRemoteDataSourceImpl(
          dio: DioClient.instance,
        );

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _analyzeWithAI() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите название привычки')),
      );
      return;
    }

    setState(() {
      _isAnalyzing = true;
    });

    try {
      final response = await _taskDataSource.analyzeHabit(
        _titleController.text.trim(),
      );

      log('✨ [HABIT_AI] Analysis: $response');

      _aiAnalysisResult = response;

      // Сразу применяем результаты
      if (mounted) {
        _applyAIResults();
      }
    } catch (e) {
      log('❌ [HABIT_AI] Error: $e');
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
          _isAnalyzed = true; // Показываем форму даже при ошибке
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка AI анализа: $e')),
        );
      }
    }
  }

  void _applyAIResults() {
    if (_aiAnalysisResult == null) return;

    setState(() {
      _isAnalyzing = false; // Завершаем анализ
      _isAnalyzed = true;
      _groupName = _aiAnalysisResult!['group_name'];
      _groupIcon = _aiAnalysisResult!['group_icon'];
      _subtasks = List<Map<String, dynamic>>.from(
        _aiAnalysisResult!['subtasks'] ?? [],
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '✨ AI создал ${_subtasks.length} подзадач для привычки',
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _createHabit() async {
    if (_groupName == null || _subtasks.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Необходимо название группы и подзадачи'),
        ),
      );
      return;
    }

    setState(() {
      _isCreating = true;
    });

    try {
      final habitData = {
        'habit_name': _groupName,
        'group_icon': _groupIcon ?? '🎯',
        'subtasks': _subtasks,
      };

      final response = await _taskDataSource.createHabitWithSubtasks(habitData);

      log('✅ [HABIT] Created: $response');

      if (mounted) {
        Navigator.of(context).pop(true); // Возвращаем true для обновления списка
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '✅ Привычка создана с ${response['subtasks_created']} подзадачами',
            ),
          ),
        );
      }
    } catch (e) {
      log('❌ [HABIT] Error creating: $e');
      if (mounted) {
        setState(() {
          _isCreating = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при создании: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: AppTheme.pageBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _isAnalyzed ? 'Настройка привычки' : 'Новая привычка',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GlassButton(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Ionicons.close, color: Colors.white, size: 20),
                ),
              ],
            ),
          ),

          // Divider
          Container(height: 1, color: Colors.white.withOpacity(0.1)),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_isAnalyzing) ...[
                    // AI Analysis Progress
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 60),
                        child: const AIAnalysisProgress(),
                      ),
                    ),
                  ] else if (!_isAnalyzed) ...[
                    // Initial Stage: Title input
                    _buildInitialStage(),
                  ] else ...[
                    // Stage 2: Edit subtasks
                    _buildSubtasksEditor(),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialStage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          // Title
          const Text(
            'Какую привычку хотите развить?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'AI создаст группу ежедневных подзадач для достижения цели',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 32),

          // Input field
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.primaryColor.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: TextField(
              controller: _titleController,
              autofocus: true,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Например: Бросить курить, Начать бегать...',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.3),
                  fontSize: 16,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(24),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Analyze button
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: _analyzeWithAI,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Ionicons.sparkles, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Создать с помощью AI',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Examples
          _buildExamplesSection(),
        ],
    );
  }

  Widget _buildExamplesSection() {
    final examples = [
      {'icon': '🚭', 'title': 'Бросить курить'},
      {'icon': '🏃', 'title': 'Начать бегать'},
      {'icon': '⚖️', 'title': 'Похудеть'},
      {'icon': '📚', 'title': 'Выучить английский'},
      {'icon': '💪', 'title': 'Набрать массу'},
      {'icon': '🧘', 'title': 'Медитировать каждый день'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Примеры привычек',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: examples.map((example) {
            return GestureDetector(
              onTap: () {
                _titleController.text = example['title']!;
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      example['icon']!,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      example['title']!,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSubtasksEditor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group info
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryColor.withOpacity(0.2),
                AppTheme.primaryColor.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppTheme.primaryColor.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _groupIcon ?? '🎯',
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _groupName ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_subtasks.length} ежедневных задач',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Subtasks list
        Text(
          'Подзадачи',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        ..._subtasks.asMap().entries.map((entry) {
          final index = entry.key;
          final subtask = entry.value;
          return _buildSubtaskCard(subtask, index);
        }).toList(),

        const SizedBox(height: 32),

        // Create button
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: _isCreating ? null : _createHabit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: _isCreating
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'Создать привычку',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubtaskCard(Map<String, dynamic> subtask, int index) {
    final color = subtask['color'] != null
        ? Color(int.parse(subtask['color'].substring(1, 7), radix: 16) + 0xFF000000)
        : AppTheme.primaryColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                _getIconData(subtask['icon']),
                color: Colors.white,
                size: 20,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtask['title'] ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtask['description'] != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtask['description'],
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                if (subtask['suggested_time'] != null) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Ionicons.time_outline,
                        size: 14,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        subtask['suggested_time'],
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (subtask['is_recurring'] == true)
                        Row(
                          children: [
                            Icon(
                              Ionicons.repeat_outline,
                              size: 14,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Ежедневно',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String? iconName) {
    if (iconName == null) return Ionicons.checkbox_outline;

    switch (iconName) {
      case 'Ionicons.water_outline':
        return Ionicons.water_outline;
      case 'Ionicons.fitness_outline':
        return Ionicons.fitness_outline;
      case 'Ionicons.restaurant_outline':
        return Ionicons.restaurant_outline;
      case 'Ionicons.book_outline':
        return Ionicons.book_outline;
      case 'Ionicons.walk_outline':
        return Ionicons.walk_outline;
      case 'Ionicons.leaf_outline':
        return Ionicons.leaf_outline;
      case 'Ionicons.medical_outline':
        return Ionicons.medical_outline;
      case 'Ionicons.heart_outline':
        return Ionicons.heart_outline;
      case 'Ionicons.sparkles_outline':
        return Ionicons.sparkles_outline;
      case 'Ionicons.body_outline':
        return Ionicons.body_outline;
      case 'Ionicons.language_outline':
        return Ionicons.language_outline;
      case 'Ionicons.play_outline':
        return Ionicons.play_outline;
      case 'Ionicons.create_outline':
        return Ionicons.create_outline;
      case 'Ionicons.close_circle_outline':
        return Ionicons.close_circle_outline;
      case 'Ionicons.bed_outline':
        return Ionicons.bed_outline;
      default:
        return Ionicons.checkbox_outline;
    }
  }
}
