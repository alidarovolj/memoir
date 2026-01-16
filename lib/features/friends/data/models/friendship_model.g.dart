// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendProfileImpl _$$FriendProfileImplFromJson(Map<String, dynamic> json) =>
    _$FriendProfileImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      memoriesCount: (json['memories_count'] as num?)?.toInt() ?? 0,
      friendsCount: (json['friends_count'] as num?)?.toInt() ?? 0,
      streakDays: (json['streak_days'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$FriendProfileImplToJson(_$FriendProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'avatar_url': instance.avatarUrl,
      'created_at': instance.createdAt.toIso8601String(),
      'memories_count': instance.memoriesCount,
      'friends_count': instance.friendsCount,
      'streak_days': instance.streakDays,
    };

_$FriendshipModelImpl _$$FriendshipModelImplFromJson(
  Map<String, dynamic> json,
) => _$FriendshipModelImpl(
  id: json['id'] as String,
  requesterId: json['requester_id'] as String,
  addresseeId: json['addressee_id'] as String,
  status: $enumDecode(_$FriendshipStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  friend: json['friend'] == null
      ? null
      : FriendProfile.fromJson(json['friend'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$FriendshipModelImplToJson(
  _$FriendshipModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'requester_id': instance.requesterId,
  'addressee_id': instance.addresseeId,
  'status': _$FriendshipStatusEnumMap[instance.status]!,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
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
      id: json['id'] as String,
      status: $enumDecode(_$FriendshipStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['created_at'] as String),
      requester: FriendProfile.fromJson(
        json['requester'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$FriendRequestImplToJson(_$FriendRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _$FriendshipStatusEnumMap[instance.status]!,
      'created_at': instance.createdAt.toIso8601String(),
      'requester': instance.requester,
    };
