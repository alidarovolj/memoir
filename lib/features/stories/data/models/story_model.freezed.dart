// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StoryModel _$StoryModelFromJson(Map<String, dynamic> json) {
  return _StoryModel.fromJson(json);
}

/// @nodoc
mixin _$StoryModel {
  String get id =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  String get user_id =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  String get memory_id =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  bool get is_public =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  DateTime get created_at =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  DateTime get expires_at => throw _privateConstructorUsedError;
  StoryUserModel? get user => throw _privateConstructorUsedError;
  StoryMemoryModel? get memory =>
      throw _privateConstructorUsedError; // Social features
  // ignore: non_constant_identifier_names
  int get likes_count =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  int get comments_count =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  int get shares_count =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  int get reposts_count =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  bool get is_liked => throw _privateConstructorUsedError; // For reposts
  // ignore: non_constant_identifier_names
  StoryOriginalModel? get original_story => throw _privateConstructorUsedError;

  /// Serializes this StoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryModelCopyWith<StoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryModelCopyWith<$Res> {
  factory $StoryModelCopyWith(
    StoryModel value,
    $Res Function(StoryModel) then,
  ) = _$StoryModelCopyWithImpl<$Res, StoryModel>;
  @useResult
  $Res call({
    String id,
    String user_id,
    String memory_id,
    bool is_public,
    DateTime created_at,
    DateTime expires_at,
    StoryUserModel? user,
    StoryMemoryModel? memory,
    int likes_count,
    int comments_count,
    int shares_count,
    int reposts_count,
    bool is_liked,
    StoryOriginalModel? original_story,
  });

  $StoryUserModelCopyWith<$Res>? get user;
  $StoryMemoryModelCopyWith<$Res>? get memory;
  $StoryOriginalModelCopyWith<$Res>? get original_story;
}

