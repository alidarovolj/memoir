// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memory_sharing_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SharedWithUser _$SharedWithUserFromJson(Map<String, dynamic> json) {
  return _SharedWithUser.fromJson(json);
}

/// @nodoc
mixin _$SharedWithUser {
  int get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  bool get canComment => throw _privateConstructorUsedError;
  bool get canReact => throw _privateConstructorUsedError;
  DateTime get sharedAt => throw _privateConstructorUsedError;
  DateTime? get viewedAt => throw _privateConstructorUsedError;

  /// Serializes this SharedWithUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SharedWithUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SharedWithUserCopyWith<SharedWithUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SharedWithUserCopyWith<$Res> {
  factory $SharedWithUserCopyWith(
    SharedWithUser value,
    $Res Function(SharedWithUser) then,
  ) = _$SharedWithUserCopyWithImpl<$Res, SharedWithUser>;
  @useResult
  $Res call({
    int userId,
    String username,
    bool canComment,
    bool canReact,
    DateTime sharedAt,
    DateTime? viewedAt,
  });
}

/// @nodoc
class _$SharedWithUserCopyWithImpl<$Res, $Val extends SharedWithUser>
    implements $SharedWithUserCopyWith<$Res> {
  _$SharedWithUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SharedWithUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? canComment = null,
    Object? canReact = null,
    Object? sharedAt = null,
    Object? viewedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            canComment: null == canComment
                ? _value.canComment
                : canComment // ignore: cast_nullable_to_non_nullable
                      as bool,
            canReact: null == canReact
                ? _value.canReact
                : canReact // ignore: cast_nullable_to_non_nullable
                      as bool,
            sharedAt: null == sharedAt
                ? _value.sharedAt
                : sharedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            viewedAt: freezed == viewedAt
                ? _value.viewedAt
                : viewedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SharedWithUserImplCopyWith<$Res>
    implements $SharedWithUserCopyWith<$Res> {
  factory _$$SharedWithUserImplCopyWith(
    _$SharedWithUserImpl value,
    $Res Function(_$SharedWithUserImpl) then,
  ) = __$$SharedWithUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int userId,
    String username,
    bool canComment,
    bool canReact,
    DateTime sharedAt,
    DateTime? viewedAt,
  });
}

