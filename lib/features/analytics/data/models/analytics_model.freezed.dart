// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analytics_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DayActivity _$DayActivityFromJson(Map<String, dynamic> json) {
  return _DayActivity.fromJson(json);
}

/// @nodoc
mixin _$DayActivity {
  DateTime get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'memories_count')
  int get memoriesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'tasks_completed')
  int get tasksCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_tracked')
  int get timeTracked => throw _privateConstructorUsedError;
  @JsonKey(name: 'stories_created')
  int get storiesCreated => throw _privateConstructorUsedError;

  /// Serializes this DayActivity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DayActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DayActivityCopyWith<DayActivity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DayActivityCopyWith<$Res> {
  factory $DayActivityCopyWith(
    DayActivity value,
    $Res Function(DayActivity) then,
  ) = _$DayActivityCopyWithImpl<$Res, DayActivity>;
  @useResult
  $Res call({
    DateTime date,
    @JsonKey(name: 'memories_count') int memoriesCount,
    @JsonKey(name: 'tasks_completed') int tasksCompleted,
    @JsonKey(name: 'time_tracked') int timeTracked,
    @JsonKey(name: 'stories_created') int storiesCreated,
  });
}

/// @nodoc
class _$DayActivityCopyWithImpl<$Res, $Val extends DayActivity>
    implements $DayActivityCopyWith<$Res> {
  _$DayActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DayActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? memoriesCount = null,
    Object? tasksCompleted = null,
    Object? timeTracked = null,
    Object? storiesCreated = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            memoriesCount: null == memoriesCount
                ? _value.memoriesCount
                : memoriesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            tasksCompleted: null == tasksCompleted
                ? _value.tasksCompleted
                : tasksCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            timeTracked: null == timeTracked
                ? _value.timeTracked
                : timeTracked // ignore: cast_nullable_to_non_nullable
                      as int,
            storiesCreated: null == storiesCreated
                ? _value.storiesCreated
                : storiesCreated // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DayActivityImplCopyWith<$Res>
    implements $DayActivityCopyWith<$Res> {
  factory _$$DayActivityImplCopyWith(
    _$DayActivityImpl value,
    $Res Function(_$DayActivityImpl) then,
  ) = __$$DayActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime date,
    @JsonKey(name: 'memories_count') int memoriesCount,
    @JsonKey(name: 'tasks_completed') int tasksCompleted,
    @JsonKey(name: 'time_tracked') int timeTracked,
    @JsonKey(name: 'stories_created') int storiesCreated,
  });
}

