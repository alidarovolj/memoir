// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PetModel _$PetModelFromJson(Map<String, dynamic> json) {
  return _PetModel.fromJson(json);
}

/// @nodoc
mixin _$PetModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  PetType get petType => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get xp => throw _privateConstructorUsedError;
  int get xpForNextLevel => throw _privateConstructorUsedError;
  EvolutionStage get evolutionStage => throw _privateConstructorUsedError;
  int get happiness => throw _privateConstructorUsedError;
  int get health => throw _privateConstructorUsedError;
  DateTime get lastFed => throw _privateConstructorUsedError;
  DateTime get lastPlayed => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get accessories => throw _privateConstructorUsedError;
  bool get needsAttention => throw _privateConstructorUsedError;
  bool get canEvolve =>
      throw _privateConstructorUsedError; // New Pet 2.0 fields
  bool get isShiny => throw _privateConstructorUsedError;
  String? get mutationType => throw _privateConstructorUsedError;
  String? get specialEffect =>
      throw _privateConstructorUsedError; // Emotions (Pet 2.0.5)
  String? get currentEmotion => throw _privateConstructorUsedError;
  String? get speechBubble => throw _privateConstructorUsedError;

  /// Serializes this PetModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PetModelCopyWith<PetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PetModelCopyWith<$Res> {
  factory $PetModelCopyWith(PetModel value, $Res Function(PetModel) then) =
      _$PetModelCopyWithImpl<$Res, PetModel>;
  @useResult
  $Res call({
    String id,
    String userId,
    PetType petType,
    String name,
    int level,
    int xp,
    int xpForNextLevel,
    EvolutionStage evolutionStage,
    int happiness,
    int health,
    DateTime lastFed,
    DateTime lastPlayed,
    DateTime createdAt,
    String accessories,
    bool needsAttention,
    bool canEvolve,
    bool isShiny,
    String? mutationType,
    String? specialEffect,
    String? currentEmotion,
    String? speechBubble,
  });
}

/// @nodoc
class _$PetModelCopyWithImpl<$Res, $Val extends PetModel>
    implements $PetModelCopyWith<$Res> {
  _$PetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? petType = null,
    Object? name = null,
    Object? level = null,
    Object? xp = null,
    Object? xpForNextLevel = null,
    Object? evolutionStage = null,
    Object? happiness = null,
    Object? health = null,
    Object? lastFed = null,
    Object? lastPlayed = null,
    Object? createdAt = null,
    Object? accessories = null,
    Object? needsAttention = null,
    Object? canEvolve = null,
    Object? isShiny = null,
    Object? mutationType = freezed,
    Object? specialEffect = freezed,
    Object? currentEmotion = freezed,
    Object? speechBubble = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            petType: null == petType
                ? _value.petType
                : petType // ignore: cast_nullable_to_non_nullable
                      as PetType,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            xp: null == xp
                ? _value.xp
                : xp // ignore: cast_nullable_to_non_nullable
                      as int,
            xpForNextLevel: null == xpForNextLevel
                ? _value.xpForNextLevel
                : xpForNextLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            evolutionStage: null == evolutionStage
                ? _value.evolutionStage
                : evolutionStage // ignore: cast_nullable_to_non_nullable
                      as EvolutionStage,
            happiness: null == happiness
                ? _value.happiness
                : happiness // ignore: cast_nullable_to_non_nullable
                      as int,
            health: null == health
                ? _value.health
                : health // ignore: cast_nullable_to_non_nullable
                      as int,
            lastFed: null == lastFed
                ? _value.lastFed
                : lastFed // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastPlayed: null == lastPlayed
                ? _value.lastPlayed
                : lastPlayed // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            accessories: null == accessories
                ? _value.accessories
                : accessories // ignore: cast_nullable_to_non_nullable
                      as String,
            needsAttention: null == needsAttention
                ? _value.needsAttention
                : needsAttention // ignore: cast_nullable_to_non_nullable
                      as bool,
            canEvolve: null == canEvolve
                ? _value.canEvolve
                : canEvolve // ignore: cast_nullable_to_non_nullable
                      as bool,
            isShiny: null == isShiny
                ? _value.isShiny
                : isShiny // ignore: cast_nullable_to_non_nullable
                      as bool,
            mutationType: freezed == mutationType
                ? _value.mutationType
                : mutationType // ignore: cast_nullable_to_non_nullable
                      as String?,
            specialEffect: freezed == specialEffect
                ? _value.specialEffect
                : specialEffect // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentEmotion: freezed == currentEmotion
                ? _value.currentEmotion
                : currentEmotion // ignore: cast_nullable_to_non_nullable
                      as String?,
            speechBubble: freezed == speechBubble
                ? _value.speechBubble
                : speechBubble // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PetModelImplCopyWith<$Res>
    implements $PetModelCopyWith<$Res> {
  factory _$$PetModelImplCopyWith(
    _$PetModelImpl value,
    $Res Function(_$PetModelImpl) then,
  ) = __$$PetModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    PetType petType,
    String name,
    int level,
    int xp,
    int xpForNextLevel,
    EvolutionStage evolutionStage,
    int happiness,
    int health,
    DateTime lastFed,
    DateTime lastPlayed,
    DateTime createdAt,
    String accessories,
    bool needsAttention,
    bool canEvolve,
    bool isShiny,
    String? mutationType,
    String? specialEffect,
    String? currentEmotion,
    String? speechBubble,
  });
}

