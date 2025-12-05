import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/features/tasks/data/models/task_model.dart';
import 'package:memoir/features/tasks/data/models/subtask_model.dart';
import 'package:memoir/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:memoir/features/tasks/presentation/widgets/subtasks_list.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/di/service_locator.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'dart:developer';

class TaskDetailsPage extends StatefulWidget {
  final TaskModel task;
  final VoidCallback? onTaskUpdated;

  const TaskDetailsPage({
    super.key,
    required this.task,
    this.onTaskUpdated,
  });

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  late final TaskRemoteDataSource _taskDataSource;
  List<SubtaskModel> _subtasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _taskDataSource = getIt<TaskRemoteDataSource>();
    _subtasks = List.from(widget.task.subtasks);
    _loadSubtasks();
  }

  Future<void> _loadSubtasks() async {
    try {
      setState(() => _isLoading = true);
      final subtasks = await _taskDataSource.getSubtasks(widget.task.id);
      setState(() {
        _subtasks = subtasks;
        _isLoading = false;
      });
    } catch (e) {
      log('❌ Error loading subtasks: $e');
      setState(() => _isLoading = false);
      if (mounted) {
        SnackBarUtils.showError(context, 'Не удалось загрузить подзадачи');
      }
    }
  }

  Future<void> _toggleSubtask(String subtaskId) async {
    try {
      final subtask = _subtasks.firstWhere((s) => s.id == subtaskId);
      final newState = !subtask.is_completed;

      // Optimistic update
      setState(() {
        final index = _subtasks.indexWhere((s) => s.id == subtaskId);
        if (index != -1) {
          _subtasks[index] = _subtasks[index].copyWith(
            is_completed: newState,
          );
        }
      });

      // API call
      await _taskDataSource.updateSubtask(
        widget.task.id,
        subtaskId,
        {'is_completed': newState},
      );

      widget.onTaskUpdated?.call();
    } catch (e) {
      log('❌ Error toggling subtask: $e');
      _loadSubtasks(); // Revert on error
      if (mounted) {
        SnackBarUtils.showError(context, 'Не удалось обновить подзадачу');
      }
    }
  }

  Future<void> _deleteSubtask(String subtaskId) async {
    try {
      // Optimistic delete
      setState(() {
        _subtasks.removeWhere((s) => s.id == subtaskId);
      });

      await _taskDataSource.deleteSubtask(widget.task.id, subtaskId);
      widget.onTaskUpdated?.call();

      if (mounted) {
        SnackBarUtils.showSuccess(context, 'Подзадача удалена');
      }
    } catch (e) {
      log('❌ Error deleting subtask: $e');
      _loadSubtasks(); // Revert on error
      if (mounted) {
        SnackBarUtils.showError(context, 'Не удалось удалить подзадачу');
      }
    }
  }

  Future<void> _addSubtask(String title) async {
    try {
      final subtask = await _taskDataSource.createSubtask(
        widget.task.id,
        {
          'title': title,
          'is_completed': false,
          'order': _subtasks.length,
        },
      );

      setState(() {
        _subtasks.add(subtask);
      });

      widget.onTaskUpdated?.call();

      if (mounted) {
        SnackBarUtils.showSuccess(context, 'Подзадача добавлена');
      }
    } catch (e) {
      log('❌ Error adding subtask: $e');
      if (mounted) {
        SnackBarUtils.showError(context, 'Не удалось добавить подзадачу');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Детали задачи'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Ionicons.chevron_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Task Title
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.task.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Description
                  if (widget.task.description != null &&
                      widget.task.description!.isNotEmpty) ...[
                    Text(
                      widget.task.description!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Task Meta
                  _buildMetaRow(),

                  const SizedBox(height: 32),

                  // Subtasks Section
                  SubtasksList(
                    taskId: widget.task.id,
                    subtasks: _subtasks,
                    onToggle: _toggleSubtask,
                    onDelete: _deleteSubtask,
                    onAdd: _addSubtask,
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }

  Widget _buildMetaRow() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        // Priority
        _buildMetaChip(
          icon: Ionicons.flag,
          label: _getPriorityLabel(widget.task.priority),
          color: _getPriorityColor(widget.task.priority),
        ),

        // Time Scope
        _buildMetaChip(
          icon: Ionicons.time_outline,
          label: _getTimeScopeLabel(widget.task.time_scope),
          color: Colors.blue,
        ),

        // Status
        _buildMetaChip(
          icon: _getStatusIcon(widget.task.status),
          label: _getStatusLabel(widget.task.status),
          color: _getStatusColor(widget.task.status),
        ),

        // Due Date
        if (widget.task.due_date != null)
          _buildMetaChip(
            icon: Ionicons.calendar_outline,
            label: _formatDate(widget.task.due_date!),
            color: Colors.orange,
          ),

        // Scheduled Time
        if (widget.task.scheduled_time != null)
          _buildMetaChip(
            icon: Ionicons.alarm_outline,
            label: widget.task.scheduled_time!,
            color: Colors.purple,
          ),
      ],
    );
  }

  Widget _buildMetaChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color.withOpacity(0.9),
            ),
          ),
        ],
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

  IconData _getStatusIcon(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return Ionicons.ellipse_outline;
      case TaskStatus.in_progress:
        return Ionicons.play_circle_outline;
      case TaskStatus.completed:
        return Ionicons.checkmark_circle;
      case TaskStatus.cancelled:
        return Ionicons.close_circle_outline;
    }
  }

  String _getStatusLabel(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return 'Ожидает';
      case TaskStatus.in_progress:
        return 'В работе';
      case TaskStatus.completed:
        return 'Завершено';
      case TaskStatus.cancelled:
        return 'Отменено';
    }
  }

  Color _getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return Colors.grey;
      case TaskStatus.in_progress:
        return Colors.blue;
      case TaskStatus.completed:
        return Colors.green;
      case TaskStatus.cancelled:
        return Colors.red;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final taskDate = DateTime(date.year, date.month, date.day);

    final diff = taskDate.difference(today).inDays;

    if (diff == 0) return 'Сегодня';
    if (diff == 1) return 'Завтра';
    if (diff == -1) return 'Вчера';

    return '${date.day}.${date.month}.${date.year}';
  }
}
