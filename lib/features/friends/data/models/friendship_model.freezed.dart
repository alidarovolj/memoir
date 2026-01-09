// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friendship_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FriendProfile _$FriendProfileFromJson(Map<String, dynamic> json) {
  return _FriendProfile.fromJson(json);
}

/// @nodoc
mixin _$FriendProfile {
  int get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get memoriesCount => throw _privateConstructorUsedError;
  int get friendsCount => throw _privateConstructorUsedError;
  int get streakDays => throw _privateConstructorUsedError;

  /// Serializes this FriendProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendProfileCopyWith<FriendProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendProfileCopyWith<$Res> {
  factory $FriendProfileCopyWith(
    FriendProfile value,
    $Res Function(FriendProfile) then,
  ) = _$FriendProfileCopyWithImpl<$Res, FriendProfile>;
  @useResult
  $Res call({
    int id,
    String username,
    String? avatarUrl,
    DateTime createdAt,
    int memoriesCount,
    int friendsCount,
    int streakDays,
  });
}

/// @nodoc
class _$FriendProfileCopyWithImpl<$Res, $Val extends FriendProfile>
    implements $FriendProfileCopyWith<$Res> {
  _$FriendProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? avatarUrl = freezed,
    Object? createdAt = null,
    Object? memoriesCount = null,
    Object? friendsCount = null,
    Object? streakDays = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            memoriesCount: null == memoriesCount
                ? _value.memoriesCount
                : memoriesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            friendsCount: null == friendsCount
                ? _value.friendsCount
                : friendsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            streakDays: null == streakDays
                ? _value.streakDays
                : streakDays // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FriendProfileImplCopyWith<$Res>
    implements $FriendProfileCopyWith<$Res> {
  factory _$$FriendProfileImplCopyWith(
    _$FriendProfileImpl value,
    $Res Function(_$FriendProfileImpl) then,
  ) = __$$FriendProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String username,
    String? avatarUrl,
    DateTime createdAt,
    int memoriesCount,
    int friendsCount,
    int streakDays,
  });
}