/// @nodoc
class __$$PetModelImplCopyWithImpl<$Res>
    extends _$PetModelCopyWithImpl<$Res, _$PetModelImpl>
    implements _$$PetModelImplCopyWith<$Res> {
  __$$PetModelImplCopyWithImpl(
    _$PetModelImpl _value,
    $Res Function(_$PetModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? petType = null,
    Object? name = null,
    Object? level = null,
    Object? xp = null,
    Object? xpForNextLevel = null,
    Object? evolutionStage = null,
    Object? happiness = null,
    Object? health = null,
    Object? lastFed = null,
    Object? lastPlayed = null,
    Object? createdAt = null,
    Object? accessories = null,
    Object? needsAttention = null,
    Object? canEvolve = null,
    Object? isShiny = null,
    Object? mutationType = freezed,
    Object? specialEffect = freezed,
    Object? currentEmotion = freezed,
    Object? speechBubble = freezed,
  }) {
    return _then(
      _$PetModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        petType: null == petType
            ? _value.petType
            : petType // ignore: cast_nullable_to_non_nullable
                  as PetType,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        xp: null == xp
            ? _value.xp
            : xp // ignore: cast_nullable_to_non_nullable
                  as int,
        xpForNextLevel: null == xpForNextLevel
            ? _value.xpForNextLevel
            : xpForNextLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        evolutionStage: null == evolutionStage
            ? _value.evolutionStage
            : evolutionStage // ignore: cast_nullable_to_non_nullable
                  as EvolutionStage,
        happiness: null == happiness
            ? _value.happiness
            : happiness // ignore: cast_nullable_to_non_nullable
                  as int,
        health: null == health
            ? _value.health
            : health // ignore: cast_nullable_to_non_nullable
                  as int,
        lastFed: null == lastFed
            ? _value.lastFed
            : lastFed // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastPlayed: null == lastPlayed
            ? _value.lastPlayed
            : lastPlayed // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        accessories: null == accessories
            ? _value.accessories
            : accessories // ignore: cast_nullable_to_non_nullable
                  as String,
        needsAttention: null == needsAttention
            ? _value.needsAttention
            : needsAttention // ignore: cast_nullable_to_non_nullable
                  as bool,
        canEvolve: null == canEvolve
            ? _value.canEvolve
            : canEvolve // ignore: cast_nullable_to_non_nullable
                  as bool,
        isShiny: null == isShiny
            ? _value.isShiny
            : isShiny // ignore: cast_nullable_to_non_nullable
                  as bool,
        mutationType: freezed == mutationType
            ? _value.mutationType
            : mutationType // ignore: cast_nullable_to_non_nullable
                  as String?,
        specialEffect: freezed == specialEffect
            ? _value.specialEffect
            : specialEffect // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentEmotion: freezed == currentEmotion
            ? _value.currentEmotion
            : currentEmotion // ignore: cast_nullable_to_non_nullable
                  as String?,
        speechBubble: freezed == speechBubble
            ? _value.speechBubble
            : speechBubble // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PetModelImpl implements _PetModel {
  const _$PetModelImpl({
    required this.id,
    required this.userId,
    required this.petType,
    required this.name,
    required this.level,
    required this.xp,
    required this.xpForNextLevel,
    required this.evolutionStage,
    required this.happiness,
    required this.health,
    required this.lastFed,
    required this.lastPlayed,
    required this.createdAt,
    required this.accessories,
    required this.needsAttention,
    required this.canEvolve,
    this.isShiny = false,
    this.mutationType,
    this.specialEffect,
    this.currentEmotion,
    this.speechBubble,
  });

  factory _$PetModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PetModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final PetType petType;
  @override
  final String name;
  @override
  final int level;
  @override
  final int xp;
  @override
  final int xpForNextLevel;
  @override
  final EvolutionStage evolutionStage;
  @override
  final int happiness;
  @override
  final int health;
  @override
  final DateTime lastFed;
  @override
  final DateTime lastPlayed;
  @override
  final DateTime createdAt;
  @override
  final String accessories;
  @override
  final bool needsAttention;
  @override
  final bool canEvolve;
  // New Pet 2.0 fields
  @override
  @JsonKey()
  final bool isShiny;
  @override
  final String? mutationType;
  @override
  final String? specialEffect;
  // Emotions (Pet 2.0.5)
  @override
  final String? currentEmotion;
  @override
  final String? speechBubble;

  @override
  String toString() {
    return 'PetModel(id: $id, userId: $userId, petType: $petType, name: $name, level: $level, xp: $xp, xpForNextLevel: $xpForNextLevel, evolutionStage: $evolutionStage, happiness: $happiness, health: $health, lastFed: $lastFed, lastPlayed: $lastPlayed, createdAt: $createdAt, accessories: $accessories, needsAttention: $needsAttention, canEvolve: $canEvolve, isShiny: $isShiny, mutationType: $mutationType, specialEffect: $specialEffect, currentEmotion: $currentEmotion, speechBubble: $speechBubble)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PetModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.petType, petType) || other.petType == petType) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.xp, xp) || other.xp == xp) &&
            (identical(other.xpForNextLevel, xpForNextLevel) ||
                other.xpForNextLevel == xpForNextLevel) &&
            (identical(other.evolutionStage, evolutionStage) ||
                other.evolutionStage == evolutionStage) &&
            (identical(other.happiness, happiness) ||
                other.happiness == happiness) &&
            (identical(other.health, health) || other.health == health) &&
            (identical(other.lastFed, lastFed) || other.lastFed == lastFed) &&
            (identical(other.lastPlayed, lastPlayed) ||
                other.lastPlayed == lastPlayed) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.accessories, accessories) ||
                other.accessories == accessories) &&
            (identical(other.needsAttention, needsAttention) ||
                other.needsAttention == needsAttention) &&
            (identical(other.canEvolve, canEvolve) ||
                other.canEvolve == canEvolve) &&
            (identical(other.isShiny, isShiny) || other.isShiny == isShiny) &&
            (identical(other.mutationType, mutationType) ||
                other.mutationType == mutationType) &&
            (identical(other.specialEffect, specialEffect) ||
                other.specialEffect == specialEffect) &&
            (identical(other.currentEmotion, currentEmotion) ||
                other.currentEmotion == currentEmotion) &&
            (identical(other.speechBubble, speechBubble) ||
                other.speechBubble == speechBubble));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    userId,
    petType,
    name,
    level,
    xp,
    xpForNextLevel,
    evolutionStage,
    happiness,
    health,
    lastFed,
    lastPlayed,
    createdAt,
    accessories,
    needsAttention,
    canEvolve,
    isShiny,
    mutationType,
    specialEffect,
    currentEmotion,
    speechBubble,
  ]);

  /// Create a copy of PetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PetModelImplCopyWith<_$PetModelImpl> get copyWith =>
      __$$PetModelImplCopyWithImpl<_$PetModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PetModelImplToJson(this);
  }
}

