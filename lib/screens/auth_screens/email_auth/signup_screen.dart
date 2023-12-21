import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/firebase_services/user_services/add_user_details_service.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/verify_email.dart';

import '../../../components/round_button.dart';
import '../../../utils/utils_toast.dart';
import '../phone_auth/login_with_phone_number.dart';
import 'login_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool loading = false ;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

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


    _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value){
      setState(() {
        loading = false ;
      });
      user = _auth.currentUser!;
      addUserDetails("User",user!.email.toString(), "phone", 0, "bio");
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
        title: const Text('Sign up'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 90,horizontal: 10),
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
                            final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Enter a valid email address';
                            }
                            return null ;
                          },
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          obscureText: !isPasswordVisible,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.lock_open),
                              suffix:IconButton(
                                onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                                icon: Icon(
                                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                ),)
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter password';
                            }else if(value.length<6){
                              return 'Password must be at least 6 characters';
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
                  color: Colors.white,
                  size: 20,
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
                    const Text("Already have an account?"),
                    TextButton(onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder:(context) => const LoginScreen())
                      );
                    },
                        child: const Text('Login'))
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
                            builder: (context) => const LoginWithPhoneNumber(comingFrom: "signup",)));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black)),
                    child: const Center(
                      child: Text('SignUp with phone'),
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