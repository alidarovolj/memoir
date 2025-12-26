// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achievement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AchievementProgress _$AchievementProgressFromJson(Map<String, dynamic> json) {
  return _AchievementProgress.fromJson(json);
}

/// @nodoc
mixin _$AchievementProgress {
  @JsonKey(name: 'achievement_id')
  String get achievementId => throw _privateConstructorUsedError;
  @JsonKey(name: 'achievement_code')
  String get achievementCode => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get emoji => throw _privateConstructorUsedError;
  @JsonKey(name: 'achievement_type')
  String get achievementType => throw _privateConstructorUsedError;
  @JsonKey(name: 'criteria_count')
  int get criteriaCount => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;
  bool get unlocked => throw _privateConstructorUsedError;
  @JsonKey(name: 'unlocked_at')
  DateTime? get unlockedAt => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'xp_reward')
  int get xpReward => throw _privateConstructorUsedError;

  /// Serializes this AchievementProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AchievementProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AchievementProgressCopyWith<AchievementProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementProgressCopyWith<$Res> {
  factory $AchievementProgressCopyWith(
    AchievementProgress value,
    $Res Function(AchievementProgress) then,
  ) = _$AchievementProgressCopyWithImpl<$Res, AchievementProgress>;
  @useResult
  $Res call({
    @JsonKey(name: 'achievement_id') String achievementId,
    @JsonKey(name: 'achievement_code') String achievementCode,
    String title,
    String description,
    String emoji,
    @JsonKey(name: 'achievement_type') String achievementType,
    @JsonKey(name: 'criteria_count') int criteriaCount,
    int progress,
    bool unlocked,
    @JsonKey(name: 'unlocked_at') DateTime? unlockedAt,
    double percentage,
    @JsonKey(name: 'xp_reward') int xpReward,
  });
}

/// @nodoc
class _$AchievementProgressCopyWithImpl<$Res, $Val extends AchievementProgress>
    implements $AchievementProgressCopyWith<$Res> {
  _$AchievementProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AchievementProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? achievementId = null,
    Object? achievementCode = null,
    Object? title = null,
    Object? description = null,
    Object? emoji = null,
    Object? achievementType = null,
    Object? criteriaCount = null,
    Object? progress = null,
    Object? unlocked = null,
    Object? unlockedAt = freezed,
    Object? percentage = null,
    Object? xpReward = null,
  }) {
    return _then(
      _value.copyWith(
            achievementId: null == achievementId
                ? _value.achievementId
                : achievementId // ignore: cast_nullable_to_non_nullable
                      as String,
            achievementCode: null == achievementCode
                ? _value.achievementCode
                : achievementCode // ignore: cast_nullable_to_non_nullable
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
            achievementType: null == achievementType
                ? _value.achievementType
                : achievementType // ignore: cast_nullable_to_non_nullable
                      as String,
            criteriaCount: null == criteriaCount
                ? _value.criteriaCount
                : criteriaCount // ignore: cast_nullable_to_non_nullable
                      as int,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as int,
            unlocked: null == unlocked
                ? _value.unlocked
                : unlocked // ignore: cast_nullable_to_non_nullable
                      as bool,
            unlockedAt: freezed == unlockedAt
                ? _value.unlockedAt
                : unlockedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            percentage: null == percentage
                ? _value.percentage
                : percentage // ignore: cast_nullable_to_non_nullable
                      as double,
            xpReward: null == xpReward
                ? _value.xpReward
                : xpReward // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AchievementProgressImplCopyWith<$Res>
    implements $AchievementProgressCopyWith<$Res> {
  factory _$$AchievementProgressImplCopyWith(
    _$AchievementProgressImpl value,
    $Res Function(_$AchievementProgressImpl) then,
  ) = __$$AchievementProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'achievement_id') String achievementId,
    @JsonKey(name: 'achievement_code') String achievementCode,
    String title,
    String description,
    String emoji,
    @JsonKey(name: 'achievement_type') String achievementType,
    @JsonKey(name: 'criteria_count') int criteriaCount,
    int progress,
    bool unlocked,
    @JsonKey(name: 'unlocked_at') DateTime? unlockedAt,
    double percentage,
    @JsonKey(name: 'xp_reward') int xpReward,
  });
}

