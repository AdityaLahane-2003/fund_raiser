import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/post_auth_screens/home_screen.dart';
import 'package:fund_raiser_second/screens/intro_screens/intro_home.dart';


class SplashServices{

  void isLogin(BuildContext context){

    final auth = FirebaseAuth.instance;
    final user =  auth.currentUser ;

    if(user != null){
      Timer(const Duration(seconds: 3),
              ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()))
      );
    }else {
      Timer(const Duration(seconds: 3),
              ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => IntroHome()))
      );
    }


  }
}