import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionProvider with ChangeNotifier {

  bool isSmsPermissionGranted = false;
  bool isNotificationPermissionGranted = false;

  get smsPermissionGranted => isSmsPermissionGranted;
  get notificationPermissionGranted => isNotificationPermissionGranted;

  // External Storage Permission
  // Future<bool> requestExternalStoragePermission() async {
  //   var status = await Permission.storage.status;
  //   print("Status: ${status.toString()}");
  //
  //   if (status.isDenied) {
  //     var result = await Permission.storage.request();
  //   print("Result: ${result.toString()}");
  //     notifyListeners();
  //     return result.isGranted;
  //   }
  //   return status.isGranted;
  // }

  // SMS Permission
  Future<bool> requestSmsPermission() async {
    var status = await Permission.sms.status;
    if (status.isDenied) {
      var result = await Permission.sms.request();
      notifyListeners();
      isSmsPermissionGranted = result.isGranted;
      return result.isGranted;
    }
    isSmsPermissionGranted = status.isGranted;
    return status.isGranted;
  }

  // Notification Permission
  Future<bool> requestNotificationPermission() async {
    var status = await Permission.notification.status;
    if (status.isDenied) {
      var result = await Permission.notification.request();
      notifyListeners();
      isNotificationPermissionGranted = result.isGranted;
      return result.isGranted;
    }
    isNotificationPermissionGranted = status.isGranted;
    return status.isGranted;
  }
}
