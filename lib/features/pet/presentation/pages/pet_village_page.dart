import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:memoir/features/pet/presentation/pages/pet_leaderboard_page.dart';
import 'package:ionicons/ionicons.dart';

class PetVillagePage extends StatefulWidget {
  const PetVillagePage({super.key});

  @override
  State<PetVillagePage> createState() => _PetVillagePageState();
}

class _PetVillagePageState extends State<PetVillagePage> {
  bool _isLoading = true;
  List<VillagePet> _pets = [];

  @override
  void initState() {
    super.initState();
    _loadVillage();
  }

  Future<void> _loadVillage() async {
    // TODO: Load from API
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackgroundColor,
      body: Column(
        children: [
          Container(
            color: AppTheme.headerBackgroundColor,
            child: const SafeArea(
              bottom: false,
              child: CustomHeader(title: '🏘️ Pet Village', type: HeaderType.pop),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _pets.length,
                    itemBuilder: (context, index) => _buildPetCard(_pets[index]),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PetLeaderboardPage()),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Ionicons.trophy),
      ),
    );
  }

  Widget _buildPetCard(VillagePet pet) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(255, 255, 255, 0.2),
            Color.fromRGBO(233, 233, 233, 0.2),
            Color.fromRGBO(242, 242, 242, 0),
          ],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(44, 44, 44, 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // Pet Avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppTheme.primaryColor.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Center(
                  child: Stack(
                    children: [
                      Text(pet.emoji, style: const TextStyle(fontSize: 48)),
                      if (pet.isShiny)
                        const Positioned(
                          right: 0,
                          top: 0,
                          child: Text('✨', style: TextStyle(fontSize: 20)),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Pet Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            pet.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Lvl ${pet.level}',
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pet.ownerName,
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      pet.evolutionStage,
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // Actions
              Column(
                children: [
                  IconButton(
                    onPressed: () => _visitPet(pet),
                    icon: const Icon(Ionicons.eye_outline, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () => _sendGift(pet),
                    icon: const Icon(Ionicons.gift_outline, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _visitPet(VillagePet pet) {
    // TODO: Visit API call
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Вы навестили ${pet.name}!', style: const TextStyle(color: Colors.white)),
        content: Text(
          '${pet.ownerName} будет рад вашему визиту! 👋',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  void _sendGift(VillagePet pet) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Отправить подарок', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildGiftButton('🍖', 'Treat', 'Счастье +15'),
            const SizedBox(height: 12),
            _buildGiftButton('🎾', 'Toy', 'Здоровье +15'),
            const SizedBox(height: 12),
            _buildGiftButton('🤗', 'Hug', 'Счастье +10, Здоровье +10'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
        ],
      ),
    );
  }

  Widget _buildGiftButton(String emoji, String name, String effect) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        // TODO: Send gift API call
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Подарок отправлен! $emoji')),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(effect, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VillagePet {
  final String name;
  final String ownerName;
  final String emoji;
  final int level;
  final String evolutionStage;
  final bool isShiny;

  VillagePet({
    required this.name,
    required this.ownerName,
    required this.emoji,
    required this.level,
    required this.evolutionStage,
    this.isShiny = false,
  });
}
