import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class AnalyticScreen extends StatefulWidget {
  AnalyticScreen({super.key});

  @override
  State<AnalyticScreen> createState() => _AnalyticScreenState();
}

class _AnalyticScreenState extends State<AnalyticScreen> {
  int indexScreen = 0;
  final analytics = FirebaseAnalytics.instance;
  List screens = [
    "Home",
    "History",
    "Setting",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnalyticsScreenShow(name: screens[indexScreen]),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home,),label: "home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history, ),label: "History"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, ),label: "Setting"),
        ],
        currentIndex: indexScreen,
        onTap: (value) {
          analytics.logEvent(name: "page_tracker", parameters: {
            'page_name': screens[value],
            'page_index': value,
          }).then((value) => print("value "));

          indexScreen = value;
          setState(() {});
        },
      ),
    );
  }
}

class AnalyticsScreenShow extends StatelessWidget {
  String name;

  AnalyticsScreenShow({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        name,
      ),
    );
  }
}
