// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) {
  return _TaskModel.fromJson(json);
}

/// @nodoc
mixin _$TaskModel {
  String get id => throw _privateConstructorUsedError;
  String get user_id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get due_date => throw _privateConstructorUsedError;
  String? get scheduled_time =>
      throw _privateConstructorUsedError; // Format: "HH:MM" (e.g. "08:00")
  DateTime? get completed_at => throw _privateConstructorUsedError;
  TaskStatus get status => throw _privateConstructorUsedError;
  TaskPriority get priority => throw _privateConstructorUsedError;
  TimeScope get time_scope => throw _privateConstructorUsedError;
  String? get category_id => throw _privateConstructorUsedError;
  String? get category_name => throw _privateConstructorUsedError;
  String? get related_memory_id => throw _privateConstructorUsedError;
  bool get ai_suggested => throw _privateConstructorUsedError;
  double? get ai_confidence => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  bool get is_recurring => throw _privateConstructorUsedError;
  String? get recurrence_rule =>
      throw _privateConstructorUsedError; // RRULE format (e.g. "FREQ=DAILY")
  String? get parent_task_id => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;
  DateTime get updated_at => throw _privateConstructorUsedError;

  /// Serializes this TaskModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskModelCopyWith<TaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskModelCopyWith<$Res> {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) then) =
      _$TaskModelCopyWithImpl<$Res, TaskModel>;
  @useResult
  $Res call({
    String id,
    String user_id,
    String title,
    String? description,
    DateTime? due_date,
    String? scheduled_time,
    DateTime? completed_at,
    TaskStatus status,
    TaskPriority priority,
    TimeScope time_scope,
    String? category_id,
    String? category_name,
    String? related_memory_id,
    bool ai_suggested,
    double? ai_confidence,
    List<String>? tags,
    bool is_recurring,
    String? recurrence_rule,
    String? parent_task_id,
    DateTime created_at,
    DateTime updated_at,
  });
}

/// @nodoc
class _$TaskModelCopyWithImpl<$Res, $Val extends TaskModel>
    implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user_id = null,
    Object? title = null,
    Object? description = freezed,
    Object? due_date = freezed,
    Object? scheduled_time = freezed,
    Object? completed_at = freezed,
    Object? status = null,
    Object? priority = null,
    Object? time_scope = null,
    Object? category_id = freezed,
    Object? category_name = freezed,
    Object? related_memory_id = freezed,
    Object? ai_suggested = null,
    Object? ai_confidence = freezed,
    Object? tags = freezed,
    Object? is_recurring = null,
    Object? recurrence_rule = freezed,
    Object? parent_task_id = freezed,
    Object? created_at = null,
    Object? updated_at = null,
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
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            due_date: freezed == due_date
                ? _value.due_date
                : due_date // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            scheduled_time: freezed == scheduled_time
                ? _value.scheduled_time
                : scheduled_time // ignore: cast_nullable_to_non_nullable
                      as String?,
            completed_at: freezed == completed_at
                ? _value.completed_at
                : completed_at // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as TaskStatus,
            priority: null == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as TaskPriority,
            time_scope: null == time_scope
                ? _value.time_scope
                : time_scope // ignore: cast_nullable_to_non_nullable
                      as TimeScope,
            category_id: freezed == category_id
                ? _value.category_id
                : category_id // ignore: cast_nullable_to_non_nullable
                      as String?,
            category_name: freezed == category_name
                ? _value.category_name
                : category_name // ignore: cast_nullable_to_non_nullable
                      as String?,
            related_memory_id: freezed == related_memory_id
                ? _value.related_memory_id
                : related_memory_id // ignore: cast_nullable_to_non_nullable
                      as String?,
            ai_suggested: null == ai_suggested
                ? _value.ai_suggested
                : ai_suggested // ignore: cast_nullable_to_non_nullable
                      as bool,
            ai_confidence: freezed == ai_confidence
                ? _value.ai_confidence
                : ai_confidence // ignore: cast_nullable_to_non_nullable
                      as double?,
            tags: freezed == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            is_recurring: null == is_recurring
                ? _value.is_recurring
                : is_recurring // ignore: cast_nullable_to_non_nullable
                      as bool,
            recurrence_rule: freezed == recurrence_rule
                ? _value.recurrence_rule
                : recurrence_rule // ignore: cast_nullable_to_non_nullable
                      as String?,
            parent_task_id: freezed == parent_task_id
                ? _value.parent_task_id
                : parent_task_id // ignore: cast_nullable_to_non_nullable
                      as String?,
            created_at: null == created_at
                ? _value.created_at
                : created_at // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updated_at: null == updated_at
                ? _value.updated_at
                : updated_at // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TaskModelImplCopyWith<$Res>
    implements $TaskModelCopyWith<$Res> {
  factory _$$TaskModelImplCopyWith(
    _$TaskModelImpl value,
    $Res Function(_$TaskModelImpl) then,
  ) = __$$TaskModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String user_id,
    String title,
    String? description,
    DateTime? due_date,
    String? scheduled_time,
    DateTime? completed_at,
    TaskStatus status,
    TaskPriority priority,
    TimeScope time_scope,
    String? category_id,
    String? category_name,
    String? related_memory_id,
    bool ai_suggested,
    double? ai_confidence,
    List<String>? tags,
    bool is_recurring,
    String? recurrence_rule,
    String? parent_task_id,
    DateTime created_at,
    DateTime updated_at,
  });
}

