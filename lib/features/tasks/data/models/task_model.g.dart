// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskModelImpl _$$TaskModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskModelImpl(
      id: json['id'] as String,
      user_id: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      due_date: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
      completed_at: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      status: $enumDecode(_$TaskStatusEnumMap, json['status']),
      priority: $enumDecode(_$TaskPriorityEnumMap, json['priority']),
      time_scope: $enumDecode(_$TimeScopeEnumMap, json['time_scope']),
      category_id: json['category_id'] as String?,
      category_name: json['category_name'] as String?,
      related_memory_id: json['related_memory_id'] as String?,
      ai_suggested: json['ai_suggested'] as bool,
      ai_confidence: (json['ai_confidence'] as num?)?.toDouble(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      created_at: DateTime.parse(json['created_at'] as String),
      updated_at: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$TaskModelImplToJson(_$TaskModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'title': instance.title,
      'description': instance.description,
      'due_date': instance.due_date?.toIso8601String(),
      'completed_at': instance.completed_at?.toIso8601String(),
      'status': _$TaskStatusEnumMap[instance.status]!,
      'priority': _$TaskPriorityEnumMap[instance.priority]!,
      'time_scope': _$TimeScopeEnumMap[instance.time_scope]!,
      'category_id': instance.category_id,
      'category_name': instance.category_name,
      'related_memory_id': instance.related_memory_id,
      'ai_suggested': instance.ai_suggested,
      'ai_confidence': instance.ai_confidence,
      'tags': instance.tags,
      'created_at': instance.created_at.toIso8601String(),
      'updated_at': instance.updated_at.toIso8601String(),
    };

const _$TaskStatusEnumMap = {
  TaskStatus.pending: 'pending',
  TaskStatus.inProgress: 'in_progress',
  TaskStatus.completed: 'completed',
  TaskStatus.cancelled: 'cancelled',
};

const _$TaskPriorityEnumMap = {
  TaskPriority.low: 'low',
  TaskPriority.medium: 'medium',
  TaskPriority.high: 'high',
  TaskPriority.urgent: 'urgent',
};

const _$TimeScopeEnumMap = {
  TimeScope.daily: 'daily',
  TimeScope.weekly: 'weekly',
  TimeScope.monthly: 'monthly',
  TimeScope.longTerm: 'long_term',
};

_$TaskAnalyzeResponseImpl _$$TaskAnalyzeResponseImplFromJson(
  Map<String, dynamic> json,
) => _$TaskAnalyzeResponseImpl(
  time_scope: $enumDecode(_$TimeScopeEnumMap, json['time_scope']),
  priority: $enumDecode(_$TaskPriorityEnumMap, json['priority']),
  suggested_time: json['suggested_time'] as String?,
  needs_deadline: json['needs_deadline'] as bool? ?? false,
  category: json['category'] as String?,
  confidence: (json['confidence'] as num).toDouble(),
  reasoning: json['reasoning'] as String,
);

Map<String, dynamic> _$$TaskAnalyzeResponseImplToJson(
  _$TaskAnalyzeResponseImpl instance,
) => <String, dynamic>{
  'time_scope': _$TimeScopeEnumMap[instance.time_scope]!,
  'priority': _$TaskPriorityEnumMap[instance.priority]!,
  'suggested_time': instance.suggested_time,
  'needs_deadline': instance.needs_deadline,
  'category': instance.category,
  'confidence': instance.confidence,
  'reasoning': instance.reasoning,
};
