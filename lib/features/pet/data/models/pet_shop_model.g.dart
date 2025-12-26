// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_shop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PetShopItemImpl _$$PetShopItemImplFromJson(Map<String, dynamic> json) =>
    _$PetShopItemImpl(
      id: json['id'] as String,
      itemType: $enumDecode(_$ItemTypeEnumMap, json['itemType']),
      name: json['name'] as String,
      emoji: json['emoji'] as String,
      description: json['description'] as String?,
      costXp: (json['costXp'] as num).toInt(),
      rarity: $enumDecode(_$ItemRarityEnumMap, json['rarity']),
      unlockRequirement:
          json['unlockRequirement'] as Map<String, dynamic>? ?? const {},
      isUnlocked: json['isUnlocked'] as bool? ?? true,
      isOwned: json['isOwned'] as bool? ?? false,
      isEquipped: json['isEquipped'] as bool? ?? false,
    );

Map<String, dynamic> _$$PetShopItemImplToJson(_$PetShopItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemType': _$ItemTypeEnumMap[instance.itemType]!,
      'name': instance.name,
      'emoji': instance.emoji,
      'description': instance.description,
      'costXp': instance.costXp,
      'rarity': _$ItemRarityEnumMap[instance.rarity]!,
      'unlockRequirement': instance.unlockRequirement,
      'isUnlocked': instance.isUnlocked,
      'isOwned': instance.isOwned,
      'isEquipped': instance.isEquipped,
    };

const _$ItemTypeEnumMap = {
  ItemType.hat: 'hat',
  ItemType.glasses: 'glasses',
  ItemType.clothing: 'clothing',
  ItemType.background: 'background',
  ItemType.effect: 'effect',
};

const _$ItemRarityEnumMap = {
  ItemRarity.common: 'common',
  ItemRarity.rare: 'rare',
  ItemRarity.epic: 'epic',
  ItemRarity.legendary: 'legendary',
};

_$UserPetItemImpl _$$UserPetItemImplFromJson(Map<String, dynamic> json) =>
    _$UserPetItemImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      itemId: json['itemId'] as String,
      equipped: json['equipped'] as bool,
      purchasedAt: json['purchasedAt'] as String,
      item: PetShopItem.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserPetItemImplToJson(_$UserPetItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'itemId': instance.itemId,
      'equipped': instance.equipped,
      'purchasedAt': instance.purchasedAt,
      'item': instance.item,
    };
