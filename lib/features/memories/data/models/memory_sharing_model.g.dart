// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory_sharing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SharedWithUserImpl _$$SharedWithUserImplFromJson(Map<String, dynamic> json) =>
    _$SharedWithUserImpl(
      userId: (json['userId'] as num).toInt(),
      username: json['username'] as String,
      canComment: json['canComment'] as bool,
      canReact: json['canReact'] as bool,
      sharedAt: DateTime.parse(json['sharedAt'] as String),
      viewedAt: json['viewedAt'] == null
          ? null
          : DateTime.parse(json['viewedAt'] as String),
    );

Map<String, dynamic> _$$SharedWithUserImplToJson(
  _$SharedWithUserImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'username': instance.username,
  'canComment': instance.canComment,
  'canReact': instance.canReact,
  'sharedAt': instance.sharedAt.toIso8601String(),
  'viewedAt': instance.viewedAt?.toIso8601String(),
};

_$MemoryShareInfoImpl _$$MemoryShareInfoImplFromJson(
  Map<String, dynamic> json,
) => _$MemoryShareInfoImpl(
  memoryId: json['memoryId'] as String,
  privacyLevel: $enumDecode(_$PrivacyLevelEnumMap, json['privacyLevel']),
  sharedWith: (json['sharedWith'] as List<dynamic>)
      .map((e) => SharedWithUser.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalShares: (json['totalShares'] as num).toInt(),
);

Map<String, dynamic> _$$MemoryShareInfoImplToJson(
  _$MemoryShareInfoImpl instance,
) => <String, dynamic>{
  'memoryId': instance.memoryId,
  'privacyLevel': _$PrivacyLevelEnumMap[instance.privacyLevel]!,
  'sharedWith': instance.sharedWith,
  'totalShares': instance.totalShares,
};

const _$PrivacyLevelEnumMap = {
  PrivacyLevel.private: 'private',
  PrivacyLevel.friendsOnly: 'friends_only',
  PrivacyLevel.shared: 'shared',
  PrivacyLevel.public: 'public',
};

_$SharedMemoryItemImpl _$$SharedMemoryItemImplFromJson(
  Map<String, dynamic> json,
) => _$SharedMemoryItemImpl(
  memoryId: json['memoryId'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  imageUrl: json['imageUrl'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  ownerId: json['ownerId'] as String,
  ownerUsername: json['ownerUsername'] as String,
  sharedAt: DateTime.parse(json['sharedAt'] as String),
  canComment: json['canComment'] as bool,
  canReact: json['canReact'] as bool,
  viewedAt: json['viewedAt'] == null
      ? null
      : DateTime.parse(json['viewedAt'] as String),
);

Map<String, dynamic> _$$SharedMemoryItemImplToJson(
  _$SharedMemoryItemImpl instance,
) => <String, dynamic>{
  'memoryId': instance.memoryId,
  'title': instance.title,
  'content': instance.content,
  'imageUrl': instance.imageUrl,
  'createdAt': instance.createdAt.toIso8601String(),
  'ownerId': instance.ownerId,
  'ownerUsername': instance.ownerUsername,
  'sharedAt': instance.sharedAt.toIso8601String(),
  'canComment': instance.canComment,
  'canReact': instance.canReact,
  'viewedAt': instance.viewedAt?.toIso8601String(),
};
