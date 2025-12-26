// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeModelImpl _$$ChallengeModelImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      emoji: json['emoji'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      goal: json['goal'] as Map<String, dynamic>,
      participantsCount: (json['participants_count'] as num).toInt(),
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      isOngoing: json['is_ongoing'] as bool?,
      daysRemaining: (json['days_remaining'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ChallengeModelImplToJson(
  _$ChallengeModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'emoji': instance.emoji,
  'start_date': instance.startDate.toIso8601String(),
  'end_date': instance.endDate.toIso8601String(),
  'goal': instance.goal,
  'participants_count': instance.participantsCount,
  'is_active': instance.isActive,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'is_ongoing': instance.isOngoing,
  'days_remaining': instance.daysRemaining,
};

_$ChallengeGoalImpl _$$ChallengeGoalImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeGoalImpl(
      type: json['type'] as String,
      target: (json['target'] as num).toInt(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$$ChallengeGoalImplToJson(_$ChallengeGoalImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'target': instance.target,
      'description': instance.description,
    };

_$ChallengeParticipantModelImpl _$$ChallengeParticipantModelImplFromJson(
  Map<String, dynamic> json,
) => _$ChallengeParticipantModelImpl(
  id: json['id'] as String,
  challengeId: json['challenge_id'] as String,
  userId: json['user_id'] as String,
  progress: (json['progress'] as num).toInt(),
  completed: json['completed'] as bool,
  joinedAt: DateTime.parse(json['joined_at'] as String),
  completedAt: json['completed_at'] == null
      ? null
      : DateTime.parse(json['completed_at'] as String),
);

Map<String, dynamic> _$$ChallengeParticipantModelImplToJson(
  _$ChallengeParticipantModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'challenge_id': instance.challengeId,
  'user_id': instance.userId,
  'progress': instance.progress,
  'completed': instance.completed,
  'joined_at': instance.joinedAt.toIso8601String(),
  'completed_at': instance.completedAt?.toIso8601String(),
};

_$ChallengeProgressModelImpl _$$ChallengeProgressModelImplFromJson(
  Map<String, dynamic> json,
) => _$ChallengeProgressModelImpl(
  challengeId: json['challenge_id'] as String,
  challengeTitle: json['challenge_title'] as String,
  challengeEmoji: json['challenge_emoji'] as String,
  goal: json['goal'] as Map<String, dynamic>,
  progress: (json['progress'] as num).toInt(),
  target: (json['target'] as num).toInt(),
  completed: json['completed'] as bool,
  percentage: (json['percentage'] as num).toDouble(),
  rank: (json['rank'] as num?)?.toInt(),
  joinedAt: DateTime.parse(json['joined_at'] as String),
);

Map<String, dynamic> _$$ChallengeProgressModelImplToJson(
  _$ChallengeProgressModelImpl instance,
) => <String, dynamic>{
  'challenge_id': instance.challengeId,
  'challenge_title': instance.challengeTitle,
  'challenge_emoji': instance.challengeEmoji,
  'goal': instance.goal,
  'progress': instance.progress,
  'target': instance.target,
  'completed': instance.completed,
  'percentage': instance.percentage,
  'rank': instance.rank,
  'joined_at': instance.joinedAt.toIso8601String(),
};

_$LeaderboardEntryImpl _$$LeaderboardEntryImplFromJson(
  Map<String, dynamic> json,
) => _$LeaderboardEntryImpl(
  rank: (json['rank'] as num).toInt(),
  userId: json['user_id'] as String,
  username: json['username'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  progress: (json['progress'] as num).toInt(),
  completed: json['completed'] as bool,
  percentage: (json['percentage'] as num).toDouble(),
);

Map<String, dynamic> _$$LeaderboardEntryImplToJson(
  _$LeaderboardEntryImpl instance,
) => <String, dynamic>{
  'rank': instance.rank,
  'user_id': instance.userId,
  'username': instance.username,
  'avatar_url': instance.avatarUrl,
  'progress': instance.progress,
  'completed': instance.completed,
  'percentage': instance.percentage,
};

_$ChallengeLeaderboardImpl _$$ChallengeLeaderboardImplFromJson(
  Map<String, dynamic> json,
) => _$ChallengeLeaderboardImpl(
  challengeId: json['challenge_id'] as String,
  challengeTitle: json['challenge_title'] as String,
  entries: (json['entries'] as List<dynamic>)
      .map((e) => LeaderboardEntry.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalParticipants: (json['total_participants'] as num).toInt(),
  userRank: (json['user_rank'] as num?)?.toInt(),
);

Map<String, dynamic> _$$ChallengeLeaderboardImplToJson(
  _$ChallengeLeaderboardImpl instance,
) => <String, dynamic>{
  'challenge_id': instance.challengeId,
  'challenge_title': instance.challengeTitle,
  'entries': instance.entries,
  'total_participants': instance.totalParticipants,
  'user_rank': instance.userRank,
};
