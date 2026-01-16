import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/services/auth_service.dart';
import 'package:memoir/core/services/notification_service.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:memoir/features/challenges/presentation/pages/challenges_page.dart';
import 'package:memoir/features/achievements/presentation/pages/achievements_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:developer' as developer;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _firstName;
  String? _lastName;
  String? _avatarUrl;
  bool _isLoading = true;
  bool _notificationsEnabled = true;
  final _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final dio = DioClient.instance;

      // Load user info from API
      final response = await dio.get('/api/v1/users/me');
      final user = response.data;

      setState(() {
        _firstName = user['first_name'];
        _lastName = user['last_name'];
        // Add base URL if avatar_url starts with /uploads
        _avatarUrl =
            user['avatar_url'] != null &&
                user['avatar_url'].toString().startsWith('/uploads')
            ? 'http://localhost:8000${user['avatar_url']}'
            : user['avatar_url'];
        _isLoading = false;
      });
    } catch (e) {
      developer.log('❌ [PROFILE] Error loading user data: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickAndUploadAvatar() async {
    // Показываем диалог выбора источника
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppTheme.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Выберите источник',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkColor,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Ionicons.camera,
                    color: AppTheme.primaryColor,
                    size: 20,
                  ),
                ),
                title: const Text(
                  'Камера',
                  style: TextStyle(color: AppTheme.darkColor),
                ),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Ionicons.images,
                    color: AppTheme.primaryColor,
                    size: 20,
                  ),
                ),
                title: const Text(
                  'Галерея',
                  style: TextStyle(color: AppTheme.darkColor),
                ),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        ),
      ),
    );

    if (source == null) return;

    // Для камеры запрашиваем разрешение
    // Для галереи в iOS 14+ не требуется разрешение при использовании image_picker
    if (source == ImageSource.camera) {
      final status = await Permission.camera.request();

      if (!status.isGranted) {
        if (mounted) {
          final shouldOpenSettings = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: AppTheme.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                'Разрешение не предоставлено',
                style: TextStyle(color: AppTheme.darkColor),
              ),
              content: Text(
                'Для использования камеры необходимо разрешение. Открыть настройки?',
                style: TextStyle(color: AppTheme.darkColor.withOpacity(0.7)),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    'Отмена',
                    style: TextStyle(color: AppTheme.darkColor.withOpacity(0.7)),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.primaryColor,
                  ),
                  child: const Text('Настройки'),
                ),
              ],
            ),
          );

          if (shouldOpenSettings == true) {
            await openAppSettings();
          }
        }
        return;
      }
    }

    // Выбираем изображение
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile == null) return;

      // Показываем загрузку
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      }

      // Загружаем на сервер
      final dio = DioClient.instance;
      final formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(
          pickedFile.path,
          filename: 'avatar.jpg',
        ),
      });

      await dio.put('/api/v1/users/me', data: formData);

      // Закрываем диалог загрузки
      if (mounted) {
        Navigator.pop(context);
      }

      developer.log('✅ [PROFILE] Avatar uploaded successfully');

      // Перезагружаем данные профиля
      await _loadUserData();

      if (mounted) {
        SnackBarUtils.showSuccess(context, 'Фото профиля обновлено');
      }
    } catch (e) {
      developer.log('❌ [PROFILE] Error uploading avatar: $e');

      // Закрываем диалог загрузки если открыт
      if (mounted && Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      if (mounted) {
        SnackBarUtils.showError(context, 'Не удалось загрузить фото');
      }
    }
  }

  Future<void> _logout() async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: AppTheme.whiteColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppTheme.darkColor.withOpacity(0.1),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Выйти из аккаунта?',
                style: TextStyle(
                  color: AppTheme.darkColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Вы действительно хотите выйти?',
                style: TextStyle(
                  color: AppTheme.darkColor.withOpacity(0.7),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Кнопка "Отмена"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.lightGrayColor,
                    foregroundColor: AppTheme.darkColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Отмена',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Кнопка "Выйти"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Выйти',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
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
      ).pushNamedAndRemoveUntil('/signup', (route) => false);

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
                          const SizedBox(height: 20),
                          // User Avatar
                          Center(
                            child: GestureDetector(
                              onTap: _pickAndUploadAvatar,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: _avatarUrl == null
                                          ? AppTheme.primaryColor
                                          : null,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.primaryColor
                                              .withOpacity(0.3),
                                          blurRadius: 20,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: _avatarUrl != null
                                        ? ClipOval(
                                            child: CachedNetworkImage(
                                              imageUrl: _avatarUrl!,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: AppTheme.primaryColor,
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: const Icon(
                                                          Ionicons.person,
                                                          size: 50,
                                                          color: AppTheme.whiteColor,
                                                        ),
                                                      ),
                                            ),
                                          )
                                        : const Icon(
                                            Ionicons.person,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: AppTheme.primaryColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppTheme.pageBackgroundColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: const Icon(
                                        Ionicons.camera,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
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
                          const SizedBox(height: 20),
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
              child: CustomHeader(title: 'Профиль', type: HeaderType.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          // Name
          Text(
            _firstName != null && _lastName != null
                ? '$_firstName $_lastName'
                : _firstName ?? _lastName ?? 'Пользователь',
            style: const TextStyle(
              color: AppTheme.darkColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: AppTheme.darkColor.withOpacity(0.9),
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildSettingsCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.darkColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // _buildSettingsItem(
          //   icon: Ionicons.stats_chart_outline,
          //   title: 'Аналитика',
          //   subtitle: 'Графики и статистика продуктивности',
          //   onTap: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(builder: (context) => const AnalyticsPage()),
          //     );
          //   },
          // ),
          //           Divider(height: 1, color: AppTheme.darkColor.withOpacity(0.1)),
          _buildSettingsItem(
            icon: Ionicons.trophy_outline,
            title: 'Челленджи',
            subtitle: 'Совместные события и достижения',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ChallengesPage()),
              );
            },
          ),
          Divider(height: 1, color: AppTheme.darkColor.withOpacity(0.1)),
          _buildSettingsItem(
            icon: Ionicons.medal_outline,
            title: 'Достижения',
            subtitle: 'Ваши награды и прогресс',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AchievementsPage(),
                ),
              );
            },
          ),
          Divider(height: 1, color: AppTheme.darkColor.withOpacity(0.1)),
          _buildSettingsItem(
            icon: Ionicons.notifications_outline,
            title: 'Уведомления',
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
                SnackBarUtils.showSuccess(
                  context,
                  value ? 'Уведомления включены' : 'Уведомления выключены',
                );
              },
              activeThumbColor: AppTheme.primaryColor,
            ),
            onTap: null,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.darkColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildSettingsItem(
            icon: Ionicons.information_circle_outline,
            title: 'Версия',
            subtitle: '1.0.0 (Beta)',
            onTap: () {},
          ),
          Divider(height: 1, color: AppTheme.darkColor.withOpacity(0.1)),
          _buildSettingsItem(
            icon: Ionicons.shield_checkmark_outline,
            title: 'Политика конфиденциальности',
            onTap: () {
              SnackBarUtils.showInfo(context, 'Политика - в разработке');
            },
          ),
          Divider(height: 1, color: AppTheme.darkColor.withOpacity(0.1)),
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
    Widget? trailing,
    VoidCallback? onTap,
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
                color: AppTheme.primaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppTheme.primaryColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppTheme.darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: AppTheme.darkColor.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            trailing ??
                Icon(
                  Ionicons.chevron_forward_outline,
                  color: AppTheme.darkColor.withOpacity(0.3),
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
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
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
                  color: AppTheme.whiteColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Выйти из аккаунта',
                  style: TextStyle(
                    color: AppTheme.whiteColor,
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
