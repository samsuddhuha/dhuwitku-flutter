import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FcmService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotif =
      FlutterLocalNotificationsPlugin();

  static bool _initialized = false;
  static String? _token;
  static String? get token => _token;

  /// ======================
  /// INIT (SAFE)
  /// ======================
  static Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    /// 🔐 Permission
    if (Platform.isIOS) {
      await _messaging.requestPermission(alert: true, badge: true, sound: true);
    } else {
      await _messaging.requestPermission();
    }

    /// 🔔 Local notification init
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();

    await _localNotif.initialize(
      const InitializationSettings(android: androidSettings, iOS: iosSettings),
      onDidReceiveNotificationResponse: _onLocalNotifTap,
    );

    /// 🔹 Foreground message
    FirebaseMessaging.onMessage.listen(_onMessage);

    /// 🔹 Tap notification (background)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleDeeplink(message.data);
    });

    /// 🔹 Tap notification (terminated)
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleDeeplink(initialMessage.data);
    }

    /// 🔄 Token refresh listener (WAJIB)
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      _token = newToken;
      debugPrint('🔄 FCM token refreshed');
      // TODO: kirim ke backend kalau perlu
    });

    /// 🔑 Initial token
    await _initToken();
  }

  /// ======================
  /// TOKEN INIT (SAFE)
  /// ======================
  static DateTime? _lastTokenFetch;

  static Future<void> _initToken() async {
    try {
      /// 🛑 Anti spam (5 menit)
      if (_lastTokenFetch != null &&
          DateTime.now().difference(_lastTokenFetch!) <
              const Duration(minutes: 5)) {
        return;
      }

      _lastTokenFetch = DateTime.now();

      if (Platform.isIOS) {
        final apns = await _messaging.getAPNSToken();
        if (apns == null) return;
      }

      _token = await _messaging.getToken();
      debugPrint('✅ FCM token: $_token');
    } catch (e) {
      if (e.toString().contains('TOO_MANY_REGISTRATIONS')) {
        debugPrint('⚠️ FCM throttled (skip token)');
        return;
      }

      debugPrint('❌ FCM token error: $e');
    }
  }

  /// ======================
  /// FOREGROUND HANDLER
  /// ======================
  static Future<void> _onMessage(RemoteMessage message) async {
    final notif = message.notification;
    if (notif == null) return;

    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'General',
      channelDescription: 'General notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    await _localNotif.show(
      notif.hashCode,
      notif.title,
      notif.body,
      const NotificationDetails(android: androidDetails, iOS: iosDetails),
      payload: jsonEncode(message.data),
    );
  }

  /// ======================
  /// LOCAL NOTIF TAP
  /// ======================
  static void _onLocalNotifTap(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null) return;

    final data = jsonDecode(payload) as Map<String, dynamic>;
    _handleDeeplink(data);
  }

  /// ======================
  /// DEEPLINK HANDLER
  /// ======================
  static void _handleDeeplink(Map<String, dynamic> data) {
    debugPrint("Received deeplink data: $data");
    final router = data['router'];
    debugPrint("router data: $router");

    switch (router) {
      case '/detail/cashin':
        debugPrint("reff data: ${data['reff']}");
        // navigatorKey.currentState?.push(
        //   MaterialPageRoute(
        //     builder: (_) => ReportDetailPage(reffCashIn: data['reff']),
        //   ),
        // );
        break;

      case 'profile':
        // TODO: handle deeplink
        // navigatorKey.currentState?.push(
        //   MaterialPageRoute(builder: (_) => const ProfilePage()),
        // );
        break;

      default:
        debugPrint('⚠️ Unknown deeplink type: $router');
    }
  }

  /// ======================
  /// TOKEN ASYNC ACCESS
  /// ======================
  static Future<String?> getTokenAsync() async {
    if (_token != null) return _token;

    if (Platform.isIOS) {
      final apns = await _messaging.getAPNSToken();
      if (apns == null) return null;
    }

    _token = await _messaging.getToken();
    return _token;
  }
}
