import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/firebase_services/add_user_details_service.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/verify_email.dart';

import '../../../components/round_button.dart';
import '../../../utils/utils_toast.dart';
import '../../post_auth_screens/take_user_info.dart';
import '../phone_auth/login_with_phone_number.dart';
import 'login_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool loading = false ;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final  _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

  }


  void signUp(){
    setState(() {
      loading = true ;
    });



    // _auth.sendSignInLinkToEmail(
    //   email: emailController.text.toString(),
    //   actionCodeSettings: ActionCodeSettings(
    //     url: 'https://flutterauth.page.link/',
    //     handleCodeInApp: true,
    //     iOSBundleId: 'com.techease.dumy',
    //     androidPackageName: 'com.techease.dumy',
    //     androidMinimumVersion: "1",
    //   ),
    //
    // ).then((value){
    // }).onError((error, stackTrace){
    //   print(error.toString());
    // });

    _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value){
      setState(() {
        loading = false ;
      });
      user = _auth.currentUser!;
      addUserDetails("User",user!.email.toString() ?? "email", "phone", 0, "bio");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const VerifyEmail(isSignUp: true,))
      );
    }).onError((error, stackTrace){
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false ;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 90,horizontal: 10),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: const  InputDecoration(
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.alternate_email)
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter email';
                            }
                            return null ;
                          },
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          obscureText: true,
                          decoration: const  InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock_open)
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter password';
                            }
                            return null ;
                          },
                        ),

                      ],
                    )
                ),
                const SizedBox(height: 50,),
                RoundButton(
                  title: 'Sign up',
                  loading: loading ,
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      signUp();
                    }
                  },
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder:(context) => LoginScreen())
                      );
                    },
                        child: Text('Login'))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginWithPhoneNumber(comingFrom: "signup",)));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black)),
                    child: Center(
                      child: Text('Login with phone'),
                    ),
                  ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }

}