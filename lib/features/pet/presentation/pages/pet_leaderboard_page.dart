import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:ionicons/ionicons.dart';

class PetLeaderboardPage extends StatefulWidget {
  const PetLeaderboardPage({super.key});

  @override
  State<PetLeaderboardPage> createState() => _PetLeaderboardPageState();
}

class _PetLeaderboardPageState extends State<PetLeaderboardPage> {
  bool _isLoading = true;
  List<LeaderboardEntry> _entries = [];
  String _selectedCategory = 'level';

  @override
  void initState() {
    super.initState();
    _loadLeaderboard();
  }

  Future<void> _loadLeaderboard() async {
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
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const CustomHeader(title: '🏆 Leaderboard', type: HeaderType.pop),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildCategoryTab('level', '🎯 Уровень'),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildCategoryTab('games', '🎮 Игры'),
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
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _entries.length,
                    itemBuilder: (context, index) => _buildLeaderboardCard(_entries[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String category, String label) {
    final isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedCategory = category);
        _loadLeaderboard();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildLeaderboardCard(LeaderboardEntry entry) {
    final isTop3 = entry.rank <= 3;
    final medalEmoji = entry.rank == 1 ? '🥇' : entry.rank == 2 ? '🥈' : entry.rank == 3 ? '🥉' : null;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: isTop3
            ? LinearGradient(
                colors: [
                  AppTheme.primaryColor.withOpacity(0.3),
                  AppTheme.primaryColor.withOpacity(0.1),
                  Colors.transparent,
                ],
              )
            : const LinearGradient(
                colors: [
                  Color.fromRGBO(255, 255, 255, 0.1),
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
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Rank
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isTop3 ? AppTheme.primaryColor.withOpacity(0.2) : Colors.white.withOpacity(0.1),
                ),
                child: Center(
                  child: Text(
                    medalEmoji ?? '#${entry.rank}',
                    style: TextStyle(
                      color: isTop3 ? AppTheme.primaryColor : Colors.white,
                      fontSize: medalEmoji != null ? 24 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Pet Avatar
              Stack(
                children: [
                  Text(entry.petEmoji, style: const TextStyle(fontSize: 40)),
                  if (entry.isShiny)
                    const Positioned(
                      right: 0,
                      top: 0,
                      child: Text('✨', style: TextStyle(fontSize: 16)),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.petName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      entry.username,
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
              // Stats
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Lvl ${entry.level}',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.stage,
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeaderboardEntry {
  final int rank;
  final String username;
  final String petName;
  final String petEmoji;
  final int level;
  final String stage;
  final bool isShiny;

  LeaderboardEntry({
    required this.rank,
    required this.username,
    required this.petName,
    required this.petEmoji,
    required this.level,
    required this.stage,
    this.isShiny = false,
  });
}
