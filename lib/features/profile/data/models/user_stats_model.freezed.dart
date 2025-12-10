// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserStatsModel _$UserStatsModelFromJson(Map<String, dynamic> json) {
  return _UserStatsModel.fromJson(json);
}

/// @nodoc
mixin _$UserStatsModel {
  @JsonKey(name: 'memories_count')
  int get memoriesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'tasks_total')
  int get tasksTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'tasks_completed')
  int get tasksCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'tasks_in_progress')
  int get tasksInProgress => throw _privateConstructorUsedError;
  @JsonKey(name: 'stories_count')
  int get storiesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_time_tracked')
  int get totalTimeTracked => throw _privateConstructorUsedError;

  /// Serializes this UserStatsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserStatsModelCopyWith<UserStatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatsModelCopyWith<$Res> {
  factory $UserStatsModelCopyWith(
    UserStatsModel value,
    $Res Function(UserStatsModel) then,
  ) = _$UserStatsModelCopyWithImpl<$Res, UserStatsModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'memories_count') int memoriesCount,
    @JsonKey(name: 'tasks_total') int tasksTotal,
    @JsonKey(name: 'tasks_completed') int tasksCompleted,
    @JsonKey(name: 'tasks_in_progress') int tasksInProgress,
    @JsonKey(name: 'stories_count') int storiesCount,
    @JsonKey(name: 'total_time_tracked') int totalTimeTracked,
  });
}

/// @nodoc
class _$UserStatsModelCopyWithImpl<$Res, $Val extends UserStatsModel>
    implements $UserStatsModelCopyWith<$Res> {
  _$UserStatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memoriesCount = null,
    Object? tasksTotal = null,
    Object? tasksCompleted = null,
    Object? tasksInProgress = null,
    Object? storiesCount = null,
    Object? totalTimeTracked = null,
  }) {
    return _then(
      _value.copyWith(
            memoriesCount: null == memoriesCount
                ? _value.memoriesCount
                : memoriesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            tasksTotal: null == tasksTotal
                ? _value.tasksTotal
                : tasksTotal // ignore: cast_nullable_to_non_nullable
                      as int,
            tasksCompleted: null == tasksCompleted
                ? _value.tasksCompleted
                : tasksCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            tasksInProgress: null == tasksInProgress
                ? _value.tasksInProgress
                : tasksInProgress // ignore: cast_nullable_to_non_nullable
                      as int,
            storiesCount: null == storiesCount
                ? _value.storiesCount
                : storiesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalTimeTracked: null == totalTimeTracked
                ? _value.totalTimeTracked
                : totalTimeTracked // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserStatsModelImplCopyWith<$Res>
    implements $UserStatsModelCopyWith<$Res> {
  factory _$$UserStatsModelImplCopyWith(
    _$UserStatsModelImpl value,
    $Res Function(_$UserStatsModelImpl) then,
  ) = __$$UserStatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'memories_count') int memoriesCount,
    @JsonKey(name: 'tasks_total') int tasksTotal,
    @JsonKey(name: 'tasks_completed') int tasksCompleted,
    @JsonKey(name: 'tasks_in_progress') int tasksInProgress,
    @JsonKey(name: 'stories_count') int storiesCount,
    @JsonKey(name: 'total_time_tracked') int totalTimeTracked,
  });
}

