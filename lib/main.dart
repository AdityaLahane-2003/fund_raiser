import 'package:flutter/material.dart';
import 'package:fund_raiser_second/phone.dart';
import 'package:fund_raiser_second/verify.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: 'phone',
    debugShowCheckedModeBanner: false,
    routes: {
      'phone': (context) => MyPhone(),
      'verify': (context) => MyVerify()
    },
  ));
}