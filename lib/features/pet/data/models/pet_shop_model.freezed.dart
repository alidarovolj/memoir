// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pet_shop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PetShopItem _$PetShopItemFromJson(Map<String, dynamic> json) {
  return _PetShopItem.fromJson(json);
}

/// @nodoc
mixin _$PetShopItem {
  String get id => throw _privateConstructorUsedError;
  ItemType get itemType => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get emoji => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get costXp => throw _privateConstructorUsedError;
  ItemRarity get rarity => throw _privateConstructorUsedError;
  Map<String, dynamic> get unlockRequirement =>
      throw _privateConstructorUsedError;
  bool get isUnlocked => throw _privateConstructorUsedError;
  bool get isOwned => throw _privateConstructorUsedError;
  bool get isEquipped => throw _privateConstructorUsedError;

  /// Serializes this PetShopItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PetShopItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PetShopItemCopyWith<PetShopItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PetShopItemCopyWith<$Res> {
  factory $PetShopItemCopyWith(
    PetShopItem value,
    $Res Function(PetShopItem) then,
  ) = _$PetShopItemCopyWithImpl<$Res, PetShopItem>;
  @useResult
  $Res call({
    String id,
    ItemType itemType,
    String name,
    String emoji,
    String? description,
    int costXp,
    ItemRarity rarity,
    Map<String, dynamic> unlockRequirement,
    bool isUnlocked,
    bool isOwned,
    bool isEquipped,
  });
}

/// @nodoc
class _$PetShopItemCopyWithImpl<$Res, $Val extends PetShopItem>
    implements $PetShopItemCopyWith<$Res> {
  _$PetShopItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PetShopItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? itemType = null,
    Object? name = null,
    Object? emoji = null,
    Object? description = freezed,
    Object? costXp = null,
    Object? rarity = null,
    Object? unlockRequirement = null,
    Object? isUnlocked = null,
    Object? isOwned = null,
    Object? isEquipped = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            itemType: null == itemType
                ? _value.itemType
                : itemType // ignore: cast_nullable_to_non_nullable
                      as ItemType,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            emoji: null == emoji
                ? _value.emoji
                : emoji // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            costXp: null == costXp
                ? _value.costXp
                : costXp // ignore: cast_nullable_to_non_nullable
                      as int,
            rarity: null == rarity
                ? _value.rarity
                : rarity // ignore: cast_nullable_to_non_nullable
                      as ItemRarity,
            unlockRequirement: null == unlockRequirement
                ? _value.unlockRequirement
                : unlockRequirement // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            isUnlocked: null == isUnlocked
                ? _value.isUnlocked
                : isUnlocked // ignore: cast_nullable_to_non_nullable
                      as bool,
            isOwned: null == isOwned
                ? _value.isOwned
                : isOwned // ignore: cast_nullable_to_non_nullable
                      as bool,
            isEquipped: null == isEquipped
                ? _value.isEquipped
                : isEquipped // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PetShopItemImplCopyWith<$Res>
    implements $PetShopItemCopyWith<$Res> {
  factory _$$PetShopItemImplCopyWith(
    _$PetShopItemImpl value,
    $Res Function(_$PetShopItemImpl) then,
  ) = __$$PetShopItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    ItemType itemType,
    String name,
    String emoji,
    String? description,
    int costXp,
    ItemRarity rarity,
    Map<String, dynamic> unlockRequirement,
    bool isUnlocked,
    bool isOwned,
    bool isEquipped,
  });
}

