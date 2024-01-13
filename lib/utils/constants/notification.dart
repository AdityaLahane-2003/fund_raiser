import 'package:flutter/material.dart';
import '../../firebase_services/notification_services/notification_service.dart';

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  String? mToken = "";
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.requestPermission();
    notificationServices.getToken().then((value) {
      // print("TOKEN: $value");
      mToken = value;
    });
    notificationServices.initLocalNotification();
    notificationServices.setContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Notification'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                notificationServices.sendPushMessage(mToken.toString(), "Body", "Title");
              },
              child: const Text('Send Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
