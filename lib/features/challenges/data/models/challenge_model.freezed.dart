// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChallengeModel _$ChallengeModelFromJson(Map<String, dynamic> json) {
  return _ChallengeModel.fromJson(json);
}

/// @nodoc
mixin _$ChallengeModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get emoji => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  DateTime get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  DateTime get endDate => throw _privateConstructorUsedError;
  Map<String, dynamic> get goal => throw _privateConstructorUsedError;
  @JsonKey(name: 'participants_count')
  int get participantsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_ongoing')
  bool? get isOngoing => throw _privateConstructorUsedError;
  @JsonKey(name: 'days_remaining')
  int? get daysRemaining => throw _privateConstructorUsedError;

  /// Serializes this ChallengeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeModelCopyWith<ChallengeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeModelCopyWith<$Res> {
  factory $ChallengeModelCopyWith(
    ChallengeModel value,
    $Res Function(ChallengeModel) then,
  ) = _$ChallengeModelCopyWithImpl<$Res, ChallengeModel>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String emoji,
    @JsonKey(name: 'start_date') DateTime startDate,
    @JsonKey(name: 'end_date') DateTime endDate,
    Map<String, dynamic> goal,
    @JsonKey(name: 'participants_count') int participantsCount,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    @JsonKey(name: 'is_ongoing') bool? isOngoing,
    @JsonKey(name: 'days_remaining') int? daysRemaining,
  });
}

/// @nodoc
class _$ChallengeModelCopyWithImpl<$Res, $Val extends ChallengeModel>
    implements $ChallengeModelCopyWith<$Res> {
  _$ChallengeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? emoji = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? goal = null,
    Object? participantsCount = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isOngoing = freezed,
    Object? daysRemaining = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            emoji: null == emoji
                ? _value.emoji
                : emoji // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            goal: null == goal
                ? _value.goal
                : goal // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            participantsCount: null == participantsCount
                ? _value.participantsCount
                : participantsCount // ignore: cast_nullable_to_non_nullable
                      as int,
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
            isOngoing: freezed == isOngoing
                ? _value.isOngoing
                : isOngoing // ignore: cast_nullable_to_non_nullable
                      as bool?,
            daysRemaining: freezed == daysRemaining
                ? _value.daysRemaining
                : daysRemaining // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChallengeModelImplCopyWith<$Res>
    implements $ChallengeModelCopyWith<$Res> {
  factory _$$ChallengeModelImplCopyWith(
    _$ChallengeModelImpl value,
    $Res Function(_$ChallengeModelImpl) then,
  ) = __$$ChallengeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String emoji,
    @JsonKey(name: 'start_date') DateTime startDate,
    @JsonKey(name: 'end_date') DateTime endDate,
    Map<String, dynamic> goal,
    @JsonKey(name: 'participants_count') int participantsCount,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    @JsonKey(name: 'is_ongoing') bool? isOngoing,
    @JsonKey(name: 'days_remaining') int? daysRemaining,
  });
}

/// @nodoc
class __$$ChallengeModelImplCopyWithImpl<$Res>
    extends _$ChallengeModelCopyWithImpl<$Res, _$ChallengeModelImpl>
    implements _$$ChallengeModelImplCopyWith<$Res> {
  __$$ChallengeModelImplCopyWithImpl(
    _$ChallengeModelImpl _value,
    $Res Function(_$ChallengeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? emoji = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? goal = null,
    Object? participantsCount = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isOngoing = freezed,
    Object? daysRemaining = freezed,
  }) {
    return _then(
      _$ChallengeModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        emoji: null == emoji
            ? _value.emoji
            : emoji // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        goal: null == goal
            ? _value._goal
            : goal // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        participantsCount: null == participantsCount
            ? _value.participantsCount
            : participantsCount // ignore: cast_nullable_to_non_nullable
                  as int,
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
        isOngoing: freezed == isOngoing
            ? _value.isOngoing
            : isOngoing // ignore: cast_nullable_to_non_nullable
                  as bool?,
        daysRemaining: freezed == daysRemaining
            ? _value.daysRemaining
            : daysRemaining // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeModelImpl
    with DiagnosticableTreeMixin
    implements _ChallengeModel {
  const _$ChallengeModelImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    @JsonKey(name: 'start_date') required this.startDate,
    @JsonKey(name: 'end_date') required this.endDate,
    required final Map<String, dynamic> goal,
    @JsonKey(name: 'participants_count') required this.participantsCount,
    @JsonKey(name: 'is_active') required this.isActive,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
    @JsonKey(name: 'is_ongoing') this.isOngoing,
    @JsonKey(name: 'days_remaining') this.daysRemaining,
  }) : _goal = goal;

  factory _$ChallengeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String emoji;
  @override
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @override
  @JsonKey(name: 'end_date')
  final DateTime endDate;
  final Map<String, dynamic> _goal;
  @override
  Map<String, dynamic> get goal {
    if (_goal is EqualUnmodifiableMapView) return _goal;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_goal);
  }

  @override
  @JsonKey(name: 'participants_count')
  final int participantsCount;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  @JsonKey(name: 'is_ongoing')
  final bool? isOngoing;
  @override
  @JsonKey(name: 'days_remaining')
  final int? daysRemaining;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChallengeModel(id: $id, title: $title, description: $description, emoji: $emoji, startDate: $startDate, endDate: $endDate, goal: $goal, participantsCount: $participantsCount, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, isOngoing: $isOngoing, daysRemaining: $daysRemaining)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChallengeModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('emoji', emoji))
      ..add(DiagnosticsProperty('startDate', startDate))
      ..add(DiagnosticsProperty('endDate', endDate))
      ..add(DiagnosticsProperty('goal', goal))
      ..add(DiagnosticsProperty('participantsCount', participantsCount))
      ..add(DiagnosticsProperty('isActive', isActive))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('isOngoing', isOngoing))
      ..add(DiagnosticsProperty('daysRemaining', daysRemaining));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(other._goal, _goal) &&
            (identical(other.participantsCount, participantsCount) ||
                other.participantsCount == participantsCount) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isOngoing, isOngoing) ||
                other.isOngoing == isOngoing) &&
            (identical(other.daysRemaining, daysRemaining) ||
                other.daysRemaining == daysRemaining));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    emoji,
    startDate,
    endDate,
    const DeepCollectionEquality().hash(_goal),
    participantsCount,
    isActive,
    createdAt,
    updatedAt,
    isOngoing,
    daysRemaining,
  );

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeModelImplCopyWith<_$ChallengeModelImpl> get copyWith =>
      __$$ChallengeModelImplCopyWithImpl<_$ChallengeModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeModelImplToJson(this);
  }
}

