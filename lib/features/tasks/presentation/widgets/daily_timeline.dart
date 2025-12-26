import 'package:flutter/material.dart';
import 'package:memoir/features/tasks/data/models/task_model.dart';
import 'package:memoir/features/tasks/presentation/widgets/complete_task_dialog.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:ionicons/ionicons.dart';

class DailyTimeline extends StatelessWidget {
  final List<TaskModel> tasks;
  final VoidCallback onRefresh;
  final Function(TaskModel task)? onTaskTap;
  final Function(
    TaskModel task,
    bool convertToMemory,
    Map<String, dynamic>? memoryData,
  )?
  onTaskComplete;
  final Function(TaskModel task)? onTaskDelete;

  const DailyTimeline({
    super.key,
    required this.tasks,
    required this.onRefresh,
    this.onTaskTap,
    this.onTaskComplete,
    this.onTaskDelete,
  });

  @override
  Widget build(BuildContext context) {
    // Group tasks by hour
    final tasksByHour = _groupTasksByHour(tasks);
    final hours = _generateHours();

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      color: AppTheme.primaryColor,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: hours.length,
        itemBuilder: (context, index) {
          final hour = hours[index];
          final hourTasks = tasksByHour[hour] ?? [];

          return _buildHourRow(context, hour, hourTasks);
        },
      ),
    );
  }

  List<int> _generateHours() {
    // Generate hours from 00:00 to 23:00
    return List.generate(24, (index) => index);
  }

  Map<int, List<TaskModel>> _groupTasksByHour(List<TaskModel> tasks) {
    final grouped = <int, List<TaskModel>>{};

    for (final task in tasks) {
      int hour;

      if (task.scheduled_time != null) {
        // Use scheduled_time (format: "HH:MM")
        final timeParts = task.scheduled_time!.split(':');
        hour = int.parse(timeParts[0]);
      } else if (task.due_date != null) {
        // Use actual due date hour
        hour = task.due_date!.hour;
      } else {
        // Default hour based on priority
        hour = _getDefaultHourByPriority(task.priority);
      }

      if (!grouped.containsKey(hour)) {
        grouped[hour] = [];
      }
      grouped[hour]!.add(task);
    }

    return grouped;
  }

  int _getDefaultHourByPriority(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.urgent:
        return 8; // Morning
      case TaskPriority.high:
        return 10;
      case TaskPriority.medium:
        return 14; // Afternoon
      case TaskPriority.low:
        return 18; // Evening
    }
  }

  Widget _buildHourRow(
    BuildContext context,
    int hour,
    List<TaskModel> hourTasks,
  ) {
    final hasTasksAtThisHour = hourTasks.isNotEmpty;
    final hourString = '${hour.toString().padLeft(2, '0')}:00';

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time label
          SizedBox(
            width: 60,
            child: Text(
              hourString,
              style: TextStyle(
                fontSize: 14,
                fontWeight: hasTasksAtThisHour
                    ? FontWeight.w600
                    : FontWeight.w400,
                color: hasTasksAtThisHour
                    ? Colors.white
                    : Colors.white.withOpacity(0.4),
              ),
            ),
          ),

          // Divider line with dot
          Container(
            width: 8,
            height: hasTasksAtThisHour ? 60 : 20,
            margin: const EdgeInsets.only(top: 6),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Vertical line
                Positioned(
                  left: 3,
                  top: 0,
                  child: Container(
                    width: 2,
                    height: hasTasksAtThisHour ? 60 : 20,
                    decoration: BoxDecoration(
                      gradient: hasTasksAtThisHour
                          ? AppTheme.primaryGradient
                          : LinearGradient(
                              colors: [
                                Colors.grey.shade300,
                                Colors.grey.shade300,
                              ],
                            ),
                    ),
                  ),
                ),
                // Dot indicator for tasks
                if (hasTasksAtThisHour)
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryColor.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Tasks at this hour
          Expanded(
            child: hasTasksAtThisHour
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: hourTasks
                        .map((task) => _buildTaskItem(context, task))
                        .toList(),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, TaskModel task) {
    final priorityColor = _getPriorityColor(task.priority);
    final isCompleted = task.status == TaskStatus.completed;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: priorityColor.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (onTaskTap != null) {
              onTaskTap!(task);
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Checkbox
                GestureDetector(
                  onTap: () {
                    if (task.status != TaskStatus.completed) {
                      _handleTaskComplete(context, task);
                    }
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: isCompleted ? AppTheme.primaryGradient : null,
                      border: isCompleted
                          ? null
                          : Border.all(
                              color: priorityColor.withOpacity(0.6),
                              width: 2,
                            ),
                    ),
                    child: isCompleted
                        ? const Icon(
                            Ionicons.checkmark,
                            size: 12,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                const SizedBox(width: 12),

                // Task content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: isCompleted
                              ? Colors.white.withOpacity(0.5)
                              : Colors.white,
                          decoration: isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (task.description != null &&
                          task.description!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          task.description!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.6),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      if (task.tags != null && task.tags!.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 4,
                          children: task.tags!.take(2).map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Priority badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: priorityColor.withOpacity(0.4)),
                  ),
                  child: Icon(
                    _getPriorityIcon(task.priority),
                    size: 14,
                    color: priorityColor,
                  ),
                ),

                const SizedBox(width: 4),

                // Delete button
                IconButton(
                  icon: const Icon(Ionicons.trash_outline),
                  iconSize: 16,
                  color: Colors.white.withOpacity(0.4),
                  onPressed: () {
                    if (onTaskDelete != null) {
                      onTaskDelete!(task);
                    }
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  IconData _getPriorityIcon(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return Ionicons.remove_outline;
      case TaskPriority.medium:
        return Ionicons.arrow_up_outline;
      case TaskPriority.high:
        return Ionicons.alert_outline;
      case TaskPriority.urgent:
        return Ionicons.alert_circle;
    }
  }

  Future<void> _handleTaskComplete(BuildContext context, TaskModel task) async {
    // Show dialog to ask if user wants to convert task to memory
    await showDialog(
      context: context,
      builder: (context) => CompleteTaskDialog(
        task: task,
        onConfirm: (convertToMemory, memoryData) {
          if (onTaskComplete != null) {
            onTaskComplete!(task, convertToMemory, memoryData);
          }
        },
      ),
    );
  }
}
