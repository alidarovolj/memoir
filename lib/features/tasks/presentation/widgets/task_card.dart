import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/features/tasks/data/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onTap;
  final VoidCallback onToggleStatus;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onToggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = task.status == TaskStatus.completed;
    final color = _getTaskColor(task);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(_getTaskIcon(task), color: Colors.white, size: 22),
            ),

            const SizedBox(width: 12),

            // Task info
            Expanded(
              child: Text(
                task.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  decoration: isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(width: 12),

            // Completion indicator
            GestureDetector(
              onTap: onToggleStatus,
              child: Container(
                width: 32,
                height: 32,
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
                    ? Icon(Ionicons.checkmark, color: color, size: 20)
                    : null,
              ),
            ),
          ],
        ),
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
