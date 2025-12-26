// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AchievementProgressImpl _$$AchievementProgressImplFromJson(
  Map<String, dynamic> json,
) => _$AchievementProgressImpl(
  achievementId: json['achievement_id'] as String,
  achievementCode: json['achievement_code'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  emoji: json['emoji'] as String,
  achievementType: json['achievement_type'] as String,
  criteriaCount: (json['criteria_count'] as num).toInt(),
  progress: (json['progress'] as num).toInt(),
  unlocked: json['unlocked'] as bool,
  unlockedAt: json['unlocked_at'] == null
      ? null
      : DateTime.parse(json['unlocked_at'] as String),
  percentage: (json['percentage'] as num).toDouble(),
  xpReward: (json['xp_reward'] as num).toInt(),
);

Map<String, dynamic> _$$AchievementProgressImplToJson(
  _$AchievementProgressImpl instance,
) => <String, dynamic>{
  'achievement_id': instance.achievementId,
  'achievement_code': instance.achievementCode,
  'title': instance.title,
  'description': instance.description,
  'emoji': instance.emoji,
  'achievement_type': instance.achievementType,
  'criteria_count': instance.criteriaCount,
  'progress': instance.progress,
  'unlocked': instance.unlocked,
  'unlocked_at': instance.unlockedAt?.toIso8601String(),
  'percentage': instance.percentage,
  'xp_reward': instance.xpReward,
};

_$AchievementListImpl _$$AchievementListImplFromJson(
  Map<String, dynamic> json,
) => _$AchievementListImpl(
  unlocked: (json['unlocked'] as List<dynamic>)
      .map((e) => AchievementProgress.fromJson(e as Map<String, dynamic>))
      .toList(),
  inProgress: (json['in_progress'] as List<dynamic>)
      .map((e) => AchievementProgress.fromJson(e as Map<String, dynamic>))
      .toList(),
  locked: (json['locked'] as List<dynamic>)
      .map((e) => AchievementProgress.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$AchievementListImplToJson(
  _$AchievementListImpl instance,
) => <String, dynamic>{
  'unlocked': instance.unlocked,
  'in_progress': instance.inProgress,
  'locked': instance.locked,
};
