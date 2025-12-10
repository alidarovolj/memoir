import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_stats_model.freezed.dart';
part 'user_stats_model.g.dart';

@freezed
class UserStatsModel with _$UserStatsModel {
  const factory UserStatsModel({
    @JsonKey(name: 'memories_count') required int memoriesCount,
    @JsonKey(name: 'tasks_total') required int tasksTotal,
    @JsonKey(name: 'tasks_completed') required int tasksCompleted,
    @JsonKey(name: 'tasks_in_progress') required int tasksInProgress,
    @JsonKey(name: 'stories_count') required int storiesCount,
    @JsonKey(name: 'total_time_tracked') required int totalTimeTracked,
  }) = _UserStatsModel;

  factory UserStatsModel.fromJson(Map<String, dynamic> json) =>
      _$UserStatsModelFromJson(json);
}

/// Extension for formatting time
extension TimeFormatting on int {
  /// Format seconds to hours string (e.g., "2.5 часа")
  String toHoursString() {
    if (this == 0) return '0 часов';

    final hours = this / 3600;
    if (hours < 1) {
      final minutes = (this / 60).round();
      return '$minutes мин';
    }

    if (hours.round() == hours) {
      final h = hours.round();
      return '$h ${_pluralizeHours(h)}';
    }

    return '${hours.toStringAsFixed(1)} часа';
  }

  String _pluralizeHours(int hours) {
    if (hours % 10 == 1 && hours % 100 != 11) {
      return 'час';
    } else if ([2, 3, 4].contains(hours % 10) &&
        ![12, 13, 14].contains(hours % 100)) {
      return 'часа';
    } else {
      return 'часов';
    }
  }
}
