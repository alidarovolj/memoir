// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_time_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskTimeLogModelImpl _$$TaskTimeLogModelImplFromJson(
  Map<String, dynamic> json,
) => _$TaskTimeLogModelImpl(
  id: json['id'] as String,
  taskId: json['taskId'] as String,
  userId: json['userId'] as String,
  startTime: DateTime.parse(json['startTime'] as String),
  endTime: json['endTime'] == null
      ? null
      : DateTime.parse(json['endTime'] as String),
  duration: (json['duration'] as num?)?.toInt(),
  notes: json['notes'] as String?,
  isActive: json['isActive'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$TaskTimeLogModelImplToJson(
  _$TaskTimeLogModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'taskId': instance.taskId,
  'userId': instance.userId,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime?.toIso8601String(),
  'duration': instance.duration,
  'notes': instance.notes,
  'isActive': instance.isActive,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

_$TaskTimeStatsImpl _$$TaskTimeStatsImplFromJson(Map<String, dynamic> json) =>
    _$TaskTimeStatsImpl(
      taskId: json['taskId'] as String,
      taskTitle: json['taskTitle'] as String,
      totalDuration: (json['totalDuration'] as num).toInt(),
      sessionCount: (json['sessionCount'] as num).toInt(),
      averageSession: (json['averageSession'] as num).toInt(),
      lastWorked: json['lastWorked'] == null
          ? null
          : DateTime.parse(json['lastWorked'] as String),
    );

Map<String, dynamic> _$$TaskTimeStatsImplToJson(_$TaskTimeStatsImpl instance) =>
    <String, dynamic>{
      'taskId': instance.taskId,
      'taskTitle': instance.taskTitle,
      'totalDuration': instance.totalDuration,
      'sessionCount': instance.sessionCount,
      'averageSession': instance.averageSession,
      'lastWorked': instance.lastWorked?.toIso8601String(),
    };

_$TimeStatsResponseImpl _$$TimeStatsResponseImplFromJson(
  Map<String, dynamic> json,
) => _$TimeStatsResponseImpl(
  totalTimeToday: (json['totalTimeToday'] as num).toInt(),
  totalTimeWeek: (json['totalTimeWeek'] as num).toInt(),
  totalTimeMonth: (json['totalTimeMonth'] as num).toInt(),
  activeTaskId: json['activeTaskId'] as String?,
  tasks:
      (json['tasks'] as List<dynamic>?)
          ?.map((e) => TaskTimeStats.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$TimeStatsResponseImplToJson(
  _$TimeStatsResponseImpl instance,
) => <String, dynamic>{
  'totalTimeToday': instance.totalTimeToday,
  'totalTimeWeek': instance.totalTimeWeek,
  'totalTimeMonth': instance.totalTimeMonth,
  'activeTaskId': instance.activeTaskId,
  'tasks': instance.tasks,
};
