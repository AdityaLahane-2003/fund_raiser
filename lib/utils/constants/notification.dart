import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fund_raiser_second/screens/main_app_screens/home_dashboard.dart';
import 'package:http/http.dart' as http;

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  String? mToken = "";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    requestPermission();
    getToken().then((value) {
      print("TOKEN: " + value);
      mToken = value;
    });
    initLocalNotification();
  }
  void requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission: ${settings.authorizationStatus}');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print(
          'User granted provisional permission: ${settings.authorizationStatus}');
    } else {
      print(
          'User declined or has not accepted permission: ${settings.authorizationStatus}');
    }
  }

  Future<String> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token!;
  }

  void initLocalNotification() async {
    var androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:(payload){
        print("Notification clicked with payload: $payload");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeDashboard()),
        );
     },
    );
  }

  void showNotification(String title, String body) async {
    var androidNotificationDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notification',
      channelDescription: 'This is a high importance notification',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
          'key=AAAAQ1ZjLRI:APA91bFWC7kxJ1454HNx-Ar7mnQQ7aNh31s3ky2cbUjxaJlDMaJXCV3NF2rbOVdK2hiSlxyd5aee0TpX9vhWNoE1tas29oGyV6g5oaggEJxsUJkGNCkOjp2R_GTBl32KIPZNxqk4_lYS',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "sound": "default",
              "android_channel_id": "high_importance_channel"
            },
            'to': token,
          },
        ),
      );
      showNotification(title, body);

    } catch (e) {
      print("ERROR: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Notification'),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                sendPushMessage(mToken.toString(), "Body", "Title");
              },
              child: Text('Send Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
