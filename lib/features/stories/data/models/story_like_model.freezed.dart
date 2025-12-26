// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_like_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StoryLikeModel _$StoryLikeModelFromJson(Map<String, dynamic> json) {
  return _StoryLikeModel.fromJson(json);
}

/// @nodoc
mixin _$StoryLikeModel {
  String get id =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  String get story_id =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  String get user_id =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  DateTime get created_at => throw _privateConstructorUsedError;
  StoryUserModel? get user => throw _privateConstructorUsedError;

  /// Serializes this StoryLikeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryLikeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryLikeModelCopyWith<StoryLikeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryLikeModelCopyWith<$Res> {
  factory $StoryLikeModelCopyWith(
    StoryLikeModel value,
    $Res Function(StoryLikeModel) then,
  ) = _$StoryLikeModelCopyWithImpl<$Res, StoryLikeModel>;
  @useResult
  $Res call({
    String id,
    String story_id,
    String user_id,
    DateTime created_at,
    StoryUserModel? user,
  });

  $StoryUserModelCopyWith<$Res>? get user;
}

/// @nodoc
class _$StoryLikeModelCopyWithImpl<$Res, $Val extends StoryLikeModel>
    implements $StoryLikeModelCopyWith<$Res> {
  _$StoryLikeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryLikeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? story_id = null,
    Object? user_id = null,
    Object? created_at = null,
    Object? user = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            story_id: null == story_id
                ? _value.story_id
                : story_id // ignore: cast_nullable_to_non_nullable
                      as String,
            user_id: null == user_id
                ? _value.user_id
                : user_id // ignore: cast_nullable_to_non_nullable
                      as String,
            created_at: null == created_at
                ? _value.created_at
                : created_at // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as StoryUserModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of StoryLikeModel
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
abstract class _$$StoryLikeModelImplCopyWith<$Res>
    implements $StoryLikeModelCopyWith<$Res> {
  factory _$$StoryLikeModelImplCopyWith(
    _$StoryLikeModelImpl value,
    $Res Function(_$StoryLikeModelImpl) then,
  ) = __$$StoryLikeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String story_id,
    String user_id,
    DateTime created_at,
    StoryUserModel? user,
  });

  @override
  $StoryUserModelCopyWith<$Res>? get user;
}