/// @nodoc
class __$$DayActivityImplCopyWithImpl<$Res>
    extends _$DayActivityCopyWithImpl<$Res, _$DayActivityImpl>
    implements _$$DayActivityImplCopyWith<$Res> {
  __$$DayActivityImplCopyWithImpl(
    _$DayActivityImpl _value,
    $Res Function(_$DayActivityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DayActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? memoriesCount = null,
    Object? tasksCompleted = null,
    Object? timeTracked = null,
    Object? storiesCreated = null,
  }) {
    return _then(
      _$DayActivityImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        memoriesCount: null == memoriesCount
            ? _value.memoriesCount
            : memoriesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        tasksCompleted: null == tasksCompleted
            ? _value.tasksCompleted
            : tasksCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        timeTracked: null == timeTracked
            ? _value.timeTracked
            : timeTracked // ignore: cast_nullable_to_non_nullable
                  as int,
        storiesCreated: null == storiesCreated
            ? _value.storiesCreated
            : storiesCreated // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DayActivityImpl implements _DayActivity {
  const _$DayActivityImpl({
    required this.date,
    @JsonKey(name: 'memories_count') this.memoriesCount = 0,
    @JsonKey(name: 'tasks_completed') this.tasksCompleted = 0,
    @JsonKey(name: 'time_tracked') this.timeTracked = 0,
    @JsonKey(name: 'stories_created') this.storiesCreated = 0,
  });

  factory _$DayActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$DayActivityImplFromJson(json);

  @override
  final DateTime date;
  @override
  @JsonKey(name: 'memories_count')
  final int memoriesCount;
  @override
  @JsonKey(name: 'tasks_completed')
  final int tasksCompleted;
  @override
  @JsonKey(name: 'time_tracked')
  final int timeTracked;
  @override
  @JsonKey(name: 'stories_created')
  final int storiesCreated;

  @override
  String toString() {
    return 'DayActivity(date: $date, memoriesCount: $memoriesCount, tasksCompleted: $tasksCompleted, timeTracked: $timeTracked, storiesCreated: $storiesCreated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DayActivityImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.memoriesCount, memoriesCount) ||
                other.memoriesCount == memoriesCount) &&
            (identical(other.tasksCompleted, tasksCompleted) ||
                other.tasksCompleted == tasksCompleted) &&
            (identical(other.timeTracked, timeTracked) ||
                other.timeTracked == timeTracked) &&
            (identical(other.storiesCreated, storiesCreated) ||
                other.storiesCreated == storiesCreated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    memoriesCount,
    tasksCompleted,
    timeTracked,
    storiesCreated,
  );

  /// Create a copy of DayActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DayActivityImplCopyWith<_$DayActivityImpl> get copyWith =>
      __$$DayActivityImplCopyWithImpl<_$DayActivityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DayActivityImplToJson(this);
  }
}

abstract class _DayActivity implements DayActivity {
  const factory _DayActivity({
    required final DateTime date,
    @JsonKey(name: 'memories_count') final int memoriesCount,
    @JsonKey(name: 'tasks_completed') final int tasksCompleted,
    @JsonKey(name: 'time_tracked') final int timeTracked,
    @JsonKey(name: 'stories_created') final int storiesCreated,
  }) = _$DayActivityImpl;

  factory _DayActivity.fromJson(Map<String, dynamic> json) =
      _$DayActivityImpl.fromJson;

  @override
  DateTime get date;
  @override
  @JsonKey(name: 'memories_count')
  int get memoriesCount;
  @override
  @JsonKey(name: 'tasks_completed')
  int get tasksCompleted;
  @override
  @JsonKey(name: 'time_tracked')
  int get timeTracked;
  @override
  @JsonKey(name: 'stories_created')
  int get storiesCreated;

  /// Create a copy of DayActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DayActivityImplCopyWith<_$DayActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonthStats _$MonthStatsFromJson(Map<String, dynamic> json) {
  return _MonthStats.fromJson(json);
}

/// @nodoc
mixin _$MonthStats {
  int get month => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_memories')
  int get totalMemories => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_tasks_completed')
  int get totalTasksCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_time_tracked')
  int get totalTimeTracked => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_stories')
  int get totalStories => throw _privateConstructorUsedError;
  @JsonKey(name: 'daily_activities')
  List<DayActivity> get dailyActivities => throw _privateConstructorUsedError;

  /// Serializes this MonthStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthStatsCopyWith<MonthStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthStatsCopyWith<$Res> {
  factory $MonthStatsCopyWith(
    MonthStats value,
    $Res Function(MonthStats) then,
  ) = _$MonthStatsCopyWithImpl<$Res, MonthStats>;
  @useResult
  $Res call({
    int month,
    int year,
    @JsonKey(name: 'total_memories') int totalMemories,
    @JsonKey(name: 'total_tasks_completed') int totalTasksCompleted,
    @JsonKey(name: 'total_time_tracked') int totalTimeTracked,
    @JsonKey(name: 'total_stories') int totalStories,
    @JsonKey(name: 'daily_activities') List<DayActivity> dailyActivities,
  });
}

/// @nodoc
class _$MonthStatsCopyWithImpl<$Res, $Val extends MonthStats>
    implements $MonthStatsCopyWith<$Res> {
  _$MonthStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? year = null,
    Object? totalMemories = null,
    Object? totalTasksCompleted = null,
    Object? totalTimeTracked = null,
    Object? totalStories = null,
    Object? dailyActivities = null,
  }) {
    return _then(
      _value.copyWith(
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as int,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            totalMemories: null == totalMemories
                ? _value.totalMemories
                : totalMemories // ignore: cast_nullable_to_non_nullable
                      as int,
            totalTasksCompleted: null == totalTasksCompleted
                ? _value.totalTasksCompleted
                : totalTasksCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            totalTimeTracked: null == totalTimeTracked
                ? _value.totalTimeTracked
                : totalTimeTracked // ignore: cast_nullable_to_non_nullable
                      as int,
            totalStories: null == totalStories
                ? _value.totalStories
                : totalStories // ignore: cast_nullable_to_non_nullable
                      as int,
            dailyActivities: null == dailyActivities
                ? _value.dailyActivities
                : dailyActivities // ignore: cast_nullable_to_non_nullable
                      as List<DayActivity>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MonthStatsImplCopyWith<$Res>
    implements $MonthStatsCopyWith<$Res> {
  factory _$$MonthStatsImplCopyWith(
    _$MonthStatsImpl value,
    $Res Function(_$MonthStatsImpl) then,
  ) = __$$MonthStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int month,
    int year,
    @JsonKey(name: 'total_memories') int totalMemories,
    @JsonKey(name: 'total_tasks_completed') int totalTasksCompleted,
    @JsonKey(name: 'total_time_tracked') int totalTimeTracked,
    @JsonKey(name: 'total_stories') int totalStories,
    @JsonKey(name: 'daily_activities') List<DayActivity> dailyActivities,
  });
}

/// @nodoc
class __$$MonthStatsImplCopyWithImpl<$Res>
    extends _$MonthStatsCopyWithImpl<$Res, _$MonthStatsImpl>
    implements _$$MonthStatsImplCopyWith<$Res> {
  __$$MonthStatsImplCopyWithImpl(
    _$MonthStatsImpl _value,
    $Res Function(_$MonthStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MonthStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? year = null,
    Object? totalMemories = null,
    Object? totalTasksCompleted = null,
    Object? totalTimeTracked = null,
    Object? totalStories = null,
    Object? dailyActivities = null,
  }) {
    return _then(
      _$MonthStatsImpl(
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as int,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        totalMemories: null == totalMemories
            ? _value.totalMemories
            : totalMemories // ignore: cast_nullable_to_non_nullable
                  as int,
        totalTasksCompleted: null == totalTasksCompleted
            ? _value.totalTasksCompleted
            : totalTasksCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        totalTimeTracked: null == totalTimeTracked
            ? _value.totalTimeTracked
            : totalTimeTracked // ignore: cast_nullable_to_non_nullable
                  as int,
        totalStories: null == totalStories
            ? _value.totalStories
            : totalStories // ignore: cast_nullable_to_non_nullable
                  as int,
        dailyActivities: null == dailyActivities
            ? _value._dailyActivities
            : dailyActivities // ignore: cast_nullable_to_non_nullable
                  as List<DayActivity>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthStatsImpl implements _MonthStats {
  const _$MonthStatsImpl({
    required this.month,
    required this.year,
    @JsonKey(name: 'total_memories') required this.totalMemories,
    @JsonKey(name: 'total_tasks_completed') required this.totalTasksCompleted,
    @JsonKey(name: 'total_time_tracked') required this.totalTimeTracked,
    @JsonKey(name: 'total_stories') required this.totalStories,
    @JsonKey(name: 'daily_activities')
    required final List<DayActivity> dailyActivities,
  }) : _dailyActivities = dailyActivities;

  factory _$MonthStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthStatsImplFromJson(json);

  @override
  final int month;
  @override
  final int year;
  @override
  @JsonKey(name: 'total_memories')
  final int totalMemories;
  @override
  @JsonKey(name: 'total_tasks_completed')
  final int totalTasksCompleted;
  @override
  @JsonKey(name: 'total_time_tracked')
  final int totalTimeTracked;
  @override
  @JsonKey(name: 'total_stories')
  final int totalStories;
  final List<DayActivity> _dailyActivities;
  @override
  @JsonKey(name: 'daily_activities')
  List<DayActivity> get dailyActivities {
    if (_dailyActivities is EqualUnmodifiableListView) return _dailyActivities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyActivities);
  }

  @override
  String toString() {
    return 'MonthStats(month: $month, year: $year, totalMemories: $totalMemories, totalTasksCompleted: $totalTasksCompleted, totalTimeTracked: $totalTimeTracked, totalStories: $totalStories, dailyActivities: $dailyActivities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthStatsImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.totalMemories, totalMemories) ||
                other.totalMemories == totalMemories) &&
            (identical(other.totalTasksCompleted, totalTasksCompleted) ||
                other.totalTasksCompleted == totalTasksCompleted) &&
            (identical(other.totalTimeTracked, totalTimeTracked) ||
                other.totalTimeTracked == totalTimeTracked) &&
            (identical(other.totalStories, totalStories) ||
                other.totalStories == totalStories) &&
            const DeepCollectionEquality().equals(
              other._dailyActivities,
              _dailyActivities,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    month,
    year,
    totalMemories,
    totalTasksCompleted,
    totalTimeTracked,
    totalStories,
    const DeepCollectionEquality().hash(_dailyActivities),
  );

  /// Create a copy of MonthStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthStatsImplCopyWith<_$MonthStatsImpl> get copyWith =>
      __$$MonthStatsImplCopyWithImpl<_$MonthStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthStatsImplToJson(this);
  }
}

abstract class _MonthStats implements MonthStats {
  const factory _MonthStats({
    required final int month,
    required final int year,
    @JsonKey(name: 'total_memories') required final int totalMemories,
    @JsonKey(name: 'total_tasks_completed')
    required final int totalTasksCompleted,
    @JsonKey(name: 'total_time_tracked') required final int totalTimeTracked,
    @JsonKey(name: 'total_stories') required final int totalStories,
    @JsonKey(name: 'daily_activities')
    required final List<DayActivity> dailyActivities,
  }) = _$MonthStatsImpl;

  factory _MonthStats.fromJson(Map<String, dynamic> json) =
      _$MonthStatsImpl.fromJson;

  @override
  int get month;
  @override
  int get year;
  @override
  @JsonKey(name: 'total_memories')
  int get totalMemories;
  @override
  @JsonKey(name: 'total_tasks_completed')
  int get totalTasksCompleted;
  @override
  @JsonKey(name: 'total_time_tracked')
  int get totalTimeTracked;
  @override
  @JsonKey(name: 'total_stories')
  int get totalStories;
  @override
  @JsonKey(name: 'daily_activities')
  List<DayActivity> get dailyActivities;

  /// Create a copy of MonthStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthStatsImplCopyWith<_$MonthStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductivityTrend _$ProductivityTrendFromJson(Map<String, dynamic> json) {
  return _ProductivityTrend.fromJson(json);
}

/// @nodoc
mixin _$ProductivityTrend {
  String get period => throw _privateConstructorUsedError;
  @JsonKey(name: 'tasks_completed')
  int get tasksCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_tracked')
  int get timeTracked => throw _privateConstructorUsedError;
  @JsonKey(name: 'memories_created')
  int get memoriesCreated => throw _privateConstructorUsedError;

  /// Serializes this ProductivityTrend to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductivityTrend
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductivityTrendCopyWith<ProductivityTrend> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductivityTrendCopyWith<$Res> {
  factory $ProductivityTrendCopyWith(
    ProductivityTrend value,
    $Res Function(ProductivityTrend) then,
  ) = _$ProductivityTrendCopyWithImpl<$Res, ProductivityTrend>;
  @useResult
  $Res call({
    String period,
    @JsonKey(name: 'tasks_completed') int tasksCompleted,
    @JsonKey(name: 'time_tracked') int timeTracked,
    @JsonKey(name: 'memories_created') int memoriesCreated,
  });
}

/// @nodoc
class _$ProductivityTrendCopyWithImpl<$Res, $Val extends ProductivityTrend>
    implements $ProductivityTrendCopyWith<$Res> {
  _$ProductivityTrendCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductivityTrend
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? tasksCompleted = null,
    Object? timeTracked = null,
    Object? memoriesCreated = null,
  }) {
    return _then(
      _value.copyWith(
            period: null == period
                ? _value.period
                : period // ignore: cast_nullable_to_non_nullable
                      as String,
            tasksCompleted: null == tasksCompleted
                ? _value.tasksCompleted
                : tasksCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            timeTracked: null == timeTracked
                ? _value.timeTracked
                : timeTracked // ignore: cast_nullable_to_non_nullable
                      as int,
            memoriesCreated: null == memoriesCreated
                ? _value.memoriesCreated
                : memoriesCreated // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductivityTrendImplCopyWith<$Res>
    implements $ProductivityTrendCopyWith<$Res> {
  factory _$$ProductivityTrendImplCopyWith(
    _$ProductivityTrendImpl value,
    $Res Function(_$ProductivityTrendImpl) then,
  ) = __$$ProductivityTrendImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String period,
    @JsonKey(name: 'tasks_completed') int tasksCompleted,
    @JsonKey(name: 'time_tracked') int timeTracked,
    @JsonKey(name: 'memories_created') int memoriesCreated,
  });
}

/// @nodoc
class __$$ProductivityTrendImplCopyWithImpl<$Res>
    extends _$ProductivityTrendCopyWithImpl<$Res, _$ProductivityTrendImpl>
    implements _$$ProductivityTrendImplCopyWith<$Res> {
  __$$ProductivityTrendImplCopyWithImpl(
    _$ProductivityTrendImpl _value,
    $Res Function(_$ProductivityTrendImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductivityTrend
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? tasksCompleted = null,
    Object? timeTracked = null,
    Object? memoriesCreated = null,
  }) {
    return _then(
      _$ProductivityTrendImpl(
        period: null == period
            ? _value.period
            : period // ignore: cast_nullable_to_non_nullable
                  as String,
        tasksCompleted: null == tasksCompleted
            ? _value.tasksCompleted
            : tasksCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        timeTracked: null == timeTracked
            ? _value.timeTracked
            : timeTracked // ignore: cast_nullable_to_non_nullable
                  as int,
        memoriesCreated: null == memoriesCreated
            ? _value.memoriesCreated
            : memoriesCreated // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductivityTrendImpl implements _ProductivityTrend {
  const _$ProductivityTrendImpl({
    required this.period,
    @JsonKey(name: 'tasks_completed') required this.tasksCompleted,
    @JsonKey(name: 'time_tracked') required this.timeTracked,
    @JsonKey(name: 'memories_created') required this.memoriesCreated,
  });

  factory _$ProductivityTrendImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductivityTrendImplFromJson(json);

  @override
  final String period;
  @override
  @JsonKey(name: 'tasks_completed')
  final int tasksCompleted;
  @override
  @JsonKey(name: 'time_tracked')
  final int timeTracked;
  @override
  @JsonKey(name: 'memories_created')
  final int memoriesCreated;

  @override
  String toString() {
    return 'ProductivityTrend(period: $period, tasksCompleted: $tasksCompleted, timeTracked: $timeTracked, memoriesCreated: $memoriesCreated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductivityTrendImpl &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.tasksCompleted, tasksCompleted) ||
                other.tasksCompleted == tasksCompleted) &&
            (identical(other.timeTracked, timeTracked) ||
                other.timeTracked == timeTracked) &&
            (identical(other.memoriesCreated, memoriesCreated) ||
                other.memoriesCreated == memoriesCreated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    period,
    tasksCompleted,
    timeTracked,
    memoriesCreated,
  );

  /// Create a copy of ProductivityTrend
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductivityTrendImplCopyWith<_$ProductivityTrendImpl> get copyWith =>
      __$$ProductivityTrendImplCopyWithImpl<_$ProductivityTrendImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductivityTrendImplToJson(this);
  }
}

abstract class _ProductivityTrend implements ProductivityTrend {
  const factory _ProductivityTrend({
    required final String period,
    @JsonKey(name: 'tasks_completed') required final int tasksCompleted,
    @JsonKey(name: 'time_tracked') required final int timeTracked,
    @JsonKey(name: 'memories_created') required final int memoriesCreated,
  }) = _$ProductivityTrendImpl;

  factory _ProductivityTrend.fromJson(Map<String, dynamic> json) =
      _$ProductivityTrendImpl.fromJson;

  @override
  String get period;
  @override
  @JsonKey(name: 'tasks_completed')
  int get tasksCompleted;
  @override
  @JsonKey(name: 'time_tracked')
  int get timeTracked;
  @override
  @JsonKey(name: 'memories_created')
  int get memoriesCreated;

  /// Create a copy of ProductivityTrend
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductivityTrendImplCopyWith<_$ProductivityTrendImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CategoryStats _$CategoryStatsFromJson(Map<String, dynamic> json) {
  return _CategoryStats.fromJson(json);
}

/// @nodoc
mixin _$CategoryStats {
  @JsonKey(name: 'category_id')
  String get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'memories_count')
  int get memoriesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'tasks_count')
  int get tasksCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'completion_rate')
  double get completionRate => throw _privateConstructorUsedError;

  /// Serializes this CategoryStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategoryStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryStatsCopyWith<CategoryStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryStatsCopyWith<$Res> {
  factory $CategoryStatsCopyWith(
    CategoryStats value,
    $Res Function(CategoryStats) then,
  ) = _$CategoryStatsCopyWithImpl<$Res, CategoryStats>;
  @useResult
  $Res call({
    @JsonKey(name: 'category_id') String categoryId,
    @JsonKey(name: 'category_name') String categoryName,
    @JsonKey(name: 'memories_count') int memoriesCount,
    @JsonKey(name: 'tasks_count') int tasksCount,
    @JsonKey(name: 'completion_rate') double completionRate,
  });
}

/// @nodoc
class _$CategoryStatsCopyWithImpl<$Res, $Val extends CategoryStats>
    implements $CategoryStatsCopyWith<$Res> {
  _$CategoryStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? memoriesCount = null,
    Object? tasksCount = null,
    Object? completionRate = null,
  }) {
    return _then(
      _value.copyWith(
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            memoriesCount: null == memoriesCount
                ? _value.memoriesCount
                : memoriesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            tasksCount: null == tasksCount
                ? _value.tasksCount
                : tasksCount // ignore: cast_nullable_to_non_nullable
                      as int,
            completionRate: null == completionRate
                ? _value.completionRate
                : completionRate // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategoryStatsImplCopyWith<$Res>
    implements $CategoryStatsCopyWith<$Res> {
  factory _$$CategoryStatsImplCopyWith(
    _$CategoryStatsImpl value,
    $Res Function(_$CategoryStatsImpl) then,
  ) = __$$CategoryStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'category_id') String categoryId,
    @JsonKey(name: 'category_name') String categoryName,
    @JsonKey(name: 'memories_count') int memoriesCount,
    @JsonKey(name: 'tasks_count') int tasksCount,
    @JsonKey(name: 'completion_rate') double completionRate,
  });
}

/// @nodoc
class __$$CategoryStatsImplCopyWithImpl<$Res>
    extends _$CategoryStatsCopyWithImpl<$Res, _$CategoryStatsImpl>
    implements _$$CategoryStatsImplCopyWith<$Res> {
  __$$CategoryStatsImplCopyWithImpl(
    _$CategoryStatsImpl _value,
    $Res Function(_$CategoryStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? memoriesCount = null,
    Object? tasksCount = null,
    Object? completionRate = null,
  }) {
    return _then(
      _$CategoryStatsImpl(
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        memoriesCount: null == memoriesCount
            ? _value.memoriesCount
            : memoriesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        tasksCount: null == tasksCount
            ? _value.tasksCount
            : tasksCount // ignore: cast_nullable_to_non_nullable
                  as int,
        completionRate: null == completionRate
            ? _value.completionRate
            : completionRate // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryStatsImpl implements _CategoryStats {
  const _$CategoryStatsImpl({
    @JsonKey(name: 'category_id') required this.categoryId,
    @JsonKey(name: 'category_name') required this.categoryName,
    @JsonKey(name: 'memories_count') required this.memoriesCount,
    @JsonKey(name: 'tasks_count') required this.tasksCount,
    @JsonKey(name: 'completion_rate') required this.completionRate,
  });

  factory _$CategoryStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryStatsImplFromJson(json);

  @override
  @JsonKey(name: 'category_id')
  final String categoryId;
  @override
  @JsonKey(name: 'category_name')
  final String categoryName;
  @override
  @JsonKey(name: 'memories_count')
  final int memoriesCount;
  @override
  @JsonKey(name: 'tasks_count')
  final int tasksCount;
  @override
  @JsonKey(name: 'completion_rate')
  final double completionRate;

  @override
  String toString() {
    return 'CategoryStats(categoryId: $categoryId, categoryName: $categoryName, memoriesCount: $memoriesCount, tasksCount: $tasksCount, completionRate: $completionRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryStatsImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.memoriesCount, memoriesCount) ||
                other.memoriesCount == memoriesCount) &&
            (identical(other.tasksCount, tasksCount) ||
                other.tasksCount == tasksCount) &&
            (identical(other.completionRate, completionRate) ||
                other.completionRate == completionRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    categoryId,
    categoryName,
    memoriesCount,
    tasksCount,
    completionRate,
  );

  /// Create a copy of CategoryStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryStatsImplCopyWith<_$CategoryStatsImpl> get copyWith =>
      __$$CategoryStatsImplCopyWithImpl<_$CategoryStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryStatsImplToJson(this);
  }
}

abstract class _CategoryStats implements CategoryStats {
  const factory _CategoryStats({
    @JsonKey(name: 'category_id') required final String categoryId,
    @JsonKey(name: 'category_name') required final String categoryName,
    @JsonKey(name: 'memories_count') required final int memoriesCount,
    @JsonKey(name: 'tasks_count') required final int tasksCount,
    @JsonKey(name: 'completion_rate') required final double completionRate,
  }) = _$CategoryStatsImpl;

  factory _CategoryStats.fromJson(Map<String, dynamic> json) =
      _$CategoryStatsImpl.fromJson;

  @override
  @JsonKey(name: 'category_id')
  String get categoryId;
  @override
  @JsonKey(name: 'category_name')
  String get categoryName;
  @override
  @JsonKey(name: 'memories_count')
  int get memoriesCount;
  @override
  @JsonKey(name: 'tasks_count')
  int get tasksCount;
  @override
  @JsonKey(name: 'completion_rate')
  double get completionRate;

  /// Create a copy of CategoryStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryStatsImplCopyWith<_$CategoryStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnalyticsDashboard _$AnalyticsDashboardFromJson(Map<String, dynamic> json) {
  return _AnalyticsDashboard.fromJson(json);
}

/// @nodoc
mixin _$AnalyticsDashboard {
  @JsonKey(name: 'current_month')
  MonthStats get currentMonth => throw _privateConstructorUsedError;
  @JsonKey(name: 'productivity_trends')
  List<ProductivityTrend> get productivityTrends =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'category_stats')
  List<CategoryStats> get categoryStats => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_streak')
  int get currentStreak => throw _privateConstructorUsedError;
  @JsonKey(name: 'longest_streak')
  int get longestStreak => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_memories')
  int get totalMemories => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_tasks_completed')
  int get totalTasksCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_time_tracked')
  int get totalTimeTracked => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_stories')
  int get totalStories => throw _privateConstructorUsedError;
  @JsonKey(name: 'this_week_memories')
  int get thisWeekMemories => throw _privateConstructorUsedError;
  @JsonKey(name: 'this_week_tasks')
  int get thisWeekTasks => throw _privateConstructorUsedError;
  @JsonKey(name: 'this_week_time')
  int get thisWeekTime => throw _privateConstructorUsedError;

  /// Serializes this AnalyticsDashboard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalyticsDashboard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalyticsDashboardCopyWith<AnalyticsDashboard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyticsDashboardCopyWith<$Res> {
  factory $AnalyticsDashboardCopyWith(
    AnalyticsDashboard value,
    $Res Function(AnalyticsDashboard) then,
  ) = _$AnalyticsDashboardCopyWithImpl<$Res, AnalyticsDashboard>;
  @useResult
  $Res call({
    @JsonKey(name: 'current_month') MonthStats currentMonth,
    @JsonKey(name: 'productivity_trends')
    List<ProductivityTrend> productivityTrends,
    @JsonKey(name: 'category_stats') List<CategoryStats> categoryStats,
    @JsonKey(name: 'current_streak') int currentStreak,
    @JsonKey(name: 'longest_streak') int longestStreak,
    @JsonKey(name: 'total_memories') int totalMemories,
    @JsonKey(name: 'total_tasks_completed') int totalTasksCompleted,
    @JsonKey(name: 'total_time_tracked') int totalTimeTracked,
    @JsonKey(name: 'total_stories') int totalStories,
    @JsonKey(name: 'this_week_memories') int thisWeekMemories,
    @JsonKey(name: 'this_week_tasks') int thisWeekTasks,
    @JsonKey(name: 'this_week_time') int thisWeekTime,
  });

  $MonthStatsCopyWith<$Res> get currentMonth;
}

/// @nodoc
class _$AnalyticsDashboardCopyWithImpl<$Res, $Val extends AnalyticsDashboard>
    implements $AnalyticsDashboardCopyWith<$Res> {
  _$AnalyticsDashboardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalyticsDashboard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentMonth = null,
    Object? productivityTrends = null,
    Object? categoryStats = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? totalMemories = null,
    Object? totalTasksCompleted = null,
    Object? totalTimeTracked = null,
    Object? totalStories = null,
    Object? thisWeekMemories = null,
    Object? thisWeekTasks = null,
    Object? thisWeekTime = null,
  }) {
    return _then(
      _value.copyWith(
            currentMonth: null == currentMonth
                ? _value.currentMonth
                : currentMonth // ignore: cast_nullable_to_non_nullable
                      as MonthStats,
            productivityTrends: null == productivityTrends
                ? _value.productivityTrends
                : productivityTrends // ignore: cast_nullable_to_non_nullable
                      as List<ProductivityTrend>,
            categoryStats: null == categoryStats
                ? _value.categoryStats
                : categoryStats // ignore: cast_nullable_to_non_nullable
                      as List<CategoryStats>,
            currentStreak: null == currentStreak
                ? _value.currentStreak
                : currentStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            longestStreak: null == longestStreak
                ? _value.longestStreak
                : longestStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            totalMemories: null == totalMemories
                ? _value.totalMemories
                : totalMemories // ignore: cast_nullable_to_non_nullable
                      as int,
            totalTasksCompleted: null == totalTasksCompleted
                ? _value.totalTasksCompleted
                : totalTasksCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            totalTimeTracked: null == totalTimeTracked
                ? _value.totalTimeTracked
                : totalTimeTracked // ignore: cast_nullable_to_non_nullable
                      as int,
            totalStories: null == totalStories
                ? _value.totalStories
                : totalStories // ignore: cast_nullable_to_non_nullable
                      as int,
            thisWeekMemories: null == thisWeekMemories
                ? _value.thisWeekMemories
                : thisWeekMemories // ignore: cast_nullable_to_non_nullable
                      as int,
            thisWeekTasks: null == thisWeekTasks
                ? _value.thisWeekTasks
                : thisWeekTasks // ignore: cast_nullable_to_non_nullable
                      as int,
            thisWeekTime: null == thisWeekTime
                ? _value.thisWeekTime
                : thisWeekTime // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of AnalyticsDashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MonthStatsCopyWith<$Res> get currentMonth {
    return $MonthStatsCopyWith<$Res>(_value.currentMonth, (value) {
      return _then(_value.copyWith(currentMonth: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AnalyticsDashboardImplCopyWith<$Res>
    implements $AnalyticsDashboardCopyWith<$Res> {
  factory _$$AnalyticsDashboardImplCopyWith(
    _$AnalyticsDashboardImpl value,
    $Res Function(_$AnalyticsDashboardImpl) then,
  ) = __$$AnalyticsDashboardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'current_month') MonthStats currentMonth,
    @JsonKey(name: 'productivity_trends')
    List<ProductivityTrend> productivityTrends,
    @JsonKey(name: 'category_stats') List<CategoryStats> categoryStats,
    @JsonKey(name: 'current_streak') int currentStreak,
    @JsonKey(name: 'longest_streak') int longestStreak,
    @JsonKey(name: 'total_memories') int totalMemories,
    @JsonKey(name: 'total_tasks_completed') int totalTasksCompleted,
    @JsonKey(name: 'total_time_tracked') int totalTimeTracked,
    @JsonKey(name: 'total_stories') int totalStories,
    @JsonKey(name: 'this_week_memories') int thisWeekMemories,
    @JsonKey(name: 'this_week_tasks') int thisWeekTasks,
    @JsonKey(name: 'this_week_time') int thisWeekTime,
  });

  @override
  $MonthStatsCopyWith<$Res> get currentMonth;
}

/// @nodoc
class __$$AnalyticsDashboardImplCopyWithImpl<$Res>
    extends _$AnalyticsDashboardCopyWithImpl<$Res, _$AnalyticsDashboardImpl>
    implements _$$AnalyticsDashboardImplCopyWith<$Res> {
  __$$AnalyticsDashboardImplCopyWithImpl(
    _$AnalyticsDashboardImpl _value,
    $Res Function(_$AnalyticsDashboardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalyticsDashboard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentMonth = null,
    Object? productivityTrends = null,
    Object? categoryStats = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? totalMemories = null,
    Object? totalTasksCompleted = null,
    Object? totalTimeTracked = null,
    Object? totalStories = null,
    Object? thisWeekMemories = null,
    Object? thisWeekTasks = null,
    Object? thisWeekTime = null,
  }) {
    return _then(
      _$AnalyticsDashboardImpl(
        currentMonth: null == currentMonth
            ? _value.currentMonth
            : currentMonth // ignore: cast_nullable_to_non_nullable
                  as MonthStats,
        productivityTrends: null == productivityTrends
            ? _value._productivityTrends
            : productivityTrends // ignore: cast_nullable_to_non_nullable
                  as List<ProductivityTrend>,
        categoryStats: null == categoryStats
            ? _value._categoryStats
            : categoryStats // ignore: cast_nullable_to_non_nullable
                  as List<CategoryStats>,
        currentStreak: null == currentStreak
            ? _value.currentStreak
            : currentStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        longestStreak: null == longestStreak
            ? _value.longestStreak
            : longestStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        totalMemories: null == totalMemories
            ? _value.totalMemories
            : totalMemories // ignore: cast_nullable_to_non_nullable
                  as int,
        totalTasksCompleted: null == totalTasksCompleted
            ? _value.totalTasksCompleted
            : totalTasksCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        totalTimeTracked: null == totalTimeTracked
            ? _value.totalTimeTracked
            : totalTimeTracked // ignore: cast_nullable_to_non_nullable
                  as int,
        totalStories: null == totalStories
            ? _value.totalStories
            : totalStories // ignore: cast_nullable_to_non_nullable
                  as int,
        thisWeekMemories: null == thisWeekMemories
            ? _value.thisWeekMemories
            : thisWeekMemories // ignore: cast_nullable_to_non_nullable
                  as int,
        thisWeekTasks: null == thisWeekTasks
            ? _value.thisWeekTasks
            : thisWeekTasks // ignore: cast_nullable_to_non_nullable
                  as int,
        thisWeekTime: null == thisWeekTime
            ? _value.thisWeekTime
            : thisWeekTime // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalyticsDashboardImpl implements _AnalyticsDashboard {
  const _$AnalyticsDashboardImpl({
    @JsonKey(name: 'current_month') required this.currentMonth,
    @JsonKey(name: 'productivity_trends')
    required final List<ProductivityTrend> productivityTrends,
    @JsonKey(name: 'category_stats')
    required final List<CategoryStats> categoryStats,
    @JsonKey(name: 'current_streak') this.currentStreak = 0,
    @JsonKey(name: 'longest_streak') this.longestStreak = 0,
    @JsonKey(name: 'total_memories') required this.totalMemories,
    @JsonKey(name: 'total_tasks_completed') required this.totalTasksCompleted,
    @JsonKey(name: 'total_time_tracked') required this.totalTimeTracked,
    @JsonKey(name: 'total_stories') required this.totalStories,
    @JsonKey(name: 'this_week_memories') required this.thisWeekMemories,
    @JsonKey(name: 'this_week_tasks') required this.thisWeekTasks,
    @JsonKey(name: 'this_week_time') required this.thisWeekTime,
  }) : _productivityTrends = productivityTrends,
       _categoryStats = categoryStats;

  factory _$AnalyticsDashboardImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalyticsDashboardImplFromJson(json);

  @override
  @JsonKey(name: 'current_month')
  final MonthStats currentMonth;
  final List<ProductivityTrend> _productivityTrends;
  @override
  @JsonKey(name: 'productivity_trends')
  List<ProductivityTrend> get productivityTrends {
    if (_productivityTrends is EqualUnmodifiableListView)
      return _productivityTrends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productivityTrends);
  }

  final List<CategoryStats> _categoryStats;
  @override
  @JsonKey(name: 'category_stats')
  List<CategoryStats> get categoryStats {
    if (_categoryStats is EqualUnmodifiableListView) return _categoryStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoryStats);
  }

  @override
  @JsonKey(name: 'current_streak')
  final int currentStreak;
  @override
  @JsonKey(name: 'longest_streak')
  final int longestStreak;
  @override
  @JsonKey(name: 'total_memories')
  final int totalMemories;
  @override
  @JsonKey(name: 'total_tasks_completed')
  final int totalTasksCompleted;
  @override
  @JsonKey(name: 'total_time_tracked')
  final int totalTimeTracked;
  @override
  @JsonKey(name: 'total_stories')
  final int totalStories;
  @override
  @JsonKey(name: 'this_week_memories')
  final int thisWeekMemories;
  @override
  @JsonKey(name: 'this_week_tasks')
  final int thisWeekTasks;
  @override
  @JsonKey(name: 'this_week_time')
  final int thisWeekTime;

  @override
  String toString() {
    return 'AnalyticsDashboard(currentMonth: $currentMonth, productivityTrends: $productivityTrends, categoryStats: $categoryStats, currentStreak: $currentStreak, longestStreak: $longestStreak, totalMemories: $totalMemories, totalTasksCompleted: $totalTasksCompleted, totalTimeTracked: $totalTimeTracked, totalStories: $totalStories, thisWeekMemories: $thisWeekMemories, thisWeekTasks: $thisWeekTasks, thisWeekTime: $thisWeekTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyticsDashboardImpl &&
            (identical(other.currentMonth, currentMonth) ||
                other.currentMonth == currentMonth) &&
            const DeepCollectionEquality().equals(
              other._productivityTrends,
              _productivityTrends,
            ) &&
            const DeepCollectionEquality().equals(
              other._categoryStats,
              _categoryStats,
            ) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.totalMemories, totalMemories) ||
                other.totalMemories == totalMemories) &&
            (identical(other.totalTasksCompleted, totalTasksCompleted) ||
                other.totalTasksCompleted == totalTasksCompleted) &&
            (identical(other.totalTimeTracked, totalTimeTracked) ||
                other.totalTimeTracked == totalTimeTracked) &&
            (identical(other.totalStories, totalStories) ||
                other.totalStories == totalStories) &&
            (identical(other.thisWeekMemories, thisWeekMemories) ||
                other.thisWeekMemories == thisWeekMemories) &&
            (identical(other.thisWeekTasks, thisWeekTasks) ||
                other.thisWeekTasks == thisWeekTasks) &&
            (identical(other.thisWeekTime, thisWeekTime) ||
                other.thisWeekTime == thisWeekTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentMonth,
    const DeepCollectionEquality().hash(_productivityTrends),
    const DeepCollectionEquality().hash(_categoryStats),
    currentStreak,
    longestStreak,
    totalMemories,
    totalTasksCompleted,
    totalTimeTracked,
    totalStories,
    thisWeekMemories,
    thisWeekTasks,
    thisWeekTime,
  );

  /// Create a copy of AnalyticsDashboard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyticsDashboardImplCopyWith<_$AnalyticsDashboardImpl> get copyWith =>
      __$$AnalyticsDashboardImplCopyWithImpl<_$AnalyticsDashboardImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalyticsDashboardImplToJson(this);
  }
}

abstract class _AnalyticsDashboard implements AnalyticsDashboard {
  const factory _AnalyticsDashboard({
    @JsonKey(name: 'current_month') required final MonthStats currentMonth,
    @JsonKey(name: 'productivity_trends')
    required final List<ProductivityTrend> productivityTrends,
    @JsonKey(name: 'category_stats')
    required final List<CategoryStats> categoryStats,
    @JsonKey(name: 'current_streak') final int currentStreak,
    @JsonKey(name: 'longest_streak') final int longestStreak,
    @JsonKey(name: 'total_memories') required final int totalMemories,
    @JsonKey(name: 'total_tasks_completed')
    required final int totalTasksCompleted,
    @JsonKey(name: 'total_time_tracked') required final int totalTimeTracked,
    @JsonKey(name: 'total_stories') required final int totalStories,
    @JsonKey(name: 'this_week_memories') required final int thisWeekMemories,
    @JsonKey(name: 'this_week_tasks') required final int thisWeekTasks,
    @JsonKey(name: 'this_week_time') required final int thisWeekTime,
  }) = _$AnalyticsDashboardImpl;

  factory _AnalyticsDashboard.fromJson(Map<String, dynamic> json) =
      _$AnalyticsDashboardImpl.fromJson;

  @override
  @JsonKey(name: 'current_month')
  MonthStats get currentMonth;
  @override
  @JsonKey(name: 'productivity_trends')
  List<ProductivityTrend> get productivityTrends;
  @override
  @JsonKey(name: 'category_stats')
  List<CategoryStats> get categoryStats;
  @override
  @JsonKey(name: 'current_streak')
  int get currentStreak;
  @override
  @JsonKey(name: 'longest_streak')
  int get longestStreak;
  @override
  @JsonKey(name: 'total_memories')
  int get totalMemories;
  @override
  @JsonKey(name: 'total_tasks_completed')
  int get totalTasksCompleted;
  @override
  @JsonKey(name: 'total_time_tracked')
  int get totalTimeTracked;
  @override
  @JsonKey(name: 'total_stories')
  int get totalStories;
  @override
  @JsonKey(name: 'this_week_memories')
  int get thisWeekMemories;
  @override
  @JsonKey(name: 'this_week_tasks')
  int get thisWeekTasks;
  @override
  @JsonKey(name: 'this_week_time')
  int get thisWeekTime;

  /// Create a copy of AnalyticsDashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalyticsDashboardImplCopyWith<_$AnalyticsDashboardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