abstract class _ChallengeModel implements ChallengeModel {
  const factory _ChallengeModel({
    required final String id,
    required final String title,
    required final String description,
    required final String emoji,
    @JsonKey(name: 'start_date') required final DateTime startDate,
    @JsonKey(name: 'end_date') required final DateTime endDate,
    required final Map<String, dynamic> goal,
    @JsonKey(name: 'participants_count') required final int participantsCount,
    @JsonKey(name: 'is_active') required final bool isActive,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
    @JsonKey(name: 'is_ongoing') final bool? isOngoing,
    @JsonKey(name: 'days_remaining') final int? daysRemaining,
  }) = _$ChallengeModelImpl;

  factory _ChallengeModel.fromJson(Map<String, dynamic> json) =
      _$ChallengeModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get emoji;
  @override
  @JsonKey(name: 'start_date')
  DateTime get startDate;
  @override
  @JsonKey(name: 'end_date')
  DateTime get endDate;
  @override
  Map<String, dynamic> get goal;
  @override
  @JsonKey(name: 'participants_count')
  int get participantsCount;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  @JsonKey(name: 'is_ongoing')
  bool? get isOngoing;
  @override
  @JsonKey(name: 'days_remaining')
  int? get daysRemaining;

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeModelImplCopyWith<_$ChallengeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChallengeGoal _$ChallengeGoalFromJson(Map<String, dynamic> json) {
  return _ChallengeGoal.fromJson(json);
}

/// @nodoc
mixin _$ChallengeGoal {
  String get type => throw _privateConstructorUsedError;
  int get target => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this ChallengeGoal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChallengeGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeGoalCopyWith<ChallengeGoal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeGoalCopyWith<$Res> {
  factory $ChallengeGoalCopyWith(
    ChallengeGoal value,
    $Res Function(ChallengeGoal) then,
  ) = _$ChallengeGoalCopyWithImpl<$Res, ChallengeGoal>;
  @useResult
  $Res call({String type, int target, String description});
}

/// @nodoc
class _$ChallengeGoalCopyWithImpl<$Res, $Val extends ChallengeGoal>
    implements $ChallengeGoalCopyWith<$Res> {
  _$ChallengeGoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChallengeGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? target = null,
    Object? description = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            target: null == target
                ? _value.target
                : target // ignore: cast_nullable_to_non_nullable
                      as int,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChallengeGoalImplCopyWith<$Res>
    implements $ChallengeGoalCopyWith<$Res> {
  factory _$$ChallengeGoalImplCopyWith(
    _$ChallengeGoalImpl value,
    $Res Function(_$ChallengeGoalImpl) then,
  ) = __$$ChallengeGoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, int target, String description});
}

/// @nodoc
class __$$ChallengeGoalImplCopyWithImpl<$Res>
    extends _$ChallengeGoalCopyWithImpl<$Res, _$ChallengeGoalImpl>
    implements _$$ChallengeGoalImplCopyWith<$Res> {
  __$$ChallengeGoalImplCopyWithImpl(
    _$ChallengeGoalImpl _value,
    $Res Function(_$ChallengeGoalImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChallengeGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? target = null,
    Object? description = null,
  }) {
    return _then(
      _$ChallengeGoalImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        target: null == target
            ? _value.target
            : target // ignore: cast_nullable_to_non_nullable
                  as int,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeGoalImpl
    with DiagnosticableTreeMixin
    implements _ChallengeGoal {
  const _$ChallengeGoalImpl({
    required this.type,
    required this.target,
    required this.description,
  });

  factory _$ChallengeGoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeGoalImplFromJson(json);

  @override
  final String type;
  @override
  final int target;
  @override
  final String description;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChallengeGoal(type: $type, target: $target, description: $description)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChallengeGoal'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('target', target))
      ..add(DiagnosticsProperty('description', description));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeGoalImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, target, description);

  /// Create a copy of ChallengeGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeGoalImplCopyWith<_$ChallengeGoalImpl> get copyWith =>
      __$$ChallengeGoalImplCopyWithImpl<_$ChallengeGoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeGoalImplToJson(this);
  }
}

abstract class _ChallengeGoal implements ChallengeGoal {
  const factory _ChallengeGoal({
    required final String type,
    required final int target,
    required final String description,
  }) = _$ChallengeGoalImpl;

  factory _ChallengeGoal.fromJson(Map<String, dynamic> json) =
      _$ChallengeGoalImpl.fromJson;

  @override
  String get type;
  @override
  int get target;
  @override
  String get description;

  /// Create a copy of ChallengeGoal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeGoalImplCopyWith<_$ChallengeGoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChallengeParticipantModel _$ChallengeParticipantModelFromJson(
  Map<String, dynamic> json,
) {
  return _ChallengeParticipantModel.fromJson(json);
}

/// @nodoc
mixin _$ChallengeParticipantModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'challenge_id')
  String get challengeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;
  @JsonKey(name: 'joined_at')
  DateTime get joinedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this ChallengeParticipantModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChallengeParticipantModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeParticipantModelCopyWith<ChallengeParticipantModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeParticipantModelCopyWith<$Res> {
  factory $ChallengeParticipantModelCopyWith(
    ChallengeParticipantModel value,
    $Res Function(ChallengeParticipantModel) then,
  ) = _$ChallengeParticipantModelCopyWithImpl<$Res, ChallengeParticipantModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'challenge_id') String challengeId,
    @JsonKey(name: 'user_id') String userId,
    int progress,
    bool completed,
    @JsonKey(name: 'joined_at') DateTime joinedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
  });
}

