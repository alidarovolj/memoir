// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_time_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TaskTimeLogModel _$TaskTimeLogModelFromJson(Map<String, dynamic> json) {
  return _TaskTimeLogModel.fromJson(json);
}

/// @nodoc
mixin _$TaskTimeLogModel {
  String get id => throw _privateConstructorUsedError;
  String get taskId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  int? get duration =>
      throw _privateConstructorUsedError; // Duration in seconds
  String? get notes => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this TaskTimeLogModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskTimeLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskTimeLogModelCopyWith<TaskTimeLogModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskTimeLogModelCopyWith<$Res> {
  factory $TaskTimeLogModelCopyWith(
    TaskTimeLogModel value,
    $Res Function(TaskTimeLogModel) then,
  ) = _$TaskTimeLogModelCopyWithImpl<$Res, TaskTimeLogModel>;
  @useResult
  $Res call({
    String id,
    String taskId,
    String userId,
    DateTime startTime,
    DateTime? endTime,
    int? duration,
    String? notes,
    bool isActive,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$TaskTimeLogModelCopyWithImpl<$Res, $Val extends TaskTimeLogModel>
    implements $TaskTimeLogModelCopyWith<$Res> {
  _$TaskTimeLogModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskTimeLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? taskId = null,
    Object? userId = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? duration = freezed,
    Object? notes = freezed,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            taskId: null == taskId
                ? _value.taskId
                : taskId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endTime: freezed == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as int?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$TaskTimeLogModelImplCopyWith<$Res>
    implements $TaskTimeLogModelCopyWith<$Res> {
  factory _$$TaskTimeLogModelImplCopyWith(
    _$TaskTimeLogModelImpl value,
    $Res Function(_$TaskTimeLogModelImpl) then,
  ) = __$$TaskTimeLogModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String taskId,
    String userId,
    DateTime startTime,
    DateTime? endTime,
    int? duration,
    String? notes,
    bool isActive,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$TaskTimeLogModelImplCopyWithImpl<$Res>
    extends _$TaskTimeLogModelCopyWithImpl<$Res, _$TaskTimeLogModelImpl>
    implements _$$TaskTimeLogModelImplCopyWith<$Res> {
  __$$TaskTimeLogModelImplCopyWithImpl(
    _$TaskTimeLogModelImpl _value,
    $Res Function(_$TaskTimeLogModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskTimeLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? taskId = null,
    Object? userId = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? duration = freezed,
    Object? notes = freezed,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$TaskTimeLogModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        taskId: null == taskId
            ? _value.taskId
            : taskId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endTime: freezed == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$TaskTimeLogModelImpl implements _TaskTimeLogModel {
  const _$TaskTimeLogModelImpl({
    required this.id,
    required this.taskId,
    required this.userId,
    required this.startTime,
    this.endTime,
    this.duration,
    this.notes,
    this.isActive = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$TaskTimeLogModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskTimeLogModelImplFromJson(json);

  @override
  final String id;
  @override
  final String taskId;
  @override
  final String userId;
  @override
  final DateTime startTime;
  @override
  final DateTime? endTime;
  @override
  final int? duration;
  // Duration in seconds
  @override
  final String? notes;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'TaskTimeLogModel(id: $id, taskId: $taskId, userId: $userId, startTime: $startTime, endTime: $endTime, duration: $duration, notes: $notes, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskTimeLogModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
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
    taskId,
    userId,
    startTime,
    endTime,
    duration,
    notes,
    isActive,
    createdAt,
    updatedAt,
  );

  /// Create a copy of TaskTimeLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskTimeLogModelImplCopyWith<_$TaskTimeLogModelImpl> get copyWith =>
      __$$TaskTimeLogModelImplCopyWithImpl<_$TaskTimeLogModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskTimeLogModelImplToJson(this);
  }
}

abstract class _TaskTimeLogModel implements TaskTimeLogModel {
  const factory _TaskTimeLogModel({
    required final String id,
    required final String taskId,
    required final String userId,
    required final DateTime startTime,
    final DateTime? endTime,
    final int? duration,
    final String? notes,
    final bool isActive,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$TaskTimeLogModelImpl;

  factory _TaskTimeLogModel.fromJson(Map<String, dynamic> json) =
      _$TaskTimeLogModelImpl.fromJson;

  @override
  String get id;
  @override
  String get taskId;
  @override
  String get userId;
  @override
  DateTime get startTime;
  @override
  DateTime? get endTime;
  @override
  int? get duration; // Duration in seconds
  @override
  String? get notes;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of TaskTimeLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskTimeLogModelImplCopyWith<_$TaskTimeLogModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskTimeStats _$TaskTimeStatsFromJson(Map<String, dynamic> json) {
  return _TaskTimeStats.fromJson(json);
}

/// @nodoc
mixin _$TaskTimeStats {
  String get taskId => throw _privateConstructorUsedError;
  String get taskTitle => throw _privateConstructorUsedError;
  int get totalDuration =>
      throw _privateConstructorUsedError; // Total time in seconds
  int get sessionCount => throw _privateConstructorUsedError;
  int get averageSession =>
      throw _privateConstructorUsedError; // Average session duration in seconds
  DateTime? get lastWorked => throw _privateConstructorUsedError;

  /// Serializes this TaskTimeStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskTimeStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskTimeStatsCopyWith<TaskTimeStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskTimeStatsCopyWith<$Res> {
  factory $TaskTimeStatsCopyWith(
    TaskTimeStats value,
    $Res Function(TaskTimeStats) then,
  ) = _$TaskTimeStatsCopyWithImpl<$Res, TaskTimeStats>;
  @useResult
  $Res call({
    String taskId,
    String taskTitle,
    int totalDuration,
    int sessionCount,
    int averageSession,
    DateTime? lastWorked,
  });
}

/// @nodoc
class _$TaskTimeStatsCopyWithImpl<$Res, $Val extends TaskTimeStats>
    implements $TaskTimeStatsCopyWith<$Res> {
  _$TaskTimeStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskTimeStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? taskTitle = null,
    Object? totalDuration = null,
    Object? sessionCount = null,
    Object? averageSession = null,
    Object? lastWorked = freezed,
  }) {
    return _then(
      _value.copyWith(
            taskId: null == taskId
                ? _value.taskId
                : taskId // ignore: cast_nullable_to_non_nullable
                      as String,
            taskTitle: null == taskTitle
                ? _value.taskTitle
                : taskTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            totalDuration: null == totalDuration
                ? _value.totalDuration
                : totalDuration // ignore: cast_nullable_to_non_nullable
                      as int,
            sessionCount: null == sessionCount
                ? _value.sessionCount
                : sessionCount // ignore: cast_nullable_to_non_nullable
                      as int,
            averageSession: null == averageSession
                ? _value.averageSession
                : averageSession // ignore: cast_nullable_to_non_nullable
                      as int,
            lastWorked: freezed == lastWorked
                ? _value.lastWorked
                : lastWorked // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TaskTimeStatsImplCopyWith<$Res>
    implements $TaskTimeStatsCopyWith<$Res> {
  factory _$$TaskTimeStatsImplCopyWith(
    _$TaskTimeStatsImpl value,
    $Res Function(_$TaskTimeStatsImpl) then,
  ) = __$$TaskTimeStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String taskId,
    String taskTitle,
    int totalDuration,
    int sessionCount,
    int averageSession,
    DateTime? lastWorked,
  });
}

/// @nodoc
class __$$TaskTimeStatsImplCopyWithImpl<$Res>
    extends _$TaskTimeStatsCopyWithImpl<$Res, _$TaskTimeStatsImpl>
    implements _$$TaskTimeStatsImplCopyWith<$Res> {
  __$$TaskTimeStatsImplCopyWithImpl(
    _$TaskTimeStatsImpl _value,
    $Res Function(_$TaskTimeStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskTimeStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? taskTitle = null,
    Object? totalDuration = null,
    Object? sessionCount = null,
    Object? averageSession = null,
    Object? lastWorked = freezed,
  }) {
    return _then(
      _$TaskTimeStatsImpl(
        taskId: null == taskId
            ? _value.taskId
            : taskId // ignore: cast_nullable_to_non_nullable
                  as String,
        taskTitle: null == taskTitle
            ? _value.taskTitle
            : taskTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        totalDuration: null == totalDuration
            ? _value.totalDuration
            : totalDuration // ignore: cast_nullable_to_non_nullable
                  as int,
        sessionCount: null == sessionCount
            ? _value.sessionCount
            : sessionCount // ignore: cast_nullable_to_non_nullable
                  as int,
        averageSession: null == averageSession
            ? _value.averageSession
            : averageSession // ignore: cast_nullable_to_non_nullable
                  as int,
        lastWorked: freezed == lastWorked
            ? _value.lastWorked
            : lastWorked // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskTimeStatsImpl implements _TaskTimeStats {
  const _$TaskTimeStatsImpl({
    required this.taskId,
    required this.taskTitle,
    required this.totalDuration,
    required this.sessionCount,
    required this.averageSession,
    this.lastWorked,
  });

  factory _$TaskTimeStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskTimeStatsImplFromJson(json);

  @override
  final String taskId;
  @override
  final String taskTitle;
  @override
  final int totalDuration;
  // Total time in seconds
  @override
  final int sessionCount;
  @override
  final int averageSession;
  // Average session duration in seconds
  @override
  final DateTime? lastWorked;

  @override
  String toString() {
    return 'TaskTimeStats(taskId: $taskId, taskTitle: $taskTitle, totalDuration: $totalDuration, sessionCount: $sessionCount, averageSession: $averageSession, lastWorked: $lastWorked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskTimeStatsImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.taskTitle, taskTitle) ||
                other.taskTitle == taskTitle) &&
            (identical(other.totalDuration, totalDuration) ||
                other.totalDuration == totalDuration) &&
            (identical(other.sessionCount, sessionCount) ||
                other.sessionCount == sessionCount) &&
            (identical(other.averageSession, averageSession) ||
                other.averageSession == averageSession) &&
            (identical(other.lastWorked, lastWorked) ||
                other.lastWorked == lastWorked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    taskId,
    taskTitle,
    totalDuration,
    sessionCount,
    averageSession,
    lastWorked,
  );

  /// Create a copy of TaskTimeStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskTimeStatsImplCopyWith<_$TaskTimeStatsImpl> get copyWith =>
      __$$TaskTimeStatsImplCopyWithImpl<_$TaskTimeStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskTimeStatsImplToJson(this);
  }
}

abstract class _TaskTimeStats implements TaskTimeStats {
  const factory _TaskTimeStats({
    required final String taskId,
    required final String taskTitle,
    required final int totalDuration,
    required final int sessionCount,
    required final int averageSession,
    final DateTime? lastWorked,
  }) = _$TaskTimeStatsImpl;

  factory _TaskTimeStats.fromJson(Map<String, dynamic> json) =
      _$TaskTimeStatsImpl.fromJson;

  @override
  String get taskId;
  @override
  String get taskTitle;
  @override
  int get totalDuration; // Total time in seconds
  @override
  int get sessionCount;
  @override
  int get averageSession; // Average session duration in seconds
  @override
  DateTime? get lastWorked;

  /// Create a copy of TaskTimeStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskTimeStatsImplCopyWith<_$TaskTimeStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimeStatsResponse _$TimeStatsResponseFromJson(Map<String, dynamic> json) {
  return _TimeStatsResponse.fromJson(json);
}

/// @nodoc
mixin _$TimeStatsResponse {
  int get totalTimeToday =>
      throw _privateConstructorUsedError; // Total time tracked today (seconds)
  int get totalTimeWeek => throw _privateConstructorUsedError;
  int get totalTimeMonth => throw _privateConstructorUsedError;
  String? get activeTaskId => throw _privateConstructorUsedError;
  List<TaskTimeStats> get tasks => throw _privateConstructorUsedError;

  /// Serializes this TimeStatsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimeStatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeStatsResponseCopyWith<TimeStatsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeStatsResponseCopyWith<$Res> {
  factory $TimeStatsResponseCopyWith(
    TimeStatsResponse value,
    $Res Function(TimeStatsResponse) then,
  ) = _$TimeStatsResponseCopyWithImpl<$Res, TimeStatsResponse>;
  @useResult
  $Res call({
    int totalTimeToday,
    int totalTimeWeek,
    int totalTimeMonth,
    String? activeTaskId,
    List<TaskTimeStats> tasks,
  });
}

/// @nodoc
class _$TimeStatsResponseCopyWithImpl<$Res, $Val extends TimeStatsResponse>
    implements $TimeStatsResponseCopyWith<$Res> {
  _$TimeStatsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeStatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTimeToday = null,
    Object? totalTimeWeek = null,
    Object? totalTimeMonth = null,
    Object? activeTaskId = freezed,
    Object? tasks = null,
  }) {
    return _then(
      _value.copyWith(
            totalTimeToday: null == totalTimeToday
                ? _value.totalTimeToday
                : totalTimeToday // ignore: cast_nullable_to_non_nullable
                      as int,
            totalTimeWeek: null == totalTimeWeek
                ? _value.totalTimeWeek
                : totalTimeWeek // ignore: cast_nullable_to_non_nullable
                      as int,
            totalTimeMonth: null == totalTimeMonth
                ? _value.totalTimeMonth
                : totalTimeMonth // ignore: cast_nullable_to_non_nullable
                      as int,
            activeTaskId: freezed == activeTaskId
                ? _value.activeTaskId
                : activeTaskId // ignore: cast_nullable_to_non_nullable
                      as String?,
            tasks: null == tasks
                ? _value.tasks
                : tasks // ignore: cast_nullable_to_non_nullable
                      as List<TaskTimeStats>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimeStatsResponseImplCopyWith<$Res>
    implements $TimeStatsResponseCopyWith<$Res> {
  factory _$$TimeStatsResponseImplCopyWith(
    _$TimeStatsResponseImpl value,
    $Res Function(_$TimeStatsResponseImpl) then,
  ) = __$$TimeStatsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalTimeToday,
    int totalTimeWeek,
    int totalTimeMonth,
    String? activeTaskId,
    List<TaskTimeStats> tasks,
  });
}

/// @nodoc
class __$$TimeStatsResponseImplCopyWithImpl<$Res>
    extends _$TimeStatsResponseCopyWithImpl<$Res, _$TimeStatsResponseImpl>
    implements _$$TimeStatsResponseImplCopyWith<$Res> {
  __$$TimeStatsResponseImplCopyWithImpl(
    _$TimeStatsResponseImpl _value,
    $Res Function(_$TimeStatsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimeStatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTimeToday = null,
    Object? totalTimeWeek = null,
    Object? totalTimeMonth = null,
    Object? activeTaskId = freezed,
    Object? tasks = null,
  }) {
    return _then(
      _$TimeStatsResponseImpl(
        totalTimeToday: null == totalTimeToday
            ? _value.totalTimeToday
            : totalTimeToday // ignore: cast_nullable_to_non_nullable
                  as int,
        totalTimeWeek: null == totalTimeWeek
            ? _value.totalTimeWeek
            : totalTimeWeek // ignore: cast_nullable_to_non_nullable
                  as int,
        totalTimeMonth: null == totalTimeMonth
            ? _value.totalTimeMonth
            : totalTimeMonth // ignore: cast_nullable_to_non_nullable
                  as int,
        activeTaskId: freezed == activeTaskId
            ? _value.activeTaskId
            : activeTaskId // ignore: cast_nullable_to_non_nullable
                  as String?,
        tasks: null == tasks
            ? _value._tasks
            : tasks // ignore: cast_nullable_to_non_nullable
                  as List<TaskTimeStats>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeStatsResponseImpl implements _TimeStatsResponse {
  const _$TimeStatsResponseImpl({
    required this.totalTimeToday,
    required this.totalTimeWeek,
    required this.totalTimeMonth,
    this.activeTaskId,
    final List<TaskTimeStats> tasks = const [],
  }) : _tasks = tasks;

  factory _$TimeStatsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeStatsResponseImplFromJson(json);

  @override
  final int totalTimeToday;
  // Total time tracked today (seconds)
  @override
  final int totalTimeWeek;
  @override
  final int totalTimeMonth;
  @override
  final String? activeTaskId;
  final List<TaskTimeStats> _tasks;
  @override
  @JsonKey()
  List<TaskTimeStats> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  String toString() {
    return 'TimeStatsResponse(totalTimeToday: $totalTimeToday, totalTimeWeek: $totalTimeWeek, totalTimeMonth: $totalTimeMonth, activeTaskId: $activeTaskId, tasks: $tasks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeStatsResponseImpl &&
            (identical(other.totalTimeToday, totalTimeToday) ||
                other.totalTimeToday == totalTimeToday) &&
            (identical(other.totalTimeWeek, totalTimeWeek) ||
                other.totalTimeWeek == totalTimeWeek) &&
            (identical(other.totalTimeMonth, totalTimeMonth) ||
                other.totalTimeMonth == totalTimeMonth) &&
            (identical(other.activeTaskId, activeTaskId) ||
                other.activeTaskId == activeTaskId) &&
            const DeepCollectionEquality().equals(other._tasks, _tasks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalTimeToday,
    totalTimeWeek,
    totalTimeMonth,
    activeTaskId,
    const DeepCollectionEquality().hash(_tasks),
  );

  /// Create a copy of TimeStatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeStatsResponseImplCopyWith<_$TimeStatsResponseImpl> get copyWith =>
      __$$TimeStatsResponseImplCopyWithImpl<_$TimeStatsResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeStatsResponseImplToJson(this);
  }
}

abstract class _TimeStatsResponse implements TimeStatsResponse {
  const factory _TimeStatsResponse({
    required final int totalTimeToday,
    required final int totalTimeWeek,
    required final int totalTimeMonth,
    final String? activeTaskId,
    final List<TaskTimeStats> tasks,
  }) = _$TimeStatsResponseImpl;

  factory _TimeStatsResponse.fromJson(Map<String, dynamic> json) =
      _$TimeStatsResponseImpl.fromJson;

  @override
  int get totalTimeToday; // Total time tracked today (seconds)
  @override
  int get totalTimeWeek;
  @override
  int get totalTimeMonth;
  @override
  String? get activeTaskId;
  @override
  List<TaskTimeStats> get tasks;

  /// Create a copy of TimeStatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeStatsResponseImplCopyWith<_$TimeStatsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
