import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'challenge_model.freezed.dart';
part 'challenge_model.g.dart';

/// Global Challenge Model
@freezed
class ChallengeModel with _$ChallengeModel {
  const factory ChallengeModel({
    required String id,
    required String title,
    required String description,
    required String emoji,
    @JsonKey(name: 'start_date') required DateTime startDate,
    @JsonKey(name: 'end_date') required DateTime endDate,
    required Map<String, dynamic> goal,
    @JsonKey(name: 'participants_count') required int participantsCount,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'is_ongoing') bool? isOngoing,
    @JsonKey(name: 'days_remaining') int? daysRemaining,
  }) = _ChallengeModel;

  factory ChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeModelFromJson(json);
}

/// Challenge Goal Model
@freezed
class ChallengeGoal with _$ChallengeGoal {
  const factory ChallengeGoal({
    required String type,
    required int target,
    required String description,
  }) = _ChallengeGoal;

  factory ChallengeGoal.fromJson(Map<String, dynamic> json) =>
      _$ChallengeGoalFromJson(json);
}

/// Challenge Participant Model
@freezed
class ChallengeParticipantModel with _$ChallengeParticipantModel {
  const factory ChallengeParticipantModel({
    required String id,
    @JsonKey(name: 'challenge_id') required String challengeId,
    @JsonKey(name: 'user_id') required String userId,
    required int progress,
    required bool completed,
    @JsonKey(name: 'joined_at') required DateTime joinedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
  }) = _ChallengeParticipantModel;

  factory ChallengeParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeParticipantModelFromJson(json);
}

/// User's Progress in a Challenge
@freezed
class ChallengeProgressModel with _$ChallengeProgressModel {
  const factory ChallengeProgressModel({
    @JsonKey(name: 'challenge_id') required String challengeId,
    @JsonKey(name: 'challenge_title') required String challengeTitle,
    @JsonKey(name: 'challenge_emoji') required String challengeEmoji,
    required Map<String, dynamic> goal,
    required int progress,
    required int target,
    required bool completed,
    required double percentage,
    int? rank,
    @JsonKey(name: 'joined_at') required DateTime joinedAt,
  }) = _ChallengeProgressModel;

  factory ChallengeProgressModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeProgressModelFromJson(json);
}

/// Leaderboard Entry
@freezed
class LeaderboardEntry with _$LeaderboardEntry {
  const factory LeaderboardEntry({
    required int rank,
    @JsonKey(name: 'user_id') required String userId,
    String? username,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    required int progress,
    required bool completed,
    required double percentage,
  }) = _LeaderboardEntry;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryFromJson(json);
}

/// Challenge Leaderboard
@freezed
class ChallengeLeaderboard with _$ChallengeLeaderboard {
  const factory ChallengeLeaderboard({
    @JsonKey(name: 'challenge_id') required String challengeId,
    @JsonKey(name: 'challenge_title') required String challengeTitle,
    required List<LeaderboardEntry> entries,
    @JsonKey(name: 'total_participants') required int totalParticipants,
    @JsonKey(name: 'user_rank') int? userRank,
  }) = _ChallengeLeaderboard;

  factory ChallengeLeaderboard.fromJson(Map<String, dynamic> json) =>
      _$ChallengeLeaderboardFromJson(json);
}

/// Extensions for UI
extension ChallengeModelX on ChallengeModel {
  /// Get goal type as readable string
  String get goalTypeText {
    final type = goal['type'] as String?;
    switch (type) {
      case 'create_memories':
        return 'Создать воспоминания';
      case 'complete_tasks':
        return 'Завершить задачи';
      case 'daily_streak':
        return 'Ежедневная серия';
      default:
        return 'Челлендж';
    }
  }

  /// Get target from goal
  int get targetCount => (goal['target'] as num?)?.toInt() ?? 0;

  /// Get goal description
  String get goalDescription => goal['description'] as String? ?? '';

  /// Check if challenge has ended
  bool get hasEnded => DateTime.now().isAfter(endDate);

  /// Check if challenge has started
  bool get hasStarted => DateTime.now().isAfter(startDate);

  /// Get progress color based on time remaining
  List<int> get statusColor {
    if (hasEnded) return [158, 158, 158]; // Gray
    if (daysRemaining != null && daysRemaining! <= 3) {
      return [255, 59, 48]; // Red
    }
    if (daysRemaining != null && daysRemaining! <= 7) {
      return [255, 149, 0]; // Orange
    }
    return [52, 199, 89]; // Green
  }
}
