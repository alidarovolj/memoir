import 'package:flutter/material.dart';
import 'package:memoir/features/tasks/data/models/task_model.dart';
import 'package:memoir/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:memoir/core/widgets/widgets.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:async';
import 'dart:developer';

class CreateTaskPage extends StatefulWidget {
  final TimeScope initialTimeScope;

  const CreateTaskPage({
    super.key,
    this.initialTimeScope = TimeScope.daily,
  });

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late TaskRemoteDataSource _taskDataSource;

  TaskPriority _priority = TaskPriority.medium;
  late TimeScope _timeScope;
  DateTime? _dueDate;
  bool _isLoading = false;
  bool _isAnalyzing = false;
  bool _showAdvancedFields = false;
  String? _aiReasoning;

  @override
  void initState() {
    super.initState();
    _timeScope = widget.initialTimeScope;
    _taskDataSource = TaskRemoteDataSourceImpl(dio: DioClient.instance);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _analyzeTaskWithAI() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      // Show error
      return;
    }

    setState(() => _isAnalyzing = true);

    try {
      final result = await _taskDataSource.analyzeTask(title);
      
      if (mounted) {
        setState(() {
          // Map strings to enums
          _timeScope = _parseTimeScope(result['time_scope']);
          _priority = _parsePriority(result['priority']);
          _aiReasoning = result['reasoning'];
          _isAnalyzing = false;
          _showAdvancedFields = true; // Show all fields after AI analysis
        });

        log('✨ [AI] Task analyzed: time_scope=${result['time_scope']}, priority=${result['priority']}');
      }
    } catch (e) {
      log('❌ [AI] Error analyzing task: $e');
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
          _showAdvancedFields = true; // Show fields even on error
        });
      }
    }
  }

  TimeScope _parseTimeScope(String scope) {
    switch (scope) {
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

  TaskPriority _parsePriority(String priority) {
    switch (priority) {
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

  Future<void> _selectDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppTheme.primaryColor,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  Future<void> _createTask() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final taskData = {
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'priority': _getPriorityString(_priority),
        'time_scope': _getTimeScopeString(_timeScope),
        'due_date': _dueDate?.toIso8601String(),
        'status': 'pending',
      };

      log('📋 [CREATE_TASK] Creating task: $taskData');

      // Return data to parent
      if (mounted) {
        Navigator.of(context).pop(taskData);
      }
    } catch (e, stackTrace) {
      log('❌ [CREATE_TASK] Error: $e', error: e, stackTrace: stackTrace);
      if (mounted) {
        setState(() => _isLoading = false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: 'Новая задача',
        leading: IconButton(
          icon: const Icon(Ionicons.close_outline),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.lightBackgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title input with AI button
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Название задачи',
                      hintText: 'Что нужно сделать?',
                      prefixIcon: const Icon(Ionicons.checkbox_outline),
                      suffixIcon: IconButton(
                        icon: _isAnalyzing
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Icon(
                                Ionicons.sparkles,
                                color: AppTheme.primaryColor,
                              ),
                        onPressed: _isAnalyzing ? null : _analyzeTaskWithAI,
                        tooltip: 'Заполнить с помощью AI',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Введите название задачи';
                      }
                      return null;
                    },
                  ),

                  // AI reasoning badge
                  if (_aiReasoning != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient.withOpacity(0.1),
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
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _aiReasoning!,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Advanced fields (shown after AI analysis)
                  if (_showAdvancedFields) ...[
                    const SizedBox(height: 24),

                    // Description
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Описание (опционально)',
                        hintText: 'Добавьте детали...',
                        prefixIcon: const Icon(Ionicons.document_text_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      maxLines: 4,
                    ),

                    const SizedBox(height: 24),

                    // Priority
                    const Text(
                      'Приоритет',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: TaskPriority.values.map((priority) {
                      final isSelected = _priority == priority;
                      return ChoiceChip(
                        label: Text(_getPriorityLabel(priority)),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _priority = priority;
                            });
                          }
                        },
                        selectedColor: _getPriorityColor(priority),
                        backgroundColor: Colors.grey.shade200,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Time Scope
                    const Text(
                    'Временной масштаб',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: TimeScope.values.map((scope) {
                      final isSelected = _timeScope == scope;
                      return ChoiceChip(
                        label: Text(_getTimeScopeLabel(scope)),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _timeScope = scope;
                            });
                          }
                        },
                        selectedColor: AppTheme.primaryColor,
                        backgroundColor: Colors.grey.shade200,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Due Date
                    const Text(
                    'Срок выполнения',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: _selectDueDate,
                      child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Ionicons.calendar_outline,
                            color: AppTheme.primaryColor,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _dueDate == null
                                ? 'Выберите дату'
                                : _formatDate(_dueDate!),
                            style: TextStyle(
                              fontSize: 15,
                              color: _dueDate == null
                                  ? Colors.grey.shade600
                                  : Colors.black87,
                            ),
                          ),
                          const Spacer(),
                          if (_dueDate != null)
                            IconButton(
                              icon: const Icon(
                                Ionicons.close_circle,
                                color: Colors.grey,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _dueDate = null;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                      // Create button
                    SizedBox(
                      width: double.infinity,
                      child: GradientButton(
                        onPressed: _isLoading ? null : _createTask,
                        text: _isLoading ? 'Создание...' : 'Создать задачу',
                        icon: Ionicons.checkmark_circle_outline,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
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
        return 'Сегодня';
      case TimeScope.weekly:
        return 'Неделя';
      case TimeScope.monthly:
        return 'Месяц';
      case TimeScope.longTerm:
        return 'Долгосрочно';
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'Сегодня';
    } else if (dateOnly == tomorrow) {
      return 'Завтра';
    } else {
      return '${date.day}.${date.month}.${date.year}';
    }
  }
}

