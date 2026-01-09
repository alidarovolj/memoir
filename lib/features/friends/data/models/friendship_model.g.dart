// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendProfileImpl _$$FriendProfileImplFromJson(Map<String, dynamic> json) =>
    _$FriendProfileImpl(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      memoriesCount: (json['memoriesCount'] as num?)?.toInt() ?? 0,
      friendsCount: (json['friendsCount'] as num?)?.toInt() ?? 0,
      streakDays: (json['streakDays'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$FriendProfileImplToJson(_$FriendProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'memoriesCount': instance.memoriesCount,
      'friendsCount': instance.friendsCount,
      'streakDays': instance.streakDays,
    };

_$FriendshipModelImpl _$$FriendshipModelImplFromJson(
  Map<String, dynamic> json,
) => _$FriendshipModelImpl(
  id: (json['id'] as num).toInt(),
  requesterId: (json['requesterId'] as num).toInt(),
  addresseeId: (json['addresseeId'] as num).toInt(),
  status: $enumDecode(_$FriendshipStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  friend: json['friend'] == null
      ? null
      : FriendProfile.fromJson(json['friend'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$FriendshipModelImplToJson(
  _$FriendshipModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'requesterId': instance.requesterId,
  'addresseeId': instance.addresseeId,
  'status': _$FriendshipStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'friend': instance.friend,
};

const _$FriendshipStatusEnumMap = {
  FriendshipStatus.pending: 'pending',
  FriendshipStatus.accepted: 'accepted',
  FriendshipStatus.rejected: 'rejected',
  FriendshipStatus.blocked: 'blocked',
};

_$FriendRequestImpl _$$FriendRequestImplFromJson(Map<String, dynamic> json) =>
    _$FriendRequestImpl(
      id: (json['id'] as num).toInt(),
      status: $enumDecode(_$FriendshipStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      requester: FriendProfile.fromJson(
        json['requester'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$FriendRequestImplToJson(_$FriendRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _$FriendshipStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'requester': instance.requester,
    };
