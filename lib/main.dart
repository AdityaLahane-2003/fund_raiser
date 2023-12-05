import 'package:flutter/material.dart';
import 'package:fund_raiser_second/phone.dart';
import 'package:fund_raiser_second/verify.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: 'phone',
    debugShowCheckedModeBanner: false,
    routes: {
      'phone': (context) => MyPhone(),
      'verify': (context) => MyVerify()
    },
  ));
}