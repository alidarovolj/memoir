import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'ai_story_model.freezed.dart';
part 'ai_story_model.g.dart';

/// Story Type Enum
enum StoryType {
  @JsonValue('poem')
  poem,
  @JsonValue('haiku')
  haiku,
  @JsonValue('story')
  story,
  @JsonValue('letter')
  letter,
  @JsonValue('gratitude')
  gratitude,
}

/// Story Generation Request
@freezed
class StoryGenerationRequest with _$StoryGenerationRequest {
  const factory StoryGenerationRequest({
    @JsonKey(name: 'story_type') required StoryType storyType,
    @JsonKey(name: 'memory_id') String? memoryId,
    @JsonKey(name: 'custom_prompt') String? customPrompt,
  }) = _StoryGenerationRequest;

  factory StoryGenerationRequest.fromJson(Map<String, dynamic> json) =>
      _$StoryGenerationRequestFromJson(json);
}

/// Story Generation Response
@freezed
class StoryGenerationResponse with _$StoryGenerationResponse {
  const factory StoryGenerationResponse({
    @JsonKey(name: 'story_type') required String storyType,
    @JsonKey(name: 'generated_text') required String generatedText,
    @JsonKey(name: 'source_memory_id') String? sourceMemoryId,
    @JsonKey(name: 'tokens_used') required int tokensUsed,
  }) = _StoryGenerationResponse;

  factory StoryGenerationResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryGenerationResponseFromJson(json);
}

/// Chat Message
@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({required String role, required String content}) =
      _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}

/// Chat With Past Request
@freezed
class ChatWithPastRequest with _$ChatWithPastRequest {
  const factory ChatWithPastRequest({
    required String message,
    @JsonKey(name: 'conversation_history')
    List<ChatMessage>? conversationHistory,
  }) = _ChatWithPastRequest;

  factory ChatWithPastRequest.fromJson(Map<String, dynamic> json) =>
      _$ChatWithPastRequestFromJson(json);
}

/// Chat With Past Response
@freezed
class ChatWithPastResponse with _$ChatWithPastResponse {
  const factory ChatWithPastResponse({
    required String response,
    @JsonKey(name: 'tokens_used') required int tokensUsed,
  }) = _ChatWithPastResponse;

  factory ChatWithPastResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatWithPastResponseFromJson(json);
}

/// Year Summary Request
@freezed
class YearSummaryRequest with _$YearSummaryRequest {
  const factory YearSummaryRequest({int? year}) = _YearSummaryRequest;

  factory YearSummaryRequest.fromJson(Map<String, dynamic> json) =>
      _$YearSummaryRequestFromJson(json);
}

/// Year Summary Response
@freezed
class YearSummaryResponse with _$YearSummaryResponse {
  const factory YearSummaryResponse({
    required int year,
    required String summary,
    @JsonKey(name: 'memories_count') required int memoriesCount,
    @JsonKey(name: 'tokens_used') required int tokensUsed,
  }) = _YearSummaryResponse;

  factory YearSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$YearSummaryResponseFromJson(json);
}

/// Extensions for UI
extension StoryTypeX on StoryType {
  String get displayName {
    switch (this) {
      case StoryType.poem:
        return 'Стихотворение';
      case StoryType.haiku:
        return 'Хайку';
      case StoryType.story:
        return 'Рассказ';
      case StoryType.letter:
        return 'Письмо себе';
      case StoryType.gratitude:
        return 'Благодарность';
    }
  }

  String get icon {
    switch (this) {
      case StoryType.poem:
        return '📜';
      case StoryType.haiku:
        return '🎋';
      case StoryType.story:
        return '📖';
      case StoryType.letter:
        return '✉️';
      case StoryType.gratitude:
        return '🙏';
    }
  }

  String get description {
    switch (this) {
      case StoryType.poem:
        return 'Лирическое стихотворение с метафорами';
      case StoryType.haiku:
        return 'Японская поэзия 5-7-5 слогов';
      case StoryType.story:
        return 'Короткий рассказ с деталями';
      case StoryType.letter:
        return 'Письмо будущему себе';
      case StoryType.gratitude:
        return 'Текст благодарности';
    }
  }
}