/// @nodoc
class __$$UserStatsModelImplCopyWithImpl<$Res>
    extends _$UserStatsModelCopyWithImpl<$Res, _$UserStatsModelImpl>
    implements _$$UserStatsModelImplCopyWith<$Res> {
  __$$UserStatsModelImplCopyWithImpl(
    _$UserStatsModelImpl _value,
    $Res Function(_$UserStatsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memoriesCount = null,
    Object? tasksTotal = null,
    Object? tasksCompleted = null,
    Object? tasksInProgress = null,
    Object? storiesCount = null,
    Object? totalTimeTracked = null,
  }) {
    return _then(
      _$UserStatsModelImpl(
        memoriesCount: null == memoriesCount
            ? _value.memoriesCount
            : memoriesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        tasksTotal: null == tasksTotal
            ? _value.tasksTotal
            : tasksTotal // ignore: cast_nullable_to_non_nullable
                  as int,
        tasksCompleted: null == tasksCompleted
            ? _value.tasksCompleted
            : tasksCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        tasksInProgress: null == tasksInProgress
            ? _value.tasksInProgress
            : tasksInProgress // ignore: cast_nullable_to_non_nullable
                  as int,
        storiesCount: null == storiesCount
            ? _value.storiesCount
            : storiesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        totalTimeTracked: null == totalTimeTracked
            ? _value.totalTimeTracked
            : totalTimeTracked // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserStatsModelImpl implements _UserStatsModel {
  const _$UserStatsModelImpl({
    @JsonKey(name: 'memories_count') required this.memoriesCount,
    @JsonKey(name: 'tasks_total') required this.tasksTotal,
    @JsonKey(name: 'tasks_completed') required this.tasksCompleted,
    @JsonKey(name: 'tasks_in_progress') required this.tasksInProgress,
    @JsonKey(name: 'stories_count') required this.storiesCount,
    @JsonKey(name: 'total_time_tracked') required this.totalTimeTracked,
  });

  factory _$UserStatsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserStatsModelImplFromJson(json);

  @override
  @JsonKey(name: 'memories_count')
  final int memoriesCount;
  @override
  @JsonKey(name: 'tasks_total')
  final int tasksTotal;
  @override
  @JsonKey(name: 'tasks_completed')
  final int tasksCompleted;
  @override
  @JsonKey(name: 'tasks_in_progress')
  final int tasksInProgress;
  @override
  @JsonKey(name: 'stories_count')
  final int storiesCount;
  @override
  @JsonKey(name: 'total_time_tracked')
  final int totalTimeTracked;

  @override
  String toString() {
    return 'UserStatsModel(memoriesCount: $memoriesCount, tasksTotal: $tasksTotal, tasksCompleted: $tasksCompleted, tasksInProgress: $tasksInProgress, storiesCount: $storiesCount, totalTimeTracked: $totalTimeTracked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatsModelImpl &&
            (identical(other.memoriesCount, memoriesCount) ||
                other.memoriesCount == memoriesCount) &&
            (identical(other.tasksTotal, tasksTotal) ||
                other.tasksTotal == tasksTotal) &&
            (identical(other.tasksCompleted, tasksCompleted) ||
                other.tasksCompleted == tasksCompleted) &&
            (identical(other.tasksInProgress, tasksInProgress) ||
                other.tasksInProgress == tasksInProgress) &&
            (identical(other.storiesCount, storiesCount) ||
                other.storiesCount == storiesCount) &&
            (identical(other.totalTimeTracked, totalTimeTracked) ||
                other.totalTimeTracked == totalTimeTracked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    memoriesCount,
    tasksTotal,
    tasksCompleted,
    tasksInProgress,
    storiesCount,
    totalTimeTracked,
  );

  /// Create a copy of UserStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatsModelImplCopyWith<_$UserStatsModelImpl> get copyWith =>
      __$$UserStatsModelImplCopyWithImpl<_$UserStatsModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserStatsModelImplToJson(this);
  }
}

abstract class _UserStatsModel implements UserStatsModel {
  const factory _UserStatsModel({
    @JsonKey(name: 'memories_count') required final int memoriesCount,
    @JsonKey(name: 'tasks_total') required final int tasksTotal,
    @JsonKey(name: 'tasks_completed') required final int tasksCompleted,
    @JsonKey(name: 'tasks_in_progress') required final int tasksInProgress,
    @JsonKey(name: 'stories_count') required final int storiesCount,
    @JsonKey(name: 'total_time_tracked') required final int totalTimeTracked,
  }) = _$UserStatsModelImpl;

  factory _UserStatsModel.fromJson(Map<String, dynamic> json) =
      _$UserStatsModelImpl.fromJson;

  @override
  @JsonKey(name: 'memories_count')
  int get memoriesCount;
  @override
  @JsonKey(name: 'tasks_total')
  int get tasksTotal;
  @override
  @JsonKey(name: 'tasks_completed')
  int get tasksCompleted;
  @override
  @JsonKey(name: 'tasks_in_progress')
  int get tasksInProgress;
  @override
  @JsonKey(name: 'stories_count')
  int get storiesCount;
  @override
  @JsonKey(name: 'total_time_tracked')
  int get totalTimeTracked;

  /// Create a copy of UserStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStatsModelImplCopyWith<_$UserStatsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
