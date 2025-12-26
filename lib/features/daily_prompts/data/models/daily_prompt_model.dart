import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_prompt_model.freezed.dart';
part 'daily_prompt_model.g.dart';

/// Category of daily prompt
enum PromptCategory {
  @JsonValue('MORNING')
  morning,
  @JsonValue('DAYTIME')
  daytime,
  @JsonValue('EVENING')
  evening,
  @JsonValue('WEEKLY')
  weekly,
}

/// Type of prompt
enum PromptType {
  @JsonValue('GRATITUDE')
  gratitude,
  @JsonValue('REFLECTION')
  reflection,
  @JsonValue('LEARNING')
  learning,
  @JsonValue('GOAL')
  goal,
  @JsonValue('EMOTION')
  emotion,
  @JsonValue('CREATIVITY')
  creativity,
}

/// Daily Prompt Model
@freezed
class DailyPromptModel with _$DailyPromptModel {
  const factory DailyPromptModel({
    required String id,
    @JsonKey(name: 'prompt_text') required String promptText,
    @JsonKey(name: 'prompt_icon') required String promptIcon,
    required PromptCategory category,
    @JsonKey(name: 'prompt_type') required PromptType promptType,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'order_index') required int orderIndex,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _DailyPromptModel;

  factory DailyPromptModel.fromJson(Map<String, dynamic> json) =>
      _$DailyPromptModelFromJson(json);
}

/// Extension for DailyPromptModel
extension DailyPromptModelX on DailyPromptModel {
  /// Get category name in Russian
  String get categoryName {
    switch (category) {
      case PromptCategory.morning:
        return 'Утро';
      case PromptCategory.daytime:
        return 'День';
      case PromptCategory.evening:
        return 'Вечер';
      case PromptCategory.weekly:
        return 'Еженедельно';
    }
  }

  /// Get type name in Russian
  String get typeName {
    switch (promptType) {
      case PromptType.gratitude:
        return 'Благодарность';
      case PromptType.reflection:
        return 'Рефлексия';
      case PromptType.learning:
        return 'Обучение';
      case PromptType.goal:
        return 'Цели';
      case PromptType.emotion:
        return 'Эмоции';
      case PromptType.creativity:
        return 'Креатив';
    }
  }

  /// Get gradient colors based on category
  List<int> get gradientColors {
    switch (category) {
      case PromptCategory.morning:
        return [0xFFFFA726, 0xFFFF7043]; // Orange sunrise
      case PromptCategory.daytime:
        return [0xFF42A5F5, 0xFF1E88E5]; // Blue sky
      case PromptCategory.evening:
        return [0xFF7E57C2, 0xFF5E35B1]; // Purple dusk
      case PromptCategory.weekly:
        return [0xFF26A69A, 0xFF00897B]; // Teal
    }
  }
}
