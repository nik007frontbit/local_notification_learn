import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../firebase_options.dart';
import '../../screens/analytics.dart';

String fcm = "";

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  AndroidNotificationChannel androidNotificationChannel =
      const AndroidNotificationChannel(
    "high_notification_channel",
    "High Notification",
    description: "This channel is important to show notification",
    importance: Importance.max,
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
        Get.to(AnalyticScreen());
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
      print('Received a value intial foreground message: ${value}');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('Received a event foreground message: ${event}');
    });
    print("background");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification == null) return;
      print('Received a foreground message: ${message.messageId}');
      print(message.notification?.body);
      print(message.notification?.title);
      print(message.data);
      /*  _flutterLocalNotificationsPlugin.show(
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
      );*/
    });
  }

  initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    log("TOken :- $fcmToken");
    print("TOken :- $fcmToken");

    initPushNotification();
    initLocalNotificationSetting();
  }

  initNoti() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    fcm = fcmToken.toString();
    log("TOken :- $fcmToken");
    print("TOken :- $fcmToken");
  }
}