/// @nodoc
class _$StoryModelCopyWithImpl<$Res, $Val extends StoryModel>
    implements $StoryModelCopyWith<$Res> {
  _$StoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user_id = null,
    Object? memory_id = null,
    Object? is_public = null,
    Object? created_at = null,
    Object? expires_at = null,
    Object? user = freezed,
    Object? memory = freezed,
    Object? likes_count = null,
    Object? comments_count = null,
    Object? shares_count = null,
    Object? reposts_count = null,
    Object? is_liked = null,
    Object? original_story = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            user_id: null == user_id
                ? _value.user_id
                : user_id // ignore: cast_nullable_to_non_nullable
                      as String,
            memory_id: null == memory_id
                ? _value.memory_id
                : memory_id // ignore: cast_nullable_to_non_nullable
                      as String,
            is_public: null == is_public
                ? _value.is_public
                : is_public // ignore: cast_nullable_to_non_nullable
                      as bool,
            created_at: null == created_at
                ? _value.created_at
                : created_at // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            expires_at: null == expires_at
                ? _value.expires_at
                : expires_at // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as StoryUserModel?,
            memory: freezed == memory
                ? _value.memory
                : memory // ignore: cast_nullable_to_non_nullable
                      as StoryMemoryModel?,
            likes_count: null == likes_count
                ? _value.likes_count
                : likes_count // ignore: cast_nullable_to_non_nullable
                      as int,
            comments_count: null == comments_count
                ? _value.comments_count
                : comments_count // ignore: cast_nullable_to_non_nullable
                      as int,
            shares_count: null == shares_count
                ? _value.shares_count
                : shares_count // ignore: cast_nullable_to_non_nullable
                      as int,
            reposts_count: null == reposts_count
                ? _value.reposts_count
                : reposts_count // ignore: cast_nullable_to_non_nullable
                      as int,
            is_liked: null == is_liked
                ? _value.is_liked
                : is_liked // ignore: cast_nullable_to_non_nullable
                      as bool,
            original_story: freezed == original_story
                ? _value.original_story
                : original_story // ignore: cast_nullable_to_non_nullable
                      as StoryOriginalModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StoryUserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $StoryUserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StoryMemoryModelCopyWith<$Res>? get memory {
    if (_value.memory == null) {
      return null;
    }

    return $StoryMemoryModelCopyWith<$Res>(_value.memory!, (value) {
      return _then(_value.copyWith(memory: value) as $Val);
    });
  }

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StoryOriginalModelCopyWith<$Res>? get original_story {
    if (_value.original_story == null) {
      return null;
    }

    return $StoryOriginalModelCopyWith<$Res>(_value.original_story!, (value) {
      return _then(_value.copyWith(original_story: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StoryModelImplCopyWith<$Res>
    implements $StoryModelCopyWith<$Res> {
  factory _$$StoryModelImplCopyWith(
    _$StoryModelImpl value,
    $Res Function(_$StoryModelImpl) then,
  ) = __$$StoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String user_id,
    String memory_id,
    bool is_public,
    DateTime created_at,
    DateTime expires_at,
    StoryUserModel? user,
    StoryMemoryModel? memory,
    int likes_count,
    int comments_count,
    int shares_count,
    int reposts_count,
    bool is_liked,
    StoryOriginalModel? original_story,
  });

  @override
  $StoryUserModelCopyWith<$Res>? get user;
  @override
  $StoryMemoryModelCopyWith<$Res>? get memory;
  @override
  $StoryOriginalModelCopyWith<$Res>? get original_story;
}

/// @nodoc
class __$$StoryModelImplCopyWithImpl<$Res>
    extends _$StoryModelCopyWithImpl<$Res, _$StoryModelImpl>
    implements _$$StoryModelImplCopyWith<$Res> {
  __$$StoryModelImplCopyWithImpl(
    _$StoryModelImpl _value,
    $Res Function(_$StoryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user_id = null,
    Object? memory_id = null,
    Object? is_public = null,
    Object? created_at = null,
    Object? expires_at = null,
    Object? user = freezed,
    Object? memory = freezed,
    Object? likes_count = null,
    Object? comments_count = null,
    Object? shares_count = null,
    Object? reposts_count = null,
    Object? is_liked = null,
    Object? original_story = freezed,
  }) {
    return _then(
      _$StoryModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        user_id: null == user_id
            ? _value.user_id
            : user_id // ignore: cast_nullable_to_non_nullable
                  as String,
        memory_id: null == memory_id
            ? _value.memory_id
            : memory_id // ignore: cast_nullable_to_non_nullable
                  as String,
        is_public: null == is_public
            ? _value.is_public
            : is_public // ignore: cast_nullable_to_non_nullable
                  as bool,
        created_at: null == created_at
            ? _value.created_at
            : created_at // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        expires_at: null == expires_at
            ? _value.expires_at
            : expires_at // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as StoryUserModel?,
        memory: freezed == memory
            ? _value.memory
            : memory // ignore: cast_nullable_to_non_nullable
                  as StoryMemoryModel?,
        likes_count: null == likes_count
            ? _value.likes_count
            : likes_count // ignore: cast_nullable_to_non_nullable
                  as int,
        comments_count: null == comments_count
            ? _value.comments_count
            : comments_count // ignore: cast_nullable_to_non_nullable
                  as int,
        shares_count: null == shares_count
            ? _value.shares_count
            : shares_count // ignore: cast_nullable_to_non_nullable
                  as int,
        reposts_count: null == reposts_count
            ? _value.reposts_count
            : reposts_count // ignore: cast_nullable_to_non_nullable
                  as int,
        is_liked: null == is_liked
            ? _value.is_liked
            : is_liked // ignore: cast_nullable_to_non_nullable
                  as bool,
        original_story: freezed == original_story
            ? _value.original_story
            : original_story // ignore: cast_nullable_to_non_nullable
                  as StoryOriginalModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryModelImpl implements _StoryModel {
  const _$StoryModelImpl({
    required this.id,
    required this.user_id,
    required this.memory_id,
    required this.is_public,
    required this.created_at,
    required this.expires_at,
    this.user,
    this.memory,
    this.likes_count = 0,
    this.comments_count = 0,
    this.shares_count = 0,
    this.reposts_count = 0,
    this.is_liked = false,
    this.original_story,
  });

  factory _$StoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryModelImplFromJson(json);

  @override
  final String id;
  // ignore: non_constant_identifier_names
  @override
  final String user_id;
  // ignore: non_constant_identifier_names
  @override
  final String memory_id;
  // ignore: non_constant_identifier_names
  @override
  final bool is_public;
  // ignore: non_constant_identifier_names
  @override
  final DateTime created_at;
  // ignore: non_constant_identifier_names
  @override
  final DateTime expires_at;
  @override
  final StoryUserModel? user;
  @override
  final StoryMemoryModel? memory;
  // Social features
  // ignore: non_constant_identifier_names
  @override
  @JsonKey()
  final int likes_count;
  // ignore: non_constant_identifier_names
  @override
  @JsonKey()
  final int comments_count;
  // ignore: non_constant_identifier_names
  @override
  @JsonKey()
  final int shares_count;
  // ignore: non_constant_identifier_names
  @override
  @JsonKey()
  final int reposts_count;
  // ignore: non_constant_identifier_names
  @override
  @JsonKey()
  final bool is_liked;
  // For reposts
  // ignore: non_constant_identifier_names
  @override
  final StoryOriginalModel? original_story;

  @override
  String toString() {
    return 'StoryModel(id: $id, user_id: $user_id, memory_id: $memory_id, is_public: $is_public, created_at: $created_at, expires_at: $expires_at, user: $user, memory: $memory, likes_count: $likes_count, comments_count: $comments_count, shares_count: $shares_count, reposts_count: $reposts_count, is_liked: $is_liked, original_story: $original_story)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.memory_id, memory_id) ||
                other.memory_id == memory_id) &&
            (identical(other.is_public, is_public) ||
                other.is_public == is_public) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.expires_at, expires_at) ||
                other.expires_at == expires_at) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.memory, memory) || other.memory == memory) &&
            (identical(other.likes_count, likes_count) ||
                other.likes_count == likes_count) &&
            (identical(other.comments_count, comments_count) ||
                other.comments_count == comments_count) &&
            (identical(other.shares_count, shares_count) ||
                other.shares_count == shares_count) &&
            (identical(other.reposts_count, reposts_count) ||
                other.reposts_count == reposts_count) &&
            (identical(other.is_liked, is_liked) ||
                other.is_liked == is_liked) &&
            (identical(other.original_story, original_story) ||
                other.original_story == original_story));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    user_id,
    memory_id,
    is_public,
    created_at,
    expires_at,
    user,
    memory,
    likes_count,
    comments_count,
    shares_count,
    reposts_count,
    is_liked,
    original_story,
  );

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryModelImplCopyWith<_$StoryModelImpl> get copyWith =>
      __$$StoryModelImplCopyWithImpl<_$StoryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryModelImplToJson(this);
  }
}

