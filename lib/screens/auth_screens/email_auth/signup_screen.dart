import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/button.dart';
import 'package:fund_raiser_second/components/footer.dart';
import 'package:fund_raiser_second/firebase_services/user_services/add_user_details_service.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/verify_email.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import '../../../components/text_filed_area.dart';
import '../../../utils/utils_toast.dart';
import '../phone_auth/login_with_phone_number.dart';

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
      persistentFooterButtons: const [
      Footer()
      ],
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Text('Sign up'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/logo.png'),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 20,),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormFieldArea(
                          title: 'Email',
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          prefixIcon: Icons.email,
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
                        TextFormFieldArea(
                          title: 'Password',
                          controller: passwordController,
                          textInputType: TextInputType.text,
                          prefixIcon: Icons.lock_open,
                          obscureText: !isPasswordVisible,
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
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
                const SizedBox(height: 15,),
                Button(
                    title: '           Sign up           ',
                  loading: loading ,
                    color: greenColor,
                    onTap:  (){
                      if(_formKey.currentState!.validate()){
                        signUp();
                      }
                    },),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder:(context) => const LoginWithPhoneNumber(comingFrom: "login",))
                      );
                    },
                        child: Text('Login',style: TextStyle(fontSize:17,color: Colors.blue.shade700),))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Button(
                  title: '   SignUp With Phone   ',
                  color: secondColor,
                  onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginWithPhoneNumber(comingFrom: "signup",)));
                },),

              ],
            ),
          ),
        ],
      ),
    );
  }

}