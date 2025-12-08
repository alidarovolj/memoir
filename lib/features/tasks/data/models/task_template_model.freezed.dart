// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_template_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TaskTemplateModel _$TaskTemplateModelFromJson(Map<String, dynamic> json) {
  return _TaskTemplateModel.fromJson(json);
}

/// @nodoc
mixin _$TaskTemplateModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  bool get isSystem => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  Map<String, dynamic> get taskData => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  String? get categoryName => throw _privateConstructorUsedError;
  int get usageCount => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this TaskTemplateModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskTemplateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskTemplateModelCopyWith<TaskTemplateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskTemplateModelCopyWith<$Res> {
  factory $TaskTemplateModelCopyWith(
    TaskTemplateModel value,
    $Res Function(TaskTemplateModel) then,
  ) = _$TaskTemplateModelCopyWithImpl<$Res, TaskTemplateModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String? icon,
    bool isSystem,
    String? userId,
    Map<String, dynamic> taskData,
    String? categoryId,
    String? categoryName,
    int usageCount,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$TaskTemplateModelCopyWithImpl<$Res, $Val extends TaskTemplateModel>
    implements $TaskTemplateModelCopyWith<$Res> {
  _$TaskTemplateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskTemplateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? isSystem = null,
    Object? userId = freezed,
    Object? taskData = null,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? usageCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            icon: freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String?,
            isSystem: null == isSystem
                ? _value.isSystem
                : isSystem // ignore: cast_nullable_to_non_nullable
                      as bool,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String?,
            taskData: null == taskData
                ? _value.taskData
                : taskData // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryName: freezed == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String?,
            usageCount: null == usageCount
                ? _value.usageCount
                : usageCount // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TaskTemplateModelImplCopyWith<$Res>
    implements $TaskTemplateModelCopyWith<$Res> {
  factory _$$TaskTemplateModelImplCopyWith(
    _$TaskTemplateModelImpl value,
    $Res Function(_$TaskTemplateModelImpl) then,
  ) = __$$TaskTemplateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String? icon,
    bool isSystem,
    String? userId,
    Map<String, dynamic> taskData,
    String? categoryId,
    String? categoryName,
    int usageCount,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$TaskTemplateModelImplCopyWithImpl<$Res>
    extends _$TaskTemplateModelCopyWithImpl<$Res, _$TaskTemplateModelImpl>
    implements _$$TaskTemplateModelImplCopyWith<$Res> {
  __$$TaskTemplateModelImplCopyWithImpl(
    _$TaskTemplateModelImpl _value,
    $Res Function(_$TaskTemplateModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskTemplateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? isSystem = null,
    Object? userId = freezed,
    Object? taskData = null,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? usageCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$TaskTemplateModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        icon: freezed == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String?,
        isSystem: null == isSystem
            ? _value.isSystem
            : isSystem // ignore: cast_nullable_to_non_nullable
                  as bool,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
        taskData: null == taskData
            ? _value._taskData
            : taskData // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryName: freezed == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String?,
        usageCount: null == usageCount
            ? _value.usageCount
            : usageCount // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskTemplateModelImpl implements _TaskTemplateModel {
  const _$TaskTemplateModelImpl({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    required this.isSystem,
    this.userId,
    required final Map<String, dynamic> taskData,
    this.categoryId,
    this.categoryName,
    this.usageCount = 0,
    required this.createdAt,
    required this.updatedAt,
  }) : _taskData = taskData;

  factory _$TaskTemplateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskTemplateModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? icon;
  @override
  final bool isSystem;
  @override
  final String? userId;
  final Map<String, dynamic> _taskData;
  @override
  Map<String, dynamic> get taskData {
    if (_taskData is EqualUnmodifiableMapView) return _taskData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_taskData);
  }

  @override
  final String? categoryId;
  @override
  final String? categoryName;
  @override
  @JsonKey()
  final int usageCount;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'TaskTemplateModel(id: $id, name: $name, description: $description, icon: $icon, isSystem: $isSystem, userId: $userId, taskData: $taskData, categoryId: $categoryId, categoryName: $categoryName, usageCount: $usageCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskTemplateModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.isSystem, isSystem) ||
                other.isSystem == isSystem) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other._taskData, _taskData) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.usageCount, usageCount) ||
                other.usageCount == usageCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    icon,
    isSystem,
    userId,
    const DeepCollectionEquality().hash(_taskData),
    categoryId,
    categoryName,
    usageCount,
    createdAt,
    updatedAt,
  );

  /// Create a copy of TaskTemplateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskTemplateModelImplCopyWith<_$TaskTemplateModelImpl> get copyWith =>
      __$$TaskTemplateModelImplCopyWithImpl<_$TaskTemplateModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskTemplateModelImplToJson(this);
  }
}

