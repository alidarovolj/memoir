import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/features/tasks/data/models/task_suggestion_model.dart';
import 'package:memoir/features/tasks/data/models/task_model.dart';

class TaskSuggestionsModal extends StatelessWidget {
  final List<TaskSuggestionModel> suggestions;
  final Function(TaskSuggestionModel) onTaskSelected;

  const TaskSuggestionsModal({
    super.key,
    required this.suggestions,
    required this.onTaskSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Ionicons.bulb,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI предлагает задачи',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'На основе вашего воспоминания',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Ionicons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Suggestions list
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = suggestions[index];
                return _buildSuggestionCard(context, suggestion);
              },
            ),
          ),

          const SizedBox(height: 20),

          // Bottom actions
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.grey[300]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Отклонить все',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionCard(
    BuildContext context,
    TaskSuggestionModel suggestion,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and confidence
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        suggestion.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _buildConfidenceBadge(suggestion.confidence),
                  ],
                ),

                const SizedBox(height: 8),

                // Description
                Text(
                  suggestion.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),

                const SizedBox(height: 12),

                // Metadata chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildMetadataChip(
                      _getTimeScopeIcon(suggestion.timeScope),
                      _getTimeScopeLabel(suggestion.timeScope),
                      Colors.blue,
                    ),
                    _buildMetadataChip(
                      _getPriorityIcon(suggestion.priority),
                      _getPriorityLabel(suggestion.priority),
                      _getPriorityColor(suggestion.priority),
                    ),
                    if (suggestion.category != null)
                      _buildMetadataChip(
                        Ionicons.pricetag_outline,
                        _getCategoryLabel(suggestion.category!),
                        Colors.purple,
                      ),
                  ],
                ),

                const SizedBox(height: 8),

                // Reasoning
                Row(
                  children: [
                    Icon(
                      Ionicons.information_circle_outline,
                      size: 16,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        suggestion.reasoning,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action button
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                onTaskSelected(suggestion);
              },
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(16)),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Ionicons.add_circle,
                      color: AppTheme.primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Создать задачу',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
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

  Widget _buildConfidenceBadge(double confidence) {
    final percentage = (confidence * 100).toInt();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Ionicons.sparkles,
            size: 14,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(width: 4),
          Text(
            '$percentage%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetadataChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods
  IconData _getTimeScopeIcon(String scope) {
    switch (scope) {
      case 'daily':
        return Ionicons.today_outline;
      case 'weekly':
        return Ionicons.calendar_outline;
      case 'monthly':
        return Ionicons.calendar_number_outline;
      case 'long_term':
        return Ionicons.flag_outline;
      default:
        return Ionicons.time_outline;
    }
  }

  String _getTimeScopeLabel(String scope) {
    switch (scope) {
      case 'daily':
        return 'Сегодня';
      case 'weekly':
        return 'На неделе';
      case 'monthly':
        return 'В месяце';
      case 'long_term':
        return 'Долгосрочно';
      default:
        return scope;
    }
  }

  IconData _getPriorityIcon(String priority) {
    switch (priority) {
      case 'urgent':
        return Ionicons.flash;
      case 'high':
        return Ionicons.arrow_up_circle;
      case 'medium':
        return Ionicons.remove_circle_outline;
      case 'low':
        return Ionicons.arrow_down_circle_outline;
      default:
        return Ionicons.ellipse_outline;
    }
  }

  String _getPriorityLabel(String priority) {
    switch (priority) {
      case 'urgent':
        return 'Срочно';
      case 'high':
        return 'Высокий';
      case 'medium':
        return 'Средний';
      case 'low':
        return 'Низкий';
      default:
        return priority;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'urgent':
        return Colors.red;
      case 'high':
        return Colors.orange;
      case 'medium':
        return Colors.blue;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case 'movies':
        return 'Фильм';
      case 'books':
        return 'Книга';
      case 'places':
        return 'Место';
      case 'ideas':
        return 'Идея';
      case 'recipes':
        return 'Рецепт';
      case 'products':
        return 'Покупка';
      default:
        return category;
    }
  }
}
