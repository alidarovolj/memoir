import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:memoir/features/pet/presentation/pages/games/hide_and_seek_game.dart';
import 'package:memoir/features/pet/presentation/pages/games/memory_match_game.dart';

class PetGamesPage extends StatelessWidget {
  const PetGamesPage({super.key});

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
              child: CustomHeader(title: '🎮 Мини-игры', type: HeaderType.pop),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildGameCard(
                  context,
                  icon: '🔍',
                  title: 'Hide & Seek',
                  description: 'Найдите питомца за 3 попытки',
                  reward: 'До 30 XP',
                  color: Colors.blue,
                  onTap: () => _launchGame(context, const HideAndSeekGame()),
                ),
                const SizedBox(height: 16),
                _buildGameCard(
                  context,
                  icon: '🧠',
                  title: 'Memory Match',
                  description: 'Найдите все пары карточек',
                  reward: 'До 40 XP',
                  color: Colors.purple,
                  onTap: () => _launchGame(context, const MemoryMatchGame()),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.05),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        '📊 Ваша статистика',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildStatRow('Игр сегодня', '0 / 3'),
                      _buildStatRow('Всего игр', '0'),
                      _buildStatRow('Заработано XP', '0'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard(
    BuildContext context, {
    required String icon,
    required String title,
    required String description,
    required String reward,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.3),
              color.withOpacity(0.1),
              Colors.transparent,
            ],
          ),
          border: Border.all(color: color.withOpacity(0.5), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.2),
                ),
                child: Center(
                  child: Text(icon, style: const TextStyle(fontSize: 32)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        reward,
                        style: TextStyle(
                          color: color,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
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

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchGame(BuildContext context, Widget game) async {
    final score = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => game),
    );

    if (score != null && context.mounted) {
      // TODO: Submit score to API
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Игра завершена! Счёт: $score')));
    }
  }
}
