import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  AndroidNotificationChannel androidNotificationChannel =
      const AndroidNotificationChannel(
    "high_notification_channel",
    "High Notification",
    description: "This channel is important to show notification",
    importance: Importance.high,
  );
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  initLocalNotificationSetting() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    DarwinInitializationSettings darwinInitializationSettings =
        const DarwinInitializationSettings(
      requestBadgePermission: true,
      requestAlertPermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true,
    );
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final message = RemoteMessage.fromMap(jsonDecode(details.payload!));
        handleMessage(message);
      },
    );
  }

  Future<void> handleBackgroundMessage(RemoteMessage? message) async {
    if (message == null) return;
    print(message.notification?.body);
    print(message.notification?.title);
    print(message.data);
  }

  Future<void> handleMessage(RemoteMessage? message) async {
    if (message == null) return;
    print("FOreground message init");
    print(message.data);
  }

  initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      print('Received a value foreground message: ${value}');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('Received a event foreground message: ${event}');
    });
   /* FirebaseMessaging.onBackgroundMessage((RemoteMessage? message) async {
      if(message==null)return;
      print('Handling a background message: ${message.messageId}');
    });*/
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification == null) return;
      print('Received a foreground message: ${message.messageId}');
      print(message.notification?.body);
      print(message.notification?.title);
      print(message.data);
      _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            androidNotificationChannel.id,
            androidNotificationChannel.name,
            channelDescription: androidNotificationChannel.description,
            icon: "@mipmap/ic_launcher",
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    log("TOken :- $fcmToken");
    initPushNotification();
    initLocalNotificationSetting();
  }
}
