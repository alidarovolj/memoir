import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/core/services/notification_service.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'dart:developer';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _isLoading = true;
  bool _taskRemindersEnabled = true;
  int _reminderHoursBefore = 1;
  bool _notificationsPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      setState(() => _isLoading = true);

      // Check notification permissions
      final notificationService = NotificationService();
      _notificationsPermissionGranted = await notificationService
          .areNotificationsEnabled();

      // Load settings from backend
      final dio = DioClient.instance;
      final response = await dio.get('/api/v1/users/notification-settings');

      setState(() {
        _taskRemindersEnabled = response.data['task_reminders_enabled'] ?? true;
        _reminderHoursBefore = response.data['reminder_hours_before'] ?? 1;
        _isLoading = false;
      });

      log('✅ Notification settings loaded');
    } catch (e) {
      log('❌ Failed to load notification settings: $e');
      setState(() => _isLoading = false);
      if (mounted) {
        SnackBarUtils.showError(
          context,
          'Не удалось загрузить настройки уведомлений',
        );
      }
    }
  }

  Future<void> _saveSettings() async {
    try {
      final dio = DioClient.instance;
      await dio.put(
        '/api/v1/users/notification-settings',
        data: {
          'task_reminders_enabled': _taskRemindersEnabled,
          'reminder_hours_before': _reminderHoursBefore,
        },
      );

      if (mounted) {
        SnackBarUtils.showSuccess(context, 'Настройки сохранены');
      }

      log('✅ Notification settings saved');
    } catch (e) {
      log('❌ Failed to save notification settings: $e');
      if (mounted) {
        SnackBarUtils.showError(context, 'Не удалось сохранить настройки');
      }
    }
  }

  Future<void> _requestPermission() async {
    final notificationService = NotificationService();
    final granted = await notificationService.requestPermission();

    setState(() {
      _notificationsPermissionGranted = granted;
    });

    if (granted) {
      if (mounted) {
        SnackBarUtils.showSuccess(
          context,
          'Разрешения на уведомления предоставлены',
        );
      }
    } else {
      if (mounted) {
        SnackBarUtils.showError(
          context,
          'Разрешения на уведомления не предоставлены',
        );
      }
    }
  }

  Future<void> _sendTestNotification() async {
    try {
      if (!_notificationsPermissionGranted) {
        SnackBarUtils.showError(
          context,
          'Сначала предоставьте разрешения на уведомления',
        );
        return;
      }

      final dio = DioClient.instance;
      await dio.post('/api/v1/users/test-notification');

      if (mounted) {
        SnackBarUtils.showSuccess(context, 'Тестовое уведомление отправлено!');
      }

      log('✅ Test notification sent');
    } catch (e) {
      log('❌ Failed to send test notification: $e');
      if (mounted) {
        SnackBarUtils.showError(context, 'Не удалось отправить уведомление');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Уведомления'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Ionicons.chevron_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Permission status
                  _buildPermissionCard(),

                  const SizedBox(height: 24),

                  // Task reminders toggle
                  _buildSectionTitle('Напоминания о задачах'),
                  const SizedBox(height: 12),
                  _buildToggleTile(
                    title: 'Включить напоминания',
                    subtitle: 'Получать уведомления о предстоящих задачах',
                    icon: Ionicons.notifications,
                    value: _taskRemindersEnabled,
                    enabled: _notificationsPermissionGranted,
                    onChanged: (value) {
                      setState(() => _taskRemindersEnabled = value);
                      _saveSettings();
                    },
                  ),

                  const SizedBox(height: 16),

                  // Reminder time selector
                  if (_taskRemindersEnabled) ...[
                    _buildSectionTitle('Время напоминания'),
                    const SizedBox(height: 12),
                    _buildReminderTimeSelector(),
                  ],

                  const SizedBox(height: 24),

                  // Test notification button
                  if (_notificationsPermissionGranted)
                    _buildTestNotificationButton(),
                ],
              ),
            ),
    );
  }

  Widget _buildPermissionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _notificationsPermissionGranted
            ? Colors.green.shade50
            : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _notificationsPermissionGranted
              ? Colors.green.shade200
              : Colors.orange.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(
            _notificationsPermissionGranted
                ? Ionicons.checkmark_circle
                : Ionicons.alert_circle,
            color: _notificationsPermissionGranted
                ? Colors.green.shade700
                : Colors.orange.shade700,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _notificationsPermissionGranted
                      ? 'Уведомления включены'
                      : 'Уведомления выключены',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _notificationsPermissionGranted
                        ? Colors.green.shade900
                        : Colors.orange.shade900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _notificationsPermissionGranted
                      ? 'Вы будете получать напоминания о задачах'
                      : 'Предоставьте разрешения для получения уведомлений',
                  style: TextStyle(
                    fontSize: 13,
                    color: _notificationsPermissionGranted
                        ? Colors.green.shade700
                        : Colors.orange.shade700,
                  ),
                ),
              ],
            ),
          ),
          if (!_notificationsPermissionGranted)
            TextButton(
              onPressed: _requestPermission,
              child: const Text('Включить'),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildToggleTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required bool enabled,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: enabled ? onChanged : null,
        title: Row(
          children: [
            Icon(icon, size: 20, color: AppTheme.primaryColor),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: enabled ? Colors.black87 : Colors.grey,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: enabled ? Colors.grey.shade600 : Colors.grey.shade400,
            ),
          ),
        ),
        activeThumbColor: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildReminderTimeSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Ionicons.time_outline, size: 20),
              const SizedBox(width: 12),
              const Text(
                'Напоминать за:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildTimeChip('30 минут', 0),
              _buildTimeChip('1 час', 1),
              _buildTimeChip('2 часа', 2),
              _buildTimeChip('6 часов', 6),
              _buildTimeChip('12 часов', 12),
              _buildTimeChip('1 день', 24),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeChip(String label, int hours) {
    final isSelected = _reminderHoursBefore == hours;

    return GestureDetector(
      onTap: () {
        setState(() => _reminderHoursBefore = hours);
        _saveSettings();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildTestNotificationButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _sendTestNotification,
        icon: const Icon(Ionicons.paper_plane_outline),
        label: const Text('Отправить тестовое уведомление'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
