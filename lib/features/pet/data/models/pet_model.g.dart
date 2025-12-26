// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PetModelImpl _$$PetModelImplFromJson(Map<String, dynamic> json) =>
    _$PetModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      petType: $enumDecode(_$PetTypeEnumMap, json['petType']),
      name: json['name'] as String,
      level: (json['level'] as num).toInt(),
      xp: (json['xp'] as num).toInt(),
      xpForNextLevel: (json['xpForNextLevel'] as num).toInt(),
      evolutionStage: $enumDecode(
        _$EvolutionStageEnumMap,
        json['evolutionStage'],
      ),
      happiness: (json['happiness'] as num).toInt(),
      health: (json['health'] as num).toInt(),
      lastFed: DateTime.parse(json['lastFed'] as String),
      lastPlayed: DateTime.parse(json['lastPlayed'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      accessories: json['accessories'] as String,
      needsAttention: json['needsAttention'] as bool,
      canEvolve: json['canEvolve'] as bool,
      isShiny: json['isShiny'] as bool? ?? false,
      mutationType: json['mutationType'] as String?,
      specialEffect: json['specialEffect'] as String?,
      currentEmotion: json['currentEmotion'] as String?,
      speechBubble: json['speechBubble'] as String?,
    );

Map<String, dynamic> _$$PetModelImplToJson(_$PetModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'petType': _$PetTypeEnumMap[instance.petType]!,
      'name': instance.name,
      'level': instance.level,
      'xp': instance.xp,
      'xpForNextLevel': instance.xpForNextLevel,
      'evolutionStage': _$EvolutionStageEnumMap[instance.evolutionStage]!,
      'happiness': instance.happiness,
      'health': instance.health,
      'lastFed': instance.lastFed.toIso8601String(),
      'lastPlayed': instance.lastPlayed.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'accessories': instance.accessories,
      'needsAttention': instance.needsAttention,
      'canEvolve': instance.canEvolve,
      'isShiny': instance.isShiny,
      'mutationType': instance.mutationType,
      'specialEffect': instance.specialEffect,
      'currentEmotion': instance.currentEmotion,
      'speechBubble': instance.speechBubble,
    };

const _$PetTypeEnumMap = {
  PetType.bird: 'BIRD',
  PetType.cat: 'CAT',
  PetType.dragon: 'DRAGON',
  PetType.fox: 'FOX',
  PetType.panda: 'PANDA',
  PetType.unicorn: 'UNICORN',
  PetType.rabbit: 'RABBIT',
  PetType.owl: 'OWL',
};

const _$EvolutionStageEnumMap = {
  EvolutionStage.egg: 'EGG',
  EvolutionStage.baby: 'BABY',
  EvolutionStage.child: 'CHILD',
  EvolutionStage.adult: 'ADULT',
  EvolutionStage.legend: 'LEGEND',
};

_$PetCreateRequestImpl _$$PetCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$PetCreateRequestImpl(
  petType: $enumDecode(_$PetTypeEnumMap, json['petType']),
  name: json['name'] as String,
);

Map<String, dynamic> _$$PetCreateRequestImplToJson(
  _$PetCreateRequestImpl instance,
) => <String, dynamic>{
  'petType': _$PetTypeEnumMap[instance.petType]!,
  'name': instance.name,
};

_$PetActionResponseImpl _$$PetActionResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PetActionResponseImpl(
  message: json['message'] as String,
  pet: PetModel.fromJson(json['pet'] as Map<String, dynamic>),
  levelUps: (json['levelUps'] as num?)?.toInt() ?? 0,
  evolved: json['evolved'] as bool? ?? false,
  rewards: json['rewards'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$PetActionResponseImplToJson(
  _$PetActionResponseImpl instance,
) => <String, dynamic>{
  'message': instance.message,
  'pet': instance.pet,
  'levelUps': instance.levelUps,
  'evolved': instance.evolved,
  'rewards': instance.rewards,
};

_$PetTypeInfoImpl _$$PetTypeInfoImplFromJson(Map<String, dynamic> json) =>
    _$PetTypeInfoImpl(
      type: json['type'] as String,
      name: json['name'] as String,
      emoji: json['emoji'] as String,
      description: json['description'] as String,
      rarity: json['rarity'] as String,
    );

Map<String, dynamic> _$$PetTypeInfoImplToJson(_$PetTypeInfoImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'emoji': instance.emoji,
      'description': instance.description,
      'rarity': instance.rarity,
    };

_$PetStatsImpl _$$PetStatsImplFromJson(Map<String, dynamic> json) =>
    _$PetStatsImpl(
      level: (json['level'] as num).toInt(),
      xp: (json['xp'] as num).toInt(),
      xpForNextLevel: (json['xpForNextLevel'] as num).toInt(),
      evolutionStage: $enumDecode(
        _$EvolutionStageEnumMap,
        json['evolutionStage'],
      ),
      happiness: (json['happiness'] as num).toInt(),
      health: (json['health'] as num).toInt(),
    );

Map<String, dynamic> _$$PetStatsImplToJson(_$PetStatsImpl instance) =>
    <String, dynamic>{
      'level': instance.level,
      'xp': instance.xp,
      'xpForNextLevel': instance.xpForNextLevel,
      'evolutionStage': _$EvolutionStageEnumMap[instance.evolutionStage]!,
      'happiness': instance.happiness,
      'health': instance.health,
    };

_$PetUpdateNameRequestImpl _$$PetUpdateNameRequestImplFromJson(
  Map<String, dynamic> json,
) => _$PetUpdateNameRequestImpl(name: json['name'] as String);

Map<String, dynamic> _$$PetUpdateNameRequestImplToJson(
  _$PetUpdateNameRequestImpl instance,
) => <String, dynamic>{'name': instance.name};
