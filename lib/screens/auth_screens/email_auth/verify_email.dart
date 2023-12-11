import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/login_screen.dart';
import 'package:fund_raiser_second/screens/post_auth_screens/take_user_info.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';

import '../../../firebase_services/add_user_details_service.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {

final auth=FirebaseAuth.instance;
late User user;
late Timer timer;
@override
  void initState() {
    user = auth.currentUser!;
  addUserDetails("User",user.email.toString(), "phone", 0, "bio");
    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
        checkEmailVerified();
        // if(user==null){
        //   timer.cancel();
        // }else{
        // Utils().toastMessage("Verifying Email, Please wait !",color: Colors.yellow);
        // }
    });
    super.initState();
  }

  @override
  void dispose() {
  timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: (){
            timer.cancel();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
          }, icon: Icon(Icons.close))
        ],
        title: Text("Verify Email"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.green,),
            Text("Verification link sent to your email ID"),
            Text(" Please Verify Email!"),
            SizedBox(height: 10,),
            ElevatedButton(
                onPressed: () {
                  user = auth.currentUser!;
                  user.sendEmailVerification();
                },
                child: Text("Resend Verification Link "))
          ],
        )),
      ),
    );
  }

Future<void> checkEmailVerified()async{
  user=auth.currentUser!;
  await user.reload();

  if(user.emailVerified){
    timer.cancel();
    Utils().toastMessage("Email Verified Successfully",color: Colors.green);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>TakeUserInfoScreen()));
  }
}
}