/// @nodoc
class __$$PetShopItemImplCopyWithImpl<$Res>
    extends _$PetShopItemCopyWithImpl<$Res, _$PetShopItemImpl>
    implements _$$PetShopItemImplCopyWith<$Res> {
  __$$PetShopItemImplCopyWithImpl(
    _$PetShopItemImpl _value,
    $Res Function(_$PetShopItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PetShopItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? itemType = null,
    Object? name = null,
    Object? emoji = null,
    Object? description = freezed,
    Object? costXp = null,
    Object? rarity = null,
    Object? unlockRequirement = null,
    Object? isUnlocked = null,
    Object? isOwned = null,
    Object? isEquipped = null,
  }) {
    return _then(
      _$PetShopItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        itemType: null == itemType
            ? _value.itemType
            : itemType // ignore: cast_nullable_to_non_nullable
                  as ItemType,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        emoji: null == emoji
            ? _value.emoji
            : emoji // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        costXp: null == costXp
            ? _value.costXp
            : costXp // ignore: cast_nullable_to_non_nullable
                  as int,
        rarity: null == rarity
            ? _value.rarity
            : rarity // ignore: cast_nullable_to_non_nullable
                  as ItemRarity,
        unlockRequirement: null == unlockRequirement
            ? _value._unlockRequirement
            : unlockRequirement // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        isUnlocked: null == isUnlocked
            ? _value.isUnlocked
            : isUnlocked // ignore: cast_nullable_to_non_nullable
                  as bool,
        isOwned: null == isOwned
            ? _value.isOwned
            : isOwned // ignore: cast_nullable_to_non_nullable
                  as bool,
        isEquipped: null == isEquipped
            ? _value.isEquipped
            : isEquipped // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PetShopItemImpl implements _PetShopItem {
  const _$PetShopItemImpl({
    required this.id,
    required this.itemType,
    required this.name,
    required this.emoji,
    this.description,
    required this.costXp,
    required this.rarity,
    final Map<String, dynamic> unlockRequirement = const {},
    this.isUnlocked = true,
    this.isOwned = false,
    this.isEquipped = false,
  }) : _unlockRequirement = unlockRequirement;

  factory _$PetShopItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PetShopItemImplFromJson(json);

  @override
  final String id;
  @override
  final ItemType itemType;
  @override
  final String name;
  @override
  final String emoji;
  @override
  final String? description;
  @override
  final int costXp;
  @override
  final ItemRarity rarity;
  final Map<String, dynamic> _unlockRequirement;
  @override
  @JsonKey()
  Map<String, dynamic> get unlockRequirement {
    if (_unlockRequirement is EqualUnmodifiableMapView)
      return _unlockRequirement;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_unlockRequirement);
  }

  @override
  @JsonKey()
  final bool isUnlocked;
  @override
  @JsonKey()
  final bool isOwned;
  @override
  @JsonKey()
  final bool isEquipped;

  @override
  String toString() {
    return 'PetShopItem(id: $id, itemType: $itemType, name: $name, emoji: $emoji, description: $description, costXp: $costXp, rarity: $rarity, unlockRequirement: $unlockRequirement, isUnlocked: $isUnlocked, isOwned: $isOwned, isEquipped: $isEquipped)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PetShopItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.itemType, itemType) ||
                other.itemType == itemType) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.costXp, costXp) || other.costXp == costXp) &&
            (identical(other.rarity, rarity) || other.rarity == rarity) &&
            const DeepCollectionEquality().equals(
              other._unlockRequirement,
              _unlockRequirement,
            ) &&
            (identical(other.isUnlocked, isUnlocked) ||
                other.isUnlocked == isUnlocked) &&
            (identical(other.isOwned, isOwned) || other.isOwned == isOwned) &&
            (identical(other.isEquipped, isEquipped) ||
                other.isEquipped == isEquipped));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    itemType,
    name,
    emoji,
    description,
    costXp,
    rarity,
    const DeepCollectionEquality().hash(_unlockRequirement),
    isUnlocked,
    isOwned,
    isEquipped,
  );

  /// Create a copy of PetShopItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PetShopItemImplCopyWith<_$PetShopItemImpl> get copyWith =>
      __$$PetShopItemImplCopyWithImpl<_$PetShopItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PetShopItemImplToJson(this);
  }
}

abstract class _PetShopItem implements PetShopItem {
  const factory _PetShopItem({
    required final String id,
    required final ItemType itemType,
    required final String name,
    required final String emoji,
    final String? description,
    required final int costXp,
    required final ItemRarity rarity,
    final Map<String, dynamic> unlockRequirement,
    final bool isUnlocked,
    final bool isOwned,
    final bool isEquipped,
  }) = _$PetShopItemImpl;

  factory _PetShopItem.fromJson(Map<String, dynamic> json) =
      _$PetShopItemImpl.fromJson;

  @override
  String get id;
  @override
  ItemType get itemType;
  @override
  String get name;
  @override
  String get emoji;
  @override
  String? get description;
  @override
  int get costXp;
  @override
  ItemRarity get rarity;
  @override
  Map<String, dynamic> get unlockRequirement;
  @override
  bool get isUnlocked;
  @override
  bool get isOwned;
  @override
  bool get isEquipped;

  /// Create a copy of PetShopItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PetShopItemImplCopyWith<_$PetShopItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserPetItem _$UserPetItemFromJson(Map<String, dynamic> json) {
  return _UserPetItem.fromJson(json);
}

