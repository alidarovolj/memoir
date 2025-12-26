// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StoryCommentModel _$StoryCommentModelFromJson(Map<String, dynamic> json) {
  return _StoryCommentModel.fromJson(json);
}

/// @nodoc
mixin _$StoryCommentModel {
  String get id =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  String get story_id =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  String get user_id => throw _privateConstructorUsedError;
  String get content =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  DateTime get created_at =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  DateTime? get updated_at => throw _privateConstructorUsedError;
  StoryUserModel? get user => throw _privateConstructorUsedError;

  /// Serializes this StoryCommentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryCommentModelCopyWith<StoryCommentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryCommentModelCopyWith<$Res> {
  factory $StoryCommentModelCopyWith(
    StoryCommentModel value,
    $Res Function(StoryCommentModel) then,
  ) = _$StoryCommentModelCopyWithImpl<$Res, StoryCommentModel>;
  @useResult
  $Res call({
    String id,
    String story_id,
    String user_id,
    String content,
    DateTime created_at,
    DateTime? updated_at,
    StoryUserModel? user,
  });

  $StoryUserModelCopyWith<$Res>? get user;
}

/// @nodoc
class _$StoryCommentModelCopyWithImpl<$Res, $Val extends StoryCommentModel>
    implements $StoryCommentModelCopyWith<$Res> {
  _$StoryCommentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? story_id = null,
    Object? user_id = null,
    Object? content = null,
    Object? created_at = null,
    Object? updated_at = freezed,
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
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            created_at: null == created_at
                ? _value.created_at
                : created_at // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updated_at: freezed == updated_at
                ? _value.updated_at
                : updated_at // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as StoryUserModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of StoryCommentModel
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
abstract class _$$StoryCommentModelImplCopyWith<$Res>
    implements $StoryCommentModelCopyWith<$Res> {
  factory _$$StoryCommentModelImplCopyWith(
    _$StoryCommentModelImpl value,
    $Res Function(_$StoryCommentModelImpl) then,
  ) = __$$StoryCommentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String story_id,
    String user_id,
    String content,
    DateTime created_at,
    DateTime? updated_at,
    StoryUserModel? user,
  });

  @override
  $StoryUserModelCopyWith<$Res>? get user;
}

