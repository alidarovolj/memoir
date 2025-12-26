import 'package:freezed_annotation/freezed_annotation.dart';

part 'pet_model.freezed.dart';
part 'pet_model.g.dart';

/// Available pet types
enum PetType {
  @JsonValue('BIRD')
  bird,
  @JsonValue('CAT')
  cat,
  @JsonValue('DRAGON')
  dragon,
  @JsonValue('FOX')
  fox, // Лиса - хитрая и умная
  @JsonValue('PANDA')
  panda, // Панда - милая и ленивая
  @JsonValue('UNICORN')
  unicorn, // Единорог - магический и редкий
  @JsonValue('RABBIT')
  rabbit, // Кролик - быстрый и энергичный
  @JsonValue('OWL')
  owl, // Сова - мудрая и ночная
}

/// Pet evolution stages
enum EvolutionStage {
  @JsonValue('EGG')
  egg, // 0-4 levels
  @JsonValue('BABY')
  baby, // 5-14 levels
  @JsonValue('CHILD')
  child, // 15-24 levels (НОВАЯ СТАДИЯ)
  @JsonValue('ADULT')
  adult, // 25-39 levels
  @JsonValue('LEGEND')
  legend, // 40+ levels
}

/// Pet model - Virtual companion
@freezed
class PetModel with _$PetModel {
  const factory PetModel({
    required String id,
    required String userId,
    required PetType petType,
    required String name,
    required int level,
    required int xp,
    required int xpForNextLevel,
    required EvolutionStage evolutionStage,
    required int happiness,
    required int health,
    required DateTime lastFed,
    required DateTime lastPlayed,
    required DateTime createdAt,
    required String accessories,
    required bool needsAttention,
    required bool canEvolve,
    // New Pet 2.0 fields
    @Default(false) bool isShiny,
    String? mutationType,
    String? specialEffect,
    // Emotions (Pet 2.0.5)
    String? currentEmotion,
    String? speechBubble,
  }) = _PetModel;

  factory PetModel.fromJson(Map<String, dynamic> json) =>
      _$PetModelFromJson(json);
}

/// Request to create a new pet
@freezed
class PetCreateRequest with _$PetCreateRequest {
  const factory PetCreateRequest({
    required PetType petType,
    required String name,
  }) = _PetCreateRequest;

  factory PetCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$PetCreateRequestFromJson(json);
}

/// Pet action response (after feed/play)
@freezed
class PetActionResponse with _$PetActionResponse {
  const factory PetActionResponse({
    required String message,
    required PetModel pet,
    @Default(0) int levelUps,
    @Default(false) bool evolved,
    Map<String, dynamic>? rewards,
  }) = _PetActionResponse;

  factory PetActionResponse.fromJson(Map<String, dynamic> json) =>
      _$PetActionResponseFromJson(json);
}

/// Available pet type info
@freezed
class PetTypeInfo with _$PetTypeInfo {
  const factory PetTypeInfo({
    required String type,
    required String name,
    required String emoji,
    required String description,
    required String rarity,
  }) = _PetTypeInfo;

  factory PetTypeInfo.fromJson(Map<String, dynamic> json) =>
      _$PetTypeInfoFromJson(json);
}

/// Pet statistics (compact version)
@freezed
class PetStats with _$PetStats {
  const factory PetStats({
    required int level,
    required int xp,
    required int xpForNextLevel,
    required EvolutionStage evolutionStage,
    required int happiness,
    required int health,
  }) = _PetStats;

  factory PetStats.fromJson(Map<String, dynamic> json) =>
      _$PetStatsFromJson(json);
}

/// Request to update pet name
@freezed
class PetUpdateNameRequest with _$PetUpdateNameRequest {
  const factory PetUpdateNameRequest({required String name}) =
      _PetUpdateNameRequest;

  factory PetUpdateNameRequest.fromJson(Map<String, dynamic> json) =>
      _$PetUpdateNameRequestFromJson(json);
}

/// Extension for PetModel
extension PetModelX on PetModel {
  /// Get happiness status emoji
  String get happinessEmoji {
    if (happiness >= 80) return '😊';
    if (happiness >= 60) return '🙂';
    if (happiness >= 40) return '😐';
    if (happiness >= 20) return '😞';
    return '😢';
  }

