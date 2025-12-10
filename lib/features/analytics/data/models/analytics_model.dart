import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics_model.freezed.dart';
part 'analytics_model.g.dart';

@freezed
class DayActivity with _$DayActivity {
  const factory DayActivity({
    required DateTime date,
    @JsonKey(name: 'memories_count') @Default(0) int memoriesCount,
    @JsonKey(name: 'tasks_completed') @Default(0) int tasksCompleted,
    @JsonKey(name: 'time_tracked') @Default(0) int timeTracked,
    @JsonKey(name: 'stories_created') @Default(0) int storiesCreated,
  }) = _DayActivity;

  factory DayActivity.fromJson(Map<String, dynamic> json) =>
      _$DayActivityFromJson(json);
}

@freezed
class MonthStats with _$MonthStats {
  const factory MonthStats({
    required int month,
    required int year,
    @JsonKey(name: 'total_memories') required int totalMemories,
    @JsonKey(name: 'total_tasks_completed') required int totalTasksCompleted,
    @JsonKey(name: 'total_time_tracked') required int totalTimeTracked,
    @JsonKey(name: 'total_stories') required int totalStories,
    @JsonKey(name: 'daily_activities')
    required List<DayActivity> dailyActivities,
  }) = _MonthStats;

  factory MonthStats.fromJson(Map<String, dynamic> json) =>
      _$MonthStatsFromJson(json);
}

@freezed
class ProductivityTrend with _$ProductivityTrend {
  const factory ProductivityTrend({
    required String period,
    @JsonKey(name: 'tasks_completed') required int tasksCompleted,
    @JsonKey(name: 'time_tracked') required int timeTracked,
    @JsonKey(name: 'memories_created') required int memoriesCreated,
  }) = _ProductivityTrend;

  factory ProductivityTrend.fromJson(Map<String, dynamic> json) =>
      _$ProductivityTrendFromJson(json);
}

@freezed
class CategoryStats with _$CategoryStats {
  const factory CategoryStats({
    @JsonKey(name: 'category_id') required String categoryId,
    @JsonKey(name: 'category_name') required String categoryName,
    @JsonKey(name: 'memories_count') required int memoriesCount,
    @JsonKey(name: 'tasks_count') required int tasksCount,
    @JsonKey(name: 'completion_rate') required double completionRate,
  }) = _CategoryStats;

  factory CategoryStats.fromJson(Map<String, dynamic> json) =>
      _$CategoryStatsFromJson(json);
}

@freezed
class AnalyticsDashboard with _$AnalyticsDashboard {
  const factory AnalyticsDashboard({
    @JsonKey(name: 'current_month') required MonthStats currentMonth,
    @JsonKey(name: 'productivity_trends')
    required List<ProductivityTrend> productivityTrends,
    @JsonKey(name: 'category_stats') required List<CategoryStats> categoryStats,
    @JsonKey(name: 'current_streak') @Default(0) int currentStreak,
    @JsonKey(name: 'longest_streak') @Default(0) int longestStreak,
    @JsonKey(name: 'total_memories') required int totalMemories,
    @JsonKey(name: 'total_tasks_completed') required int totalTasksCompleted,
    @JsonKey(name: 'total_time_tracked') required int totalTimeTracked,
    @JsonKey(name: 'total_stories') required int totalStories,
    @JsonKey(name: 'this_week_memories') required int thisWeekMemories,
    @JsonKey(name: 'this_week_tasks') required int thisWeekTasks,
    @JsonKey(name: 'this_week_time') required int thisWeekTime,
  }) = _AnalyticsDashboard;

  factory AnalyticsDashboard.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsDashboardFromJson(json);
}
