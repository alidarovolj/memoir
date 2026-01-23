import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/features/tasks/data/models/task_model.dart';
import 'package:memoir/features/tasks/data/models/subtask_model.dart';

class TaskCard extends StatefulWidget {
  final TaskModel task;
  final VoidCallback onTap;
  final VoidCallback onToggleStatus;
  final Function(String subtaskId)? onToggleSubtask;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onToggleStatus,
    this.onToggleSubtask,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isExpanded = true; // Раскрыто по умолчанию

  @override
  Widget build(BuildContext context) {
    final isCompleted = widget.task.status == TaskStatus.completed;
    final color = _getTaskColor(widget.task);
    final hasSubtasks = widget.task.subtasks.isNotEmpty;
    
    // Логируем подзадачи для отладки
    if (widget.task.subtasks.isNotEmpty) {
      debugPrint('📝 [TASK_CARD] Task "${widget.task.title}" has ${widget.task.subtasks.length} subtasks');
      for (var subtask in widget.task.subtasks) {
        debugPrint('   - Subtask: ${subtask.title} (completed: ${subtask.is_completed})');
      }
    } else {
      debugPrint('⚠️ [TASK_CARD] Task "${widget.task.title}" has NO subtasks (parent_task_id: ${widget.task.parent_task_id})');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main task card
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Expand/Collapse button for tasks with subtasks
                if (hasSubtasks)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      margin: const EdgeInsets.only(right: 6),
                      child: Icon(
                        _isExpanded
                            ? Ionicons.chevron_down
                            : Ionicons.chevron_forward,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),

                // Icon
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _getTaskIcon(widget.task),
                    color: Colors.white,
                    size: 18,
                  ),
                ),

                const SizedBox(width: 10),