/// @nodoc
class __$$TaskModelImplCopyWithImpl<$Res>
    extends _$TaskModelCopyWithImpl<$Res, _$TaskModelImpl>
    implements _$$TaskModelImplCopyWith<$Res> {
  __$$TaskModelImplCopyWithImpl(
    _$TaskModelImpl _value,
    $Res Function(_$TaskModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user_id = null,
    Object? title = null,
    Object? description = freezed,
    Object? due_date = freezed,
    Object? scheduled_time = freezed,
    Object? completed_at = freezed,
    Object? status = null,
    Object? priority = null,
    Object? time_scope = null,
    Object? category_id = freezed,
    Object? category_name = freezed,
    Object? related_memory_id = freezed,
    Object? ai_suggested = null,
    Object? ai_confidence = freezed,
    Object? tags = freezed,
    Object? is_recurring = null,
    Object? recurrence_rule = freezed,
    Object? parent_task_id = freezed,
    Object? created_at = null,
    Object? updated_at = null,
  }) {
    return _then(
      _$TaskModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        user_id: null == user_id
            ? _value.user_id
            : user_id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        due_date: freezed == due_date
            ? _value.due_date
            : due_date // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        scheduled_time: freezed == scheduled_time
            ? _value.scheduled_time
            : scheduled_time // ignore: cast_nullable_to_non_nullable
                  as String?,
        completed_at: freezed == completed_at
            ? _value.completed_at
            : completed_at // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as TaskStatus,
        priority: null == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as TaskPriority,
        time_scope: null == time_scope
            ? _value.time_scope
            : time_scope // ignore: cast_nullable_to_non_nullable
                  as TimeScope,
        category_id: freezed == category_id
            ? _value.category_id
            : category_id // ignore: cast_nullable_to_non_nullable
                  as String?,
        category_name: freezed == category_name
            ? _value.category_name
            : category_name // ignore: cast_nullable_to_non_nullable
                  as String?,
        related_memory_id: freezed == related_memory_id
            ? _value.related_memory_id
            : related_memory_id // ignore: cast_nullable_to_non_nullable
                  as String?,
        ai_suggested: null == ai_suggested
            ? _value.ai_suggested
            : ai_suggested // ignore: cast_nullable_to_non_nullable
                  as bool,
        ai_confidence: freezed == ai_confidence
            ? _value.ai_confidence
            : ai_confidence // ignore: cast_nullable_to_non_nullable
                  as double?,
        tags: freezed == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        is_recurring: null == is_recurring
            ? _value.is_recurring
            : is_recurring // ignore: cast_nullable_to_non_nullable
                  as bool,
        recurrence_rule: freezed == recurrence_rule
            ? _value.recurrence_rule
            : recurrence_rule // ignore: cast_nullable_to_non_nullable
                  as String?,
        parent_task_id: freezed == parent_task_id
            ? _value.parent_task_id
            : parent_task_id // ignore: cast_nullable_to_non_nullable
                  as String?,
        created_at: null == created_at
            ? _value.created_at
            : created_at // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updated_at: null == updated_at
            ? _value.updated_at
            : updated_at // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskModelImpl implements _TaskModel {
  const _$TaskModelImpl({
    required this.id,
    required this.user_id,
    required this.title,
    this.description,
    this.due_date,
    this.scheduled_time,
    this.completed_at,
    required this.status,
    required this.priority,
    required this.time_scope,
    this.category_id,
    this.category_name,
    this.related_memory_id,
    required this.ai_suggested,
    this.ai_confidence,
    final List<String>? tags,
    this.is_recurring = false,
    this.recurrence_rule,
    this.parent_task_id,
    required this.created_at,
    required this.updated_at,
  }) : _tags = tags;

  factory _$TaskModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskModelImplFromJson(json);

  @override
  final String id;
  @override
  final String user_id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final DateTime? due_date;
  @override
  final String? scheduled_time;
  // Format: "HH:MM" (e.g. "08:00")
  @override
  final DateTime? completed_at;
  @override
  final TaskStatus status;
  @override
  final TaskPriority priority;
  @override
  final TimeScope time_scope;
  @override
  final String? category_id;
  @override
  final String? category_name;
  @override
  final String? related_memory_id;
  @override
  final bool ai_suggested;
  @override
  final double? ai_confidence;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool is_recurring;
  @override
  final String? recurrence_rule;
  // RRULE format (e.g. "FREQ=DAILY")
  @override
  final String? parent_task_id;
  @override
  final DateTime created_at;
  @override
  final DateTime updated_at;

  @override
  String toString() {
    return 'TaskModel(id: $id, user_id: $user_id, title: $title, description: $description, due_date: $due_date, scheduled_time: $scheduled_time, completed_at: $completed_at, status: $status, priority: $priority, time_scope: $time_scope, category_id: $category_id, category_name: $category_name, related_memory_id: $related_memory_id, ai_suggested: $ai_suggested, ai_confidence: $ai_confidence, tags: $tags, is_recurring: $is_recurring, recurrence_rule: $recurrence_rule, parent_task_id: $parent_task_id, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.due_date, due_date) ||
                other.due_date == due_date) &&
            (identical(other.scheduled_time, scheduled_time) ||
                other.scheduled_time == scheduled_time) &&
            (identical(other.completed_at, completed_at) ||
                other.completed_at == completed_at) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.time_scope, time_scope) ||
                other.time_scope == time_scope) &&
            (identical(other.category_id, category_id) ||
                other.category_id == category_id) &&
            (identical(other.category_name, category_name) ||
                other.category_name == category_name) &&
            (identical(other.related_memory_id, related_memory_id) ||
                other.related_memory_id == related_memory_id) &&
            (identical(other.ai_suggested, ai_suggested) ||
                other.ai_suggested == ai_suggested) &&
            (identical(other.ai_confidence, ai_confidence) ||
                other.ai_confidence == ai_confidence) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.is_recurring, is_recurring) ||
                other.is_recurring == is_recurring) &&
            (identical(other.recurrence_rule, recurrence_rule) ||
                other.recurrence_rule == recurrence_rule) &&
            (identical(other.parent_task_id, parent_task_id) ||
                other.parent_task_id == parent_task_id) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.updated_at, updated_at) ||
                other.updated_at == updated_at));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    user_id,
    title,
    description,
    due_date,
    scheduled_time,
    completed_at,
    status,
    priority,
    time_scope,
    category_id,
    category_name,
    related_memory_id,
    ai_suggested,
    ai_confidence,
    const DeepCollectionEquality().hash(_tags),
    is_recurring,
    recurrence_rule,
    parent_task_id,
    created_at,
    updated_at,
  ]);

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      __$$TaskModelImplCopyWithImpl<_$TaskModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskModelImplToJson(this);
  }
}

