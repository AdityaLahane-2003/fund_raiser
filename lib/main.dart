import 'package:flutter/material.dart';
import 'package:fund_raiser_second/home.dart';
import 'package:fund_raiser_second/screens/auth_screens/otp_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // try {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  //   runApp(MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     home: Home(),
  //   ));
  // } catch (e) {
  //   print('Error initializing Firebase: $e');
  // }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}