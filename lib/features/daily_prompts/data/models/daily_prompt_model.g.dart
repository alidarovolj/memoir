// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_prompt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyPromptModelImpl _$$DailyPromptModelImplFromJson(
  Map<String, dynamic> json,
) => _$DailyPromptModelImpl(
  id: json['id'] as String,
  promptText: json['prompt_text'] as String,
  promptIcon: json['prompt_icon'] as String,
  category: $enumDecode(_$PromptCategoryEnumMap, json['category']),
  promptType: $enumDecode(_$PromptTypeEnumMap, json['prompt_type']),
  isActive: json['is_active'] as bool,
  orderIndex: (json['order_index'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$DailyPromptModelImplToJson(
  _$DailyPromptModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'prompt_text': instance.promptText,
  'prompt_icon': instance.promptIcon,
  'category': _$PromptCategoryEnumMap[instance.category]!,
  'prompt_type': _$PromptTypeEnumMap[instance.promptType]!,
  'is_active': instance.isActive,
  'order_index': instance.orderIndex,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

const _$PromptCategoryEnumMap = {
  PromptCategory.morning: 'MORNING',
  PromptCategory.daytime: 'DAYTIME',
  PromptCategory.evening: 'EVENING',
  PromptCategory.weekly: 'WEEKLY',
};

const _$PromptTypeEnumMap = {
  PromptType.gratitude: 'GRATITUDE',
  PromptType.reflection: 'REFLECTION',
  PromptType.learning: 'LEARNING',
  PromptType.goal: 'GOAL',
  PromptType.emotion: 'EMOTION',
  PromptType.creativity: 'CREATIVITY',
};