/// @nodoc
class __$$FriendProfileImplCopyWithImpl<$Res>
    extends _$FriendProfileCopyWithImpl<$Res, _$FriendProfileImpl>
    implements _$$FriendProfileImplCopyWith<$Res> {
  __$$FriendProfileImplCopyWithImpl(
    _$FriendProfileImpl _value,
    $Res Function(_$FriendProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? avatarUrl = freezed,
    Object? createdAt = null,
    Object? memoriesCount = null,
    Object? friendsCount = null,
    Object? streakDays = null,
  }) {
    return _then(
      _$FriendProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        memoriesCount: null == memoriesCount
            ? _value.memoriesCount
            : memoriesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        friendsCount: null == friendsCount
            ? _value.friendsCount
            : friendsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        streakDays: null == streakDays
            ? _value.streakDays
            : streakDays // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendProfileImpl implements _FriendProfile {
  const _$FriendProfileImpl({
    required this.id,
    required this.username,
    this.avatarUrl,
    required this.createdAt,
    this.memoriesCount = 0,
    this.friendsCount = 0,
    this.streakDays = 0,
  });

  factory _$FriendProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendProfileImplFromJson(json);

  @override
  final int id;
  @override
  final String username;
  @override
  final String? avatarUrl;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final int memoriesCount;
  @override
  @JsonKey()
  final int friendsCount;
  @override
  @JsonKey()
  final int streakDays;

  @override
  String toString() {
    return 'FriendProfile(id: $id, username: $username, avatarUrl: $avatarUrl, createdAt: $createdAt, memoriesCount: $memoriesCount, friendsCount: $friendsCount, streakDays: $streakDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.memoriesCount, memoriesCount) ||
                other.memoriesCount == memoriesCount) &&
            (identical(other.friendsCount, friendsCount) ||
                other.friendsCount == friendsCount) &&
            (identical(other.streakDays, streakDays) ||
                other.streakDays == streakDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    username,
    avatarUrl,
    createdAt,
    memoriesCount,
    friendsCount,
    streakDays,
  );

  /// Create a copy of FriendProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendProfileImplCopyWith<_$FriendProfileImpl> get copyWith =>
      __$$FriendProfileImplCopyWithImpl<_$FriendProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendProfileImplToJson(this);
  }
}

abstract class _FriendProfile implements FriendProfile {
  const factory _FriendProfile({
    required final int id,
    required final String username,
    final String? avatarUrl,
    required final DateTime createdAt,
    final int memoriesCount,
    final int friendsCount,
    final int streakDays,
  }) = _$FriendProfileImpl;

  factory _FriendProfile.fromJson(Map<String, dynamic> json) =
      _$FriendProfileImpl.fromJson;

  @override
  int get id;
  @override
  String get username;
  @override
  String? get avatarUrl;
  @override
  DateTime get createdAt;
  @override
  int get memoriesCount;
  @override
  int get friendsCount;
  @override
  int get streakDays;

  /// Create a copy of FriendProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendProfileImplCopyWith<_$FriendProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FriendshipModel _$FriendshipModelFromJson(Map<String, dynamic> json) {
  return _FriendshipModel.fromJson(json);
}

/// @nodoc
mixin _$FriendshipModel {
  int get id => throw _privateConstructorUsedError;
  int get requesterId => throw _privateConstructorUsedError;
  int get addresseeId => throw _privateConstructorUsedError;
  FriendshipStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  FriendProfile? get friend => throw _privateConstructorUsedError;

  /// Serializes this FriendshipModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendshipModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendshipModelCopyWith<FriendshipModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendshipModelCopyWith<$Res> {
  factory $FriendshipModelCopyWith(
    FriendshipModel value,
    $Res Function(FriendshipModel) then,
  ) = _$FriendshipModelCopyWithImpl<$Res, FriendshipModel>;
  @useResult
  $Res call({
    int id,
    int requesterId,
    int addresseeId,
    FriendshipStatus status,
    DateTime createdAt,
    DateTime updatedAt,
    FriendProfile? friend,
  });

  $FriendProfileCopyWith<$Res>? get friend;
}

/// @nodoc
class _$FriendshipModelCopyWithImpl<$Res, $Val extends FriendshipModel>
    implements $FriendshipModelCopyWith<$Res> {
  _$FriendshipModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendshipModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requesterId = null,
    Object? addresseeId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? friend = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            requesterId: null == requesterId
                ? _value.requesterId
                : requesterId // ignore: cast_nullable_to_non_nullable
                      as int,
            addresseeId: null == addresseeId
                ? _value.addresseeId
                : addresseeId // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as FriendshipStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            friend: freezed == friend
                ? _value.friend
                : friend // ignore: cast_nullable_to_non_nullable
                      as FriendProfile?,
          )
          as $Val,
    );
  }

  /// Create a copy of FriendshipModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FriendProfileCopyWith<$Res>? get friend {
    if (_value.friend == null) {
      return null;
    }

    return $FriendProfileCopyWith<$Res>(_value.friend!, (value) {
      return _then(_value.copyWith(friend: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FriendshipModelImplCopyWith<$Res>
    implements $FriendshipModelCopyWith<$Res> {
  factory _$$FriendshipModelImplCopyWith(
    _$FriendshipModelImpl value,
    $Res Function(_$FriendshipModelImpl) then,
  ) = __$$FriendshipModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int requesterId,
    int addresseeId,
    FriendshipStatus status,
    DateTime createdAt,
    DateTime updatedAt,
    FriendProfile? friend,
  });

  @override
  $FriendProfileCopyWith<$Res>? get friend;
}

/// @nodoc
class __$$FriendshipModelImplCopyWithImpl<$Res>
    extends _$FriendshipModelCopyWithImpl<$Res, _$FriendshipModelImpl>
    implements _$$FriendshipModelImplCopyWith<$Res> {
  __$$FriendshipModelImplCopyWithImpl(
    _$FriendshipModelImpl _value,
    $Res Function(_$FriendshipModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendshipModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requesterId = null,
    Object? addresseeId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? friend = freezed,
  }) {
    return _then(
      _$FriendshipModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        requesterId: null == requesterId
            ? _value.requesterId
            : requesterId // ignore: cast_nullable_to_non_nullable
                  as int,
        addresseeId: null == addresseeId
            ? _value.addresseeId
            : addresseeId // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as FriendshipStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        friend: freezed == friend
            ? _value.friend
            : friend // ignore: cast_nullable_to_non_nullable
                  as FriendProfile?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendshipModelImpl implements _FriendshipModel {
  const _$FriendshipModelImpl({
    required this.id,
    required this.requesterId,
    required this.addresseeId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.friend,
  });

  factory _$FriendshipModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendshipModelImplFromJson(json);

  @override
  final int id;
  @override
  final int requesterId;
  @override
  final int addresseeId;
  @override
  final FriendshipStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final FriendProfile? friend;

  @override
  String toString() {
    return 'FriendshipModel(id: $id, requesterId: $requesterId, addresseeId: $addresseeId, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, friend: $friend)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendshipModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.requesterId, requesterId) ||
                other.requesterId == requesterId) &&
            (identical(other.addresseeId, addresseeId) ||
                other.addresseeId == addresseeId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.friend, friend) || other.friend == friend));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    requesterId,
    addresseeId,
    status,
    createdAt,
    updatedAt,
    friend,
  );

  /// Create a copy of FriendshipModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendshipModelImplCopyWith<_$FriendshipModelImpl> get copyWith =>
      __$$FriendshipModelImplCopyWithImpl<_$FriendshipModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendshipModelImplToJson(this);
  }
}

abstract class _FriendshipModel implements FriendshipModel {
  const factory _FriendshipModel({
    required final int id,
    required final int requesterId,
    required final int addresseeId,
    required final FriendshipStatus status,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final FriendProfile? friend,
  }) = _$FriendshipModelImpl;

  factory _FriendshipModel.fromJson(Map<String, dynamic> json) =
      _$FriendshipModelImpl.fromJson;

  @override
  int get id;
  @override
  int get requesterId;
  @override
  int get addresseeId;
  @override
  FriendshipStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  FriendProfile? get friend;

  /// Create a copy of FriendshipModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendshipModelImplCopyWith<_$FriendshipModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FriendRequest _$FriendRequestFromJson(Map<String, dynamic> json) {
  return _FriendRequest.fromJson(json);
}

/// @nodoc
mixin _$FriendRequest {
  int get id => throw _privateConstructorUsedError;
  FriendshipStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  FriendProfile get requester => throw _privateConstructorUsedError;

  /// Serializes this FriendRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendRequestCopyWith<FriendRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendRequestCopyWith<$Res> {
  factory $FriendRequestCopyWith(
    FriendRequest value,
    $Res Function(FriendRequest) then,
  ) = _$FriendRequestCopyWithImpl<$Res, FriendRequest>;
  @useResult
  $Res call({
    int id,
    FriendshipStatus status,
    DateTime createdAt,
    FriendProfile requester,
  });

  $FriendProfileCopyWith<$Res> get requester;
}

/// @nodoc
class _$FriendRequestCopyWithImpl<$Res, $Val extends FriendRequest>
    implements $FriendRequestCopyWith<$Res> {
  _$FriendRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? createdAt = null,
    Object? requester = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as FriendshipStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            requester: null == requester
                ? _value.requester
                : requester // ignore: cast_nullable_to_non_nullable
                      as FriendProfile,
          )
          as $Val,
    );
  }

  /// Create a copy of FriendRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FriendProfileCopyWith<$Res> get requester {
    return $FriendProfileCopyWith<$Res>(_value.requester, (value) {
      return _then(_value.copyWith(requester: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FriendRequestImplCopyWith<$Res>
    implements $FriendRequestCopyWith<$Res> {
  factory _$$FriendRequestImplCopyWith(
    _$FriendRequestImpl value,
    $Res Function(_$FriendRequestImpl) then,
  ) = __$$FriendRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    FriendshipStatus status,
    DateTime createdAt,
    FriendProfile requester,
  });

  @override
  $FriendProfileCopyWith<$Res> get requester;
}

/// @nodoc
class __$$FriendRequestImplCopyWithImpl<$Res>
    extends _$FriendRequestCopyWithImpl<$Res, _$FriendRequestImpl>
    implements _$$FriendRequestImplCopyWith<$Res> {
  __$$FriendRequestImplCopyWithImpl(
    _$FriendRequestImpl _value,
    $Res Function(_$FriendRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? createdAt = null,
    Object? requester = null,
  }) {
    return _then(
      _$FriendRequestImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as FriendshipStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        requester: null == requester
            ? _value.requester
            : requester // ignore: cast_nullable_to_non_nullable
                  as FriendProfile,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendRequestImpl implements _FriendRequest {
  const _$FriendRequestImpl({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.requester,
  });

  factory _$FriendRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendRequestImplFromJson(json);

  @override
  final int id;
  @override
  final FriendshipStatus status;
  @override
  final DateTime createdAt;
  @override
  final FriendProfile requester;

  @override
  String toString() {
    return 'FriendRequest(id: $id, status: $status, createdAt: $createdAt, requester: $requester)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.requester, requester) ||
                other.requester == requester));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, status, createdAt, requester);

  /// Create a copy of FriendRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendRequestImplCopyWith<_$FriendRequestImpl> get copyWith =>
      __$$FriendRequestImplCopyWithImpl<_$FriendRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendRequestImplToJson(this);
  }
}

abstract class _FriendRequest implements FriendRequest {
  const factory _FriendRequest({
    required final int id,
    required final FriendshipStatus status,
    required final DateTime createdAt,
    required final FriendProfile requester,
  }) = _$FriendRequestImpl;

  factory _FriendRequest.fromJson(Map<String, dynamic> json) =
      _$FriendRequestImpl.fromJson;

  @override
  int get id;
  @override
  FriendshipStatus get status;
  @override
  DateTime get createdAt;
  @override
  FriendProfile get requester;

  /// Create a copy of FriendRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendRequestImplCopyWith<_$FriendRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