abstract class _StoryModel implements StoryModel {
  const factory _StoryModel({
    required final String id,
    required final String user_id,
    required final String memory_id,
    required final bool is_public,
    required final DateTime created_at,
    required final DateTime expires_at,
    final StoryUserModel? user,
    final StoryMemoryModel? memory,
    final int likes_count,
    final int comments_count,
    final int shares_count,
    final int reposts_count,
    final bool is_liked,
    final StoryOriginalModel? original_story,
  }) = _$StoryModelImpl;

  factory _StoryModel.fromJson(Map<String, dynamic> json) =
      _$StoryModelImpl.fromJson;

  @override
  String get id; // ignore: non_constant_identifier_names
  @override
  String get user_id; // ignore: non_constant_identifier_names
  @override
  String get memory_id; // ignore: non_constant_identifier_names
  @override
  bool get is_public; // ignore: non_constant_identifier_names
  @override
  DateTime get created_at; // ignore: non_constant_identifier_names
  @override
  DateTime get expires_at;
  @override
  StoryUserModel? get user;
  @override
  StoryMemoryModel? get memory; // Social features
  // ignore: non_constant_identifier_names
  @override
  int get likes_count; // ignore: non_constant_identifier_names
  @override
  int get comments_count; // ignore: non_constant_identifier_names
  @override
  int get shares_count; // ignore: non_constant_identifier_names
  @override
  int get reposts_count; // ignore: non_constant_identifier_names
  @override
  bool get is_liked; // For reposts
  // ignore: non_constant_identifier_names
  @override
  StoryOriginalModel? get original_story;

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryModelImplCopyWith<_$StoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StoryUserModel _$StoryUserModelFromJson(Map<String, dynamic> json) {
  return _StoryUserModel.fromJson(json);
}

/// @nodoc
mixin _$StoryUserModel {
  String get id => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get email =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  String? get first_name =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  String? get last_name =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  String? get avatar_url => throw _privateConstructorUsedError;

  /// Serializes this StoryUserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryUserModelCopyWith<StoryUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryUserModelCopyWith<$Res> {
  factory $StoryUserModelCopyWith(
    StoryUserModel value,
    $Res Function(StoryUserModel) then,
  ) = _$StoryUserModelCopyWithImpl<$Res, StoryUserModel>;
  @useResult
  $Res call({
    String id,
    String? username,
    String? email,
    String? first_name,
    String? last_name,
    String? avatar_url,
  });
}

/// @nodoc
class _$StoryUserModelCopyWithImpl<$Res, $Val extends StoryUserModel>
    implements $StoryUserModelCopyWith<$Res> {
  _$StoryUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = freezed,
    Object? email = freezed,
    Object? first_name = freezed,
    Object? last_name = freezed,
    Object? avatar_url = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            first_name: freezed == first_name
                ? _value.first_name
                : first_name // ignore: cast_nullable_to_non_nullable
                      as String?,
            last_name: freezed == last_name
                ? _value.last_name
                : last_name // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatar_url: freezed == avatar_url
                ? _value.avatar_url
                : avatar_url // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoryUserModelImplCopyWith<$Res>
    implements $StoryUserModelCopyWith<$Res> {
  factory _$$StoryUserModelImplCopyWith(
    _$StoryUserModelImpl value,
    $Res Function(_$StoryUserModelImpl) then,
  ) = __$$StoryUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? username,
    String? email,
    String? first_name,
    String? last_name,
    String? avatar_url,
  });
}

