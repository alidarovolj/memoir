import 'package:flutter/material.dart';
import 'package:memoir/features/tasks/data/models/task_model.dart';
import 'package:memoir/features/tasks/presentation/widgets/task_card.dart';
import 'package:memoir/features/tasks/presentation/widgets/complete_task_dialog.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:ionicons/ionicons.dart';

class KanbanBoard extends StatelessWidget {
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

  const KanbanBoard({
    super.key,
    required this.tasks,
    required this.onRefresh,
    this.onTaskTap,
    this.onTaskComplete,
    this.onTaskDelete,
  });

  @override
  Widget build(BuildContext context) {
    // Group tasks by status
    final pendingTasks = tasks
        .where((t) => t.status == TaskStatus.pending)
        .toList();
    final inProgressTasks = tasks
        .where((t) => t.status == TaskStatus.inProgress)
        .toList();
    final completedTasks = tasks
        .where((t) => t.status == TaskStatus.completed)
        .toList();

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      color: AppTheme.primaryColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TO DO Column
              Expanded(
                child: _buildColumn(
                  context,
                  title: 'ЗАПЛАНИРОВАНО',
                  icon: Ionicons.list_outline,
                  color: Colors.blue,
                  tasks: pendingTasks,
                  count: pendingTasks.length,
                ),
              ),
              const SizedBox(width: 12),

              // IN PROGRESS Column
              Expanded(
                child: _buildColumn(
                  context,
                  title: 'В РАБОТЕ',
                  icon: Ionicons.flash_outline,
                  color: Colors.orange,
                  tasks: inProgressTasks,
                  count: inProgressTasks.length,
                ),
              ),
              const SizedBox(width: 12),

              // DONE Column
              Expanded(
                child: _buildColumn(
                  context,
                  title: 'ГОТОВО',
                  icon: Ionicons.checkmark_circle_outline,
                  color: Colors.green,
                  tasks: completedTasks,
                  count: completedTasks.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColumn(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required List<TaskModel> tasks,
    required int count,
  }) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Column header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(icon, size: 16, color: color),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: color,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Tasks
          if (tasks.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.cardColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: color.withOpacity(0.2),
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                children: [
                  Icon(icon, size: 32, color: Colors.white.withOpacity(0.3)),
                  const SizedBox(height: 8),
                  Text(
                    'Нет задач',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            )
          else
            ...tasks.map(
              (task) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TaskCard(
                  task: task,
                  onTap: () {
                    if (onTaskTap != null) {
                      onTaskTap!(task);
                    }
                  },
                  onToggleStatus: () => _handleTaskComplete(context, task),
                ),
              ),
            ),
        ],
      ),
    );
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
