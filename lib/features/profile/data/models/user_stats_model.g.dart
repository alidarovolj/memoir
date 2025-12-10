// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserStatsModelImpl _$$UserStatsModelImplFromJson(Map<String, dynamic> json) =>
    _$UserStatsModelImpl(
      memoriesCount: (json['memories_count'] as num).toInt(),
      tasksTotal: (json['tasks_total'] as num).toInt(),
      tasksCompleted: (json['tasks_completed'] as num).toInt(),
      tasksInProgress: (json['tasks_in_progress'] as num).toInt(),
      storiesCount: (json['stories_count'] as num).toInt(),
      totalTimeTracked: (json['total_time_tracked'] as num).toInt(),
    );

Map<String, dynamic> _$$UserStatsModelImplToJson(
  _$UserStatsModelImpl instance,
) => <String, dynamic>{
  'memories_count': instance.memoriesCount,
  'tasks_total': instance.tasksTotal,
  'tasks_completed': instance.tasksCompleted,
  'tasks_in_progress': instance.tasksInProgress,
  'stories_count': instance.storiesCount,
  'total_time_tracked': instance.totalTimeTracked,
};
