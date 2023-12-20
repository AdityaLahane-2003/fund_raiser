import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/signup_screen.dart';
import 'package:fund_raiser_second/screens/auth_screens/phone_auth/login_with_phone_number.dart';
import 'package:fund_raiser_second/screens/main_app_screens/home_dashboard.dart';
import '../../../components/round_button.dart';
import '../../../utils/utils_toast.dart';
import 'forgot_passwod_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
      Utils().toastMessage(value.user!.email.toString(), color: Colors.green);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeDashboard()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                          decoration: const InputDecoration(
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.alternate_email)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter email';
                            }final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          obscureText: !isPasswordVisible,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock_open),
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
                    )),
                const SizedBox(
                  height: 30,
                ),
                RoundButton(
                  title: 'Login',
                  loading: loading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen()));
                      },
                      child: Text('Forgot Password?')),
                ),
                // const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text('Sign up'))
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
                            builder: (context) => LoginWithPhoneNumber(comingFrom: "login",)));
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
        ),
      ),
    );
  }
}