abstract class _PetModel implements PetModel {
  const factory _PetModel({
    required final String id,
    required final String userId,
    required final PetType petType,
    required final String name,
    required final int level,
    required final int xp,
    required final int xpForNextLevel,
    required final EvolutionStage evolutionStage,
    required final int happiness,
    required final int health,
    required final DateTime lastFed,
    required final DateTime lastPlayed,
    required final DateTime createdAt,
    required final String accessories,
    required final bool needsAttention,
    required final bool canEvolve,
    final bool isShiny,
    final String? mutationType,
    final String? specialEffect,
    final String? currentEmotion,
    final String? speechBubble,
  }) = _$PetModelImpl;

  factory _PetModel.fromJson(Map<String, dynamic> json) =
      _$PetModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  PetType get petType;
  @override
  String get name;
  @override
  int get level;
  @override
  int get xp;
  @override
  int get xpForNextLevel;
  @override
  EvolutionStage get evolutionStage;
  @override
  int get happiness;
  @override
  int get health;
  @override
  DateTime get lastFed;
  @override
  DateTime get lastPlayed;
  @override
  DateTime get createdAt;
  @override
  String get accessories;
  @override
  bool get needsAttention;
  @override
  bool get canEvolve; // New Pet 2.0 fields
  @override
  bool get isShiny;
  @override
  String? get mutationType;
  @override
  String? get specialEffect; // Emotions (Pet 2.0.5)
  @override
  String? get currentEmotion;
  @override
  String? get speechBubble;

