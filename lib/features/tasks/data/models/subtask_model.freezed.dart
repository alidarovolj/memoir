// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subtask_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SubtaskModel _$SubtaskModelFromJson(Map<String, dynamic> json) {
  return _SubtaskModel.fromJson(json);
}

/// @nodoc
mixin _$SubtaskModel {
  String get id => throw _privateConstructorUsedError;
  String get task_id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool get is_completed => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;
  DateTime get updated_at => throw _privateConstructorUsedError;
  DateTime? get completed_at => throw _privateConstructorUsedError;

  /// Serializes this SubtaskModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubtaskModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubtaskModelCopyWith<SubtaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubtaskModelCopyWith<$Res> {
  factory $SubtaskModelCopyWith(
    SubtaskModel value,
    $Res Function(SubtaskModel) then,
  ) = _$SubtaskModelCopyWithImpl<$Res, SubtaskModel>;
  @useResult
  $Res call({
    String id,
    String task_id,
    String title,
    bool is_completed,
    int order,
    DateTime created_at,
    DateTime updated_at,
    DateTime? completed_at,
  });
}

/// @nodoc
class _$SubtaskModelCopyWithImpl<$Res, $Val extends SubtaskModel>
    implements $SubtaskModelCopyWith<$Res> {
  _$SubtaskModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubtaskModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? task_id = null,
    Object? title = null,
    Object? is_completed = null,
    Object? order = null,
    Object? created_at = null,
    Object? updated_at = null,
    Object? completed_at = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            task_id: null == task_id
                ? _value.task_id
                : task_id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            is_completed: null == is_completed
                ? _value.is_completed
                : is_completed // ignore: cast_nullable_to_non_nullable
                      as bool,
            order: null == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int,
            created_at: null == created_at
                ? _value.created_at
                : created_at // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updated_at: null == updated_at
                ? _value.updated_at
                : updated_at // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completed_at: freezed == completed_at
                ? _value.completed_at
                : completed_at // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubtaskModelImplCopyWith<$Res>
    implements $SubtaskModelCopyWith<$Res> {
  factory _$$SubtaskModelImplCopyWith(
    _$SubtaskModelImpl value,
    $Res Function(_$SubtaskModelImpl) then,
  ) = __$$SubtaskModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String task_id,
    String title,
    bool is_completed,
    int order,
    DateTime created_at,
    DateTime updated_at,
    DateTime? completed_at,
  });
}

/// @nodoc
class __$$SubtaskModelImplCopyWithImpl<$Res>
    extends _$SubtaskModelCopyWithImpl<$Res, _$SubtaskModelImpl>
    implements _$$SubtaskModelImplCopyWith<$Res> {
  __$$SubtaskModelImplCopyWithImpl(
    _$SubtaskModelImpl _value,
    $Res Function(_$SubtaskModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubtaskModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? task_id = null,
    Object? title = null,
    Object? is_completed = null,
    Object? order = null,
    Object? created_at = null,
    Object? updated_at = null,
    Object? completed_at = freezed,
  }) {
    return _then(
      _$SubtaskModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        task_id: null == task_id
            ? _value.task_id
            : task_id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        is_completed: null == is_completed
            ? _value.is_completed
            : is_completed // ignore: cast_nullable_to_non_nullable
                  as bool,
        order: null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int,
        created_at: null == created_at
            ? _value.created_at
            : created_at // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updated_at: null == updated_at
            ? _value.updated_at
            : updated_at // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completed_at: freezed == completed_at
            ? _value.completed_at
            : completed_at // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubtaskModelImpl implements _SubtaskModel {
  const _$SubtaskModelImpl({
    required this.id,
    required this.task_id,
    required this.title,
    this.is_completed = false,
    this.order = 0,
    required this.created_at,
    required this.updated_at,
    this.completed_at,
  });

  factory _$SubtaskModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubtaskModelImplFromJson(json);

  @override
  final String id;
  @override
  final String task_id;
  @override
  final String title;
  @override
  @JsonKey()
  final bool is_completed;
  @override
  @JsonKey()
  final int order;
  @override
  final DateTime created_at;
  @override
  final DateTime updated_at;
  @override
  final DateTime? completed_at;

  @override
  String toString() {
    return 'SubtaskModel(id: $id, task_id: $task_id, title: $title, is_completed: $is_completed, order: $order, created_at: $created_at, updated_at: $updated_at, completed_at: $completed_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubtaskModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.task_id, task_id) || other.task_id == task_id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.is_completed, is_completed) ||
                other.is_completed == is_completed) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.updated_at, updated_at) ||
                other.updated_at == updated_at) &&
            (identical(other.completed_at, completed_at) ||
                other.completed_at == completed_at));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    task_id,
    title,
    is_completed,
    order,
    created_at,
    updated_at,
    completed_at,
  );

  /// Create a copy of SubtaskModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubtaskModelImplCopyWith<_$SubtaskModelImpl> get copyWith =>
      __$$SubtaskModelImplCopyWithImpl<_$SubtaskModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubtaskModelImplToJson(this);
  }
}