/// @nodoc
class __$$StoryLikeModelImplCopyWithImpl<$Res>
    extends _$StoryLikeModelCopyWithImpl<$Res, _$StoryLikeModelImpl>
    implements _$$StoryLikeModelImplCopyWith<$Res> {
  __$$StoryLikeModelImplCopyWithImpl(
    _$StoryLikeModelImpl _value,
    $Res Function(_$StoryLikeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryLikeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? story_id = null,
    Object? user_id = null,
    Object? created_at = null,
    Object? user = freezed,
  }) {
    return _then(
      _$StoryLikeModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        story_id: null == story_id
            ? _value.story_id
            : story_id // ignore: cast_nullable_to_non_nullable
                  as String,
        user_id: null == user_id
            ? _value.user_id
            : user_id // ignore: cast_nullable_to_non_nullable
                  as String,
        created_at: null == created_at
            ? _value.created_at
            : created_at // ignore: cast_nullable_to_non_nullable
                  as DateTime,
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
class _$StoryLikeModelImpl implements _StoryLikeModel {
  const _$StoryLikeModelImpl({
    required this.id,
    required this.story_id,
    required this.user_id,
    required this.created_at,
    this.user,
  });

  factory _$StoryLikeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryLikeModelImplFromJson(json);

  @override
  final String id;
  // ignore: non_constant_identifier_names
  @override
  final String story_id;
  // ignore: non_constant_identifier_names
  @override
  final String user_id;
  // ignore: non_constant_identifier_names
  @override
  final DateTime created_at;
  @override
  final StoryUserModel? user;

  @override
  String toString() {
    return 'StoryLikeModel(id: $id, story_id: $story_id, user_id: $user_id, created_at: $created_at, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryLikeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.story_id, story_id) ||
                other.story_id == story_id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, story_id, user_id, created_at, user);

  /// Create a copy of StoryLikeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryLikeModelImplCopyWith<_$StoryLikeModelImpl> get copyWith =>
      __$$StoryLikeModelImplCopyWithImpl<_$StoryLikeModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryLikeModelImplToJson(this);
  }
}

abstract class _StoryLikeModel implements StoryLikeModel {
  const factory _StoryLikeModel({
    required final String id,
    required final String story_id,
    required final String user_id,
    required final DateTime created_at,
    final StoryUserModel? user,
  }) = _$StoryLikeModelImpl;

  factory _StoryLikeModel.fromJson(Map<String, dynamic> json) =
      _$StoryLikeModelImpl.fromJson;

  @override
  String get id; // ignore: non_constant_identifier_names
  @override
  String get story_id; // ignore: non_constant_identifier_names
  @override
  String get user_id; // ignore: non_constant_identifier_names
  @override
  DateTime get created_at;
  @override
  StoryUserModel? get user;

  /// Create a copy of StoryLikeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryLikeModelImplCopyWith<_$StoryLikeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StoryLikeListModel _$StoryLikeListModelFromJson(Map<String, dynamic> json) {
  return _StoryLikeListModel.fromJson(json);
}

/// @nodoc
mixin _$StoryLikeListModel {
  List<StoryLikeModel> get items => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  /// Serializes this StoryLikeListModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryLikeListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryLikeListModelCopyWith<StoryLikeListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryLikeListModelCopyWith<$Res> {
  factory $StoryLikeListModelCopyWith(
    StoryLikeListModel value,
    $Res Function(StoryLikeListModel) then,
  ) = _$StoryLikeListModelCopyWithImpl<$Res, StoryLikeListModel>;
  @useResult
  $Res call({List<StoryLikeModel> items, int total});
}

/// @nodoc
class _$StoryLikeListModelCopyWithImpl<$Res, $Val extends StoryLikeListModel>
    implements $StoryLikeListModelCopyWith<$Res> {
  _$StoryLikeListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryLikeListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null, Object? total = null}) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<StoryLikeModel>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoryLikeListModelImplCopyWith<$Res>
    implements $StoryLikeListModelCopyWith<$Res> {
  factory _$$StoryLikeListModelImplCopyWith(
    _$StoryLikeListModelImpl value,
    $Res Function(_$StoryLikeListModelImpl) then,
  ) = __$$StoryLikeListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<StoryLikeModel> items, int total});
}

/// @nodoc
class __$$StoryLikeListModelImplCopyWithImpl<$Res>
    extends _$StoryLikeListModelCopyWithImpl<$Res, _$StoryLikeListModelImpl>
    implements _$$StoryLikeListModelImplCopyWith<$Res> {
  __$$StoryLikeListModelImplCopyWithImpl(
    _$StoryLikeListModelImpl _value,
    $Res Function(_$StoryLikeListModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryLikeListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null, Object? total = null}) {
    return _then(
      _$StoryLikeListModelImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<StoryLikeModel>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryLikeListModelImpl implements _StoryLikeListModel {
  const _$StoryLikeListModelImpl({
    required final List<StoryLikeModel> items,
    required this.total,
  }) : _items = items;

  factory _$StoryLikeListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryLikeListModelImplFromJson(json);

  final List<StoryLikeModel> _items;
  @override
  List<StoryLikeModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int total;

  @override
  String toString() {
    return 'StoryLikeListModel(items: $items, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryLikeListModelImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    total,
  );

  /// Create a copy of StoryLikeListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryLikeListModelImplCopyWith<_$StoryLikeListModelImpl> get copyWith =>
      __$$StoryLikeListModelImplCopyWithImpl<_$StoryLikeListModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryLikeListModelImplToJson(this);
  }
}

abstract class _StoryLikeListModel implements StoryLikeListModel {
  const factory _StoryLikeListModel({
    required final List<StoryLikeModel> items,
    required final int total,
  }) = _$StoryLikeListModelImpl;

  factory _StoryLikeListModel.fromJson(Map<String, dynamic> json) =
      _$StoryLikeListModelImpl.fromJson;

  @override
  List<StoryLikeModel> get items;
  @override
  int get total;

  /// Create a copy of StoryLikeListModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryLikeListModelImplCopyWith<_$StoryLikeListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
