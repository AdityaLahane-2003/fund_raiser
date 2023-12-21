import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/loading.dart';
import '../firebase_services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
            [Image(image: AssetImage('assets/logo.png')),
              SizedBox(height: 20.0,),
              Loading(size: 50.0, color: Colors.green.shade400)
            ],
        ),
      ),
    );
  }
}
