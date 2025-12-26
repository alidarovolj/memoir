// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryGenerationRequestImpl _$$StoryGenerationRequestImplFromJson(
  Map<String, dynamic> json,
) => _$StoryGenerationRequestImpl(
  storyType: $enumDecode(_$StoryTypeEnumMap, json['story_type']),
  memoryId: json['memory_id'] as String?,
  customPrompt: json['custom_prompt'] as String?,
);

Map<String, dynamic> _$$StoryGenerationRequestImplToJson(
  _$StoryGenerationRequestImpl instance,
) => <String, dynamic>{
  'story_type': _$StoryTypeEnumMap[instance.storyType]!,
  'memory_id': instance.memoryId,
  'custom_prompt': instance.customPrompt,
};

const _$StoryTypeEnumMap = {
  StoryType.poem: 'poem',
  StoryType.haiku: 'haiku',
  StoryType.story: 'story',
  StoryType.letter: 'letter',
  StoryType.gratitude: 'gratitude',
};

_$StoryGenerationResponseImpl _$$StoryGenerationResponseImplFromJson(
  Map<String, dynamic> json,
) => _$StoryGenerationResponseImpl(
  storyType: json['story_type'] as String,
  generatedText: json['generated_text'] as String,
  sourceMemoryId: json['source_memory_id'] as String?,
  tokensUsed: (json['tokens_used'] as num).toInt(),
);

Map<String, dynamic> _$$StoryGenerationResponseImplToJson(
  _$StoryGenerationResponseImpl instance,
) => <String, dynamic>{
  'story_type': instance.storyType,
  'generated_text': instance.generatedText,
  'source_memory_id': instance.sourceMemoryId,
  'tokens_used': instance.tokensUsed,
};

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      role: json['role'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{'role': instance.role, 'content': instance.content};

_$ChatWithPastRequestImpl _$$ChatWithPastRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ChatWithPastRequestImpl(
  message: json['message'] as String,
  conversationHistory: (json['conversation_history'] as List<dynamic>?)
      ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$ChatWithPastRequestImplToJson(
  _$ChatWithPastRequestImpl instance,
) => <String, dynamic>{
  'message': instance.message,
  'conversation_history': instance.conversationHistory,
};

_$ChatWithPastResponseImpl _$$ChatWithPastResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ChatWithPastResponseImpl(
  response: json['response'] as String,
  tokensUsed: (json['tokens_used'] as num).toInt(),
);

Map<String, dynamic> _$$ChatWithPastResponseImplToJson(
  _$ChatWithPastResponseImpl instance,
) => <String, dynamic>{
  'response': instance.response,
  'tokens_used': instance.tokensUsed,
};

_$YearSummaryRequestImpl _$$YearSummaryRequestImplFromJson(
  Map<String, dynamic> json,
) => _$YearSummaryRequestImpl(year: (json['year'] as num?)?.toInt());

Map<String, dynamic> _$$YearSummaryRequestImplToJson(
  _$YearSummaryRequestImpl instance,
) => <String, dynamic>{'year': instance.year};

_$YearSummaryResponseImpl _$$YearSummaryResponseImplFromJson(
  Map<String, dynamic> json,
) => _$YearSummaryResponseImpl(
  year: (json['year'] as num).toInt(),
  summary: json['summary'] as String,
  memoriesCount: (json['memories_count'] as num).toInt(),
  tokensUsed: (json['tokens_used'] as num).toInt(),
);

Map<String, dynamic> _$$YearSummaryResponseImplToJson(
  _$YearSummaryResponseImpl instance,
) => <String, dynamic>{
  'year': instance.year,
  'summary': instance.summary,
  'memories_count': instance.memoriesCount,
  'tokens_used': instance.tokensUsed,
};
