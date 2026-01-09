import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:memoir/features/pet/data/models/pet_shop_model.dart';

class PetShopPage extends StatefulWidget {
  final int currentXp;

  const PetShopPage({super.key, required this.currentXp});

  @override
  State<PetShopPage> createState() => _PetShopPageState();
}

class _PetShopPageState extends State<PetShopPage> {
  List<PetShopItem> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadShop();
  }

  Future<void> _loadShop() async {
    // TODO: Load from API
    // Mock data for now
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _items = [
        // Hats
        PetShopItem(
          id: '1',
          name: 'Топ шляпа',
          emoji: '🎩',
          itemType: ItemType.hat,
          rarity: ItemRarity.common,
          costXp: 100,
        ),
        PetShopItem(
          id: '2',
          name: 'Корона',
          emoji: '👑',
          itemType: ItemType.hat,
          rarity: ItemRarity.legendary,
          costXp: 500,
        ),
        PetShopItem(
          id: '3',
          name: 'Бейсболка',
          emoji: '🧢',
          itemType: ItemType.hat,
          rarity: ItemRarity.common,
          costXp: 80,
        ),

        // Glasses
        PetShopItem(
          id: '4',
          name: 'Крутые очки',
          emoji: '😎',
          itemType: ItemType.glasses,
          rarity: ItemRarity.rare,
          costXp: 150,
        ),
        PetShopItem(
          id: '5',
          name: 'Очки',
          emoji: '👓',
          itemType: ItemType.glasses,
          rarity: ItemRarity.common,
          costXp: 120,
        ),

        // Clothing
        PetShopItem(
          id: '6',
          name: 'Футболка',
          emoji: '👕',
          itemType: ItemType.clothing,
          rarity: ItemRarity.common,
          costXp: 90,
        ),
        PetShopItem(
          id: '7',
          name: 'Костюм',
          emoji: '🤵',
          itemType: ItemType.clothing,
          rarity: ItemRarity.epic,
          costXp: 300,
        ),

        // Effects
        PetShopItem(
          id: '8',
          name: 'Искорки',
          emoji: '✨',
          itemType: ItemType.effect,
          rarity: ItemRarity.rare,
          costXp: 200,
        ),
        PetShopItem(
          id: '9',
          name: 'Радуга',
          emoji: '🌈',
          itemType: ItemType.effect,
          rarity: ItemRarity.legendary,
          costXp: 1000,
        ),
        PetShopItem(
          id: '10',
          name: 'Огонь',
          emoji: '🔥',
          itemType: ItemType.effect,
          rarity: ItemRarity.epic,
          costXp: 350,
        ),

        // Backgrounds
        PetShopItem(
          id: '11',
          name: 'Звёзды',
          emoji: '⭐',
          itemType: ItemType.background,
          rarity: ItemRarity.rare,
          costXp: 180,
        ),
        PetShopItem(
          id: '12',
          name: 'Сердца',
          emoji: '💖',
          itemType: ItemType.background,
          rarity: ItemRarity.common,
          costXp: 100,
        ),
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackgroundColor,
      body: Column(
        children: [
          Container(
            color: AppTheme.headerBackgroundColor,
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const CustomHeader(
                    title: '🛍️ Магазин',
                    type: HeaderType.pop,
                  ),
                  // XP Balance
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryColor.withOpacity(0.3),
                          AppTheme.primaryColor.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.primaryColor.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('⭐', style: TextStyle(fontSize: 32)),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ваш баланс',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '${widget.currentXp} XP',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: _items.length,
                    itemBuilder: (context, index) =>
                        _buildItemCard(_items[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(PetShopItem item) {
    final rarityColor = _getRarityColor(item.rarity);

    return GestureDetector(
      onTap: () => _showPurchaseDialog(item),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              rarityColor.withOpacity(0.3),
              rarityColor.withOpacity(0.1),
              Colors.transparent,
            ],
          ),
          border: Border.all(color: rarityColor.withOpacity(0.5), width: 2),
        ),
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(44, 44, 44, 1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Rarity badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: rarityColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _getRarityText(item.rarity),
                  style: TextStyle(
                    color: rarityColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(item.emoji, style: const TextStyle(fontSize: 48)),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  item.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('⭐', style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 4),
                    Text(
                      '${item.costXp}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getRarityColor(ItemRarity rarity) {
    switch (rarity) {
      case ItemRarity.common:
        return Colors.grey;
      case ItemRarity.rare:
        return Colors.blue;
      case ItemRarity.epic:
        return Colors.purple;
      case ItemRarity.legendary:
        return Colors.orange;
    }
  }

  String _getRarityText(ItemRarity rarity) {
    switch (rarity) {
      case ItemRarity.common:
        return 'ОБЫЧНЫЙ';
      case ItemRarity.rare:
        return 'РЕДКИЙ';
      case ItemRarity.epic:
        return 'ЭПИЧЕСКИЙ';
      case ItemRarity.legendary:
        return 'ЛЕГЕНДАРНЫЙ';
    }
  }

  void _showPurchaseDialog(PetShopItem item) {
    final canAfford = widget.currentXp >= item.costXp;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Text(item.emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.name,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getRarityColor(item.rarity).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getRarityText(item.rarity),
                    style: TextStyle(
                      color: _getRarityColor(item.rarity),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Стоимость: ',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const Text('⭐', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 4),
                Text(
                  '${item.costXp}',
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Balance info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: canAfford
                    ? Colors.green.withOpacity(0.2)
                    : Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    canAfford ? Icons.check_circle : Icons.cancel,
                    color: canAfford ? Colors.green : Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    canAfford ? 'Доступно для покупки' : 'Недостаточно XP',
                    style: TextStyle(
                      color: canAfford ? Colors.green : Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (!canAfford) ...[
              const SizedBox(height: 8),
              Text(
                'Нужно ещё ${item.costXp - widget.currentXp} XP',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: canAfford
                ? () {
                    Navigator.pop(context);
                    // TODO: Purchase API call
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item.emoji} ${item.name} куплен!'),
                        backgroundColor: _getRarityColor(item.rarity),
                      ),
                    );
                  }
                : null,
            child: Text(
              'Купить',
              style: TextStyle(
                color: canAfford ? AppTheme.primaryColor : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
