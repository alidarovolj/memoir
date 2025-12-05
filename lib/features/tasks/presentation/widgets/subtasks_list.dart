import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/features/tasks/data/models/subtask_model.dart';
import 'package:memoir/core/theme/app_theme.dart';

class SubtasksList extends StatefulWidget {
  final String taskId;
  final List<SubtaskModel> subtasks;
  final Function(String subtaskId) onToggle;
  final Function(String subtaskId) onDelete;
  final Function(String title) onAdd;

  const SubtasksList({
    super.key,
    required this.taskId,
    required this.subtasks,
    required this.onToggle,
    required this.onDelete,
    required this.onAdd,
  });

  @override
  State<SubtasksList> createState() => _SubtasksListState();
}

class _SubtasksListState extends State<SubtasksList> {
  final TextEditingController _newSubtaskController = TextEditingController();
  bool _isAdding = false;

  @override
  void dispose() {
    _newSubtaskController.dispose();
    super.dispose();
  }

  int get _completedCount =>
      widget.subtasks.where((s) => s.is_completed).length;
  int get _totalCount => widget.subtasks.length;
  double get _progress =>
      _totalCount == 0 ? 0.0 : _completedCount / _totalCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with progress
          Row(
            children: [
              Icon(
                Ionicons.list_outline,
                color: AppTheme.primaryColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Подзадачи',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              if (_totalCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _completedCount == _totalCount
                        ? Colors.green.shade100
                        : Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$_completedCount/$_totalCount',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _completedCount == _totalCount
                          ? Colors.green.shade700
                          : Colors.blue.shade700,
                    ),
                  ),
                ),
            ],
          ),

          // Progress bar
          if (_totalCount > 0) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: _progress,
                minHeight: 6,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _completedCount == _totalCount
                      ? Colors.green
                      : AppTheme.primaryColor,
                ),
              ),
            ),
          ],

          const SizedBox(height: 16),

          // Subtasks list
          if (_totalCount > 0)
            ...widget.subtasks.map((subtask) => _buildSubtaskItem(subtask)),

          // Add new subtask
          if (_isAdding) _buildAddSubtaskField() else _buildAddButton(),
        ],
      ),
    );
  }

  Widget _buildSubtaskItem(SubtaskModel subtask) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          // Checkbox
          GestureDetector(
            onTap: () => widget.onToggle(subtask.id),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: subtask.is_completed
                    ? AppTheme.primaryColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: subtask.is_completed
                      ? AppTheme.primaryColor
                      : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: subtask.is_completed
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ),

          const SizedBox(width: 12),

          // Title
          Expanded(
            child: Text(
              subtask.title,
              style: TextStyle(
                fontSize: 15,
                color: subtask.is_completed
                    ? Colors.grey.shade500
                    : Colors.black87,
                decoration: subtask.is_completed
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: Colors.grey.shade400,
              ),
            ),
          ),

          // Delete button
          IconButton(
            icon: Icon(
              Ionicons.trash_outline,
              size: 18,
              color: Colors.red.shade400,
            ),
            onPressed: () => widget.onDelete(subtask.id),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildAddSubtaskField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.primaryColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _newSubtaskController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Название подзадачи...',
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onSubmitted: _handleAddSubtask,
            ),
          ),
          IconButton(
            icon: const Icon(
              Ionicons.checkmark_circle,
              color: AppTheme.primaryColor,
              size: 24,
            ),
            onPressed: () => _handleAddSubtask(_newSubtaskController.text),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(
              Ionicons.close_circle,
              color: Colors.grey.shade400,
              size: 24,
            ),
            onPressed: () {
              setState(() {
                _isAdding = false;
                _newSubtaskController.clear();
              });
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return TextButton.icon(
      onPressed: () {
        setState(() {
          _isAdding = true;
        });
      },
      icon: Icon(
        Ionicons.add_circle_outline,
        size: 20,
        color: AppTheme.primaryColor,
      ),
      label: const Text(
        'Добавить подзадачу',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      style: TextButton.styleFrom(
        foregroundColor: AppTheme.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  void _handleAddSubtask(String title) {
    if (title.trim().isEmpty) return;

    widget.onAdd(title.trim());
    setState(() {
      _isAdding = false;
      _newSubtaskController.clear();
    });
  }
}