  /// Get health status emoji
  String get healthEmoji {
    if (health >= 80) return '💚';
    if (health >= 60) return '💛';
    if (health >= 40) return '🧡';
    if (health >= 20) return '❤️';
    return '💔';
  }

  /// Get evolution emoji
  String get evolutionEmoji {
    switch (evolutionStage) {
      case EvolutionStage.egg:
        return '🥚';
      case EvolutionStage.baby:
        return '🐣';
      case EvolutionStage.child:
        return '🐤';
      case EvolutionStage.adult:
        return '🐦';
      case EvolutionStage.legend:
        return '🦅';
    }
  }

  /// Get evolution stage name in Russian
  String get evolutionStageName {
    switch (evolutionStage) {
      case EvolutionStage.egg:
        return 'Яйцо';
      case EvolutionStage.baby:
        return 'Малыш';
      case EvolutionStage.child:
        return 'Ребенок';
      case EvolutionStage.adult:
        return 'Взрослый';
      case EvolutionStage.legend:
        return 'Легенда';
    }
  }

  /// Get pet type emoji
  String get petTypeEmoji {
    switch (petType) {
      case PetType.bird:
        switch (evolutionStage) {
          case EvolutionStage.egg:
            return '🥚';
          case EvolutionStage.baby:
            return '🐣';
          case EvolutionStage.child:
            return '🐤';
          case EvolutionStage.adult:
            return '🐦';
          case EvolutionStage.legend:
            return '🦅';
        }
      case PetType.cat:
        switch (evolutionStage) {
          case EvolutionStage.egg:
            return '🥚';
          case EvolutionStage.baby:
            return '🐱';
          case EvolutionStage.child:
            return '😺';
          case EvolutionStage.adult:
            return '🐈';
          case EvolutionStage.legend:
            return '🦁';
        }
      case PetType.dragon:
        switch (evolutionStage) {
          case EvolutionStage.egg:
            return '🥚';
          case EvolutionStage.baby:
            return '🦎';
          case EvolutionStage.child:
            return '🐊';
          case EvolutionStage.adult:
            return '🐲';
          case EvolutionStage.legend:
            return '🐉';
        }
      case PetType.fox:
        switch (evolutionStage) {
          case EvolutionStage.egg:
            return '🥚';
          case EvolutionStage.baby:
            return '🦊';
          case EvolutionStage.child:
            return '🦊';
          case EvolutionStage.adult:
            return '🦊';
          case EvolutionStage.legend:
            return '🦊✨';
        }
      case PetType.panda:
        switch (evolutionStage) {
          case EvolutionStage.egg:
            return '🥚';
          case EvolutionStage.baby:
            return '🐼';
          case EvolutionStage.child:
            return '🐼';
          case EvolutionStage.adult:
            return '🐼';
          case EvolutionStage.legend:
            return '🐼👑';
        }
      case PetType.unicorn:
        switch (evolutionStage) {
          case EvolutionStage.egg:
            return '🥚';
          case EvolutionStage.baby:
            return '🦄';
          case EvolutionStage.child:
            return '🦄';
          case EvolutionStage.adult:
            return '🦄';
          case EvolutionStage.legend:
            return '🦄🌈';
        }
      case PetType.rabbit:
        switch (evolutionStage) {
          case EvolutionStage.egg:
            return '🥚';
          case EvolutionStage.baby:
            return '🐰';
          case EvolutionStage.child:
            return '🐇';
          case EvolutionStage.adult:
            return '🐰';
          case EvolutionStage.legend:
            return '🐰⚡';
        }
      case PetType.owl:
        switch (evolutionStage) {
          case EvolutionStage.egg:
            return '🥚';
          case EvolutionStage.baby:
            return '🦉';
          case EvolutionStage.child:
            return '🦉';
          case EvolutionStage.adult:
            return '🦉';
          case EvolutionStage.legend:
            return '🦉📚';
        }
    }
  }

  /// Calculate XP percentage for progress bar
  double get xpPercentage {
    if (xpForNextLevel == 0) return 1.0;
    return xp / xpForNextLevel;
  }

  /// Get level milestone text
  String? get nextMilestone {
    if (level < 5) return 'Эволюция в малыша на уровне 5';
    if (level < 15) return 'Эволюция в ребенка на уровне 15';
    if (level < 25) return 'Эволюция во взрослого на уровне 25';
    if (level < 40) return 'Эволюция в легенду на уровне 40';
    return null;
  }
}
