// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_like_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryLikeModelImpl _$$StoryLikeModelImplFromJson(Map<String, dynamic> json) =>
    _$StoryLikeModelImpl(
      id: json['id'] as String,
      story_id: json['story_id'] as String,
      user_id: json['user_id'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
      user: json['user'] == null
          ? null
          : StoryUserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StoryLikeModelImplToJson(
  _$StoryLikeModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'story_id': instance.story_id,
  'user_id': instance.user_id,
  'created_at': instance.created_at.toIso8601String(),
  'user': instance.user,
};

_$StoryLikeListModelImpl _$$StoryLikeListModelImplFromJson(
  Map<String, dynamic> json,
) => _$StoryLikeListModelImpl(
  items: (json['items'] as List<dynamic>)
      .map((e) => StoryLikeModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
);

Map<String, dynamic> _$$StoryLikeListModelImplToJson(
  _$StoryLikeListModelImpl instance,
) => <String, dynamic>{'items': instance.items, 'total': instance.total};
