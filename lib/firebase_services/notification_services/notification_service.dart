import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices{
   FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

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


   void requestPermission() async{
     NotificationSettings settings = await _firebaseMessaging.requestPermission(
       alert: true,
       announcement: true,
       badge: true,
       carPlay: false,
       criticalAlert: false,
       provisional: false,
       sound: true,
     );

     if(settings.authorizationStatus == AuthorizationStatus.authorized) {
       print('User granted permission: ${settings.authorizationStatus}');
     }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
       print('User granted provisional permission: ${settings.authorizationStatus}');
      }else{
       AppSettings.openAppSettings();
       print('User declined or has not accepted permission: ${settings.authorizationStatus}');
     }
   }

    Future<String> getToken() async{
      String? token = await _firebaseMessaging.getToken();
     return token!;
    }

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

}