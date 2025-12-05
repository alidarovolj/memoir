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

  const CreateTaskPage({super.key, this.initialTimeScope = TimeScope.daily});

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
  TimeOfDay? _suggestedTime;
  String? _suggestedDueDate; // "today", "tomorrow", "this_week", "this_month"
  bool _needsDeadline = false;
  bool _isLoading = false;
  bool _isAnalyzing = false;
  bool _showAdvancedFields = false;
  String? _aiReasoning;

  // Recurring
  bool _isRecurring = false;
  String _recurrenceRule = 'FREQ=DAILY'; // Default: daily

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
          _needsDeadline = result['needs_deadline'] ?? false;

          // Parse suggested time
          if (result['suggested_time'] != null) {
            final timeParts = result['suggested_time'].split(':');
            if (timeParts.length == 2) {
              _suggestedTime = TimeOfDay(
                hour: int.parse(timeParts[0]),
                minute: int.parse(timeParts[1]),
              );
            }
          }

          // Parse suggested due date
          _suggestedDueDate = result['suggested_due_date'];

          _isAnalyzing = false;
          _showAdvancedFields = true; // Show all fields after AI analysis
        });

        log(
          '✨ [AI] Task analyzed: time_scope=${result['time_scope']}, priority=${result['priority']}, time=${result['suggested_time']}, due_date=${result['suggested_due_date']}, needs_deadline=${result['needs_deadline']}',
        );
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

  DateTime? _parseSuggestedDueDate(String? suggestedDueDate) {
    if (suggestedDueDate == null) return null;

    final now = DateTime.now();
    switch (suggestedDueDate) {
      case 'today':
        return DateTime(now.year, now.month, now.day, 23, 59);
      case 'tomorrow':
        final tomorrow = now.add(const Duration(days: 1));
        return DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 59);
      case 'this_week':
        return now.add(const Duration(days: 7));
      case 'this_month':
        return now.add(const Duration(days: 30));
      default:
        return null;
    }
  }

  String _formatSuggestedDueDate(String? suggestedDueDate) {
    if (suggestedDueDate == null) return '';

    switch (suggestedDueDate) {
      case 'today':
        return 'Сегодня';
      case 'tomorrow':
        return 'Завтра';
      case 'this_week':
        return 'На этой неделе';
      case 'this_month':
        return 'В этом месяце';
      default:
        return suggestedDueDate;
    }
  }

  void _applySuggestedDueDate() {
    if (_suggestedDueDate != null) {
      final suggestedDate = _parseSuggestedDueDate(_suggestedDueDate);
      if (suggestedDate != null) {
        setState(() {
          _dueDate = suggestedDate;
        });
      }
    }
  }

  Future<void> _createTask() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Convert suggested time to string format "HH:MM"
      String? scheduledTime;
      if (_suggestedTime != null) {
        scheduledTime =
            '${_suggestedTime!.hour.toString().padLeft(2, '0')}:${_suggestedTime!.minute.toString().padLeft(2, '0')}';
      }

      final taskData = {
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'priority': _getPriorityString(_priority),
        'time_scope': _getTimeScopeString(_timeScope),
        'due_date': _dueDate?.toIso8601String(),
        'scheduled_time': scheduledTime,
        'status': 'pending',
        'is_recurring': _isRecurring,
        'recurrence_rule': _isRecurring ? _recurrenceRule : null,
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
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
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

                    // Recommended Time (if available)
                    if (_suggestedTime != null) ...[
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
                              Ionicons.time_outline,
                              color: AppTheme.primaryColor,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Рекомендуемое время: ${_suggestedTime!.format(context)}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Suggested Due Date (if available)
                    if (_suggestedDueDate != null) ...[
                      Container(
                        padding: const EdgeInsets.all(16),
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
                              Ionicons.calendar,
                              color: AppTheme.primaryColor,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'AI предлагает выполнить:',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _formatSuggestedDueDate(_suggestedDueDate),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: _applySuggestedDueDate,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                backgroundColor: AppTheme.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Применить',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Deadline Checkbox
                    CheckboxListTile(
                      title: const Text(
                        'Установить дедлайн',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: _needsDeadline
                          ? const Text(
                              'AI рекомендует установить дедлайн',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.orange,
                              ),
                            )
                          : null,
                      value: _dueDate != null,
                      onChanged: (value) async {
                        if (value == true) {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );
                          if (date != null) {
                            final time =
                                _suggestedTime ??
                                const TimeOfDay(hour: 9, minute: 0);
                            final timeResult = await showTimePicker(
                              context: context,
                              initialTime: time,
                            );
                            if (timeResult != null) {
                              setState(() {
                                _dueDate = DateTime(
                                  date.year,
                                  date.month,
                                  date.day,
                                  timeResult.hour,
                                  timeResult.minute,
                                );
                              });
                            }
                          }
                        } else {
                          setState(() {
                            _dueDate = null;
                          });
                        }
                      },
                      activeColor: AppTheme.primaryColor,
                      contentPadding: EdgeInsets.zero,
                    ),

                    // Show selected due date
                    if (_dueDate != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
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
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                '${_dueDate!.day}.${_dueDate!.month}.${_dueDate!.year} в ${_dueDate!.hour}:${_dueDate!.minute.toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Ionicons.trash_outline),
                              color: Colors.red,
                              onPressed: () {
                                setState(() {
                                  _dueDate = null;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Recurring Task Toggle
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _isRecurring
                              ? AppTheme.primaryColor
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _isRecurring
                                    ? Ionicons.repeat
                                    : Ionicons.repeat_outline,
                                color: _isRecurring
                                    ? AppTheme.primaryColor
                                    : Colors.grey,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Повторяющаяся задача',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      'Автоматически создавать задачу по расписанию',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: _isRecurring,
                                onChanged: (value) {
                                  setState(() {
                                    _isRecurring = value;
                                  });
                                },
                                activeColor: AppTheme.primaryColor,
                              ),
                            ],
                          ),

                          if (_isRecurring) ...[
                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 16),

                            const Text(
                              'Частота повторения',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 12),

                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _buildRecurrenceChip(
                                  'Ежедневно',
                                  'FREQ=DAILY',
                                  Ionicons.calendar,
                                ),
                                _buildRecurrenceChip(
                                  'По будням',
                                  'FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR',
                                  Ionicons.briefcase,
                                ),
                                _buildRecurrenceChip(
                                  'Еженедельно',
                                  'FREQ=WEEKLY',
                                  Ionicons.calendar_outline,
                                ),
                                _buildRecurrenceChip(
                                  'Ежемесячно',
                                  'FREQ=MONTHLY',
                                  Ionicons.calendar_number,
                                ),
                              ],
                            ),
                          ],
                        ],
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

  Widget _buildRecurrenceChip(String label, String rule, IconData icon) {
    final isSelected = _recurrenceRule == rule;
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: isSelected ? Colors.white : Colors.black87,
          ),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _recurrenceRule = rule;
          });
        }
      },
      selectedColor: AppTheme.primaryColor,
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
        fontWeight: FontWeight.w600,
        fontSize: 13,
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
}
