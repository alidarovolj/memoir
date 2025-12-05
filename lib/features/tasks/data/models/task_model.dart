import 'package:freezed_annotation/freezed_annotation.dart';
import 'subtask_model.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

enum TaskStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

enum TaskPriority {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('urgent')
  urgent,
}

enum TimeScope {
  @JsonValue('daily')
  daily,
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly,
  @JsonValue('long_term')
  longTerm,
}

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required String user_id,
    required String title,
    String? description,
    DateTime? due_date,
    String? scheduled_time, // Format: "HH:MM" (e.g. "08:00")
    DateTime? completed_at,
    required TaskStatus status,
    required TaskPriority priority,
    required TimeScope time_scope,
    String? category_id,
    String? category_name,
    String? related_memory_id,
    required bool ai_suggested,
    double? ai_confidence,
    List<String>? tags,
    @Default(false) bool is_recurring,
    String? recurrence_rule, // RRULE format (e.g. "FREQ=DAILY")
    String? parent_task_id,
    @Default([]) List<SubtaskModel> subtasks,
    required DateTime created_at,
    required DateTime updated_at,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}

@freezed
class TaskAnalyzeResponse with _$TaskAnalyzeResponse {
  const factory TaskAnalyzeResponse({
    required TimeScope time_scope,
    required TaskPriority priority,
    String? suggested_time, // Format: "HH:MM"
    @Default(false) bool needs_deadline,
    String? category,
    required double confidence,
    required String reasoning,
  }) = _TaskAnalyzeResponse;

  factory TaskAnalyzeResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskAnalyzeResponseFromJson(json);
}