/// @nodoc
class __$$SharedWithUserImplCopyWithImpl<$Res>
    extends _$SharedWithUserCopyWithImpl<$Res, _$SharedWithUserImpl>
    implements _$$SharedWithUserImplCopyWith<$Res> {
  __$$SharedWithUserImplCopyWithImpl(
    _$SharedWithUserImpl _value,
    $Res Function(_$SharedWithUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SharedWithUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? canComment = null,
    Object? canReact = null,
    Object? sharedAt = null,
    Object? viewedAt = freezed,
  }) {
    return _then(
      _$SharedWithUserImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        canComment: null == canComment
            ? _value.canComment
            : canComment // ignore: cast_nullable_to_non_nullable
                  as bool,
        canReact: null == canReact
            ? _value.canReact
            : canReact // ignore: cast_nullable_to_non_nullable
                  as bool,
        sharedAt: null == sharedAt
            ? _value.sharedAt
            : sharedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        viewedAt: freezed == viewedAt
            ? _value.viewedAt
            : viewedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SharedWithUserImpl implements _SharedWithUser {
  const _$SharedWithUserImpl({
    required this.userId,
    required this.username,
    required this.canComment,
    required this.canReact,
    required this.sharedAt,
    this.viewedAt,
  });

  factory _$SharedWithUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$SharedWithUserImplFromJson(json);

  @override
  final int userId;
  @override
  final String username;
  @override
  final bool canComment;
  @override
  final bool canReact;
  @override
  final DateTime sharedAt;
  @override
  final DateTime? viewedAt;

  @override
  String toString() {
    return 'SharedWithUser(userId: $userId, username: $username, canComment: $canComment, canReact: $canReact, sharedAt: $sharedAt, viewedAt: $viewedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SharedWithUserImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.canComment, canComment) ||
                other.canComment == canComment) &&
            (identical(other.canReact, canReact) ||
                other.canReact == canReact) &&
            (identical(other.sharedAt, sharedAt) ||
                other.sharedAt == sharedAt) &&
            (identical(other.viewedAt, viewedAt) ||
                other.viewedAt == viewedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    username,
    canComment,
    canReact,
    sharedAt,
    viewedAt,
  );

  /// Create a copy of SharedWithUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SharedWithUserImplCopyWith<_$SharedWithUserImpl> get copyWith =>
      __$$SharedWithUserImplCopyWithImpl<_$SharedWithUserImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SharedWithUserImplToJson(this);
  }
}

abstract class _SharedWithUser implements SharedWithUser {
  const factory _SharedWithUser({
    required final int userId,
    required final String username,
    required final bool canComment,
    required final bool canReact,
    required final DateTime sharedAt,
    final DateTime? viewedAt,
  }) = _$SharedWithUserImpl;

  factory _SharedWithUser.fromJson(Map<String, dynamic> json) =
      _$SharedWithUserImpl.fromJson;

  @override
  int get userId;
  @override
  String get username;
  @override
  bool get canComment;
  @override
  bool get canReact;
  @override
  DateTime get sharedAt;
  @override
  DateTime? get viewedAt;

  /// Create a copy of SharedWithUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SharedWithUserImplCopyWith<_$SharedWithUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MemoryShareInfo _$MemoryShareInfoFromJson(Map<String, dynamic> json) {
  return _MemoryShareInfo.fromJson(json);
}

/// @nodoc
mixin _$MemoryShareInfo {
  String get memoryId => throw _privateConstructorUsedError;
  PrivacyLevel get privacyLevel => throw _privateConstructorUsedError;
  List<SharedWithUser> get sharedWith => throw _privateConstructorUsedError;
  int get totalShares => throw _privateConstructorUsedError;

  /// Serializes this MemoryShareInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MemoryShareInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemoryShareInfoCopyWith<MemoryShareInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemoryShareInfoCopyWith<$Res> {
  factory $MemoryShareInfoCopyWith(
    MemoryShareInfo value,
    $Res Function(MemoryShareInfo) then,
  ) = _$MemoryShareInfoCopyWithImpl<$Res, MemoryShareInfo>;
  @useResult
  $Res call({
    String memoryId,
    PrivacyLevel privacyLevel,
    List<SharedWithUser> sharedWith,
    int totalShares,
  });
}

/// @nodoc
class _$MemoryShareInfoCopyWithImpl<$Res, $Val extends MemoryShareInfo>
    implements $MemoryShareInfoCopyWith<$Res> {
  _$MemoryShareInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MemoryShareInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memoryId = null,
    Object? privacyLevel = null,
    Object? sharedWith = null,
    Object? totalShares = null,
  }) {
    return _then(
      _value.copyWith(
            memoryId: null == memoryId
                ? _value.memoryId
                : memoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            privacyLevel: null == privacyLevel
                ? _value.privacyLevel
                : privacyLevel // ignore: cast_nullable_to_non_nullable
                      as PrivacyLevel,
            sharedWith: null == sharedWith
                ? _value.sharedWith
                : sharedWith // ignore: cast_nullable_to_non_nullable
                      as List<SharedWithUser>,
            totalShares: null == totalShares
                ? _value.totalShares
                : totalShares // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MemoryShareInfoImplCopyWith<$Res>
    implements $MemoryShareInfoCopyWith<$Res> {
  factory _$$MemoryShareInfoImplCopyWith(
    _$MemoryShareInfoImpl value,
    $Res Function(_$MemoryShareInfoImpl) then,
  ) = __$$MemoryShareInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String memoryId,
    PrivacyLevel privacyLevel,
    List<SharedWithUser> sharedWith,
    int totalShares,
  });
}

/// @nodoc
class __$$MemoryShareInfoImplCopyWithImpl<$Res>
    extends _$MemoryShareInfoCopyWithImpl<$Res, _$MemoryShareInfoImpl>
    implements _$$MemoryShareInfoImplCopyWith<$Res> {
  __$$MemoryShareInfoImplCopyWithImpl(
    _$MemoryShareInfoImpl _value,
    $Res Function(_$MemoryShareInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MemoryShareInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memoryId = null,
    Object? privacyLevel = null,
    Object? sharedWith = null,
    Object? totalShares = null,
  }) {
    return _then(
      _$MemoryShareInfoImpl(
        memoryId: null == memoryId
            ? _value.memoryId
            : memoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        privacyLevel: null == privacyLevel
            ? _value.privacyLevel
            : privacyLevel // ignore: cast_nullable_to_non_nullable
                  as PrivacyLevel,
        sharedWith: null == sharedWith
            ? _value._sharedWith
            : sharedWith // ignore: cast_nullable_to_non_nullable
                  as List<SharedWithUser>,
        totalShares: null == totalShares
            ? _value.totalShares
            : totalShares // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MemoryShareInfoImpl implements _MemoryShareInfo {
  const _$MemoryShareInfoImpl({
    required this.memoryId,
    required this.privacyLevel,
    required final List<SharedWithUser> sharedWith,
    required this.totalShares,
  }) : _sharedWith = sharedWith;

  factory _$MemoryShareInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemoryShareInfoImplFromJson(json);

  @override
  final String memoryId;
  @override
  final PrivacyLevel privacyLevel;
  final List<SharedWithUser> _sharedWith;
  @override
  List<SharedWithUser> get sharedWith {
    if (_sharedWith is EqualUnmodifiableListView) return _sharedWith;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sharedWith);
  }

  @override
  final int totalShares;

  @override
  String toString() {
    return 'MemoryShareInfo(memoryId: $memoryId, privacyLevel: $privacyLevel, sharedWith: $sharedWith, totalShares: $totalShares)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemoryShareInfoImpl &&
            (identical(other.memoryId, memoryId) ||
                other.memoryId == memoryId) &&
            (identical(other.privacyLevel, privacyLevel) ||
                other.privacyLevel == privacyLevel) &&
            const DeepCollectionEquality().equals(
              other._sharedWith,
              _sharedWith,
            ) &&
            (identical(other.totalShares, totalShares) ||
                other.totalShares == totalShares));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    memoryId,
    privacyLevel,
    const DeepCollectionEquality().hash(_sharedWith),
    totalShares,
  );

  /// Create a copy of MemoryShareInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemoryShareInfoImplCopyWith<_$MemoryShareInfoImpl> get copyWith =>
      __$$MemoryShareInfoImplCopyWithImpl<_$MemoryShareInfoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MemoryShareInfoImplToJson(this);
  }
}

abstract class _MemoryShareInfo implements MemoryShareInfo {
  const factory _MemoryShareInfo({
    required final String memoryId,
    required final PrivacyLevel privacyLevel,
    required final List<SharedWithUser> sharedWith,
    required final int totalShares,
  }) = _$MemoryShareInfoImpl;

  factory _MemoryShareInfo.fromJson(Map<String, dynamic> json) =
      _$MemoryShareInfoImpl.fromJson;

  @override
  String get memoryId;
  @override
  PrivacyLevel get privacyLevel;
  @override
  List<SharedWithUser> get sharedWith;
  @override
  int get totalShares;

  /// Create a copy of MemoryShareInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemoryShareInfoImplCopyWith<_$MemoryShareInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SharedMemoryItem _$SharedMemoryItemFromJson(Map<String, dynamic> json) {
  return _SharedMemoryItem.fromJson(json);
}

/// @nodoc
mixin _$SharedMemoryItem {
  String get memoryId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  String get ownerUsername => throw _privateConstructorUsedError;
  DateTime get sharedAt => throw _privateConstructorUsedError;
  bool get canComment => throw _privateConstructorUsedError;
  bool get canReact => throw _privateConstructorUsedError;
  DateTime? get viewedAt => throw _privateConstructorUsedError;

  /// Serializes this SharedMemoryItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SharedMemoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SharedMemoryItemCopyWith<SharedMemoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SharedMemoryItemCopyWith<$Res> {
  factory $SharedMemoryItemCopyWith(
    SharedMemoryItem value,
    $Res Function(SharedMemoryItem) then,
  ) = _$SharedMemoryItemCopyWithImpl<$Res, SharedMemoryItem>;
  @useResult
  $Res call({
    String memoryId,
    String title,
    String content,
    String? imageUrl,
    DateTime createdAt,
    String ownerId,
    String ownerUsername,
    DateTime sharedAt,
    bool canComment,
    bool canReact,
    DateTime? viewedAt,
  });
}

/// @nodoc
class _$SharedMemoryItemCopyWithImpl<$Res, $Val extends SharedMemoryItem>
    implements $SharedMemoryItemCopyWith<$Res> {
  _$SharedMemoryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SharedMemoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memoryId = null,
    Object? title = null,
    Object? content = null,
    Object? imageUrl = freezed,
    Object? createdAt = null,
    Object? ownerId = null,
    Object? ownerUsername = null,
    Object? sharedAt = null,
    Object? canComment = null,
    Object? canReact = null,
    Object? viewedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            memoryId: null == memoryId
                ? _value.memoryId
                : memoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            ownerId: null == ownerId
                ? _value.ownerId
                : ownerId // ignore: cast_nullable_to_non_nullable
                      as String,
            ownerUsername: null == ownerUsername
                ? _value.ownerUsername
                : ownerUsername // ignore: cast_nullable_to_non_nullable
                      as String,
            sharedAt: null == sharedAt
                ? _value.sharedAt
                : sharedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            canComment: null == canComment
                ? _value.canComment
                : canComment // ignore: cast_nullable_to_non_nullable
                      as bool,
            canReact: null == canReact
                ? _value.canReact
                : canReact // ignore: cast_nullable_to_non_nullable
                      as bool,
            viewedAt: freezed == viewedAt
                ? _value.viewedAt
                : viewedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SharedMemoryItemImplCopyWith<$Res>
    implements $SharedMemoryItemCopyWith<$Res> {
  factory _$$SharedMemoryItemImplCopyWith(
    _$SharedMemoryItemImpl value,
    $Res Function(_$SharedMemoryItemImpl) then,
  ) = __$$SharedMemoryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String memoryId,
    String title,
    String content,
    String? imageUrl,
    DateTime createdAt,
    String ownerId,
    String ownerUsername,
    DateTime sharedAt,
    bool canComment,
    bool canReact,
    DateTime? viewedAt,
  });
}

/// @nodoc
class __$$SharedMemoryItemImplCopyWithImpl<$Res>
    extends _$SharedMemoryItemCopyWithImpl<$Res, _$SharedMemoryItemImpl>
    implements _$$SharedMemoryItemImplCopyWith<$Res> {
  __$$SharedMemoryItemImplCopyWithImpl(
    _$SharedMemoryItemImpl _value,
    $Res Function(_$SharedMemoryItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SharedMemoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memoryId = null,
    Object? title = null,
    Object? content = null,
    Object? imageUrl = freezed,
    Object? createdAt = null,
    Object? ownerId = null,
    Object? ownerUsername = null,
    Object? sharedAt = null,
    Object? canComment = null,
    Object? canReact = null,
    Object? viewedAt = freezed,
  }) {
    return _then(
      _$SharedMemoryItemImpl(
        memoryId: null == memoryId
            ? _value.memoryId
            : memoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        ownerId: null == ownerId
            ? _value.ownerId
            : ownerId // ignore: cast_nullable_to_non_nullable
                  as String,
        ownerUsername: null == ownerUsername
            ? _value.ownerUsername
            : ownerUsername // ignore: cast_nullable_to_non_nullable
                  as String,
        sharedAt: null == sharedAt
            ? _value.sharedAt
            : sharedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        canComment: null == canComment
            ? _value.canComment
            : canComment // ignore: cast_nullable_to_non_nullable
                  as bool,
        canReact: null == canReact
            ? _value.canReact
            : canReact // ignore: cast_nullable_to_non_nullable
                  as bool,
        viewedAt: freezed == viewedAt
            ? _value.viewedAt
            : viewedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SharedMemoryItemImpl extends _SharedMemoryItem {
  const _$SharedMemoryItemImpl({
    required this.memoryId,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.createdAt,
    required this.ownerId,
    required this.ownerUsername,
    required this.sharedAt,
    required this.canComment,
    required this.canReact,
    this.viewedAt,
  }) : super._();

  factory _$SharedMemoryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$SharedMemoryItemImplFromJson(json);

  @override
  final String memoryId;
  @override
  final String title;
  @override
  final String content;
  @override
  final String? imageUrl;
  @override
  final DateTime createdAt;
  @override
  final String ownerId;
  @override
  final String ownerUsername;
  @override
  final DateTime sharedAt;
  @override
  final bool canComment;
  @override
  final bool canReact;
  @override
  final DateTime? viewedAt;

  @override
  String toString() {
    return 'SharedMemoryItem(memoryId: $memoryId, title: $title, content: $content, imageUrl: $imageUrl, createdAt: $createdAt, ownerId: $ownerId, ownerUsername: $ownerUsername, sharedAt: $sharedAt, canComment: $canComment, canReact: $canReact, viewedAt: $viewedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SharedMemoryItemImpl &&
            (identical(other.memoryId, memoryId) ||
                other.memoryId == memoryId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.ownerUsername, ownerUsername) ||
                other.ownerUsername == ownerUsername) &&
            (identical(other.sharedAt, sharedAt) ||
                other.sharedAt == sharedAt) &&
            (identical(other.canComment, canComment) ||
                other.canComment == canComment) &&
            (identical(other.canReact, canReact) ||
                other.canReact == canReact) &&
            (identical(other.viewedAt, viewedAt) ||
                other.viewedAt == viewedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    memoryId,
    title,
    content,
    imageUrl,
    createdAt,
    ownerId,
    ownerUsername,
    sharedAt,
    canComment,
    canReact,
    viewedAt,
  );

  /// Create a copy of SharedMemoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SharedMemoryItemImplCopyWith<_$SharedMemoryItemImpl> get copyWith =>
      __$$SharedMemoryItemImplCopyWithImpl<_$SharedMemoryItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SharedMemoryItemImplToJson(this);
  }
}

abstract class _SharedMemoryItem extends SharedMemoryItem {
  const factory _SharedMemoryItem({
    required final String memoryId,
    required final String title,
    required final String content,
    final String? imageUrl,
    required final DateTime createdAt,
    required final String ownerId,
    required final String ownerUsername,
    required final DateTime sharedAt,
    required final bool canComment,
    required final bool canReact,
    final DateTime? viewedAt,
  }) = _$SharedMemoryItemImpl;
  const _SharedMemoryItem._() : super._();

  factory _SharedMemoryItem.fromJson(Map<String, dynamic> json) =
      _$SharedMemoryItemImpl.fromJson;

  @override
  String get memoryId;
  @override
  String get title;
  @override
  String get content;
  @override
  String? get imageUrl;
  @override
  DateTime get createdAt;
  @override
  String get ownerId;
  @override
  String get ownerUsername;
  @override
  DateTime get sharedAt;
  @override
  bool get canComment;
  @override
  bool get canReact;
  @override
  DateTime? get viewedAt;

  /// Create a copy of SharedMemoryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SharedMemoryItemImplCopyWith<_$SharedMemoryItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