/// @nodoc
class _$ChallengeParticipantModelCopyWithImpl<
  $Res,
  $Val extends ChallengeParticipantModel
>
    implements $ChallengeParticipantModelCopyWith<$Res> {
  _$ChallengeParticipantModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChallengeParticipantModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? challengeId = null,
    Object? userId = null,
    Object? progress = null,
    Object? completed = null,
    Object? joinedAt = null,
    Object? completedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            challengeId: null == challengeId
                ? _value.challengeId
                : challengeId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as int,
            completed: null == completed
                ? _value.completed
                : completed // ignore: cast_nullable_to_non_nullable
                      as bool,
            joinedAt: null == joinedAt
                ? _value.joinedAt
                : joinedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChallengeParticipantModelImplCopyWith<$Res>
    implements $ChallengeParticipantModelCopyWith<$Res> {
  factory _$$ChallengeParticipantModelImplCopyWith(
    _$ChallengeParticipantModelImpl value,
    $Res Function(_$ChallengeParticipantModelImpl) then,
  ) = __$$ChallengeParticipantModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'challenge_id') String challengeId,
    @JsonKey(name: 'user_id') String userId,
    int progress,
    bool completed,
    @JsonKey(name: 'joined_at') DateTime joinedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
  });
}

/// @nodoc
class __$$ChallengeParticipantModelImplCopyWithImpl<$Res>
    extends
        _$ChallengeParticipantModelCopyWithImpl<
          $Res,
          _$ChallengeParticipantModelImpl
        >
    implements _$$ChallengeParticipantModelImplCopyWith<$Res> {
  __$$ChallengeParticipantModelImplCopyWithImpl(
    _$ChallengeParticipantModelImpl _value,
    $Res Function(_$ChallengeParticipantModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChallengeParticipantModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? challengeId = null,
    Object? userId = null,
    Object? progress = null,
    Object? completed = null,
    Object? joinedAt = null,
    Object? completedAt = freezed,
  }) {
    return _then(
      _$ChallengeParticipantModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        challengeId: null == challengeId
            ? _value.challengeId
            : challengeId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as int,
        completed: null == completed
            ? _value.completed
            : completed // ignore: cast_nullable_to_non_nullable
                  as bool,
        joinedAt: null == joinedAt
            ? _value.joinedAt
            : joinedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeParticipantModelImpl
    with DiagnosticableTreeMixin
    implements _ChallengeParticipantModel {
  const _$ChallengeParticipantModelImpl({
    required this.id,
    @JsonKey(name: 'challenge_id') required this.challengeId,
    @JsonKey(name: 'user_id') required this.userId,
    required this.progress,
    required this.completed,
    @JsonKey(name: 'joined_at') required this.joinedAt,
    @JsonKey(name: 'completed_at') this.completedAt,
  });

  factory _$ChallengeParticipantModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeParticipantModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'challenge_id')
  final String challengeId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final int progress;
  @override
  final bool completed;
  @override
  @JsonKey(name: 'joined_at')
  final DateTime joinedAt;
  @override
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChallengeParticipantModel(id: $id, challengeId: $challengeId, userId: $userId, progress: $progress, completed: $completed, joinedAt: $joinedAt, completedAt: $completedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChallengeParticipantModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('challengeId', challengeId))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('progress', progress))
      ..add(DiagnosticsProperty('completed', completed))
      ..add(DiagnosticsProperty('joinedAt', joinedAt))
      ..add(DiagnosticsProperty('completedAt', completedAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeParticipantModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.challengeId, challengeId) ||
                other.challengeId == challengeId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    challengeId,
    userId,
    progress,
    completed,
    joinedAt,
    completedAt,
  );

  /// Create a copy of ChallengeParticipantModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeParticipantModelImplCopyWith<_$ChallengeParticipantModelImpl>
  get copyWith =>
      __$$ChallengeParticipantModelImplCopyWithImpl<
        _$ChallengeParticipantModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeParticipantModelImplToJson(this);
  }
}

