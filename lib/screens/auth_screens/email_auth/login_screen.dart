import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fund_raiser_second/components/footer.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';
import 'package:fund_raiser_second/screens/auth_screens/auth_screen1.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/signup_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/home_dashboard.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import '../../../components/button.dart';
import '../../../utils/utils_toast.dart';
import '../phone_auth/login_with_phone_number.dart';
import 'forgot_passwod_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;
  DateTime? lastBackPressedTime;

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
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const HomeDashboard()));
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
  Future<bool> _onBackPressed() async {
    if (lastBackPressedTime == null ||
        DateTime.now().difference(lastBackPressedTime!) >
            const Duration(seconds: 2)) {
      lastBackPressedTime = DateTime.now();
      _showExitDialog();
      return false;
    } else {
      return true;
    }
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you really want to exit?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              SystemNavigator.pop();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    ).then((result) {
      if (result == true) {
        Navigator.of(context).pop(true);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        persistentFooterButtons: const [
          Footer(),
        ],
        appBar: AppBar(
          backgroundColor: greenColor,
          automaticallyImplyLeading: false,
          title: const Text('Login'),
          leading: IconButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AuthScreen1()));
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AuthScreen1()));
              },
              icon: const FaIcon(FontAwesomeIcons.backward, size: 20,),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                          prefixIcon: Icons.alternate_email,
                          textInputType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter email';
                            }
                            final emailRegex = RegExp(
                                r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
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
                    )),
                const SizedBox(
                  height: 30,
                ),
                Button(
                  title: '         Login        ',
                  loading: loading ,
                  color: greenColor,
                  onTap:() {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const ForgotPasswordScreen()));
                      },
                      child: Text('Forgot Password?',style: TextStyle(color: secondColor),)),
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
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: Text('Sign up',style: TextStyle(fontSize:18.0,color: Colors.blue.shade700),))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Button(
                  title: 'Login with phone',
                  color: secondColor,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginWithPhoneNumber(comingFrom: "login",)));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
