// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_suggestion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskSuggestionModelImpl _$$TaskSuggestionModelImplFromJson(
  Map<String, dynamic> json,
) => _$TaskSuggestionModelImpl(
  title: json['title'] as String,
  description: json['description'] as String,
  timeScope: json['time_scope'] as String,
  priority: json['priority'] as String,
  confidence: (json['confidence'] as num).toDouble(),
  reasoning: json['reasoning'] as String,
  category: json['category'] as String?,
);

Map<String, dynamic> _$$TaskSuggestionModelImplToJson(
  _$TaskSuggestionModelImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'time_scope': instance.timeScope,
  'priority': instance.priority,
  'confidence': instance.confidence,
  'reasoning': instance.reasoning,
  'category': instance.category,
};
