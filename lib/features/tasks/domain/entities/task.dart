/// Task entity
enum TaskStatus {
  pending,
  inProgress,
  completed,
  cancelled,
}

enum TaskPriority {
  low,
  medium,
  high,
  urgent,
}

enum TimeScope {
  daily,
  weekly,
  monthly,
  longTerm,
}

class Task {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final DateTime? completedAt;
  final TaskStatus status;
  final TaskPriority priority;
  final TimeScope timeScope;
  final String? categoryId;
  final String? categoryName;
  final String? relatedMemoryId;
  final bool aiSuggested;
  final double? aiConfidence;
  final List<String>? tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  Task({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.dueDate,
    this.completedAt,
    required this.status,
    required this.priority,
    required this.timeScope,
    this.categoryId,
    this.categoryName,
    this.relatedMemoryId,
    required this.aiSuggested,
    this.aiConfidence,
    this.tags,
    required this.createdAt,
    required this.updatedAt,
  });
}

