import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/footer.dart';
import 'package:fund_raiser_second/components/loading.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/login_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/take_user_info.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';

import '../../../components/button.dart';

class VerifyEmail extends StatefulWidget {
  final bool isSignUp;

  const VerifyEmail({super.key, required this.isSignUp});

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
    user.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        checkEmailVerified();
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
      persistentFooterButtons: const [
         Footer(),
      ],
      appBar: AppBar(
        backgroundColor: greenColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: (){
            timer.cancel();
            widget.isSignUp?Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()))
            :Navigator.pop(context);
          }, icon: const Icon(Icons.close))
        ],
        title: const Text("Verify Email"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/logo.png'),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 10,),
             Loading(size: 90, color: secondColor),
            const SizedBox(height: 20,),
            const Text("Verification link sent to your email ID"),
            const Text(" Please Verify Email!"),
            const SizedBox(height: 10,),
            Button(
              color: greenColor,
              title:"Resend Verification Link ",
                onTap: () {
                  user = auth.currentUser!;
                  user.sendEmailVerification();
                },),
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
    widget.isSignUp?Navigator.push(context, MaterialPageRoute(builder: (context)=>const TakeUserInfoScreen()))
        :Navigator.pop(context);
  }
}
}
