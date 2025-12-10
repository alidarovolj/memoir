// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DayActivityImpl _$$DayActivityImplFromJson(Map<String, dynamic> json) =>
    _$DayActivityImpl(
      date: DateTime.parse(json['date'] as String),
      memoriesCount: (json['memories_count'] as num?)?.toInt() ?? 0,
      tasksCompleted: (json['tasks_completed'] as num?)?.toInt() ?? 0,
      timeTracked: (json['time_tracked'] as num?)?.toInt() ?? 0,
      storiesCreated: (json['stories_created'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DayActivityImplToJson(_$DayActivityImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'memories_count': instance.memoriesCount,
      'tasks_completed': instance.tasksCompleted,
      'time_tracked': instance.timeTracked,
      'stories_created': instance.storiesCreated,
    };

_$MonthStatsImpl _$$MonthStatsImplFromJson(Map<String, dynamic> json) =>
    _$MonthStatsImpl(
      month: (json['month'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      totalMemories: (json['total_memories'] as num).toInt(),
      totalTasksCompleted: (json['total_tasks_completed'] as num).toInt(),
      totalTimeTracked: (json['total_time_tracked'] as num).toInt(),
      totalStories: (json['total_stories'] as num).toInt(),
      dailyActivities: (json['daily_activities'] as List<dynamic>)
          .map((e) => DayActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MonthStatsImplToJson(_$MonthStatsImpl instance) =>
    <String, dynamic>{
      'month': instance.month,
      'year': instance.year,
      'total_memories': instance.totalMemories,
      'total_tasks_completed': instance.totalTasksCompleted,
      'total_time_tracked': instance.totalTimeTracked,
      'total_stories': instance.totalStories,
      'daily_activities': instance.dailyActivities,
    };

_$ProductivityTrendImpl _$$ProductivityTrendImplFromJson(
  Map<String, dynamic> json,
) => _$ProductivityTrendImpl(
  period: json['period'] as String,
  tasksCompleted: (json['tasks_completed'] as num).toInt(),
  timeTracked: (json['time_tracked'] as num).toInt(),
  memoriesCreated: (json['memories_created'] as num).toInt(),
);

Map<String, dynamic> _$$ProductivityTrendImplToJson(
  _$ProductivityTrendImpl instance,
) => <String, dynamic>{
  'period': instance.period,
  'tasks_completed': instance.tasksCompleted,
  'time_tracked': instance.timeTracked,
  'memories_created': instance.memoriesCreated,
};

_$CategoryStatsImpl _$$CategoryStatsImplFromJson(Map<String, dynamic> json) =>
    _$CategoryStatsImpl(
      categoryId: json['category_id'] as String,
      categoryName: json['category_name'] as String,
      memoriesCount: (json['memories_count'] as num).toInt(),
      tasksCount: (json['tasks_count'] as num).toInt(),
      completionRate: (json['completion_rate'] as num).toDouble(),
    );

Map<String, dynamic> _$$CategoryStatsImplToJson(_$CategoryStatsImpl instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'memories_count': instance.memoriesCount,
      'tasks_count': instance.tasksCount,
      'completion_rate': instance.completionRate,
    };

_$AnalyticsDashboardImpl _$$AnalyticsDashboardImplFromJson(
  Map<String, dynamic> json,
) => _$AnalyticsDashboardImpl(
  currentMonth: MonthStats.fromJson(
    json['current_month'] as Map<String, dynamic>,
  ),
  productivityTrends: (json['productivity_trends'] as List<dynamic>)
      .map((e) => ProductivityTrend.fromJson(e as Map<String, dynamic>))
      .toList(),
  categoryStats: (json['category_stats'] as List<dynamic>)
      .map((e) => CategoryStats.fromJson(e as Map<String, dynamic>))
      .toList(),
  currentStreak: (json['current_streak'] as num?)?.toInt() ?? 0,
  longestStreak: (json['longest_streak'] as num?)?.toInt() ?? 0,
  totalMemories: (json['total_memories'] as num).toInt(),
  totalTasksCompleted: (json['total_tasks_completed'] as num).toInt(),
  totalTimeTracked: (json['total_time_tracked'] as num).toInt(),
  totalStories: (json['total_stories'] as num).toInt(),
  thisWeekMemories: (json['this_week_memories'] as num).toInt(),
  thisWeekTasks: (json['this_week_tasks'] as num).toInt(),
  thisWeekTime: (json['this_week_time'] as num).toInt(),
);

Map<String, dynamic> _$$AnalyticsDashboardImplToJson(
  _$AnalyticsDashboardImpl instance,
) => <String, dynamic>{
  'current_month': instance.currentMonth,
  'productivity_trends': instance.productivityTrends,
  'category_stats': instance.categoryStats,
  'current_streak': instance.currentStreak,
  'longest_streak': instance.longestStreak,
  'total_memories': instance.totalMemories,
  'total_tasks_completed': instance.totalTasksCompleted,
  'total_time_tracked': instance.totalTimeTracked,
  'total_stories': instance.totalStories,
  'this_week_memories': instance.thisWeekMemories,
  'this_week_tasks': instance.thisWeekTasks,
  'this_week_time': instance.thisWeekTime,
};
