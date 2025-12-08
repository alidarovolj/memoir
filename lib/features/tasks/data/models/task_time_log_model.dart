import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_time_log_model.freezed.dart';
part 'task_time_log_model.g.dart';

@freezed
class TaskTimeLogModel with _$TaskTimeLogModel {
  const factory TaskTimeLogModel({
    required String id,
    required String taskId,
    required String userId,
    required DateTime startTime,
    DateTime? endTime,
    int? duration, // Duration in seconds
    String? notes,
    @Default(false) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _TaskTimeLogModel;

  factory TaskTimeLogModel.fromJson(Map<String, dynamic> json) =>
      _$TaskTimeLogModelFromJson(json);
}

@freezed
class TaskTimeStats with _$TaskTimeStats {
  const factory TaskTimeStats({
    required String taskId,
    required String taskTitle,
    required int totalDuration, // Total time in seconds
    required int sessionCount,
    required int averageSession, // Average session duration in seconds
    DateTime? lastWorked,
  }) = _TaskTimeStats;

  factory TaskTimeStats.fromJson(Map<String, dynamic> json) =>
      _$TaskTimeStatsFromJson(json);
}

@freezed
class TimeStatsResponse with _$TimeStatsResponse {
  const factory TimeStatsResponse({
    required int totalTimeToday, // Total time tracked today (seconds)
    required int totalTimeWeek,
    required int totalTimeMonth,
    String? activeTaskId,
    @Default([]) List<TaskTimeStats> tasks,
  }) = _TimeStatsResponse;

  factory TimeStatsResponse.fromJson(Map<String, dynamic> json) =>
      _$TimeStatsResponseFromJson(json);
}

// Helper extension for formatting duration
extension DurationFormatting on int {
  /// Format seconds as "2h 30m" or "45m" or "30s"
  String toFormattedDuration() {
    if (this < 60) {
      return '${this}s';
    } else if (this < 3600) {
      final minutes = this ~/ 60;
      return '${minutes}m';
    } else {
      final hours = this ~/ 3600;
      final minutes = (this % 3600) ~/ 60;
      if (minutes > 0) {
        return '${hours}h ${minutes}m';
      }
      return '${hours}h';
    }
  }

  /// Format seconds as "2:30:45" or "30:45" or "0:45"
  String toTimeFormat() {
    final hours = this ~/ 3600;
    final minutes = (this % 3600) ~/ 60;
    final seconds = this % 60;

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    }
  }
}