/// @nodoc
class __$$StoryUserModelImplCopyWithImpl<$Res>
    extends _$StoryUserModelCopyWithImpl<$Res, _$StoryUserModelImpl>
    implements _$$StoryUserModelImplCopyWith<$Res> {
  __$$StoryUserModelImplCopyWithImpl(
    _$StoryUserModelImpl _value,
    $Res Function(_$StoryUserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = freezed,
    Object? email = freezed,
    Object? first_name = freezed,
    Object? last_name = freezed,
    Object? avatar_url = freezed,
  }) {
    return _then(
      _$StoryUserModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        first_name: freezed == first_name
            ? _value.first_name
            : first_name // ignore: cast_nullable_to_non_nullable
                  as String?,
        last_name: freezed == last_name
            ? _value.last_name
            : last_name // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatar_url: freezed == avatar_url
            ? _value.avatar_url
            : avatar_url // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryUserModelImpl implements _StoryUserModel {
  const _$StoryUserModelImpl({
    required this.id,
    this.username,
    this.email,
    this.first_name,
    this.last_name,
    this.avatar_url,
  });

  factory _$StoryUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryUserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? username;
  @override
  final String? email;
  // ignore: non_constant_identifier_names
  @override
  final String? first_name;
  // ignore: non_constant_identifier_names
  @override
  final String? last_name;
  // ignore: non_constant_identifier_names
  @override
  final String? avatar_url;

  @override
  String toString() {
    return 'StoryUserModel(id: $id, username: $username, email: $email, first_name: $first_name, last_name: $last_name, avatar_url: $avatar_url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryUserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.first_name, first_name) ||
                other.first_name == first_name) &&
            (identical(other.last_name, last_name) ||
                other.last_name == last_name) &&
            (identical(other.avatar_url, avatar_url) ||
                other.avatar_url == avatar_url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    username,
    email,
    first_name,
    last_name,
    avatar_url,
  );

  /// Create a copy of StoryUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryUserModelImplCopyWith<_$StoryUserModelImpl> get copyWith =>
      __$$StoryUserModelImplCopyWithImpl<_$StoryUserModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryUserModelImplToJson(this);
  }
}

abstract class _StoryUserModel implements StoryUserModel {
  const factory _StoryUserModel({
    required final String id,
    final String? username,
    final String? email,
    final String? first_name,
    final String? last_name,
    final String? avatar_url,
  }) = _$StoryUserModelImpl;

  factory _StoryUserModel.fromJson(Map<String, dynamic> json) =
      _$StoryUserModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get username;
  @override
  String? get email; // ignore: non_constant_identifier_names
  @override
  String? get first_name; // ignore: non_constant_identifier_names
  @override
  String? get last_name; // ignore: non_constant_identifier_names
  @override
  String? get avatar_url;

  /// Create a copy of StoryUserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryUserModelImplCopyWith<_$StoryUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StoryMemoryModel _$StoryMemoryModelFromJson(Map<String, dynamic> json) {
  return _StoryMemoryModel.fromJson(json);
}

/// @nodoc
mixin _$StoryMemoryModel {
  String get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get content =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  String? get image_url =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  String? get backdrop_url =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  String? get source_type => throw _privateConstructorUsedError;

  /// Serializes this StoryMemoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryMemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryMemoryModelCopyWith<StoryMemoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryMemoryModelCopyWith<$Res> {
  factory $StoryMemoryModelCopyWith(
    StoryMemoryModel value,
    $Res Function(StoryMemoryModel) then,
  ) = _$StoryMemoryModelCopyWithImpl<$Res, StoryMemoryModel>;
  @useResult
  $Res call({
    String id,
    String? title,
    String? content,
    String? image_url,
    String? backdrop_url,
    String? source_type,
  });
}

/// @nodoc
class _$StoryMemoryModelCopyWithImpl<$Res, $Val extends StoryMemoryModel>
    implements $StoryMemoryModelCopyWith<$Res> {
  _$StoryMemoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryMemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? content = freezed,
    Object? image_url = freezed,
    Object? backdrop_url = freezed,
    Object? source_type = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
            image_url: freezed == image_url
                ? _value.image_url
                : image_url // ignore: cast_nullable_to_non_nullable
                      as String?,
            backdrop_url: freezed == backdrop_url
                ? _value.backdrop_url
                : backdrop_url // ignore: cast_nullable_to_non_nullable
                      as String?,
            source_type: freezed == source_type
                ? _value.source_type
                : source_type // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoryMemoryModelImplCopyWith<$Res>
    implements $StoryMemoryModelCopyWith<$Res> {
  factory _$$StoryMemoryModelImplCopyWith(
    _$StoryMemoryModelImpl value,
    $Res Function(_$StoryMemoryModelImpl) then,
  ) = __$$StoryMemoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? title,
    String? content,
    String? image_url,
    String? backdrop_url,
    String? source_type,
  });
}

