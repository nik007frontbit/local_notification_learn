import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../firebase/messaging/api.dart';
import '../main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<void> showNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "notification-leaning",
      "Local Notification",
      priority: Priority.max,
      importance: Importance.high,
    );
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        0, "First notification", "Here i am boy", notificationDetails,
        payload: "notification-0");
  }

  notificationDetails() async {
    NotificationAppLaunchDetails? details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null) {
      if (details.didNotificationLaunchApp) {
        NotificationResponse? notificationResponse =
            details.notificationResponse;

        setState(() {
          texts = notificationResponse!.payload.toString();
        });
      }
    }
  }

  String texts = "hello";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationDetails();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              texts,
            ),
            Text(
              fcm.toString(),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showNotification,
        tooltip: 'Notification',
        child: const Icon(Icons.notification_add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