abstract class _SubtaskModel implements SubtaskModel {
  const factory _SubtaskModel({
    required final String id,
    required final String task_id,
    required final String title,
    final bool is_completed,
    final int order,
    required final DateTime created_at,
    required final DateTime updated_at,
    final DateTime? completed_at,
  }) = _$SubtaskModelImpl;

  factory _SubtaskModel.fromJson(Map<String, dynamic> json) =
      _$SubtaskModelImpl.fromJson;

  @override
  String get id;
  @override
  String get task_id;
  @override
  String get title;
  @override
  bool get is_completed;
  @override
  int get order;
  @override
  DateTime get created_at;
  @override
  DateTime get updated_at;
  @override
  DateTime? get completed_at;

  /// Create a copy of SubtaskModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubtaskModelImplCopyWith<_$SubtaskModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubtaskCreate _$SubtaskCreateFromJson(Map<String, dynamic> json) {
  return _SubtaskCreate.fromJson(json);
}

/// @nodoc
mixin _$SubtaskCreate {
  String get title => throw _privateConstructorUsedError;
  bool get is_completed => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;

  /// Serializes this SubtaskCreate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubtaskCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubtaskCreateCopyWith<SubtaskCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubtaskCreateCopyWith<$Res> {
  factory $SubtaskCreateCopyWith(
    SubtaskCreate value,
    $Res Function(SubtaskCreate) then,
  ) = _$SubtaskCreateCopyWithImpl<$Res, SubtaskCreate>;
  @useResult
  $Res call({String title, bool is_completed, int order});
}

/// @nodoc
class _$SubtaskCreateCopyWithImpl<$Res, $Val extends SubtaskCreate>
    implements $SubtaskCreateCopyWith<$Res> {
  _$SubtaskCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubtaskCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? is_completed = null,
    Object? order = null,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            is_completed: null == is_completed
                ? _value.is_completed
                : is_completed // ignore: cast_nullable_to_non_nullable
                      as bool,
            order: null == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubtaskCreateImplCopyWith<$Res>
    implements $SubtaskCreateCopyWith<$Res> {
  factory _$$SubtaskCreateImplCopyWith(
    _$SubtaskCreateImpl value,
    $Res Function(_$SubtaskCreateImpl) then,
  ) = __$$SubtaskCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, bool is_completed, int order});
}