/// @nodoc
mixin _$UserPetItem {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get itemId => throw _privateConstructorUsedError;
  bool get equipped => throw _privateConstructorUsedError;
  String get purchasedAt => throw _privateConstructorUsedError;
  PetShopItem get item => throw _privateConstructorUsedError;

  /// Serializes this UserPetItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserPetItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserPetItemCopyWith<UserPetItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPetItemCopyWith<$Res> {
  factory $UserPetItemCopyWith(
    UserPetItem value,
    $Res Function(UserPetItem) then,
  ) = _$UserPetItemCopyWithImpl<$Res, UserPetItem>;
  @useResult
  $Res call({
    String id,
    String userId,
    String itemId,
    bool equipped,
    String purchasedAt,
    PetShopItem item,
  });

  $PetShopItemCopyWith<$Res> get item;
}

/// @nodoc
class _$UserPetItemCopyWithImpl<$Res, $Val extends UserPetItem>
    implements $UserPetItemCopyWith<$Res> {
  _$UserPetItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPetItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? itemId = null,
    Object? equipped = null,
    Object? purchasedAt = null,
    Object? item = null,
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
            itemId: null == itemId
                ? _value.itemId
                : itemId // ignore: cast_nullable_to_non_nullable
                      as String,
            equipped: null == equipped
                ? _value.equipped
                : equipped // ignore: cast_nullable_to_non_nullable
                      as bool,
            purchasedAt: null == purchasedAt
                ? _value.purchasedAt
                : purchasedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            item: null == item
                ? _value.item
                : item // ignore: cast_nullable_to_non_nullable
                      as PetShopItem,
          )
          as $Val,
    );
  }

  /// Create a copy of UserPetItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PetShopItemCopyWith<$Res> get item {
    return $PetShopItemCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserPetItemImplCopyWith<$Res>
    implements $UserPetItemCopyWith<$Res> {
  factory _$$UserPetItemImplCopyWith(
    _$UserPetItemImpl value,
    $Res Function(_$UserPetItemImpl) then,
  ) = __$$UserPetItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String itemId,
    bool equipped,
    String purchasedAt,
    PetShopItem item,
  });

  @override
  $PetShopItemCopyWith<$Res> get item;
}

/// @nodoc
class __$$UserPetItemImplCopyWithImpl<$Res>
    extends _$UserPetItemCopyWithImpl<$Res, _$UserPetItemImpl>
    implements _$$UserPetItemImplCopyWith<$Res> {
  __$$UserPetItemImplCopyWithImpl(
    _$UserPetItemImpl _value,
    $Res Function(_$UserPetItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserPetItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? itemId = null,
    Object? equipped = null,
    Object? purchasedAt = null,
    Object? item = null,
  }) {
    return _then(
      _$UserPetItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        itemId: null == itemId
            ? _value.itemId
            : itemId // ignore: cast_nullable_to_non_nullable
                  as String,
        equipped: null == equipped
            ? _value.equipped
            : equipped // ignore: cast_nullable_to_non_nullable
                  as bool,
        purchasedAt: null == purchasedAt
            ? _value.purchasedAt
            : purchasedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        item: null == item
            ? _value.item
            : item // ignore: cast_nullable_to_non_nullable
                  as PetShopItem,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserPetItemImpl implements _UserPetItem {
  const _$UserPetItemImpl({
    required this.id,
    required this.userId,
    required this.itemId,
    required this.equipped,
    required this.purchasedAt,
    required this.item,
  });

  factory _$UserPetItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPetItemImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String itemId;
  @override
  final bool equipped;
  @override
  final String purchasedAt;
  @override
  final PetShopItem item;

  @override
  String toString() {
    return 'UserPetItem(id: $id, userId: $userId, itemId: $itemId, equipped: $equipped, purchasedAt: $purchasedAt, item: $item)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPetItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.equipped, equipped) ||
                other.equipped == equipped) &&
            (identical(other.purchasedAt, purchasedAt) ||
                other.purchasedAt == purchasedAt) &&
            (identical(other.item, item) || other.item == item));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, itemId, equipped, purchasedAt, item);

  /// Create a copy of UserPetItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPetItemImplCopyWith<_$UserPetItemImpl> get copyWith =>
      __$$UserPetItemImplCopyWithImpl<_$UserPetItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPetItemImplToJson(this);
  }
}

abstract class _UserPetItem implements UserPetItem {
  const factory _UserPetItem({
    required final String id,
    required final String userId,
    required final String itemId,
    required final bool equipped,
    required final String purchasedAt,
    required final PetShopItem item,
  }) = _$UserPetItemImpl;

  factory _UserPetItem.fromJson(Map<String, dynamic> json) =
      _$UserPetItemImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get itemId;
  @override
  bool get equipped;
  @override
  String get purchasedAt;
  @override
  PetShopItem get item;

  /// Create a copy of UserPetItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserPetItemImplCopyWith<_$UserPetItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
