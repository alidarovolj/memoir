import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/core.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/analytics/data/datasources/analytics_remote_datasource.dart';
import 'package:memoir/features/analytics/data/models/analytics_model.dart';
import 'package:memoir/features/analytics/presentation/widgets/activity_heatmap.dart';
import 'package:memoir/features/analytics/presentation/widgets/productivity_chart.dart';
import 'package:memoir/features/analytics/presentation/widgets/category_chart.dart';
import 'package:memoir/features/analytics/presentation/widgets/stats_card.dart';
import 'package:memoir/features/tasks/data/models/task_time_log_model.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late AnalyticsRemoteDataSource _dataSource;
  AnalyticsDashboard? _analytics;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _dataSource = AnalyticsRemoteDataSourceImpl(dio: DioClient.instance);
    _loadAnalytics();
  }

  Future<void> _loadAnalytics() async {
    try {
      setState(() => _isLoading = true);
      final analytics = await _dataSource.getAnalyticsDashboard();
      if (mounted) {
        setState(() {
          _analytics = analytics;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _analytics = null;
          _isLoading = false;
        });
        SnackBarUtils.showError(context, 'Ошибка загрузки аналитики');
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
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.primaryColor,
                    ),
                  ),
                )
              : _analytics == null
              ? const Center(
                  child: EmptyState(
                    title: 'Аналитика недоступна',
                    subtitle: 'Данные не загружены',
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
                      padding: const EdgeInsets.all(20),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          // Header Stats
                          _buildHeaderStats(),
                          const SizedBox(height: 24),

                          // Streaks
                          _buildStreaksCard(),
                          const SizedBox(height: 24),

                          // Activity Heatmap
                          _buildSectionTitle('Активность за месяц'),
                          const SizedBox(height: 12),
                          ActivityHeatmap(
                            dailyActivities:
                                _analytics!.currentMonth.dailyActivities,
                          ),
                          const SizedBox(height: 24),

                          // Productivity Trends
                          _buildSectionTitle('Продуктивность (6 месяцев)'),
                          const SizedBox(height: 12),
                          ProductivityChart(
                            trends: _analytics!.productivityTrends,
                          ),
                          const SizedBox(height: 24),

                          // Category Stats
                          if (_analytics!.categoryStats.isNotEmpty) ...[
                            _buildSectionTitle('Категории'),
                            const SizedBox(height: 12),
                            CategoryChart(
                              categoryStats: _analytics!.categoryStats,
                            ),
                            const SizedBox(height: 24),
                          ],
                        ]),
                      ),
                    ),
                    // Отступ снизу для таббара
                    SliverPadding(
                      padding: const EdgeInsets.only(bottom: 90),
                    ),
                  ],
                ),

          // CustomHeader поверх контента
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: CustomHeader(title: 'Аналитика', type: HeaderType.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppTheme.darkColor,
      ),
    );
  }

  Widget _buildHeaderStats() {
    return Row(
      children: [
        Expanded(
          child: StatsCard(
            icon: Ionicons.albums_outline,
            value: '${_analytics!.totalMemories}',
            label: 'Воспоминаний',
            color: const Color(0xFF667EEA),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatsCard(
            icon: Ionicons.checkmark_circle_outline,
            value: '${_analytics!.totalTasksCompleted}',
            label: 'Задач',
            color: const Color(0xFF48BB78),
          ),
        ),
      ],
    );
  }

  Widget _buildThisWeekCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Ionicons.calendar_outline,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'На этой неделе',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildWeekStat(
                '${_analytics!.thisWeekMemories}',
                'Воспоминаний',
                Ionicons.albums_outline,
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withOpacity(0.2),
              ),
              _buildWeekStat(
                '${_analytics!.thisWeekTasks}',
                'Задач',
                Ionicons.checkmark_circle_outline,
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withOpacity(0.2),
              ),
              _buildWeekStat(
                _analytics!.thisWeekTime.toTimeFormat(),
                'Времени',
                Ionicons.time_outline,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeekStat(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.primaryColor, size: 20),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6)),
        ),
      ],
    );
  }

  Widget _buildStreaksCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFFF6B6B), const Color(0xFFFF8E53)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B6B).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Ionicons.flame, color: Colors.white, size: 28),
                    SizedBox(width: 8),
                    Text(
                      'Текущий стрик',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${_analytics!.currentStreak} дней',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Container(width: 1, height: 60, color: Colors.white.withOpacity(0.3)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Ionicons.trophy, color: Colors.white, size: 28),
                const SizedBox(height: 8),
                Text(
                  '${_analytics!.longestStreak}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Рекорд',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
