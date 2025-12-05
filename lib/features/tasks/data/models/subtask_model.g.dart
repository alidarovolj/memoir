// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtask_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubtaskModelImpl _$$SubtaskModelImplFromJson(Map<String, dynamic> json) =>
    _$SubtaskModelImpl(
      id: json['id'] as String,
      task_id: json['task_id'] as String,
      title: json['title'] as String,
      is_completed: json['is_completed'] as bool? ?? false,
      order: (json['order'] as num?)?.toInt() ?? 0,
      created_at: DateTime.parse(json['created_at'] as String),
      updated_at: DateTime.parse(json['updated_at'] as String),
      completed_at: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
    );

Map<String, dynamic> _$$SubtaskModelImplToJson(_$SubtaskModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_id': instance.task_id,
      'title': instance.title,
      'is_completed': instance.is_completed,
      'order': instance.order,
      'created_at': instance.created_at.toIso8601String(),
      'updated_at': instance.updated_at.toIso8601String(),
      'completed_at': instance.completed_at?.toIso8601String(),
    };

_$SubtaskCreateImpl _$$SubtaskCreateImplFromJson(Map<String, dynamic> json) =>
    _$SubtaskCreateImpl(
      title: json['title'] as String,
      is_completed: json['is_completed'] as bool? ?? false,
      order: (json['order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$SubtaskCreateImplToJson(_$SubtaskCreateImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'is_completed': instance.is_completed,
      'order': instance.order,
    };

_$SubtaskUpdateImpl _$$SubtaskUpdateImplFromJson(Map<String, dynamic> json) =>
    _$SubtaskUpdateImpl(
      title: json['title'] as String?,
      is_completed: json['is_completed'] as bool?,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SubtaskUpdateImplToJson(_$SubtaskUpdateImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'is_completed': instance.is_completed,
      'order': instance.order,
    };