/// @nodoc
class __$$AchievementProgressImplCopyWithImpl<$Res>
    extends _$AchievementProgressCopyWithImpl<$Res, _$AchievementProgressImpl>
    implements _$$AchievementProgressImplCopyWith<$Res> {
  __$$AchievementProgressImplCopyWithImpl(
    _$AchievementProgressImpl _value,
    $Res Function(_$AchievementProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AchievementProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? achievementId = null,
    Object? achievementCode = null,
    Object? title = null,
    Object? description = null,
    Object? emoji = null,
    Object? achievementType = null,
    Object? criteriaCount = null,
    Object? progress = null,
    Object? unlocked = null,
    Object? unlockedAt = freezed,
    Object? percentage = null,
    Object? xpReward = null,
  }) {
    return _then(
      _$AchievementProgressImpl(
        achievementId: null == achievementId
            ? _value.achievementId
            : achievementId // ignore: cast_nullable_to_non_nullable
                  as String,
        achievementCode: null == achievementCode
            ? _value.achievementCode
            : achievementCode // ignore: cast_nullable_to_non_nullable
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
        achievementType: null == achievementType
            ? _value.achievementType
            : achievementType // ignore: cast_nullable_to_non_nullable
                  as String,
        criteriaCount: null == criteriaCount
            ? _value.criteriaCount
            : criteriaCount // ignore: cast_nullable_to_non_nullable
                  as int,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as int,
        unlocked: null == unlocked
            ? _value.unlocked
            : unlocked // ignore: cast_nullable_to_non_nullable
                  as bool,
        unlockedAt: freezed == unlockedAt
            ? _value.unlockedAt
            : unlockedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        percentage: null == percentage
            ? _value.percentage
            : percentage // ignore: cast_nullable_to_non_nullable
                  as double,
        xpReward: null == xpReward
            ? _value.xpReward
            : xpReward // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AchievementProgressImpl
    with DiagnosticableTreeMixin
    implements _AchievementProgress {
  const _$AchievementProgressImpl({
    @JsonKey(name: 'achievement_id') required this.achievementId,
    @JsonKey(name: 'achievement_code') required this.achievementCode,
    required this.title,
    required this.description,
    required this.emoji,
    @JsonKey(name: 'achievement_type') required this.achievementType,
    @JsonKey(name: 'criteria_count') required this.criteriaCount,
    required this.progress,
    required this.unlocked,
    @JsonKey(name: 'unlocked_at') this.unlockedAt,
    required this.percentage,
    @JsonKey(name: 'xp_reward') required this.xpReward,
  });

  factory _$AchievementProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$AchievementProgressImplFromJson(json);

  @override
  @JsonKey(name: 'achievement_id')
  final String achievementId;
  @override
  @JsonKey(name: 'achievement_code')
  final String achievementCode;
  @override
  final String title;
  @override
  final String description;
  @override
  final String emoji;
  @override
  @JsonKey(name: 'achievement_type')
  final String achievementType;
  @override
  @JsonKey(name: 'criteria_count')
  final int criteriaCount;
  @override
  final int progress;
  @override
  final bool unlocked;
  @override
  @JsonKey(name: 'unlocked_at')
  final DateTime? unlockedAt;
  @override
  final double percentage;
  @override
  @JsonKey(name: 'xp_reward')
  final int xpReward;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AchievementProgress(achievementId: $achievementId, achievementCode: $achievementCode, title: $title, description: $description, emoji: $emoji, achievementType: $achievementType, criteriaCount: $criteriaCount, progress: $progress, unlocked: $unlocked, unlockedAt: $unlockedAt, percentage: $percentage, xpReward: $xpReward)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AchievementProgress'))
      ..add(DiagnosticsProperty('achievementId', achievementId))
      ..add(DiagnosticsProperty('achievementCode', achievementCode))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('emoji', emoji))
      ..add(DiagnosticsProperty('achievementType', achievementType))
      ..add(DiagnosticsProperty('criteriaCount', criteriaCount))
      ..add(DiagnosticsProperty('progress', progress))
      ..add(DiagnosticsProperty('unlocked', unlocked))
      ..add(DiagnosticsProperty('unlockedAt', unlockedAt))
      ..add(DiagnosticsProperty('percentage', percentage))
      ..add(DiagnosticsProperty('xpReward', xpReward));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementProgressImpl &&
            (identical(other.achievementId, achievementId) ||
                other.achievementId == achievementId) &&
            (identical(other.achievementCode, achievementCode) ||
                other.achievementCode == achievementCode) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.achievementType, achievementType) ||
                other.achievementType == achievementType) &&
            (identical(other.criteriaCount, criteriaCount) ||
                other.criteriaCount == criteriaCount) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.unlocked, unlocked) ||
                other.unlocked == unlocked) &&
            (identical(other.unlockedAt, unlockedAt) ||
                other.unlockedAt == unlockedAt) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.xpReward, xpReward) ||
                other.xpReward == xpReward));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    achievementId,
    achievementCode,
    title,
    description,
    emoji,
    achievementType,
    criteriaCount,
    progress,
    unlocked,
    unlockedAt,
    percentage,
    xpReward,
  );

  /// Create a copy of AchievementProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementProgressImplCopyWith<_$AchievementProgressImpl> get copyWith =>
      __$$AchievementProgressImplCopyWithImpl<_$AchievementProgressImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AchievementProgressImplToJson(this);
  }
}

