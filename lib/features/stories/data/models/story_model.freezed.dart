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
  StoryMemoryModel? get memory => throw _privateConstructorUsedError;

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
  });

  $StoryUserModelCopyWith<$Res>? get user;
  $StoryMemoryModelCopyWith<$Res>? get memory;
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
  });

  @override
  $StoryUserModelCopyWith<$Res>? get user;
  @override
  $StoryMemoryModelCopyWith<$Res>? get memory;
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

  @override
  String toString() {
    return 'StoryModel(id: $id, user_id: $user_id, memory_id: $memory_id, is_public: $is_public, created_at: $created_at, expires_at: $expires_at, user: $user, memory: $memory)';
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
            (identical(other.memory, memory) || other.memory == memory));
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
  StoryMemoryModel? get memory;

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
  String? get email => throw _privateConstructorUsedError;

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
  $Res call({String id, String? username, String? email});
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
  $Res call({String id, String? username, String? email});
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryUserModelImpl implements _StoryUserModel {
  const _$StoryUserModelImpl({required this.id, this.username, this.email});

  factory _$StoryUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryUserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? username;
  @override
  final String? email;

  @override
  String toString() {
    return 'StoryUserModel(id: $id, username: $username, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryUserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, username, email);

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
  }) = _$StoryUserModelImpl;

  factory _StoryUserModel.fromJson(Map<String, dynamic> json) =
      _$StoryUserModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get username;
  @override
  String? get email;

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