abstract class _TaskTemplateModel implements TaskTemplateModel {
  const factory _TaskTemplateModel({
    required final String id,
    required final String name,
    final String? description,
    final String? icon,
    required final bool isSystem,
    final String? userId,
    required final Map<String, dynamic> taskData,
    final String? categoryId,
    final String? categoryName,
    final int usageCount,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$TaskTemplateModelImpl;

  factory _TaskTemplateModel.fromJson(Map<String, dynamic> json) =
      _$TaskTemplateModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get icon;
  @override
  bool get isSystem;
  @override
  String? get userId;
  @override
  Map<String, dynamic> get taskData;
  @override
  String? get categoryId;
  @override
  String? get categoryName;
  @override
  int get usageCount;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of TaskTemplateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskTemplateModelImplCopyWith<_$TaskTemplateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UseTemplateRequest _$UseTemplateRequestFromJson(Map<String, dynamic> json) {
  return _UseTemplateRequest.fromJson(json);
}

/// @nodoc
mixin _$UseTemplateRequest {
  DateTime? get dueDate => throw _privateConstructorUsedError;
  String? get scheduledTime => throw _privateConstructorUsedError;
  Map<String, dynamic>? get customFields => throw _privateConstructorUsedError;

  /// Serializes this UseTemplateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UseTemplateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UseTemplateRequestCopyWith<UseTemplateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UseTemplateRequestCopyWith<$Res> {
  factory $UseTemplateRequestCopyWith(
    UseTemplateRequest value,
    $Res Function(UseTemplateRequest) then,
  ) = _$UseTemplateRequestCopyWithImpl<$Res, UseTemplateRequest>;
  @useResult
  $Res call({
    DateTime? dueDate,
    String? scheduledTime,
    Map<String, dynamic>? customFields,
  });
}

/// @nodoc
class _$UseTemplateRequestCopyWithImpl<$Res, $Val extends UseTemplateRequest>
    implements $UseTemplateRequestCopyWith<$Res> {
  _$UseTemplateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UseTemplateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dueDate = freezed,
    Object? scheduledTime = freezed,
    Object? customFields = freezed,
  }) {
    return _then(
      _value.copyWith(
            dueDate: freezed == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            scheduledTime: freezed == scheduledTime
                ? _value.scheduledTime
                : scheduledTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            customFields: freezed == customFields
                ? _value.customFields
                : customFields // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UseTemplateRequestImplCopyWith<$Res>
    implements $UseTemplateRequestCopyWith<$Res> {
  factory _$$UseTemplateRequestImplCopyWith(
    _$UseTemplateRequestImpl value,
    $Res Function(_$UseTemplateRequestImpl) then,
  ) = __$$UseTemplateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime? dueDate,
    String? scheduledTime,
    Map<String, dynamic>? customFields,
  });
}

/// @nodoc
class __$$UseTemplateRequestImplCopyWithImpl<$Res>
    extends _$UseTemplateRequestCopyWithImpl<$Res, _$UseTemplateRequestImpl>
    implements _$$UseTemplateRequestImplCopyWith<$Res> {
  __$$UseTemplateRequestImplCopyWithImpl(
    _$UseTemplateRequestImpl _value,
    $Res Function(_$UseTemplateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UseTemplateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dueDate = freezed,
    Object? scheduledTime = freezed,
    Object? customFields = freezed,
  }) {
    return _then(
      _$UseTemplateRequestImpl(
        dueDate: freezed == dueDate
            ? _value.dueDate
            : dueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        scheduledTime: freezed == scheduledTime
            ? _value.scheduledTime
            : scheduledTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        customFields: freezed == customFields
            ? _value._customFields
            : customFields // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UseTemplateRequestImpl implements _UseTemplateRequest {
  const _$UseTemplateRequestImpl({
    this.dueDate,
    this.scheduledTime,
    final Map<String, dynamic>? customFields,
  }) : _customFields = customFields;

  factory _$UseTemplateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UseTemplateRequestImplFromJson(json);

  @override
  final DateTime? dueDate;
  @override
  final String? scheduledTime;
  final Map<String, dynamic>? _customFields;
  @override
  Map<String, dynamic>? get customFields {
    final value = _customFields;
    if (value == null) return null;
    if (_customFields is EqualUnmodifiableMapView) return _customFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'UseTemplateRequest(dueDate: $dueDate, scheduledTime: $scheduledTime, customFields: $customFields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UseTemplateRequestImpl &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.scheduledTime, scheduledTime) ||
                other.scheduledTime == scheduledTime) &&
            const DeepCollectionEquality().equals(
              other._customFields,
              _customFields,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    dueDate,
    scheduledTime,
    const DeepCollectionEquality().hash(_customFields),
  );

  /// Create a copy of UseTemplateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UseTemplateRequestImplCopyWith<_$UseTemplateRequestImpl> get copyWith =>
      __$$UseTemplateRequestImplCopyWithImpl<_$UseTemplateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UseTemplateRequestImplToJson(this);
  }
}

abstract class _UseTemplateRequest implements UseTemplateRequest {
  const factory _UseTemplateRequest({
    final DateTime? dueDate,
    final String? scheduledTime,
    final Map<String, dynamic>? customFields,
  }) = _$UseTemplateRequestImpl;

  factory _UseTemplateRequest.fromJson(Map<String, dynamic> json) =
      _$UseTemplateRequestImpl.fromJson;

  @override
  DateTime? get dueDate;
  @override
  String? get scheduledTime;
  @override
  Map<String, dynamic>? get customFields;

  /// Create a copy of UseTemplateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UseTemplateRequestImplCopyWith<_$UseTemplateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