abstract class _ChallengeParticipantModel implements ChallengeParticipantModel {
  const factory _ChallengeParticipantModel({
    required final String id,
    @JsonKey(name: 'challenge_id') required final String challengeId,
    @JsonKey(name: 'user_id') required final String userId,
    required final int progress,
    required final bool completed,
    @JsonKey(name: 'joined_at') required final DateTime joinedAt,
    @JsonKey(name: 'completed_at') final DateTime? completedAt,
  }) = _$ChallengeParticipantModelImpl;

  factory _ChallengeParticipantModel.fromJson(Map<String, dynamic> json) =
      _$ChallengeParticipantModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'challenge_id')
  String get challengeId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  int get progress;
  @override
  bool get completed;
  @override
  @JsonKey(name: 'joined_at')
  DateTime get joinedAt;
  @override
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt;

  /// Create a copy of ChallengeParticipantModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeParticipantModelImplCopyWith<_$ChallengeParticipantModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ChallengeProgressModel _$ChallengeProgressModelFromJson(
  Map<String, dynamic> json,
) {
  return _ChallengeProgressModel.fromJson(json);
}

/// @nodoc
mixin _$ChallengeProgressModel {
  @JsonKey(name: 'challenge_id')
  String get challengeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'challenge_title')
  String get challengeTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'challenge_emoji')
  String get challengeEmoji => throw _privateConstructorUsedError;
  Map<String, dynamic> get goal => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;
  int get target => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;
  int? get rank => throw _privateConstructorUsedError;
  @JsonKey(name: 'joined_at')
  DateTime get joinedAt => throw _privateConstructorUsedError;

  /// Serializes this ChallengeProgressModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChallengeProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeProgressModelCopyWith<ChallengeProgressModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeProgressModelCopyWith<$Res> {
  factory $ChallengeProgressModelCopyWith(
    ChallengeProgressModel value,
    $Res Function(ChallengeProgressModel) then,
  ) = _$ChallengeProgressModelCopyWithImpl<$Res, ChallengeProgressModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'challenge_id') String challengeId,
    @JsonKey(name: 'challenge_title') String challengeTitle,
    @JsonKey(name: 'challenge_emoji') String challengeEmoji,
    Map<String, dynamic> goal,
    int progress,
    int target,
    bool completed,
    double percentage,
    int? rank,
    @JsonKey(name: 'joined_at') DateTime joinedAt,
  });
}

/// @nodoc
class _$ChallengeProgressModelCopyWithImpl<
  $Res,
  $Val extends ChallengeProgressModel
>
    implements $ChallengeProgressModelCopyWith<$Res> {
  _$ChallengeProgressModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChallengeProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? challengeId = null,
    Object? challengeTitle = null,
    Object? challengeEmoji = null,
    Object? goal = null,
    Object? progress = null,
    Object? target = null,
    Object? completed = null,
    Object? percentage = null,
    Object? rank = freezed,
    Object? joinedAt = null,
  }) {
    return _then(
      _value.copyWith(
            challengeId: null == challengeId
                ? _value.challengeId
                : challengeId // ignore: cast_nullable_to_non_nullable
                      as String,
            challengeTitle: null == challengeTitle
                ? _value.challengeTitle
                : challengeTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            challengeEmoji: null == challengeEmoji
                ? _value.challengeEmoji
                : challengeEmoji // ignore: cast_nullable_to_non_nullable
                      as String,
            goal: null == goal
                ? _value.goal
                : goal // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as int,
            target: null == target
                ? _value.target
                : target // ignore: cast_nullable_to_non_nullable
                      as int,
            completed: null == completed
                ? _value.completed
                : completed // ignore: cast_nullable_to_non_nullable
                      as bool,
            percentage: null == percentage
                ? _value.percentage
                : percentage // ignore: cast_nullable_to_non_nullable
                      as double,
            rank: freezed == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int?,
            joinedAt: null == joinedAt
                ? _value.joinedAt
                : joinedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChallengeProgressModelImplCopyWith<$Res>
    implements $ChallengeProgressModelCopyWith<$Res> {
  factory _$$ChallengeProgressModelImplCopyWith(
    _$ChallengeProgressModelImpl value,
    $Res Function(_$ChallengeProgressModelImpl) then,
  ) = __$$ChallengeProgressModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'challenge_id') String challengeId,
    @JsonKey(name: 'challenge_title') String challengeTitle,
    @JsonKey(name: 'challenge_emoji') String challengeEmoji,
    Map<String, dynamic> goal,
    int progress,
    int target,
    bool completed,
    double percentage,
    int? rank,
    @JsonKey(name: 'joined_at') DateTime joinedAt,
  });
}

