import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/login_screen.dart';

import '../../../components/button.dart';
import '../../../utils/utils_toast.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final emailController =TextEditingController();
  final auth = FirebaseAuth.instance ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: const AssetImage('assets/logo.png'),
              backgroundColor: Colors.transparent,
            ),
          SizedBox(height: 20,),
          TextFormFieldArea(
            title:'Email',
            prefixIcon:Icons.email,
          textInputType: TextInputType.emailAddress,
          controller: emailController,
          validator: (value){
            if(value!.isEmpty){
              return 'Enter email';
            }
            final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
            if (!emailRegex.hasMatch(value)) {
              return 'Enter a valid email address';
            }
            return null ;
          },
        ),
            const SizedBox(height: 40,),
            Button(
                title: '   Get Email   ',
                color: Colors.blue.shade700,
                onTap: (){
              auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
                Utils().toastMessage('We have sent you email to recover password, please check email');
                Utils().toastMessage('Also check in spam folder and login with your new password !');
                Navigator.push(context,
                    MaterialPageRoute(
                        builder:(context) => const LoginScreen())
                );
              }).onError((error, stackTrace){
                Utils().toastMessage(error.toString());
              });
            })
          ],
        ),
      ),
    );
  }
}