abstract class _AchievementProgress implements AchievementProgress {
  const factory _AchievementProgress({
    @JsonKey(name: 'achievement_id') required final String achievementId,
    @JsonKey(name: 'achievement_code') required final String achievementCode,
    required final String title,
    required final String description,
    required final String emoji,
    @JsonKey(name: 'achievement_type') required final String achievementType,
    @JsonKey(name: 'criteria_count') required final int criteriaCount,
    required final int progress,
    required final bool unlocked,
    @JsonKey(name: 'unlocked_at') final DateTime? unlockedAt,
    required final double percentage,
    @JsonKey(name: 'xp_reward') required final int xpReward,
  }) = _$AchievementProgressImpl;

  factory _AchievementProgress.fromJson(Map<String, dynamic> json) =
      _$AchievementProgressImpl.fromJson;

  @override
  @JsonKey(name: 'achievement_id')
  String get achievementId;
  @override
  @JsonKey(name: 'achievement_code')
  String get achievementCode;
  @override
  String get title;
  @override
  String get description;
  @override
  String get emoji;
  @override
  @JsonKey(name: 'achievement_type')
  String get achievementType;
  @override
  @JsonKey(name: 'criteria_count')
  int get criteriaCount;
  @override
  int get progress;
  @override
  bool get unlocked;
  @override
  @JsonKey(name: 'unlocked_at')
  DateTime? get unlockedAt;
  @override
  double get percentage;
  @override
  @JsonKey(name: 'xp_reward')
  int get xpReward;

  /// Create a copy of AchievementProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AchievementProgressImplCopyWith<_$AchievementProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AchievementList _$AchievementListFromJson(Map<String, dynamic> json) {
  return _AchievementList.fromJson(json);
}

/// @nodoc
mixin _$AchievementList {
  List<AchievementProgress> get unlocked => throw _privateConstructorUsedError;
  @JsonKey(name: 'in_progress')
  List<AchievementProgress> get inProgress =>
      throw _privateConstructorUsedError;
  List<AchievementProgress> get locked => throw _privateConstructorUsedError;

  /// Serializes this AchievementList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AchievementList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AchievementListCopyWith<AchievementList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementListCopyWith<$Res> {
  factory $AchievementListCopyWith(
    AchievementList value,
    $Res Function(AchievementList) then,
  ) = _$AchievementListCopyWithImpl<$Res, AchievementList>;
  @useResult
  $Res call({
    List<AchievementProgress> unlocked,
    @JsonKey(name: 'in_progress') List<AchievementProgress> inProgress,
    List<AchievementProgress> locked,
  });
}