                // Task info
                Expanded(
                  child: Text(
                    widget.task.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(width: 10),

                // Completion indicator
                GestureDetector(
                  onTap: widget.onToggleStatus,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? Colors.white
                          : Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: !isCompleted
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
                    ),
                    child: isCompleted
                        ? Icon(Ionicons.checkmark, color: color, size: 24)
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Subtasks tree
        if (hasSubtasks && _isExpanded)
          Container(
            margin: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                ...() {
                  final sortedSubtasks = List<SubtaskModel>.from(widget.task.subtasks);
                  sortedSubtasks.sort((a, b) => a.order.compareTo(b.order));
                  return sortedSubtasks.asMap().entries.map((entry) {
                    final index = entry.key;
                    final subtask = entry.value;
                    final isLast = index == sortedSubtasks.length - 1;
                    return _buildSubtaskItem(
                      subtask,
                      color,
                      isLast: isLast,
                      isFirst: index == 0,
                    );
                  });
                }(),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSubtaskItem(SubtaskModel subtask, Color parentColor, {bool isLast = false, bool isFirst = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Контейнер для вертикальной и горизонтальной линий
          SizedBox(
            width: 20,
            height: 44,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Вертикальная линия (если не первая подзадача, начинается сверху)
                if (!isFirst)
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 24,
                    child: Container(
                      width: 3,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(1.5),
                      ),
                    ),
                  ),
                // Вертикальная линия (продолжается вниз, если не последняя)
                if (!isLast)
                  Positioned(
                    left: 0,
                    top: 24,
                    bottom: 0,
                    child: Container(
                      width: 3,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(1.5),
                      ),
                    ),
                  ),
                // Горизонтальная линия
                Positioned(
                  left: 0,
                  top: 20,
                  child: Container(
                    width: 16,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 4),

          // Подзадача
          Expanded(
            child: GestureDetector(
              onTap: widget.onToggleSubtask != null
                  ? () => widget.onToggleSubtask!(subtask.id)
                  : null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: parentColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    // Checkbox
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: subtask.is_completed
                            ? Colors.white
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.8),
                          width: 2,
                        ),
                      ),
                      child: subtask.is_completed
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.black87,
                            )
                          : null,
                    ),

                    const SizedBox(width: 12),

                    // Subtask title
                    Expanded(
                      child: Text(
                        subtask.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: subtask.is_completed
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getTaskColor(TaskModel task) {
    // Use saved color if available
    if (task.color != null && task.color!.isNotEmpty) {
      try {
        return Color(int.parse(task.color!.replaceFirst('#', '0xFF')));
      } catch (e) {
        // Fall back to priority-based color if parsing fails
      }
    }
    
    // Generate color based on priority or use default
    switch (task.priority) {
      case TaskPriority.urgent:
        return const Color(0xFFEF4444); // Red
      case TaskPriority.high:
        return const Color(0xFFF97316); // Orange
      case TaskPriority.medium:
        return const Color(0xFFE91E63); // Magenta (default Grit color)
      case TaskPriority.low:
        return const Color(0xFF8B5CF6); // Purple
    }
  }

  IconData _getTaskIcon(TaskModel task) {
    // Use saved icon if available
    if (task.icon != null && task.icon!.isNotEmpty) {
      return _getIconDataFromName(task.icon!);
    }
    
    // Иконки в зависимости от приоритета и типа задачи
    final title = task.title.toLowerCase();
    
    // Определяем иконку по ключевым словам в названии
    if (title.contains('постель') || title.contains('кровать')) {
      return Ionicons.bed_outline;
    } else if (title.contains('зуб') || title.contains('чист')) {
      return Ionicons.sparkles_outline;
    } else if (title.contains('работ') || title.contains('офис')) {
      return Ionicons.briefcase_outline;
    } else if (title.contains('спорт') || title.contains('трениров') || title.contains('зал')) {
      return Ionicons.fitness_outline;
    } else if (title.contains('еда') || title.contains('завтрак') || title.contains('обед') || title.contains('ужин')) {
      return Ionicons.restaurant_outline;
    } else if (title.contains('вода') || title.contains('пить')) {
      return Ionicons.water_outline;
    } else if (title.contains('чита') || title.contains('книг')) {
      return Ionicons.book_outline;
    } else if (title.contains('звон') || title.contains('позвон')) {
      return Ionicons.call_outline;
    } else if (title.contains('магазин') || title.contains('покуп')) {
      return Ionicons.cart_outline;
    } else if (title.contains('дом') || title.contains('уборк')) {
      return Ionicons.home_outline;
    } else if (title.contains('прогулк')) {
      return Ionicons.walk_outline;
    } else if (title.contains('медитац')) {
      return Ionicons.leaf_outline;
    }
    
    // По умолчанию - иконка в зависимости от приоритета
    switch (task.priority) {
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

  IconData _getIconDataFromName(String iconName) {
    // Convert icon name to IconData
    switch (iconName) {
      case 'checkbox_outline':
        return Ionicons.checkbox_outline;
      case 'briefcase_outline':
        return Ionicons.briefcase_outline;
      case 'fitness_outline':
        return Ionicons.fitness_outline;
      case 'book_outline':
        return Ionicons.book_outline;
      case 'restaurant_outline':
        return Ionicons.restaurant_outline;
      case 'water_outline':
        return Ionicons.water_outline;
      case 'bed_outline':
        return Ionicons.bed_outline;
      case 'pencil_outline':
        return Ionicons.pencil_outline;
      case 'cart_outline':
        return Ionicons.cart_outline;
      case 'call_outline':
        return Ionicons.call_outline;
      case 'sparkles_outline':
        return Ionicons.sparkles_outline;
      case 'flash_outline':
        return Ionicons.flash_outline;
      case 'alert_circle_outline':
        return Ionicons.alert_circle_outline;
      case 'ellipse_outline':
        return Ionicons.ellipse_outline;
      case 'home_outline':
        return Ionicons.home_outline;
      case 'walk_outline':
        return Ionicons.walk_outline;
      case 'leaf_outline':
        return Ionicons.leaf_outline;
      default:
        return Ionicons.checkbox_outline;
    }
  }
}

