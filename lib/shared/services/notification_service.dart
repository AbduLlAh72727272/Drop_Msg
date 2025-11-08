import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  
  static Future<void> initialize() async {
    // Initialize local notifications
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
    
    // Request permissions for iOS
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      announcement: false,
    );
    
    // Configure Firebase messaging
    FirebaseMessaging.onMessage.listen(_onMessageReceived);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
    
    // Get FCM token
    await _getFCMToken();
  }
  
  static void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap
    debugPrint('Notification tapped: ${response.payload}');
  }
  
  static void _onMessageReceived(RemoteMessage message) {
    // Handle foreground messages
    _showLocalNotification(
      title: message.notification?.title ?? 'New Message',
      body: message.notification?.body ?? '',
      payload: message.data.toString(),
    );
  }
  
  static void _onMessageOpenedApp(RemoteMessage message) {
    // Handle notification tap when app is in background
    debugPrint('Message clicked: ${message.data}');
  }
  
  static Future<String?> _getFCMToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      debugPrint('FCM Token: $token');
      return token;
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
      return null;
    }
  }
  
  static Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'dropmsg_channel',
      'DropMsg Notifications',
      channelDescription: 'Notifications for DropMsg app',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
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
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      details,
      payload: payload,
    );
  }
  
  static Future<void> showMessageNotification({
    required String senderName,
    required String message,
    String? chatId,
  }) async {
    await _showLocalNotification(
      title: senderName,
      body: message,
      payload: chatId,
    );
  }
  
  static Future<void> showCallNotification({
    required String callerName,
    required bool isVideoCall,
    String? callId,
  }) async {
    await _showLocalNotification(
      title: 'Incoming ${isVideoCall ? 'Video' : 'Voice'} Call',
      body: 'From $callerName',
      payload: callId,
    );
  }
  
  static Future<void> cancelAll() async {
    await _localNotifications.cancelAll();
  }
  
  static Future<void> cancelNotification(int id) async {
    await _localNotifications.cancel(id);
  }
}