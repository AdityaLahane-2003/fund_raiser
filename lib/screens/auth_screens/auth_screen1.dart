import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/login_screen.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/signup_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/campaign_list.dart';

class AuthScreen1 extends StatelessWidget {
  const AuthScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink[100],
      // margin: EdgeInsets.only(left: 25, right: 25),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 50,
            child: Image.asset(
              "assets/logo.png",
              height: 125,
              width: 125,
            ),
          ),
          Positioned(
            top: 250,
            child: Image.asset(
              "assets/img1.png",
              height: 200,
              width: 200,
            ),
          ),
          const Positioned(
            top: 500,
            left: 3,
            right: 3,
            child: Text(
              "We help you to raise funds for your projects and any more text can be added here to make it look good",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.none),
            ),
          ),
          Positioned(
              top: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(40.0), backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const SignUpScreen()));
                      },
                      child: const Text("Start Fundraising",style: TextStyle(color: Colors.black),)),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(40.0),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const CampaignsList()));
                      },
                      child: const Text("Start Donating",style: TextStyle(color: Colors.black))),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: const Text(
                          "Already have an acoount? ",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()));
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
