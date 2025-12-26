import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'achievement_model.freezed.dart';
part 'achievement_model.g.dart';

/// Achievement Progress Model
@freezed
class AchievementProgress with _$AchievementProgress {
  const factory AchievementProgress({
    @JsonKey(name: 'achievement_id') required String achievementId,
    @JsonKey(name: 'achievement_code') required String achievementCode,
    required String title,
    required String description,
    required String emoji,
    @JsonKey(name: 'achievement_type') required String achievementType,
    @JsonKey(name: 'criteria_count') required int criteriaCount,
    required int progress,
    required bool unlocked,
    @JsonKey(name: 'unlocked_at') DateTime? unlockedAt,
    required double percentage,
    @JsonKey(name: 'xp_reward') required int xpReward,
  }) = _AchievementProgress;

  factory AchievementProgress.fromJson(Map<String, dynamic> json) =>
      _$AchievementProgressFromJson(json);
}

/// Achievement List Response
@freezed
class AchievementList with _$AchievementList {
  const factory AchievementList({
    required List<AchievementProgress> unlocked,
    @JsonKey(name: 'in_progress') required List<AchievementProgress> inProgress,
    required List<AchievementProgress> locked,
  }) = _AchievementList;

  factory AchievementList.fromJson(Map<String, dynamic> json) =>
      _$AchievementListFromJson(json);
}

/// Extensions for UI
extension AchievementProgressX on AchievementProgress {
  /// Get category color
  List<int> get categoryColor {
    switch (achievementType) {
      case 'MEMORIES':
        return [138, 43, 226]; // Purple
      case 'TASKS':
        return [52, 199, 89]; // Green
      case 'STREAKS':
        return [255, 149, 0]; // Orange
      case 'SOCIAL':
        return [0, 122, 255]; // Blue
      case 'PET':
        return [255, 45, 85]; // Pink
      default:
        return [142, 142, 147]; // Gray
    }
  }

  /// Get readable type name
  String get typeName {
    switch (achievementType) {
      case 'MEMORIES':
        return 'Воспоминания';
      case 'TASKS':
        return 'Задачи';
      case 'STREAKS':
        return 'Серии';
      case 'SOCIAL':
        return 'Социальное';
      case 'PET':
        return 'Питомец';
      default:
        return 'Другое';
    }
  }
}
