import 'package:flutter/material.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:memoir/features/achievements/data/models/achievement_model.dart';
import 'package:memoir/features/achievements/data/datasources/achievement_remote_datasource.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key});

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage>
    with SingleTickerProviderStateMixin {
  late AchievementRemoteDataSource _dataSource;
  late TabController _tabController;

  AchievementList? _achievements;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _dataSource = AchievementRemoteDataSourceImpl(dio: DioClient.instance);
    _tabController = TabController(length: 3, vsync: this);
    _loadAchievements();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadAchievements() async {
    setState(() => _isLoading = true);
    try {
      final achievements = await _dataSource.getAchievements();
      setState(() {
        _achievements = achievements;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackgroundColor, // rgba(28, 27, 32, 1)
      body: Column(
        children: [
          Container(
            color: AppTheme.headerBackgroundColor, // rgba(21, 20, 24, 1)
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const CustomHeader(title: 'Достижения', type: HeaderType.pop),
                  TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white60,
                    tabs: [
                      Tab(
                        text:
                            'Открытые (${_achievements?.unlocked.length ?? 0})',
                      ),
                      Tab(
                        text:
                            'В процессе (${_achievements?.inProgress.length ?? 0})',
                      ),
                      Tab(
                        text: 'Закрытые (${_achievements?.locked.length ?? 0})',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : _achievements == null
                ? const Center(
                    child: Text(
                      'Нет данных',
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildList(_achievements!.unlocked, true),
                      _buildList(_achievements!.inProgress, false),
                      _buildList(_achievements!.locked, false),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<AchievementProgress> achievements, bool showDate) {
    if (achievements.isEmpty) {
      return const Center(
        child: Text('Пусто', style: TextStyle(color: Colors.white54)),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadAchievements,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final achievement = achievements[index];
          return _AchievementCard(achievement: achievement, showDate: showDate);
        },
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final AchievementProgress achievement;
  final bool showDate;

  const _AchievementCard({required this.achievement, required this.showDate});

  @override
  Widget build(BuildContext context) {
    final color = Color.fromRGBO(
      achievement.categoryColor[0],
      achievement.categoryColor[1],
      achievement.categoryColor[2],
      1,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: achievement.unlocked
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  color.withOpacity(0.3),
                  color.withOpacity(0.1),
                  color.withOpacity(0.05),
                ],
                stops: const [0.0, 0.5, 1.0],
              )
            : const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 255, 255, 0.2),
                  Color.fromRGBO(233, 233, 233, 0.2),
                  Color.fromRGBO(242, 242, 242, 0),
                ],
                stops: [0.0, 0.5, 1.0],
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(achievement.emoji, style: const TextStyle(fontSize: 32)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          achievement.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          achievement.typeName,
                          style: TextStyle(color: color, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  if (achievement.unlocked)
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 24,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                achievement.description,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              if (!achievement.unlocked) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: achievement.percentage / 100,
                          backgroundColor: Colors.white10,
                          valueColor: AlwaysStoppedAnimation(color),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${achievement.progress}/${achievement.criteriaCount}',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
              if (showDate && achievement.unlockedAt != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Получено: ${_formatDate(achievement.unlockedAt!)}',
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('⭐', style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    Text(
                      '+${achievement.xpReward} XP',
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }
}
