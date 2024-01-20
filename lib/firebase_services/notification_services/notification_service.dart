import 'dart:convert';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/display_campaigns_screen/campaign_list.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';
import 'package:http/http.dart' as http;

import '../../screens/main_app_screens/home_dashboard.dart';

class NotificationServices {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late BuildContext _context;

  void setContext(BuildContext context) {
    _context = context;
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
      // print('User granted permission: ${settings.authorizationStatus}');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // print(
      //     'User granted provisional permission: ${settings.authorizationStatus}');
    } else {
      AppSettings.openAppSettings();
      // print(
      //     'User declined or has not accepted permission: ${settings.authorizationStatus}');
    }
  }

  Future<String> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token!;
  }

  void initLocalNotification() async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        // print("Notification clicked with payload: $payload");
        Navigator.push(
          _context,
          MaterialPageRoute(builder: (context) => const CampaignsList()),
        );
      },
    );
  }

  void showNotification(String title, String body) async {
    var bigPictureStyleInformation = BigPictureStyleInformation(
       const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );

    var androidNotificationDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notification',
      channelDescription: 'This is a high importance notification',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: bigPictureStyleInformation,
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: 'custom_payload',
    );
  }

  void sendPushMessage(
      String token, String body, String title) async {
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
              "android_channel_id": "high_importance_channel",
            },
            'to': token,
          },
        ),
      );
      showNotification(title, body);
    } catch (e) {
      Utils().toastMessage("ERROR: $e", color:Colors.red);
    }
  }
}

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// void initLocalNotification(BuildContext context, RemoteMessage message) async{
//   var androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//   var initializationSettings = InitializationSettings(
//       android: androidInitializationSettings
//   );
//   await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//     onDidReceiveNotificationResponse: (payload){
//
//     }
//   );
// }
//
// Future<void>showNotificaiton(RemoteMessage message) async{
//
//   AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
//    Random.secure().nextInt(10000).toString(),
//     'High Importance Notification',
//     importance: Importance.high,
//   );
//
// AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
//     androidNotificationChannel.id.toString(),
//     androidNotificationChannel.name.toString(),
//   channelDescription: 'This is a high importance notification',
//   importance: Importance.high,
//   priority: Priority.high,
//   ticker: 'ticker',
// );
//
// NotificationDetails notificationDetails = NotificationDetails(
//   android: androidNotificationDetails,
// );
//   Future.delayed(Duration.zero,(){
//     flutterLocalNotificationsPlugin.show(
//       0,
//       message.notification!.title.toString(),
//       message.notification!.body.toString(),
//       notificationDetails,
//     );
//   });
// }

//
// void requestPermission() async{
//   NotificationSettings settings = await _firebaseMessaging.requestPermission(
//     alert: true,
//     announcement: true,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//
//   if(settings.authorizationStatus == AuthorizationStatus.authorized) {
//     print('User granted permission: ${settings.authorizationStatus}');
//   }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
//     print('User granted provisional permission: ${settings.authorizationStatus}');
//    }else{
//     AppSettings.openAppSettings();
//     print('User declined or has not accepted permission: ${settings.authorizationStatus}');
//   }
// }
//
//  Future<String> getToken() async{
//    String? token = await _firebaseMessaging.getToken();
//   return token!;
//  }

// void isTokenRefresh() async{
//    _firebaseMessaging.onTokenRefresh.listen((event) {
//      print('Token Refreshed: $event');
//    });
// }
//
// void firebaseInit(){
//  FirebaseMessaging.onMessage.listen((message) {
//     print('Message Received: $message');
//     showNotificaiton(message);
//   });
// }





// TAARN - Key Pair - > BJOVVnzqVfAYh-TMmNxJEEWNBJmuyalME9x0m82aXM27pNSOLnEut5Dv-lezlzF9qhLpp8kV4Ueti5aA-gMeemE