abstract class _TaskModel implements TaskModel {
  const factory _TaskModel({
    required final String id,
    required final String user_id,
    required final String title,
    final String? description,
    final DateTime? due_date,
    final String? scheduled_time,
    final DateTime? completed_at,
    required final TaskStatus status,
    required final TaskPriority priority,
    required final TimeScope time_scope,
    final String? category_id,
    final String? category_name,
    final String? related_memory_id,
    required final bool ai_suggested,
    final double? ai_confidence,
    final List<String>? tags,
    final bool is_recurring,
    final String? recurrence_rule,
    final String? parent_task_id,
    required final DateTime created_at,
    required final DateTime updated_at,
  }) = _$TaskModelImpl;

  factory _TaskModel.fromJson(Map<String, dynamic> json) =
      _$TaskModelImpl.fromJson;

  @override
  String get id;
  @override
  String get user_id;
  @override
  String get title;
  @override
  String? get description;
  @override
  DateTime? get due_date;
  @override
  String? get scheduled_time; // Format: "HH:MM" (e.g. "08:00")
  @override
  DateTime? get completed_at;
  @override
  TaskStatus get status;
  @override
  TaskPriority get priority;
  @override
  TimeScope get time_scope;
  @override
  String? get category_id;
  @override
  String? get category_name;
  @override
  String? get related_memory_id;
  @override
  bool get ai_suggested;
  @override
  double? get ai_confidence;
  @override
  List<String>? get tags;
  @override
  bool get is_recurring;
  @override
  String? get recurrence_rule; // RRULE format (e.g. "FREQ=DAILY")
  @override
  String? get parent_task_id;
  @override
  DateTime get created_at;
  @override
  DateTime get updated_at;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskAnalyzeResponse _$TaskAnalyzeResponseFromJson(Map<String, dynamic> json) {
  return _TaskAnalyzeResponse.fromJson(json);
}

/// @nodoc
mixin _$TaskAnalyzeResponse {
  TimeScope get time_scope => throw _privateConstructorUsedError;
  TaskPriority get priority => throw _privateConstructorUsedError;
  String? get suggested_time =>
      throw _privateConstructorUsedError; // Format: "HH:MM"
  bool get needs_deadline => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  String get reasoning => throw _privateConstructorUsedError;

  /// Serializes this TaskAnalyzeResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskAnalyzeResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskAnalyzeResponseCopyWith<TaskAnalyzeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskAnalyzeResponseCopyWith<$Res> {
  factory $TaskAnalyzeResponseCopyWith(
    TaskAnalyzeResponse value,
    $Res Function(TaskAnalyzeResponse) then,
  ) = _$TaskAnalyzeResponseCopyWithImpl<$Res, TaskAnalyzeResponse>;
  @useResult
  $Res call({
    TimeScope time_scope,
    TaskPriority priority,
    String? suggested_time,
    bool needs_deadline,
    String? category,
    double confidence,
    String reasoning,
  });
}

/// @nodoc
class _$TaskAnalyzeResponseCopyWithImpl<$Res, $Val extends TaskAnalyzeResponse>
    implements $TaskAnalyzeResponseCopyWith<$Res> {
  _$TaskAnalyzeResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskAnalyzeResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time_scope = null,
    Object? priority = null,
    Object? suggested_time = freezed,
    Object? needs_deadline = null,
    Object? category = freezed,
    Object? confidence = null,
    Object? reasoning = null,
  }) {
    return _then(
      _value.copyWith(
            time_scope: null == time_scope
                ? _value.time_scope
                : time_scope // ignore: cast_nullable_to_non_nullable
                      as TimeScope,
            priority: null == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as TaskPriority,
            suggested_time: freezed == suggested_time
                ? _value.suggested_time
                : suggested_time // ignore: cast_nullable_to_non_nullable
                      as String?,
            needs_deadline: null == needs_deadline
                ? _value.needs_deadline
                : needs_deadline // ignore: cast_nullable_to_non_nullable
                      as bool,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            reasoning: null == reasoning
                ? _value.reasoning
                : reasoning // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TaskAnalyzeResponseImplCopyWith<$Res>
    implements $TaskAnalyzeResponseCopyWith<$Res> {
  factory _$$TaskAnalyzeResponseImplCopyWith(
    _$TaskAnalyzeResponseImpl value,
    $Res Function(_$TaskAnalyzeResponseImpl) then,
  ) = __$$TaskAnalyzeResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    TimeScope time_scope,
    TaskPriority priority,
    String? suggested_time,
    bool needs_deadline,
    String? category,
    double confidence,
    String reasoning,
  });
}

/// @nodoc
class __$$TaskAnalyzeResponseImplCopyWithImpl<$Res>
    extends _$TaskAnalyzeResponseCopyWithImpl<$Res, _$TaskAnalyzeResponseImpl>
    implements _$$TaskAnalyzeResponseImplCopyWith<$Res> {
  __$$TaskAnalyzeResponseImplCopyWithImpl(
    _$TaskAnalyzeResponseImpl _value,
    $Res Function(_$TaskAnalyzeResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskAnalyzeResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time_scope = null,
    Object? priority = null,
    Object? suggested_time = freezed,
    Object? needs_deadline = null,
    Object? category = freezed,
    Object? confidence = null,
    Object? reasoning = null,
  }) {
    return _then(
      _$TaskAnalyzeResponseImpl(
        time_scope: null == time_scope
            ? _value.time_scope
            : time_scope // ignore: cast_nullable_to_non_nullable
                  as TimeScope,
        priority: null == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as TaskPriority,
        suggested_time: freezed == suggested_time
            ? _value.suggested_time
            : suggested_time // ignore: cast_nullable_to_non_nullable
                  as String?,
        needs_deadline: null == needs_deadline
            ? _value.needs_deadline
            : needs_deadline // ignore: cast_nullable_to_non_nullable
                  as bool,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        reasoning: null == reasoning
            ? _value.reasoning
            : reasoning // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskAnalyzeResponseImpl implements _TaskAnalyzeResponse {
  const _$TaskAnalyzeResponseImpl({
    required this.time_scope,
    required this.priority,
    this.suggested_time,
    this.needs_deadline = false,
    this.category,
    required this.confidence,
    required this.reasoning,
  });

  factory _$TaskAnalyzeResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskAnalyzeResponseImplFromJson(json);

  @override
  final TimeScope time_scope;
  @override
  final TaskPriority priority;
  @override
  final String? suggested_time;
  // Format: "HH:MM"
  @override
  @JsonKey()
  final bool needs_deadline;
  @override
  final String? category;
  @override
  final double confidence;
  @override
  final String reasoning;

  @override
  String toString() {
    return 'TaskAnalyzeResponse(time_scope: $time_scope, priority: $priority, suggested_time: $suggested_time, needs_deadline: $needs_deadline, category: $category, confidence: $confidence, reasoning: $reasoning)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskAnalyzeResponseImpl &&
            (identical(other.time_scope, time_scope) ||
                other.time_scope == time_scope) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.suggested_time, suggested_time) ||
                other.suggested_time == suggested_time) &&
            (identical(other.needs_deadline, needs_deadline) ||
                other.needs_deadline == needs_deadline) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.reasoning, reasoning) ||
                other.reasoning == reasoning));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    time_scope,
    priority,
    suggested_time,
    needs_deadline,
    category,
    confidence,
    reasoning,
  );

  /// Create a copy of TaskAnalyzeResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskAnalyzeResponseImplCopyWith<_$TaskAnalyzeResponseImpl> get copyWith =>
      __$$TaskAnalyzeResponseImplCopyWithImpl<_$TaskAnalyzeResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskAnalyzeResponseImplToJson(this);
  }
}

abstract class _TaskAnalyzeResponse implements TaskAnalyzeResponse {
  const factory _TaskAnalyzeResponse({
    required final TimeScope time_scope,
    required final TaskPriority priority,
    final String? suggested_time,
    final bool needs_deadline,
    final String? category,
    required final double confidence,
    required final String reasoning,
  }) = _$TaskAnalyzeResponseImpl;

  factory _TaskAnalyzeResponse.fromJson(Map<String, dynamic> json) =
      _$TaskAnalyzeResponseImpl.fromJson;

  @override
  TimeScope get time_scope;
  @override
  TaskPriority get priority;
  @override
  String? get suggested_time; // Format: "HH:MM"
  @override
  bool get needs_deadline;
  @override
  String? get category;
  @override
  double get confidence;
  @override
  String get reasoning;

  /// Create a copy of TaskAnalyzeResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskAnalyzeResponseImplCopyWith<_$TaskAnalyzeResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