/// @nodoc
class __$$ChallengeProgressModelImplCopyWithImpl<$Res>
    extends
        _$ChallengeProgressModelCopyWithImpl<$Res, _$ChallengeProgressModelImpl>
    implements _$$ChallengeProgressModelImplCopyWith<$Res> {
  __$$ChallengeProgressModelImplCopyWithImpl(
    _$ChallengeProgressModelImpl _value,
    $Res Function(_$ChallengeProgressModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChallengeProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? challengeId = null,
    Object? challengeTitle = null,
    Object? challengeEmoji = null,
    Object? goal = null,
    Object? progress = null,
    Object? target = null,
    Object? completed = null,
    Object? percentage = null,
    Object? rank = freezed,
    Object? joinedAt = null,
  }) {
    return _then(
      _$ChallengeProgressModelImpl(
        challengeId: null == challengeId
            ? _value.challengeId
            : challengeId // ignore: cast_nullable_to_non_nullable
                  as String,
        challengeTitle: null == challengeTitle
            ? _value.challengeTitle
            : challengeTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        challengeEmoji: null == challengeEmoji
            ? _value.challengeEmoji
            : challengeEmoji // ignore: cast_nullable_to_non_nullable
                  as String,
        goal: null == goal
            ? _value._goal
            : goal // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as int,
        target: null == target
            ? _value.target
            : target // ignore: cast_nullable_to_non_nullable
                  as int,
        completed: null == completed
            ? _value.completed
            : completed // ignore: cast_nullable_to_non_nullable
                  as bool,
        percentage: null == percentage
            ? _value.percentage
            : percentage // ignore: cast_nullable_to_non_nullable
                  as double,
        rank: freezed == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int?,
        joinedAt: null == joinedAt
            ? _value.joinedAt
            : joinedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeProgressModelImpl
    with DiagnosticableTreeMixin
    implements _ChallengeProgressModel {
  const _$ChallengeProgressModelImpl({
    @JsonKey(name: 'challenge_id') required this.challengeId,
    @JsonKey(name: 'challenge_title') required this.challengeTitle,
    @JsonKey(name: 'challenge_emoji') required this.challengeEmoji,
    required final Map<String, dynamic> goal,
    required this.progress,
    required this.target,
    required this.completed,
    required this.percentage,
    this.rank,
    @JsonKey(name: 'joined_at') required this.joinedAt,
  }) : _goal = goal;

  factory _$ChallengeProgressModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeProgressModelImplFromJson(json);

  @override
  @JsonKey(name: 'challenge_id')
  final String challengeId;
  @override
  @JsonKey(name: 'challenge_title')
  final String challengeTitle;
  @override
  @JsonKey(name: 'challenge_emoji')
  final String challengeEmoji;
  final Map<String, dynamic> _goal;
  @override
  Map<String, dynamic> get goal {
    if (_goal is EqualUnmodifiableMapView) return _goal;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_goal);
  }

  @override
  final int progress;
  @override
  final int target;
  @override
  final bool completed;
  @override
  final double percentage;
  @override
  final int? rank;
  @override
  @JsonKey(name: 'joined_at')
  final DateTime joinedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChallengeProgressModel(challengeId: $challengeId, challengeTitle: $challengeTitle, challengeEmoji: $challengeEmoji, goal: $goal, progress: $progress, target: $target, completed: $completed, percentage: $percentage, rank: $rank, joinedAt: $joinedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChallengeProgressModel'))
      ..add(DiagnosticsProperty('challengeId', challengeId))
      ..add(DiagnosticsProperty('challengeTitle', challengeTitle))
      ..add(DiagnosticsProperty('challengeEmoji', challengeEmoji))
      ..add(DiagnosticsProperty('goal', goal))
      ..add(DiagnosticsProperty('progress', progress))
      ..add(DiagnosticsProperty('target', target))
      ..add(DiagnosticsProperty('completed', completed))
      ..add(DiagnosticsProperty('percentage', percentage))
      ..add(DiagnosticsProperty('rank', rank))
      ..add(DiagnosticsProperty('joinedAt', joinedAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeProgressModelImpl &&
            (identical(other.challengeId, challengeId) ||
                other.challengeId == challengeId) &&
            (identical(other.challengeTitle, challengeTitle) ||
                other.challengeTitle == challengeTitle) &&
            (identical(other.challengeEmoji, challengeEmoji) ||
                other.challengeEmoji == challengeEmoji) &&
            const DeepCollectionEquality().equals(other._goal, _goal) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    challengeId,
    challengeTitle,
    challengeEmoji,
    const DeepCollectionEquality().hash(_goal),
    progress,
    target,
    completed,
    percentage,
    rank,
    joinedAt,
  );

  /// Create a copy of ChallengeProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeProgressModelImplCopyWith<_$ChallengeProgressModelImpl>
  get copyWith =>
      __$$ChallengeProgressModelImplCopyWithImpl<_$ChallengeProgressModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeProgressModelImplToJson(this);
  }
}

abstract class _ChallengeProgressModel implements ChallengeProgressModel {
  const factory _ChallengeProgressModel({
    @JsonKey(name: 'challenge_id') required final String challengeId,
    @JsonKey(name: 'challenge_title') required final String challengeTitle,
    @JsonKey(name: 'challenge_emoji') required final String challengeEmoji,
    required final Map<String, dynamic> goal,
    required final int progress,
    required final int target,
    required final bool completed,
    required final double percentage,
    final int? rank,
    @JsonKey(name: 'joined_at') required final DateTime joinedAt,
  }) = _$ChallengeProgressModelImpl;

  factory _ChallengeProgressModel.fromJson(Map<String, dynamic> json) =
      _$ChallengeProgressModelImpl.fromJson;

  @override
  @JsonKey(name: 'challenge_id')
  String get challengeId;
  @override
  @JsonKey(name: 'challenge_title')
  String get challengeTitle;
  @override
  @JsonKey(name: 'challenge_emoji')
  String get challengeEmoji;
  @override
  Map<String, dynamic> get goal;
  @override
  int get progress;
  @override
  int get target;
  @override
  bool get completed;
  @override
  double get percentage;
  @override
  int? get rank;
  @override
  @JsonKey(name: 'joined_at')
  DateTime get joinedAt;

  /// Create a copy of ChallengeProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeProgressModelImplCopyWith<_$ChallengeProgressModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

LeaderboardEntry _$LeaderboardEntryFromJson(Map<String, dynamic> json) {
  return _LeaderboardEntry.fromJson(json);
}

/// @nodoc
mixin _$LeaderboardEntry {
  int get rank => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;

  /// Serializes this LeaderboardEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaderboardEntryCopyWith<LeaderboardEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardEntryCopyWith<$Res> {
  factory $LeaderboardEntryCopyWith(
    LeaderboardEntry value,
    $Res Function(LeaderboardEntry) then,
  ) = _$LeaderboardEntryCopyWithImpl<$Res, LeaderboardEntry>;
  @useResult
  $Res call({
    int rank,
    @JsonKey(name: 'user_id') String userId,
    String? username,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    int progress,
    bool completed,
    double percentage,
  });
}

/// @nodoc
class _$LeaderboardEntryCopyWithImpl<$Res, $Val extends LeaderboardEntry>
    implements $LeaderboardEntryCopyWith<$Res> {
  _$LeaderboardEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rank = null,
    Object? userId = null,
    Object? username = freezed,
    Object? avatarUrl = freezed,
    Object? progress = null,
    Object? completed = null,
    Object? percentage = null,
  }) {
    return _then(
      _value.copyWith(
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as int,
            completed: null == completed
                ? _value.completed
                : completed // ignore: cast_nullable_to_non_nullable
                      as bool,
            percentage: null == percentage
                ? _value.percentage
                : percentage // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LeaderboardEntryImplCopyWith<$Res>
    implements $LeaderboardEntryCopyWith<$Res> {
  factory _$$LeaderboardEntryImplCopyWith(
    _$LeaderboardEntryImpl value,
    $Res Function(_$LeaderboardEntryImpl) then,
  ) = __$$LeaderboardEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int rank,
    @JsonKey(name: 'user_id') String userId,
    String? username,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    int progress,
    bool completed,
    double percentage,
  });
}

/// @nodoc
class __$$LeaderboardEntryImplCopyWithImpl<$Res>
    extends _$LeaderboardEntryCopyWithImpl<$Res, _$LeaderboardEntryImpl>
    implements _$$LeaderboardEntryImplCopyWith<$Res> {
  __$$LeaderboardEntryImplCopyWithImpl(
    _$LeaderboardEntryImpl _value,
    $Res Function(_$LeaderboardEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rank = null,
    Object? userId = null,
    Object? username = freezed,
    Object? avatarUrl = freezed,
    Object? progress = null,
    Object? completed = null,
    Object? percentage = null,
  }) {
    return _then(
      _$LeaderboardEntryImpl(
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as int,
        completed: null == completed
            ? _value.completed
            : completed // ignore: cast_nullable_to_non_nullable
                  as bool,
        percentage: null == percentage
            ? _value.percentage
            : percentage // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaderboardEntryImpl
    with DiagnosticableTreeMixin
    implements _LeaderboardEntry {
  const _$LeaderboardEntryImpl({
    required this.rank,
    @JsonKey(name: 'user_id') required this.userId,
    this.username,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    required this.progress,
    required this.completed,
    required this.percentage,
  });

  factory _$LeaderboardEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaderboardEntryImplFromJson(json);

  @override
  final int rank;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String? username;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  final int progress;
  @override
  final bool completed;
  @override
  final double percentage;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LeaderboardEntry(rank: $rank, userId: $userId, username: $username, avatarUrl: $avatarUrl, progress: $progress, completed: $completed, percentage: $percentage)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LeaderboardEntry'))
      ..add(DiagnosticsProperty('rank', rank))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('avatarUrl', avatarUrl))
      ..add(DiagnosticsProperty('progress', progress))
      ..add(DiagnosticsProperty('completed', completed))
      ..add(DiagnosticsProperty('percentage', percentage));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardEntryImpl &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    rank,
    userId,
    username,
    avatarUrl,
    progress,
    completed,
    percentage,
  );

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardEntryImplCopyWith<_$LeaderboardEntryImpl> get copyWith =>
      __$$LeaderboardEntryImplCopyWithImpl<_$LeaderboardEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaderboardEntryImplToJson(this);
  }
}

abstract class _LeaderboardEntry implements LeaderboardEntry {
  const factory _LeaderboardEntry({
    required final int rank,
    @JsonKey(name: 'user_id') required final String userId,
    final String? username,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    required final int progress,
    required final bool completed,
    required final double percentage,
  }) = _$LeaderboardEntryImpl;

  factory _LeaderboardEntry.fromJson(Map<String, dynamic> json) =
      _$LeaderboardEntryImpl.fromJson;

  @override
  int get rank;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String? get username;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  int get progress;
  @override
  bool get completed;
  @override
  double get percentage;

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaderboardEntryImplCopyWith<_$LeaderboardEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChallengeLeaderboard _$ChallengeLeaderboardFromJson(Map<String, dynamic> json) {
  return _ChallengeLeaderboard.fromJson(json);
}

/// @nodoc
mixin _$ChallengeLeaderboard {
  @JsonKey(name: 'challenge_id')
  String get challengeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'challenge_title')
  String get challengeTitle => throw _privateConstructorUsedError;
  List<LeaderboardEntry> get entries => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_participants')
  int get totalParticipants => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_rank')
  int? get userRank => throw _privateConstructorUsedError;

  /// Serializes this ChallengeLeaderboard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChallengeLeaderboard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeLeaderboardCopyWith<ChallengeLeaderboard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeLeaderboardCopyWith<$Res> {
  factory $ChallengeLeaderboardCopyWith(
    ChallengeLeaderboard value,
    $Res Function(ChallengeLeaderboard) then,
  ) = _$ChallengeLeaderboardCopyWithImpl<$Res, ChallengeLeaderboard>;
  @useResult
  $Res call({
    @JsonKey(name: 'challenge_id') String challengeId,
    @JsonKey(name: 'challenge_title') String challengeTitle,
    List<LeaderboardEntry> entries,
    @JsonKey(name: 'total_participants') int totalParticipants,
    @JsonKey(name: 'user_rank') int? userRank,
  });
}

/// @nodoc
class _$ChallengeLeaderboardCopyWithImpl<
  $Res,
  $Val extends ChallengeLeaderboard
>
    implements $ChallengeLeaderboardCopyWith<$Res> {
  _$ChallengeLeaderboardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChallengeLeaderboard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? challengeId = null,
    Object? challengeTitle = null,
    Object? entries = null,
    Object? totalParticipants = null,
    Object? userRank = freezed,
  }) {
    return _then(
      _value.copyWith(
            challengeId: null == challengeId
                ? _value.challengeId
                : challengeId // ignore: cast_nullable_to_non_nullable
                      as String,
            challengeTitle: null == challengeTitle
                ? _value.challengeTitle
                : challengeTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            entries: null == entries
                ? _value.entries
                : entries // ignore: cast_nullable_to_non_nullable
                      as List<LeaderboardEntry>,
            totalParticipants: null == totalParticipants
                ? _value.totalParticipants
                : totalParticipants // ignore: cast_nullable_to_non_nullable
                      as int,
            userRank: freezed == userRank
                ? _value.userRank
                : userRank // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChallengeLeaderboardImplCopyWith<$Res>
    implements $ChallengeLeaderboardCopyWith<$Res> {
  factory _$$ChallengeLeaderboardImplCopyWith(
    _$ChallengeLeaderboardImpl value,
    $Res Function(_$ChallengeLeaderboardImpl) then,
  ) = __$$ChallengeLeaderboardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'challenge_id') String challengeId,
    @JsonKey(name: 'challenge_title') String challengeTitle,
    List<LeaderboardEntry> entries,
    @JsonKey(name: 'total_participants') int totalParticipants,
    @JsonKey(name: 'user_rank') int? userRank,
  });
}

/// @nodoc
class __$$ChallengeLeaderboardImplCopyWithImpl<$Res>
    extends _$ChallengeLeaderboardCopyWithImpl<$Res, _$ChallengeLeaderboardImpl>
    implements _$$ChallengeLeaderboardImplCopyWith<$Res> {
  __$$ChallengeLeaderboardImplCopyWithImpl(
    _$ChallengeLeaderboardImpl _value,
    $Res Function(_$ChallengeLeaderboardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChallengeLeaderboard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? challengeId = null,
    Object? challengeTitle = null,
    Object? entries = null,
    Object? totalParticipants = null,
    Object? userRank = freezed,
  }) {
    return _then(
      _$ChallengeLeaderboardImpl(
        challengeId: null == challengeId
            ? _value.challengeId
            : challengeId // ignore: cast_nullable_to_non_nullable
                  as String,
        challengeTitle: null == challengeTitle
            ? _value.challengeTitle
            : challengeTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        entries: null == entries
            ? _value._entries
            : entries // ignore: cast_nullable_to_non_nullable
                  as List<LeaderboardEntry>,
        totalParticipants: null == totalParticipants
            ? _value.totalParticipants
            : totalParticipants // ignore: cast_nullable_to_non_nullable
                  as int,
        userRank: freezed == userRank
            ? _value.userRank
            : userRank // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeLeaderboardImpl
    with DiagnosticableTreeMixin
    implements _ChallengeLeaderboard {
  const _$ChallengeLeaderboardImpl({
    @JsonKey(name: 'challenge_id') required this.challengeId,
    @JsonKey(name: 'challenge_title') required this.challengeTitle,
    required final List<LeaderboardEntry> entries,
    @JsonKey(name: 'total_participants') required this.totalParticipants,
    @JsonKey(name: 'user_rank') this.userRank,
  }) : _entries = entries;

  factory _$ChallengeLeaderboardImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeLeaderboardImplFromJson(json);

  @override
  @JsonKey(name: 'challenge_id')
  final String challengeId;
  @override
  @JsonKey(name: 'challenge_title')
  final String challengeTitle;
  final List<LeaderboardEntry> _entries;
  @override
  List<LeaderboardEntry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  @JsonKey(name: 'total_participants')
  final int totalParticipants;
  @override
  @JsonKey(name: 'user_rank')
  final int? userRank;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChallengeLeaderboard(challengeId: $challengeId, challengeTitle: $challengeTitle, entries: $entries, totalParticipants: $totalParticipants, userRank: $userRank)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChallengeLeaderboard'))
      ..add(DiagnosticsProperty('challengeId', challengeId))
      ..add(DiagnosticsProperty('challengeTitle', challengeTitle))
      ..add(DiagnosticsProperty('entries', entries))
      ..add(DiagnosticsProperty('totalParticipants', totalParticipants))
      ..add(DiagnosticsProperty('userRank', userRank));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeLeaderboardImpl &&
            (identical(other.challengeId, challengeId) ||
                other.challengeId == challengeId) &&
            (identical(other.challengeTitle, challengeTitle) ||
                other.challengeTitle == challengeTitle) &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            (identical(other.totalParticipants, totalParticipants) ||
                other.totalParticipants == totalParticipants) &&
            (identical(other.userRank, userRank) ||
                other.userRank == userRank));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    challengeId,
    challengeTitle,
    const DeepCollectionEquality().hash(_entries),
    totalParticipants,
    userRank,
  );

  /// Create a copy of ChallengeLeaderboard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeLeaderboardImplCopyWith<_$ChallengeLeaderboardImpl>
  get copyWith =>
      __$$ChallengeLeaderboardImplCopyWithImpl<_$ChallengeLeaderboardImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeLeaderboardImplToJson(this);
  }
}

abstract class _ChallengeLeaderboard implements ChallengeLeaderboard {
  const factory _ChallengeLeaderboard({
    @JsonKey(name: 'challenge_id') required final String challengeId,
    @JsonKey(name: 'challenge_title') required final String challengeTitle,
    required final List<LeaderboardEntry> entries,
    @JsonKey(name: 'total_participants') required final int totalParticipants,
    @JsonKey(name: 'user_rank') final int? userRank,
  }) = _$ChallengeLeaderboardImpl;

  factory _ChallengeLeaderboard.fromJson(Map<String, dynamic> json) =
      _$ChallengeLeaderboardImpl.fromJson;

  @override
  @JsonKey(name: 'challenge_id')
  String get challengeId;
  @override
  @JsonKey(name: 'challenge_title')
  String get challengeTitle;
  @override
  List<LeaderboardEntry> get entries;
  @override
  @JsonKey(name: 'total_participants')
  int get totalParticipants;
  @override
  @JsonKey(name: 'user_rank')
  int? get userRank;

  /// Create a copy of ChallengeLeaderboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeLeaderboardImplCopyWith<_$ChallengeLeaderboardImpl>
  get copyWith => throw _privateConstructorUsedError;
}
