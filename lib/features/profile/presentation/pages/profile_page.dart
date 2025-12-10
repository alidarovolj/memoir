import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_app_bar.dart';
import 'package:memoir/core/services/auth_service.dart';
import 'package:memoir/core/services/notification_service.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'package:memoir/features/analytics/presentation/pages/analytics_page.dart';
import 'package:memoir/features/profile/data/models/user_stats_model.dart';
import 'package:memoir/features/profile/data/datasources/user_stats_remote_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _phoneNumber;
  String? _username;
  UserStatsModel? _stats;
  bool _isLoading = true;
  late UserStatsRemoteDataSource _statsDataSource;

  @override
  void initState() {
    super.initState();
    _statsDataSource = UserStatsRemoteDataSourceImpl(dio: DioClient.instance);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Load user info from SharedPreferences
      final phoneNumber = prefs.getString('user_phone');
      final username = prefs.getString('username');

      // Load stats from API
      final stats = await _statsDataSource.getUserStats();

      setState(() {
        _phoneNumber = phoneNumber;
        _username = username;
        _stats = stats;
        _isLoading = false;
      });
    } catch (e) {
      developer.log('❌ [PROFILE] Error loading user data: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _logout() async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Выйти из аккаунта?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Вы действительно хотите выйти?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Выйти'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    developer.log('👋 [PROFILE] Logging out...');

    try {
      // Delete FCM token from backend
      final notificationService = NotificationService();
      await notificationService.deleteToken();

      // Logout
      final prefs = await SharedPreferences.getInstance();
      final dio = DioClient.instance;
      final authService = AuthService(dio, prefs);
      await authService.logout();

      if (!mounted) return;

      // Navigate to login
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil('/phone-login', (route) => false);

      developer.log('✅ [PROFILE] Logged out successfully');
    } catch (e) {
      developer.log('❌ [PROFILE] Error during logout: $e');
      if (mounted) {
        SnackBarUtils.showError(context, 'Ошибка при выходе');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: 'Профиль'),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.lightBackgroundGradient,
        ),
        child: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    const SizedBox(height: 20),
                    // User Avatar
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryColor.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Ionicons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // User Info
                    _buildInfoCard(),
                    const SizedBox(height: 24),
                    // Settings Section
                    _buildSectionTitle('Настройки'),
                    const SizedBox(height: 12),
                    _buildSettingsCard(),
                    const SizedBox(height: 24),
                    // About Section
                    _buildSectionTitle('О приложении'),
                    const SizedBox(height: 12),
                    _buildAboutCard(),
                    const SizedBox(height: 24),
                    // Logout Button
                    _buildLogoutButton(),
                    const SizedBox(height: 40),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Username
          Text(
            _username ?? 'Пользователь',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Phone
          if (_phoneNumber != null)
            Text(
              _phoneNumber!,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white12),
          const SizedBox(height: 16),
          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('${_stats?.memoriesCount ?? 0}', 'Воспоминаний'),
              Container(width: 1, height: 40, color: Colors.white12),
              _buildStatItem(
                '${_stats?.tasksCompleted ?? 0}/${_stats?.tasksTotal ?? 0}',
                'Задач',
              ),
              Container(width: 1, height: 40, color: Colors.white12),
              _buildStatItem('${_stats?.storiesCount ?? 0}', 'Stories'),
            ],
          ),
          if (_stats != null && _stats!.totalTimeTracked > 0) ...[
            const SizedBox(height: 16),
            const Divider(color: Colors.white12),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Ionicons.time_outline,
                  color: Colors.white70,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Отслежено: ${_stats!.totalTimeTracked.toHoursString()}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildSettingsCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSettingsItem(
            icon: Ionicons.stats_chart_outline,
            title: 'Аналитика',
            subtitle: 'Графики и статистика продуктивности',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AnalyticsPage()),
              );
            },
          ),
          const Divider(height: 1, color: Colors.white12),
          _buildSettingsItem(
            icon: Ionicons.notifications_outline,
            title: 'Уведомления',
            subtitle: 'Управление push-уведомлениями',
            onTap: () {
              SnackBarUtils.showInfo(
                context,
                'Настройки уведомлений - в разработке',
              );
            },
          ),
          const Divider(height: 1, color: Colors.white12),
          _buildSettingsItem(
            icon: Ionicons.language_outline,
            title: 'Язык',
            subtitle: 'Русский',
            onTap: () {
              SnackBarUtils.showInfo(context, 'Выбор языка - в разработке');
            },
          ),
          const Divider(height: 1, color: Colors.white12),
          _buildSettingsItem(
            icon: Ionicons.moon_outline,
            title: 'Тема',
            subtitle: 'Светлая',
            onTap: () {
              SnackBarUtils.showInfo(context, 'Выбор темы - в разработке');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSettingsItem(
            icon: Ionicons.information_circle_outline,
            title: 'Версия',
            subtitle: '1.0.0 (Beta)',
            onTap: () {},
          ),
          const Divider(height: 1, color: Colors.white12),
          _buildSettingsItem(
            icon: Ionicons.shield_checkmark_outline,
            title: 'Политика конфиденциальности',
            onTap: () {
              SnackBarUtils.showInfo(context, 'Политика - в разработке');
            },
          ),
          const Divider(height: 1, color: Colors.white12),
          _buildSettingsItem(
            icon: Ionicons.document_text_outline,
            title: 'Условия использования',
            onTap: () {
              SnackBarUtils.showInfo(context, 'Условия - в разработке');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
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
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Ionicons.chevron_forward_outline,
              color: Colors.white.withOpacity(0.3),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.red.withOpacity(0.8),
            Colors.redAccent.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _logout,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Ionicons.log_out_outline,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Выйти из аккаунта',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