/// @nodoc
class __$$SubtaskCreateImplCopyWithImpl<$Res>
    extends _$SubtaskCreateCopyWithImpl<$Res, _$SubtaskCreateImpl>
    implements _$$SubtaskCreateImplCopyWith<$Res> {
  __$$SubtaskCreateImplCopyWithImpl(
    _$SubtaskCreateImpl _value,
    $Res Function(_$SubtaskCreateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubtaskCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? is_completed = null,
    Object? order = null,
  }) {
    return _then(
      _$SubtaskCreateImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        is_completed: null == is_completed
            ? _value.is_completed
            : is_completed // ignore: cast_nullable_to_non_nullable
                  as bool,
        order: null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubtaskCreateImpl implements _SubtaskCreate {
  const _$SubtaskCreateImpl({
    required this.title,
    this.is_completed = false,
    this.order = 0,
  });

  factory _$SubtaskCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubtaskCreateImplFromJson(json);

  @override
  final String title;
  @override
  @JsonKey()
  final bool is_completed;
  @override
  @JsonKey()
  final int order;

  @override
  String toString() {
    return 'SubtaskCreate(title: $title, is_completed: $is_completed, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubtaskCreateImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.is_completed, is_completed) ||
                other.is_completed == is_completed) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, is_completed, order);

  /// Create a copy of SubtaskCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubtaskCreateImplCopyWith<_$SubtaskCreateImpl> get copyWith =>
      __$$SubtaskCreateImplCopyWithImpl<_$SubtaskCreateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubtaskCreateImplToJson(this);
  }
}

abstract class _SubtaskCreate implements SubtaskCreate {
  const factory _SubtaskCreate({
    required final String title,
    final bool is_completed,
    final int order,
  }) = _$SubtaskCreateImpl;

  factory _SubtaskCreate.fromJson(Map<String, dynamic> json) =
      _$SubtaskCreateImpl.fromJson;

  @override
  String get title;
  @override
  bool get is_completed;
  @override
  int get order;

  /// Create a copy of SubtaskCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubtaskCreateImplCopyWith<_$SubtaskCreateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubtaskUpdate _$SubtaskUpdateFromJson(Map<String, dynamic> json) {
  return _SubtaskUpdate.fromJson(json);
}

/// @nodoc
mixin _$SubtaskUpdate {
  String? get title => throw _privateConstructorUsedError;
  bool? get is_completed => throw _privateConstructorUsedError;
  int? get order => throw _privateConstructorUsedError;

  /// Serializes this SubtaskUpdate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubtaskUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubtaskUpdateCopyWith<SubtaskUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubtaskUpdateCopyWith<$Res> {
  factory $SubtaskUpdateCopyWith(
    SubtaskUpdate value,
    $Res Function(SubtaskUpdate) then,
  ) = _$SubtaskUpdateCopyWithImpl<$Res, SubtaskUpdate>;
  @useResult
  $Res call({String? title, bool? is_completed, int? order});
}

/// @nodoc
class _$SubtaskUpdateCopyWithImpl<$Res, $Val extends SubtaskUpdate>
    implements $SubtaskUpdateCopyWith<$Res> {
  _$SubtaskUpdateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubtaskUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? is_completed = freezed,
    Object? order = freezed,
  }) {
    return _then(
      _value.copyWith(
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            is_completed: freezed == is_completed
                ? _value.is_completed
                : is_completed // ignore: cast_nullable_to_non_nullable
                      as bool?,
            order: freezed == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubtaskUpdateImplCopyWith<$Res>
    implements $SubtaskUpdateCopyWith<$Res> {
  factory _$$SubtaskUpdateImplCopyWith(
    _$SubtaskUpdateImpl value,
    $Res Function(_$SubtaskUpdateImpl) then,
  ) = __$$SubtaskUpdateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, bool? is_completed, int? order});
}

/// @nodoc
class __$$SubtaskUpdateImplCopyWithImpl<$Res>
    extends _$SubtaskUpdateCopyWithImpl<$Res, _$SubtaskUpdateImpl>
    implements _$$SubtaskUpdateImplCopyWith<$Res> {
  __$$SubtaskUpdateImplCopyWithImpl(
    _$SubtaskUpdateImpl _value,
    $Res Function(_$SubtaskUpdateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubtaskUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? is_completed = freezed,
    Object? order = freezed,
  }) {
    return _then(
      _$SubtaskUpdateImpl(
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        is_completed: freezed == is_completed
            ? _value.is_completed
            : is_completed // ignore: cast_nullable_to_non_nullable
                  as bool?,
        order: freezed == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubtaskUpdateImpl implements _SubtaskUpdate {
  const _$SubtaskUpdateImpl({this.title, this.is_completed, this.order});

  factory _$SubtaskUpdateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubtaskUpdateImplFromJson(json);

  @override
  final String? title;
  @override
  final bool? is_completed;
  @override
  final int? order;

  @override
  String toString() {
    return 'SubtaskUpdate(title: $title, is_completed: $is_completed, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubtaskUpdateImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.is_completed, is_completed) ||
                other.is_completed == is_completed) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, is_completed, order);

  /// Create a copy of SubtaskUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubtaskUpdateImplCopyWith<_$SubtaskUpdateImpl> get copyWith =>
      __$$SubtaskUpdateImplCopyWithImpl<_$SubtaskUpdateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubtaskUpdateImplToJson(this);
  }
}

abstract class _SubtaskUpdate implements SubtaskUpdate {
  const factory _SubtaskUpdate({
    final String? title,
    final bool? is_completed,
    final int? order,
  }) = _$SubtaskUpdateImpl;

  factory _SubtaskUpdate.fromJson(Map<String, dynamic> json) =
      _$SubtaskUpdateImpl.fromJson;

  @override
  String? get title;
  @override
  bool? get is_completed;
  @override
  int? get order;

  /// Create a copy of SubtaskUpdate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubtaskUpdateImplCopyWith<_$SubtaskUpdateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