/// @nodoc
class __$$StoryMemoryModelImplCopyWithImpl<$Res>
    extends _$StoryMemoryModelCopyWithImpl<$Res, _$StoryMemoryModelImpl>
    implements _$$StoryMemoryModelImplCopyWith<$Res> {
  __$$StoryMemoryModelImplCopyWithImpl(
    _$StoryMemoryModelImpl _value,
    $Res Function(_$StoryMemoryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryMemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? content = freezed,
    Object? image_url = freezed,
    Object? backdrop_url = freezed,
    Object? source_type = freezed,
  }) {
    return _then(
      _$StoryMemoryModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
        image_url: freezed == image_url
            ? _value.image_url
            : image_url // ignore: cast_nullable_to_non_nullable
                  as String?,
        backdrop_url: freezed == backdrop_url
            ? _value.backdrop_url
            : backdrop_url // ignore: cast_nullable_to_non_nullable
                  as String?,
        source_type: freezed == source_type
            ? _value.source_type
            : source_type // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryMemoryModelImpl implements _StoryMemoryModel {
  const _$StoryMemoryModelImpl({
    required this.id,
    this.title,
    this.content,
    this.image_url,
    this.backdrop_url,
    this.source_type,
  });

  factory _$StoryMemoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryMemoryModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? title;
  @override
  final String? content;
  // ignore: non_constant_identifier_names
  @override
  final String? image_url;
  // ignore: non_constant_identifier_names
  @override
  final String? backdrop_url;
  // ignore: non_constant_identifier_names
  @override
  final String? source_type;

  @override
  String toString() {
    return 'StoryMemoryModel(id: $id, title: $title, content: $content, image_url: $image_url, backdrop_url: $backdrop_url, source_type: $source_type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryMemoryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.image_url, image_url) ||
                other.image_url == image_url) &&
            (identical(other.backdrop_url, backdrop_url) ||
                other.backdrop_url == backdrop_url) &&
            (identical(other.source_type, source_type) ||
                other.source_type == source_type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    content,
    image_url,
    backdrop_url,
    source_type,
  );

  /// Create a copy of StoryMemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryMemoryModelImplCopyWith<_$StoryMemoryModelImpl> get copyWith =>
      __$$StoryMemoryModelImplCopyWithImpl<_$StoryMemoryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryMemoryModelImplToJson(this);
  }
}

abstract class _StoryMemoryModel implements StoryMemoryModel {
  const factory _StoryMemoryModel({
    required final String id,
    final String? title,
    final String? content,
    final String? image_url,
    final String? backdrop_url,
    final String? source_type,
  }) = _$StoryMemoryModelImpl;

  factory _StoryMemoryModel.fromJson(Map<String, dynamic> json) =
      _$StoryMemoryModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get title;
  @override
  String? get content; // ignore: non_constant_identifier_names
  @override
  String? get image_url; // ignore: non_constant_identifier_names
  @override
  String? get backdrop_url; // ignore: non_constant_identifier_names
  @override
  String? get source_type;

  /// Create a copy of StoryMemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryMemoryModelImplCopyWith<_$StoryMemoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StoryOriginalModel _$StoryOriginalModelFromJson(Map<String, dynamic> json) {
  return _StoryOriginalModel.fromJson(json);
}

/// @nodoc
mixin _$StoryOriginalModel {
  String get id => throw _privateConstructorUsedError;
  StoryUserModel? get user => throw _privateConstructorUsedError;

  /// Serializes this StoryOriginalModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryOriginalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryOriginalModelCopyWith<StoryOriginalModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryOriginalModelCopyWith<$Res> {
  factory $StoryOriginalModelCopyWith(
    StoryOriginalModel value,
    $Res Function(StoryOriginalModel) then,
  ) = _$StoryOriginalModelCopyWithImpl<$Res, StoryOriginalModel>;
  @useResult
  $Res call({String id, StoryUserModel? user});

  $StoryUserModelCopyWith<$Res>? get user;
}

/// @nodoc
class _$StoryOriginalModelCopyWithImpl<$Res, $Val extends StoryOriginalModel>
    implements $StoryOriginalModelCopyWith<$Res> {
  _$StoryOriginalModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryOriginalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? user = freezed}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as StoryUserModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of StoryOriginalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StoryUserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $StoryUserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StoryOriginalModelImplCopyWith<$Res>
    implements $StoryOriginalModelCopyWith<$Res> {
  factory _$$StoryOriginalModelImplCopyWith(
    _$StoryOriginalModelImpl value,
    $Res Function(_$StoryOriginalModelImpl) then,
  ) = __$$StoryOriginalModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, StoryUserModel? user});

  @override
  $StoryUserModelCopyWith<$Res>? get user;
}

