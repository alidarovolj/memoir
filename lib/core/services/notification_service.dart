import 'dart:async';
import 'dart:developer';
import 'dart:ui' show Color;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:memoir/core/network/dio_client.dart';

/// Background message handler - must be top-level function
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('📬 Background message received: ${message.messageId}');
  log('   Title: ${message.notification?.title}');
  log('   Body: ${message.notification?.body}');
  log('   Data: ${message.data}');
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  String? _fcmToken;

  /// Get FCM token
  String? get fcmToken => _fcmToken;

  /// Initialize notification service
  Future<void> initialize() async {
    if (_isInitialized) {
      log('ℹ️ Notification service already initialized');
      return;
    }

    try {
      // Request permission
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        log('✅ User granted notification permissions');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        log('⚠️ User granted provisional notification permissions');
      } else {
        log('❌ User declined or has not accepted notification permissions');
        return;
      }

      // Initialize local notifications
      await _initializeLocalNotifications();

      // Get FCM token
      _fcmToken = await _firebaseMessaging.getToken();
      log('🔑 FCM Token obtained: ${_fcmToken?.substring(0, 20)}...');

      // Send token to backend
      if (_fcmToken != null) {
        await _sendTokenToBackend(_fcmToken!);
      }

      // Listen to token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        log('🔄 FCM Token refreshed');
        _fcmToken = newToken;
        _sendTokenToBackend(newToken);
      });

      // Set up background handler
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // Handle notification taps
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

      // Check if app was opened from a terminated state
      RemoteMessage? initialMessage = await _firebaseMessaging
          .getInitialMessage();
      if (initialMessage != null) {
        _handleMessageOpenedApp(initialMessage);
      }

      _isInitialized = true;
      log('✅ Notification service initialized successfully');
    } catch (e, stackTrace) {
      log('❌ Failed to initialize notification service: $e');
      log('Stack trace: $stackTrace');
    }
  }

  /// Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    log('✅ Local notifications initialized');
  }

  /// Handle foreground message
  void _handleForegroundMessage(RemoteMessage message) {
    log('📬 Foreground message received: ${message.messageId}');
    log('   Title: ${message.notification?.title}');
    log('   Body: ${message.notification?.body}');
    log('   Data: ${message.data}');

    // Show local notification when app is in foreground
    _showLocalNotification(message);
  }

  /// Show local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    try {
      final notification = message.notification;
      if (notification == null) return;

      const androidDetails = AndroidNotificationDetails(
        'memoir_reminders', // channel ID
        'Task Reminders', // channel name
        channelDescription: 'Notifications for task reminders',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        icon: '@mipmap/ic_launcher',
        color: Color(0xFF6366F1), // Primary color
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _localNotifications.show(
        message.hashCode,
        notification.title,
        notification.body,
        details,
        payload: message.data.toString(),
      );

      log('✅ Local notification shown');
    } catch (e) {
      log('❌ Error showing local notification: $e');
    }
  }

  /// Handle message opened from notification tap
  void _handleMessageOpenedApp(RemoteMessage message) {
    log('🔔 Notification tapped: ${message.data}');

    final data = message.data;
    final type = data['type'];
    final taskId = data['task_id'];

    // Handle navigation based on notification type
    switch (type) {
      case 'task_reminder':
      case 'task_due_soon':
        if (taskId != null) {
          log('📋 Opening task: $taskId');
          // TODO: Navigate to task details page
          // navigatorKey.currentState?.pushNamed('/task-details', arguments: taskId);
        }
        break;
      case 'daily_summary':
        log('📊 Opening tasks page');
        // TODO: Navigate to tasks page
        // navigatorKey.currentState?.pushNamed('/tasks');
        break;
      default:
        log('ℹ️ Unknown notification type: $type');
    }
  }

  /// Handle notification tap (local notifications)
  void _onNotificationTapped(NotificationResponse response) {
    log('🔔 Local notification tapped: ${response.payload}');
    // Handle navigation here if needed
  }

  /// Send FCM token to backend
  Future<void> _sendTokenToBackend(String token) async {
    try {
      final dio = DioClient.instance;
      await dio.post('/api/v1/users/fcm-token', data: {'fcm_token': token});
      log('✅ FCM token sent to backend');
    } catch (e) {
      log('❌ Failed to send FCM token to backend: $e');
    }
  }

  /// Delete FCM token from backend (call on logout)
  Future<void> deleteToken() async {
    try {
      final dio = DioClient.instance;
      await dio.delete('/api/v1/users/fcm-token');
      await _firebaseMessaging.deleteToken();
      _fcmToken = null;
      log('✅ FCM token deleted');
    } catch (e) {
      log('❌ Failed to delete FCM token: $e');
    }
  }

  /// Request permission manually (for settings page)
  Future<bool> requestPermission() async {
    try {
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      return settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional;
    } catch (e) {
      log('❌ Failed to request permission: $e');
      return false;
    }
  }

  /// Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    try {
      final settings = await _firebaseMessaging.getNotificationSettings();
      return settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional;
    } catch (e) {
      log('❌ Failed to check notification settings: $e');
      return false;
    }
  }

  /// Subscribe to topic (optional - for broadcast notifications)
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      log('✅ Subscribed to topic: $topic');
    } catch (e) {
      log('❌ Failed to subscribe to topic: $e');
    }
  }

  /// Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      log('✅ Unsubscribed from topic: $topic');
    } catch (e) {
      log('❌ Failed to unsubscribe from topic: $e');
    }
  }
}
