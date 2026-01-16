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

class _AchievementsPageState extends State<AchievementsPage> {
  late AchievementRemoteDataSource _dataSource;

  AchievementList? _achievements;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _dataSource = AchievementRemoteDataSourceImpl(dio: DioClient.instance);
    _loadAchievements();
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
      backgroundColor: AppTheme.pageBackgroundColor,
      body: Stack(
        children: [
          // Content
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                  ),
                )
              : _achievements == null
              ? Center(
                  child: Text(
                    'Нет данных',
                    style: TextStyle(
                      color: AppTheme.darkColor.withOpacity(0.7),
                    ),
                  ),
                )
              : (_achievements!.unlocked.isEmpty &&
                    _achievements!.inProgress.isEmpty &&
                    _achievements!.locked.isEmpty)
              ? Center(
                  child: Text(
                    'Пусто',
                    style: TextStyle(
                      color: AppTheme.darkColor.withOpacity(0.5),
                    ),
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    // Отступ для CustomHeader
                    SliverPadding(
                      padding: EdgeInsets.only(
                        top:
                            MediaQuery.of(context).padding.top +
                            64, // SafeArea + высота CustomHeader
                      ),
                    ),
                    // Основной контент
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final allAchievements = <AchievementProgress>[
                              ..._achievements!.unlocked,
                              ..._achievements!.inProgress,
                              ..._achievements!.locked,
                            ];
                            final achievement = allAchievements[index];
                            final showDate = achievement.unlocked;
                            return _AchievementCard(
                              achievement: achievement,
                              showDate: showDate,
                            );
                          },
                          childCount:
                              _achievements!.unlocked.length +
                              _achievements!.inProgress.length +
                              _achievements!.locked.length,
                        ),
                      ),
                    ),
                    const SliverPadding(padding: EdgeInsets.only(bottom: 90)),
                  ],
                ),

          // CustomHeader поверх контента
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: CustomHeader(title: 'Достижения', type: HeaderType.pop),
            ),
          ),
        ],
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
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: achievement.unlocked
              ? color.withOpacity(0.3)
              : AppTheme.darkColor.withOpacity(0.1),
          width: achievement.unlocked ? 2 : 1,
        ),
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
                        style: TextStyle(
                          color: AppTheme.darkColor,
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
                  const Icon(Icons.check_circle, color: Colors.green, size: 24),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              achievement.description,
              style: TextStyle(
                color: AppTheme.darkColor.withOpacity(0.7),
                fontSize: 14,
              ),
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
                        backgroundColor: AppTheme.lightGrayColor,
                        valueColor: AlwaysStoppedAnimation(color),
                        minHeight: 6,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${achievement.progress}/${achievement.criteriaCount}',
                    style: TextStyle(
                      color: AppTheme.darkColor.withOpacity(0.5),
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
                style: TextStyle(
                  color: AppTheme.darkColor.withOpacity(0.5),
                  fontSize: 12,
                ),
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
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }
}
