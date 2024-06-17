
import 'package:flutter/material.dart';
import 'package:local_notification_learn/screens/animation_learn.dart';
import 'package:local_notification_learn/screens/firebase_notification_screen.dart';
import 'package:local_notification_learn/screens/home_screen.dart';

class Routes {
  static const String home = '/';
  static const String aniFirst = '/animation_first';
  static const String aniSecond = '/animation_second';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      print("home");
      return MaterialPageRoute(builder: (_) =>AnimationFirstPage());
    case Routes.aniFirst:
      return MaterialPageRoute(builder: (_) => AnimationFirstPage());
    case Routes.aniSecond:
      return MaterialPageRoute(builder: (_) => AnimationSecondPage());
    default:
      print("default");
      return MaterialPageRoute(builder: (_) => FirebaseNotificationScreen());
  }
}