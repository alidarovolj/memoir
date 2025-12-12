import 'package:flutter/material.dart';
import 'package:memoir/features/tasks/data/models/task_model.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/widgets.dart';
import 'package:ionicons/ionicons.dart';

/// Dialog shown when completing a task, offering to convert it to a memory
class CompleteTaskDialog extends StatefulWidget {
  final TaskModel task;
  final Function(bool convertToMemory, Map<String, dynamic>? memoryData)
  onConfirm;

  const CompleteTaskDialog({
    super.key,
    required this.task,
    required this.onConfirm,
  });

  @override
  State<CompleteTaskDialog> createState() => _CompleteTaskDialogState();
}

class _CompleteTaskDialogState extends State<CompleteTaskDialog> {
  bool _convertToMemory = false;
  final _notesController = TextEditingController();
  double? _rating;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.lightBackgroundGradient,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Ionicons.checkmark_circle,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Завершить задачу?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        widget.task.title,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Convert to Memory option
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _convertToMemory
                      ? AppTheme.primaryColor
                      : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _convertToMemory = !_convertToMemory;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          _convertToMemory
                              ? Ionicons.checkbox
                              : Ionicons.square_outline,
                          color: _convertToMemory
                              ? AppTheme.primaryColor
                              : Colors.grey.shade400,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Создать воспоминание',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    Ionicons.sparkles,
                                    size: 16,
                                    color: AppTheme.primaryColor,
                                  ),
                                ],
                              ),
                              Text(
                                'Сохранить выполненную задачу как воспоминание',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Additional fields when converting to memory
                  if (_convertToMemory) ...[
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),

                    // Notes field
                    TextField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        labelText: 'Заметки (опционально)',
                        hintText: 'Добавьте свои впечатления...',
                        prefixIcon: const Icon(Ionicons.document_text_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      maxLines: 3,
                    ),

                    const SizedBox(height: 16),

                    // Rating (for movies/books)
                    if (_shouldShowRating()) ...[
                      const Text(
                        'Оценка',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: List.generate(5, (index) {
                          final starValue = (index + 1) * 2.0;
                          final isSelected =
                              _rating != null && _rating! >= starValue;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _rating = starValue;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Icon(
                                isSelected
                                    ? Ionicons.star
                                    : Ionicons.star_outline,
                                color: isSelected
                                    ? Colors.amber
                                    : Colors.grey.shade400,
                                size: 32,
                              ),
                            ),
                          );
                        }),
                      ),
                      if (_rating != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            '${_rating!.toStringAsFixed(0)}/10',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                    ],
                  ],
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Отмена'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GradientButton(
                    onPressed: _onConfirm,
                    text: 'Завершить',
                    icon: Ionicons.checkmark,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _shouldShowRating() {
    // Show rating for movie/book related categories
    final categoryName = widget.task.category_name?.toLowerCase() ?? '';
    return categoryName.contains('фильм') ||
        categoryName.contains('книг') ||
        categoryName.contains('movie') ||
        categoryName.contains('book');
  }

  void _onConfirm() {
    Map<String, dynamic>? memoryData;

    if (_convertToMemory) {
      memoryData = {'notes': _notesController.text.trim(), 'rating': _rating};
    }

    widget.onConfirm(_convertToMemory, memoryData);
    Navigator.of(context).pop();
  }
}
