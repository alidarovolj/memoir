// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryModelImpl _$$StoryModelImplFromJson(Map<String, dynamic> json) =>
    _$StoryModelImpl(
      id: json['id'] as String,
      user_id: json['user_id'] as String,
      memory_id: json['memory_id'] as String,
      is_public: json['is_public'] as bool,
      created_at: DateTime.parse(json['created_at'] as String),
      expires_at: DateTime.parse(json['expires_at'] as String),
      user: json['user'] == null
          ? null
          : StoryUserModel.fromJson(json['user'] as Map<String, dynamic>),
      memory: json['memory'] == null
          ? null
          : StoryMemoryModel.fromJson(json['memory'] as Map<String, dynamic>),
      likes_count: (json['likes_count'] as num?)?.toInt() ?? 0,
      comments_count: (json['comments_count'] as num?)?.toInt() ?? 0,
      shares_count: (json['shares_count'] as num?)?.toInt() ?? 0,
      reposts_count: (json['reposts_count'] as num?)?.toInt() ?? 0,
      is_liked: json['is_liked'] as bool? ?? false,
      original_story: json['original_story'] == null
          ? null
          : StoryOriginalModel.fromJson(
              json['original_story'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$$StoryModelImplToJson(_$StoryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'memory_id': instance.memory_id,
      'is_public': instance.is_public,
      'created_at': instance.created_at.toIso8601String(),
      'expires_at': instance.expires_at.toIso8601String(),
      'user': instance.user,
      'memory': instance.memory,
      'likes_count': instance.likes_count,
      'comments_count': instance.comments_count,
      'shares_count': instance.shares_count,
      'reposts_count': instance.reposts_count,
      'is_liked': instance.is_liked,
      'original_story': instance.original_story,
    };

_$StoryUserModelImpl _$$StoryUserModelImplFromJson(Map<String, dynamic> json) =>
    _$StoryUserModelImpl(
      id: json['id'] as String,
      username: json['username'] as String?,
      email: json['email'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      avatar_url: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$$StoryUserModelImplToJson(
  _$StoryUserModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'first_name': instance.first_name,
  'last_name': instance.last_name,
  'avatar_url': instance.avatar_url,
};

_$StoryMemoryModelImpl _$$StoryMemoryModelImplFromJson(
  Map<String, dynamic> json,
) => _$StoryMemoryModelImpl(
  id: json['id'] as String,
  title: json['title'] as String?,
  content: json['content'] as String?,
  image_url: json['image_url'] as String?,
  backdrop_url: json['backdrop_url'] as String?,
  source_type: json['source_type'] as String?,
);

Map<String, dynamic> _$$StoryMemoryModelImplToJson(
  _$StoryMemoryModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'content': instance.content,
  'image_url': instance.image_url,
  'backdrop_url': instance.backdrop_url,
  'source_type': instance.source_type,
};

_$StoryOriginalModelImpl _$$StoryOriginalModelImplFromJson(
  Map<String, dynamic> json,
) => _$StoryOriginalModelImpl(
  id: json['id'] as String,
  user: json['user'] == null
      ? null
      : StoryUserModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$StoryOriginalModelImplToJson(
  _$StoryOriginalModelImpl instance,
) => <String, dynamic>{'id': instance.id, 'user': instance.user};