  /// Create a copy of PetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PetModelImplCopyWith<_$PetModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PetCreateRequest _$PetCreateRequestFromJson(Map<String, dynamic> json) {
  return _PetCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$PetCreateRequest {
  PetType get petType => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this PetCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PetCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PetCreateRequestCopyWith<PetCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PetCreateRequestCopyWith<$Res> {
  factory $PetCreateRequestCopyWith(
    PetCreateRequest value,
    $Res Function(PetCreateRequest) then,
  ) = _$PetCreateRequestCopyWithImpl<$Res, PetCreateRequest>;
  @useResult
  $Res call({PetType petType, String name});
}

/// @nodoc
class _$PetCreateRequestCopyWithImpl<$Res, $Val extends PetCreateRequest>
    implements $PetCreateRequestCopyWith<$Res> {
  _$PetCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PetCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? petType = null, Object? name = null}) {
    return _then(
      _value.copyWith(
            petType: null == petType
                ? _value.petType
                : petType // ignore: cast_nullable_to_non_nullable
                      as PetType,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PetCreateRequestImplCopyWith<$Res>
    implements $PetCreateRequestCopyWith<$Res> {
  factory _$$PetCreateRequestImplCopyWith(
    _$PetCreateRequestImpl value,
    $Res Function(_$PetCreateRequestImpl) then,
  ) = __$$PetCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PetType petType, String name});
}

/// @nodoc
class __$$PetCreateRequestImplCopyWithImpl<$Res>
    extends _$PetCreateRequestCopyWithImpl<$Res, _$PetCreateRequestImpl>
    implements _$$PetCreateRequestImplCopyWith<$Res> {
  __$$PetCreateRequestImplCopyWithImpl(
    _$PetCreateRequestImpl _value,
    $Res Function(_$PetCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PetCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? petType = null, Object? name = null}) {
    return _then(
      _$PetCreateRequestImpl(
        petType: null == petType
            ? _value.petType
            : petType // ignore: cast_nullable_to_non_nullable
                  as PetType,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PetCreateRequestImpl implements _PetCreateRequest {
  const _$PetCreateRequestImpl({required this.petType, required this.name});

  factory _$PetCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PetCreateRequestImplFromJson(json);

  @override
  final PetType petType;
  @override
  final String name;

  @override
  String toString() {
    return 'PetCreateRequest(petType: $petType, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PetCreateRequestImpl &&
            (identical(other.petType, petType) || other.petType == petType) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, petType, name);

  /// Create a copy of PetCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PetCreateRequestImplCopyWith<_$PetCreateRequestImpl> get copyWith =>
      __$$PetCreateRequestImplCopyWithImpl<_$PetCreateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PetCreateRequestImplToJson(this);
  }
}

abstract class _PetCreateRequest implements PetCreateRequest {
  const factory _PetCreateRequest({
    required final PetType petType,
    required final String name,
  }) = _$PetCreateRequestImpl;

  factory _PetCreateRequest.fromJson(Map<String, dynamic> json) =
      _$PetCreateRequestImpl.fromJson;

  @override
  PetType get petType;
  @override
  String get name;

  /// Create a copy of PetCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PetCreateRequestImplCopyWith<_$PetCreateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PetActionResponse _$PetActionResponseFromJson(Map<String, dynamic> json) {
  return _PetActionResponse.fromJson(json);
}

/// @nodoc
mixin _$PetActionResponse {
  String get message => throw _privateConstructorUsedError;
  PetModel get pet => throw _privateConstructorUsedError;
  int get levelUps => throw _privateConstructorUsedError;
  bool get evolved => throw _privateConstructorUsedError;
  Map<String, dynamic>? get rewards => throw _privateConstructorUsedError;

  /// Serializes this PetActionResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PetActionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PetActionResponseCopyWith<PetActionResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PetActionResponseCopyWith<$Res> {
  factory $PetActionResponseCopyWith(
    PetActionResponse value,
    $Res Function(PetActionResponse) then,
  ) = _$PetActionResponseCopyWithImpl<$Res, PetActionResponse>;
  @useResult
  $Res call({
    String message,
    PetModel pet,
    int levelUps,
    bool evolved,
    Map<String, dynamic>? rewards,
  });

  $PetModelCopyWith<$Res> get pet;
}

/// @nodoc
class _$PetActionResponseCopyWithImpl<$Res, $Val extends PetActionResponse>
    implements $PetActionResponseCopyWith<$Res> {
  _$PetActionResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PetActionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? pet = null,
    Object? levelUps = null,
    Object? evolved = null,
    Object? rewards = freezed,
  }) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            pet: null == pet
                ? _value.pet
                : pet // ignore: cast_nullable_to_non_nullable
                      as PetModel,
            levelUps: null == levelUps
                ? _value.levelUps
                : levelUps // ignore: cast_nullable_to_non_nullable
                      as int,
            evolved: null == evolved
                ? _value.evolved
                : evolved // ignore: cast_nullable_to_non_nullable
                      as bool,
            rewards: freezed == rewards
                ? _value.rewards
                : rewards // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }

  /// Create a copy of PetActionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PetModelCopyWith<$Res> get pet {
    return $PetModelCopyWith<$Res>(_value.pet, (value) {
      return _then(_value.copyWith(pet: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PetActionResponseImplCopyWith<$Res>
    implements $PetActionResponseCopyWith<$Res> {
  factory _$$PetActionResponseImplCopyWith(
    _$PetActionResponseImpl value,
    $Res Function(_$PetActionResponseImpl) then,
  ) = __$$PetActionResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    PetModel pet,
    int levelUps,
    bool evolved,
    Map<String, dynamic>? rewards,
  });

  @override
  $PetModelCopyWith<$Res> get pet;
}

/// @nodoc
class __$$PetActionResponseImplCopyWithImpl<$Res>
    extends _$PetActionResponseCopyWithImpl<$Res, _$PetActionResponseImpl>
    implements _$$PetActionResponseImplCopyWith<$Res> {
  __$$PetActionResponseImplCopyWithImpl(
    _$PetActionResponseImpl _value,
    $Res Function(_$PetActionResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PetActionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? pet = null,
    Object? levelUps = null,
    Object? evolved = null,
    Object? rewards = freezed,
  }) {
    return _then(
      _$PetActionResponseImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        pet: null == pet
            ? _value.pet
            : pet // ignore: cast_nullable_to_non_nullable
                  as PetModel,
        levelUps: null == levelUps
            ? _value.levelUps
            : levelUps // ignore: cast_nullable_to_non_nullable
                  as int,
        evolved: null == evolved
            ? _value.evolved
            : evolved // ignore: cast_nullable_to_non_nullable
                  as bool,
        rewards: freezed == rewards
            ? _value._rewards
            : rewards // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PetActionResponseImpl implements _PetActionResponse {
  const _$PetActionResponseImpl({
    required this.message,
    required this.pet,
    this.levelUps = 0,
    this.evolved = false,
    final Map<String, dynamic>? rewards,
  }) : _rewards = rewards;

  factory _$PetActionResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PetActionResponseImplFromJson(json);

  @override
  final String message;
  @override
  final PetModel pet;
  @override
  @JsonKey()
  final int levelUps;
  @override
  @JsonKey()
  final bool evolved;
  final Map<String, dynamic>? _rewards;
  @override
  Map<String, dynamic>? get rewards {
    final value = _rewards;
    if (value == null) return null;
    if (_rewards is EqualUnmodifiableMapView) return _rewards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'PetActionResponse(message: $message, pet: $pet, levelUps: $levelUps, evolved: $evolved, rewards: $rewards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PetActionResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.pet, pet) || other.pet == pet) &&
            (identical(other.levelUps, levelUps) ||
                other.levelUps == levelUps) &&
            (identical(other.evolved, evolved) || other.evolved == evolved) &&
            const DeepCollectionEquality().equals(other._rewards, _rewards));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    pet,
    levelUps,
    evolved,
    const DeepCollectionEquality().hash(_rewards),
  );

  /// Create a copy of PetActionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PetActionResponseImplCopyWith<_$PetActionResponseImpl> get copyWith =>
      __$$PetActionResponseImplCopyWithImpl<_$PetActionResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PetActionResponseImplToJson(this);
  }
}

abstract class _PetActionResponse implements PetActionResponse {
  const factory _PetActionResponse({
    required final String message,
    required final PetModel pet,
    final int levelUps,
    final bool evolved,
    final Map<String, dynamic>? rewards,
  }) = _$PetActionResponseImpl;

  factory _PetActionResponse.fromJson(Map<String, dynamic> json) =
      _$PetActionResponseImpl.fromJson;

  @override
  String get message;
  @override
  PetModel get pet;
  @override
  int get levelUps;
  @override
  bool get evolved;
  @override
  Map<String, dynamic>? get rewards;

  /// Create a copy of PetActionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PetActionResponseImplCopyWith<_$PetActionResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PetTypeInfo _$PetTypeInfoFromJson(Map<String, dynamic> json) {
  return _PetTypeInfo.fromJson(json);
}

/// @nodoc
mixin _$PetTypeInfo {
  String get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get emoji => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get rarity => throw _privateConstructorUsedError;

  /// Serializes this PetTypeInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PetTypeInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PetTypeInfoCopyWith<PetTypeInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PetTypeInfoCopyWith<$Res> {
  factory $PetTypeInfoCopyWith(
    PetTypeInfo value,
    $Res Function(PetTypeInfo) then,
  ) = _$PetTypeInfoCopyWithImpl<$Res, PetTypeInfo>;
  @useResult
  $Res call({
    String type,
    String name,
    String emoji,
    String description,
    String rarity,
  });
}

/// @nodoc
class _$PetTypeInfoCopyWithImpl<$Res, $Val extends PetTypeInfo>
    implements $PetTypeInfoCopyWith<$Res> {
  _$PetTypeInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PetTypeInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? name = null,
    Object? emoji = null,
    Object? description = null,
    Object? rarity = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            emoji: null == emoji
                ? _value.emoji
                : emoji // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            rarity: null == rarity
                ? _value.rarity
                : rarity // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PetTypeInfoImplCopyWith<$Res>
    implements $PetTypeInfoCopyWith<$Res> {
  factory _$$PetTypeInfoImplCopyWith(
    _$PetTypeInfoImpl value,
    $Res Function(_$PetTypeInfoImpl) then,
  ) = __$$PetTypeInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String type,
    String name,
    String emoji,
    String description,
    String rarity,
  });
}

/// @nodoc
class __$$PetTypeInfoImplCopyWithImpl<$Res>
    extends _$PetTypeInfoCopyWithImpl<$Res, _$PetTypeInfoImpl>
    implements _$$PetTypeInfoImplCopyWith<$Res> {
  __$$PetTypeInfoImplCopyWithImpl(
    _$PetTypeInfoImpl _value,
    $Res Function(_$PetTypeInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PetTypeInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? name = null,
    Object? emoji = null,
    Object? description = null,
    Object? rarity = null,
  }) {
    return _then(
      _$PetTypeInfoImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        emoji: null == emoji
            ? _value.emoji
            : emoji // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        rarity: null == rarity
            ? _value.rarity
            : rarity // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PetTypeInfoImpl implements _PetTypeInfo {
  const _$PetTypeInfoImpl({
    required this.type,
    required this.name,
    required this.emoji,
    required this.description,
    required this.rarity,
  });

  factory _$PetTypeInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PetTypeInfoImplFromJson(json);

  @override
  final String type;
  @override
  final String name;
  @override
  final String emoji;
  @override
  final String description;
  @override
  final String rarity;

  @override
  String toString() {
    return 'PetTypeInfo(type: $type, name: $name, emoji: $emoji, description: $description, rarity: $rarity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PetTypeInfoImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.rarity, rarity) || other.rarity == rarity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, name, emoji, description, rarity);

  /// Create a copy of PetTypeInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PetTypeInfoImplCopyWith<_$PetTypeInfoImpl> get copyWith =>
      __$$PetTypeInfoImplCopyWithImpl<_$PetTypeInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PetTypeInfoImplToJson(this);
  }
}

abstract class _PetTypeInfo implements PetTypeInfo {
  const factory _PetTypeInfo({
    required final String type,
    required final String name,
    required final String emoji,
    required final String description,
    required final String rarity,
  }) = _$PetTypeInfoImpl;

  factory _PetTypeInfo.fromJson(Map<String, dynamic> json) =
      _$PetTypeInfoImpl.fromJson;

  @override
  String get type;
  @override
  String get name;
  @override
  String get emoji;
  @override
  String get description;
  @override
  String get rarity;

  /// Create a copy of PetTypeInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PetTypeInfoImplCopyWith<_$PetTypeInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PetStats _$PetStatsFromJson(Map<String, dynamic> json) {
  return _PetStats.fromJson(json);
}

/// @nodoc
mixin _$PetStats {
  int get level => throw _privateConstructorUsedError;
  int get xp => throw _privateConstructorUsedError;
  int get xpForNextLevel => throw _privateConstructorUsedError;
  EvolutionStage get evolutionStage => throw _privateConstructorUsedError;
  int get happiness => throw _privateConstructorUsedError;
  int get health => throw _privateConstructorUsedError;

  /// Serializes this PetStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PetStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PetStatsCopyWith<PetStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PetStatsCopyWith<$Res> {
  factory $PetStatsCopyWith(PetStats value, $Res Function(PetStats) then) =
      _$PetStatsCopyWithImpl<$Res, PetStats>;
  @useResult
  $Res call({
    int level,
    int xp,
    int xpForNextLevel,
    EvolutionStage evolutionStage,
    int happiness,
    int health,
  });
}

/// @nodoc
class _$PetStatsCopyWithImpl<$Res, $Val extends PetStats>
    implements $PetStatsCopyWith<$Res> {
  _$PetStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PetStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? xp = null,
    Object? xpForNextLevel = null,
    Object? evolutionStage = null,
    Object? happiness = null,
    Object? health = null,
  }) {
    return _then(
      _value.copyWith(
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            xp: null == xp
                ? _value.xp
                : xp // ignore: cast_nullable_to_non_nullable
                      as int,
            xpForNextLevel: null == xpForNextLevel
                ? _value.xpForNextLevel
                : xpForNextLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            evolutionStage: null == evolutionStage
                ? _value.evolutionStage
                : evolutionStage // ignore: cast_nullable_to_non_nullable
                      as EvolutionStage,
            happiness: null == happiness
                ? _value.happiness
                : happiness // ignore: cast_nullable_to_non_nullable
                      as int,
            health: null == health
                ? _value.health
                : health // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PetStatsImplCopyWith<$Res>
    implements $PetStatsCopyWith<$Res> {
  factory _$$PetStatsImplCopyWith(
    _$PetStatsImpl value,
    $Res Function(_$PetStatsImpl) then,
  ) = __$$PetStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int level,
    int xp,
    int xpForNextLevel,
    EvolutionStage evolutionStage,
    int happiness,
    int health,
  });
}

/// @nodoc
class __$$PetStatsImplCopyWithImpl<$Res>
    extends _$PetStatsCopyWithImpl<$Res, _$PetStatsImpl>
    implements _$$PetStatsImplCopyWith<$Res> {
  __$$PetStatsImplCopyWithImpl(
    _$PetStatsImpl _value,
    $Res Function(_$PetStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PetStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? xp = null,
    Object? xpForNextLevel = null,
    Object? evolutionStage = null,
    Object? happiness = null,
    Object? health = null,
  }) {
    return _then(
      _$PetStatsImpl(
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        xp: null == xp
            ? _value.xp
            : xp // ignore: cast_nullable_to_non_nullable
                  as int,
        xpForNextLevel: null == xpForNextLevel
            ? _value.xpForNextLevel
            : xpForNextLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        evolutionStage: null == evolutionStage
            ? _value.evolutionStage
            : evolutionStage // ignore: cast_nullable_to_non_nullable
                  as EvolutionStage,
        happiness: null == happiness
            ? _value.happiness
            : happiness // ignore: cast_nullable_to_non_nullable
                  as int,
        health: null == health
            ? _value.health
            : health // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PetStatsImpl implements _PetStats {
  const _$PetStatsImpl({
    required this.level,
    required this.xp,
    required this.xpForNextLevel,
    required this.evolutionStage,
    required this.happiness,
    required this.health,
  });

  factory _$PetStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PetStatsImplFromJson(json);

  @override
  final int level;
  @override
  final int xp;
  @override
  final int xpForNextLevel;
  @override
  final EvolutionStage evolutionStage;
  @override
  final int happiness;
  @override
  final int health;

  @override
  String toString() {
    return 'PetStats(level: $level, xp: $xp, xpForNextLevel: $xpForNextLevel, evolutionStage: $evolutionStage, happiness: $happiness, health: $health)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PetStatsImpl &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.xp, xp) || other.xp == xp) &&
            (identical(other.xpForNextLevel, xpForNextLevel) ||
                other.xpForNextLevel == xpForNextLevel) &&
            (identical(other.evolutionStage, evolutionStage) ||
                other.evolutionStage == evolutionStage) &&
            (identical(other.happiness, happiness) ||
                other.happiness == happiness) &&
            (identical(other.health, health) || other.health == health));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    level,
    xp,
    xpForNextLevel,
    evolutionStage,
    happiness,
    health,
  );

  /// Create a copy of PetStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PetStatsImplCopyWith<_$PetStatsImpl> get copyWith =>
      __$$PetStatsImplCopyWithImpl<_$PetStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PetStatsImplToJson(this);
  }
}

abstract class _PetStats implements PetStats {
  const factory _PetStats({
    required final int level,
    required final int xp,
    required final int xpForNextLevel,
    required final EvolutionStage evolutionStage,
    required final int happiness,
    required final int health,
  }) = _$PetStatsImpl;

  factory _PetStats.fromJson(Map<String, dynamic> json) =
      _$PetStatsImpl.fromJson;

  @override
  int get level;
  @override
  int get xp;
  @override
  int get xpForNextLevel;
  @override
  EvolutionStage get evolutionStage;
  @override
  int get happiness;
  @override
  int get health;

  /// Create a copy of PetStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PetStatsImplCopyWith<_$PetStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PetUpdateNameRequest _$PetUpdateNameRequestFromJson(Map<String, dynamic> json) {
  return _PetUpdateNameRequest.fromJson(json);
}

/// @nodoc
mixin _$PetUpdateNameRequest {
  String get name => throw _privateConstructorUsedError;

  /// Serializes this PetUpdateNameRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PetUpdateNameRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PetUpdateNameRequestCopyWith<PetUpdateNameRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PetUpdateNameRequestCopyWith<$Res> {
  factory $PetUpdateNameRequestCopyWith(
    PetUpdateNameRequest value,
    $Res Function(PetUpdateNameRequest) then,
  ) = _$PetUpdateNameRequestCopyWithImpl<$Res, PetUpdateNameRequest>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$PetUpdateNameRequestCopyWithImpl<
  $Res,
  $Val extends PetUpdateNameRequest
>
    implements $PetUpdateNameRequestCopyWith<$Res> {
  _$PetUpdateNameRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PetUpdateNameRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PetUpdateNameRequestImplCopyWith<$Res>
    implements $PetUpdateNameRequestCopyWith<$Res> {
  factory _$$PetUpdateNameRequestImplCopyWith(
    _$PetUpdateNameRequestImpl value,
    $Res Function(_$PetUpdateNameRequestImpl) then,
  ) = __$$PetUpdateNameRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$PetUpdateNameRequestImplCopyWithImpl<$Res>
    extends _$PetUpdateNameRequestCopyWithImpl<$Res, _$PetUpdateNameRequestImpl>
    implements _$$PetUpdateNameRequestImplCopyWith<$Res> {
  __$$PetUpdateNameRequestImplCopyWithImpl(
    _$PetUpdateNameRequestImpl _value,
    $Res Function(_$PetUpdateNameRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PetUpdateNameRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null}) {
    return _then(
      _$PetUpdateNameRequestImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PetUpdateNameRequestImpl implements _PetUpdateNameRequest {
  const _$PetUpdateNameRequestImpl({required this.name});

  factory _$PetUpdateNameRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PetUpdateNameRequestImplFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'PetUpdateNameRequest(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PetUpdateNameRequestImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of PetUpdateNameRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PetUpdateNameRequestImplCopyWith<_$PetUpdateNameRequestImpl>
  get copyWith =>
      __$$PetUpdateNameRequestImplCopyWithImpl<_$PetUpdateNameRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PetUpdateNameRequestImplToJson(this);
  }
}

abstract class _PetUpdateNameRequest implements PetUpdateNameRequest {
  const factory _PetUpdateNameRequest({required final String name}) =
      _$PetUpdateNameRequestImpl;

  factory _PetUpdateNameRequest.fromJson(Map<String, dynamic> json) =
      _$PetUpdateNameRequestImpl.fromJson;

  @override
  String get name;

  /// Create a copy of PetUpdateNameRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PetUpdateNameRequestImplCopyWith<_$PetUpdateNameRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