/// @nodoc
class __$$StoryCommentModelImplCopyWithImpl<$Res>
    extends _$StoryCommentModelCopyWithImpl<$Res, _$StoryCommentModelImpl>
    implements _$$StoryCommentModelImplCopyWith<$Res> {
  __$$StoryCommentModelImplCopyWithImpl(
    _$StoryCommentModelImpl _value,
    $Res Function(_$StoryCommentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? story_id = null,
    Object? user_id = null,
    Object? content = null,
    Object? created_at = null,
    Object? updated_at = freezed,
    Object? user = freezed,
  }) {
    return _then(
      _$StoryCommentModelImpl(
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
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        created_at: null == created_at
            ? _value.created_at
            : created_at // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updated_at: freezed == updated_at
            ? _value.updated_at
            : updated_at // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
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
class _$StoryCommentModelImpl implements _StoryCommentModel {
  const _$StoryCommentModelImpl({
    required this.id,
    required this.story_id,
    required this.user_id,
    required this.content,
    required this.created_at,
    this.updated_at,
    this.user,
  });

  factory _$StoryCommentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryCommentModelImplFromJson(json);

  @override
  final String id;
  // ignore: non_constant_identifier_names
  @override
  final String story_id;
  // ignore: non_constant_identifier_names
  @override
  final String user_id;
  @override
  final String content;
  // ignore: non_constant_identifier_names
  @override
  final DateTime created_at;
  // ignore: non_constant_identifier_names
  @override
  final DateTime? updated_at;
  @override
  final StoryUserModel? user;

  @override
  String toString() {
    return 'StoryCommentModel(id: $id, story_id: $story_id, user_id: $user_id, content: $content, created_at: $created_at, updated_at: $updated_at, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryCommentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.story_id, story_id) ||
                other.story_id == story_id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.updated_at, updated_at) ||
                other.updated_at == updated_at) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    story_id,
    user_id,
    content,
    created_at,
    updated_at,
    user,
  );

  /// Create a copy of StoryCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryCommentModelImplCopyWith<_$StoryCommentModelImpl> get copyWith =>
      __$$StoryCommentModelImplCopyWithImpl<_$StoryCommentModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryCommentModelImplToJson(this);
  }
}

abstract class _StoryCommentModel implements StoryCommentModel {
  const factory _StoryCommentModel({
    required final String id,
    required final String story_id,
    required final String user_id,
    required final String content,
    required final DateTime created_at,
    final DateTime? updated_at,
    final StoryUserModel? user,
  }) = _$StoryCommentModelImpl;

  factory _StoryCommentModel.fromJson(Map<String, dynamic> json) =
      _$StoryCommentModelImpl.fromJson;

  @override
  String get id; // ignore: non_constant_identifier_names
  @override
  String get story_id; // ignore: non_constant_identifier_names
  @override
  String get user_id;
  @override
  String get content; // ignore: non_constant_identifier_names
  @override
  DateTime get created_at; // ignore: non_constant_identifier_names
  @override
  DateTime? get updated_at;
  @override
  StoryUserModel? get user;

  /// Create a copy of StoryCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryCommentModelImplCopyWith<_$StoryCommentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StoryCommentListModel _$StoryCommentListModelFromJson(
  Map<String, dynamic> json,
) {
  return _StoryCommentListModel.fromJson(json);
}

/// @nodoc
mixin _$StoryCommentListModel {
  List<StoryCommentModel> get items => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  /// Serializes this StoryCommentListModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryCommentListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryCommentListModelCopyWith<StoryCommentListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryCommentListModelCopyWith<$Res> {
  factory $StoryCommentListModelCopyWith(
    StoryCommentListModel value,
    $Res Function(StoryCommentListModel) then,
  ) = _$StoryCommentListModelCopyWithImpl<$Res, StoryCommentListModel>;
  @useResult
  $Res call({List<StoryCommentModel> items, int total});
}

/// @nodoc
class _$StoryCommentListModelCopyWithImpl<
  $Res,
  $Val extends StoryCommentListModel
>
    implements $StoryCommentListModelCopyWith<$Res> {
  _$StoryCommentListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryCommentListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null, Object? total = null}) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<StoryCommentModel>,
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
abstract class _$$StoryCommentListModelImplCopyWith<$Res>
    implements $StoryCommentListModelCopyWith<$Res> {
  factory _$$StoryCommentListModelImplCopyWith(
    _$StoryCommentListModelImpl value,
    $Res Function(_$StoryCommentListModelImpl) then,
  ) = __$$StoryCommentListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<StoryCommentModel> items, int total});
}

/// @nodoc
class __$$StoryCommentListModelImplCopyWithImpl<$Res>
    extends
        _$StoryCommentListModelCopyWithImpl<$Res, _$StoryCommentListModelImpl>
    implements _$$StoryCommentListModelImplCopyWith<$Res> {
  __$$StoryCommentListModelImplCopyWithImpl(
    _$StoryCommentListModelImpl _value,
    $Res Function(_$StoryCommentListModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryCommentListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null, Object? total = null}) {
    return _then(
      _$StoryCommentListModelImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<StoryCommentModel>,
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
class _$StoryCommentListModelImpl implements _StoryCommentListModel {
  const _$StoryCommentListModelImpl({
    required final List<StoryCommentModel> items,
    required this.total,
  }) : _items = items;

  factory _$StoryCommentListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryCommentListModelImplFromJson(json);

  final List<StoryCommentModel> _items;
  @override
  List<StoryCommentModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int total;

  @override
  String toString() {
    return 'StoryCommentListModel(items: $items, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryCommentListModelImpl &&
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

  /// Create a copy of StoryCommentListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryCommentListModelImplCopyWith<_$StoryCommentListModelImpl>
  get copyWith =>
      __$$StoryCommentListModelImplCopyWithImpl<_$StoryCommentListModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryCommentListModelImplToJson(this);
  }
}

abstract class _StoryCommentListModel implements StoryCommentListModel {
  const factory _StoryCommentListModel({
    required final List<StoryCommentModel> items,
    required final int total,
  }) = _$StoryCommentListModelImpl;

  factory _StoryCommentListModel.fromJson(Map<String, dynamic> json) =
      _$StoryCommentListModelImpl.fromJson;

  @override
  List<StoryCommentModel> get items;
  @override
  int get total;

  /// Create a copy of StoryCommentListModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryCommentListModelImplCopyWith<_$StoryCommentListModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
