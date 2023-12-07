import 'package:flutter/material.dart';
import 'package:fund_raiser_second/home.dart';
import 'package:fund_raiser_second/screens/phone.dart';
import 'package:fund_raiser_second/screens/verify.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}