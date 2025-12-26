import 'package:freezed_annotation/freezed_annotation.dart';

part 'pet_shop_model.freezed.dart';
part 'pet_shop_model.g.dart';

/// Item type enum
enum ItemType {
  @JsonValue('hat')
  hat,
  @JsonValue('glasses')
  glasses,
  @JsonValue('clothing')
  clothing,
  @JsonValue('background')
  background,
  @JsonValue('effect')
  effect,
}

/// Item rarity enum
enum ItemRarity {
  @JsonValue('common')
  common,
  @JsonValue('rare')
  rare,
  @JsonValue('epic')
  epic,
  @JsonValue('legendary')
  legendary,
}

/// Pet shop item
@freezed
class PetShopItem with _$PetShopItem {
  const factory PetShopItem({
    required String id,
    required ItemType itemType,
    required String name,
    required String emoji,
    String? description,
    required int costXp,
    required ItemRarity rarity,
    @Default({}) Map<String, dynamic> unlockRequirement,
    @Default(true) bool isUnlocked,
    @Default(false) bool isOwned,
    @Default(false) bool isEquipped,
  }) = _PetShopItem;

  factory PetShopItem.fromJson(Map<String, dynamic> json) =>
      _$PetShopItemFromJson(json);
}

/// User's owned item
@freezed
class UserPetItem with _$UserPetItem {
  const factory UserPetItem({
    required String id,
    required String userId,
    required String itemId,
    required bool equipped,
    required String purchasedAt,
    required PetShopItem item,
  }) = _UserPetItem;

  factory UserPetItem.fromJson(Map<String, dynamic> json) =>
      _$UserPetItemFromJson(json);
}