/// @nodoc
class __$$StoryOriginalModelImplCopyWithImpl<$Res>
    extends _$StoryOriginalModelCopyWithImpl<$Res, _$StoryOriginalModelImpl>
    implements _$$StoryOriginalModelImplCopyWith<$Res> {
  __$$StoryOriginalModelImplCopyWithImpl(
    _$StoryOriginalModelImpl _value,
    $Res Function(_$StoryOriginalModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryOriginalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? user = freezed}) {
    return _then(
      _$StoryOriginalModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as StoryUserModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryOriginalModelImpl implements _StoryOriginalModel {
  const _$StoryOriginalModelImpl({required this.id, this.user});

  factory _$StoryOriginalModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryOriginalModelImplFromJson(json);

  @override
  final String id;
  @override
  final StoryUserModel? user;

  @override
  String toString() {
    return 'StoryOriginalModel(id: $id, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryOriginalModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, user);

  /// Create a copy of StoryOriginalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryOriginalModelImplCopyWith<_$StoryOriginalModelImpl> get copyWith =>
      __$$StoryOriginalModelImplCopyWithImpl<_$StoryOriginalModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryOriginalModelImplToJson(this);
  }
}

abstract class _StoryOriginalModel implements StoryOriginalModel {
  const factory _StoryOriginalModel({
    required final String id,
    final StoryUserModel? user,
  }) = _$StoryOriginalModelImpl;

  factory _StoryOriginalModel.fromJson(Map<String, dynamic> json) =
      _$StoryOriginalModelImpl.fromJson;

  @override
  String get id;
  @override
  StoryUserModel? get user;

  /// Create a copy of StoryOriginalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryOriginalModelImplCopyWith<_$StoryOriginalModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