/// @nodoc
class _$AchievementListCopyWithImpl<$Res, $Val extends AchievementList>
    implements $AchievementListCopyWith<$Res> {
  _$AchievementListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AchievementList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unlocked = null,
    Object? inProgress = null,
    Object? locked = null,
  }) {
    return _then(
      _value.copyWith(
            unlocked: null == unlocked
                ? _value.unlocked
                : unlocked // ignore: cast_nullable_to_non_nullable
                      as List<AchievementProgress>,
            inProgress: null == inProgress
                ? _value.inProgress
                : inProgress // ignore: cast_nullable_to_non_nullable
                      as List<AchievementProgress>,
            locked: null == locked
                ? _value.locked
                : locked // ignore: cast_nullable_to_non_nullable
                      as List<AchievementProgress>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AchievementListImplCopyWith<$Res>
    implements $AchievementListCopyWith<$Res> {
  factory _$$AchievementListImplCopyWith(
    _$AchievementListImpl value,
    $Res Function(_$AchievementListImpl) then,
  ) = __$$AchievementListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<AchievementProgress> unlocked,
    @JsonKey(name: 'in_progress') List<AchievementProgress> inProgress,
    List<AchievementProgress> locked,
  });
}

/// @nodoc
class __$$AchievementListImplCopyWithImpl<$Res>
    extends _$AchievementListCopyWithImpl<$Res, _$AchievementListImpl>
    implements _$$AchievementListImplCopyWith<$Res> {
  __$$AchievementListImplCopyWithImpl(
    _$AchievementListImpl _value,
    $Res Function(_$AchievementListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AchievementList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unlocked = null,
    Object? inProgress = null,
    Object? locked = null,
  }) {
    return _then(
      _$AchievementListImpl(
        unlocked: null == unlocked
            ? _value._unlocked
            : unlocked // ignore: cast_nullable_to_non_nullable
                  as List<AchievementProgress>,
        inProgress: null == inProgress
            ? _value._inProgress
            : inProgress // ignore: cast_nullable_to_non_nullable
                  as List<AchievementProgress>,
        locked: null == locked
            ? _value._locked
            : locked // ignore: cast_nullable_to_non_nullable
                  as List<AchievementProgress>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AchievementListImpl
    with DiagnosticableTreeMixin
    implements _AchievementList {
  const _$AchievementListImpl({
    required final List<AchievementProgress> unlocked,
    @JsonKey(name: 'in_progress')
    required final List<AchievementProgress> inProgress,
    required final List<AchievementProgress> locked,
  }) : _unlocked = unlocked,
       _inProgress = inProgress,
       _locked = locked;

  factory _$AchievementListImpl.fromJson(Map<String, dynamic> json) =>
      _$$AchievementListImplFromJson(json);

  final List<AchievementProgress> _unlocked;
  @override
  List<AchievementProgress> get unlocked {
    if (_unlocked is EqualUnmodifiableListView) return _unlocked;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unlocked);
  }

  final List<AchievementProgress> _inProgress;
  @override
  @JsonKey(name: 'in_progress')
  List<AchievementProgress> get inProgress {
    if (_inProgress is EqualUnmodifiableListView) return _inProgress;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inProgress);
  }

  final List<AchievementProgress> _locked;
  @override
  List<AchievementProgress> get locked {
    if (_locked is EqualUnmodifiableListView) return _locked;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locked);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AchievementList(unlocked: $unlocked, inProgress: $inProgress, locked: $locked)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AchievementList'))
      ..add(DiagnosticsProperty('unlocked', unlocked))
      ..add(DiagnosticsProperty('inProgress', inProgress))
      ..add(DiagnosticsProperty('locked', locked));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementListImpl &&
            const DeepCollectionEquality().equals(other._unlocked, _unlocked) &&
            const DeepCollectionEquality().equals(
              other._inProgress,
              _inProgress,
            ) &&
            const DeepCollectionEquality().equals(other._locked, _locked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_unlocked),
    const DeepCollectionEquality().hash(_inProgress),
    const DeepCollectionEquality().hash(_locked),
  );

  /// Create a copy of AchievementList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementListImplCopyWith<_$AchievementListImpl> get copyWith =>
      __$$AchievementListImplCopyWithImpl<_$AchievementListImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AchievementListImplToJson(this);
  }
}

abstract class _AchievementList implements AchievementList {
  const factory _AchievementList({
    required final List<AchievementProgress> unlocked,
    @JsonKey(name: 'in_progress')
    required final List<AchievementProgress> inProgress,
    required final List<AchievementProgress> locked,
  }) = _$AchievementListImpl;

  factory _AchievementList.fromJson(Map<String, dynamic> json) =
      _$AchievementListImpl.fromJson;

  @override
  List<AchievementProgress> get unlocked;
  @override
  @JsonKey(name: 'in_progress')
  List<AchievementProgress> get inProgress;
  @override
  List<AchievementProgress> get locked;

  /// Create a copy of AchievementList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AchievementListImplCopyWith<_$AchievementListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
