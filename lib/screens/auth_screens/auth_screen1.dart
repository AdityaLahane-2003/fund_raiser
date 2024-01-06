import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/button.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/login_screen.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/signup_screen.dart';
import 'package:fund_raiser_second/screens/auth_screens/phone_auth/login_with_phone_number.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/display_campaigns_screen/campaign_list.dart';

import '../../components/footer.dart';
import '../../utils/constants/color_code.dart';

class AuthScreen1 extends StatelessWidget {
  const AuthScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: const [
        Footer(),
      ],
      appBar: AppBar(
        titleSpacing: MediaQuery.of(context).size.width/3,
        title: const Text("Welcome",textAlign: TextAlign.center,),
        backgroundColor: greenColor,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 20,
              child: Image.asset(
                "assets/logo.png",
                height: 100,
                width: 100,
              ),
            ),
            Positioned(
              top: 150,
              child: Image.asset(
                "assets/img1.png",
                height: 200,
                width: 200,
              ),
            ),
            const Positioned(
              top: 370,
              left: 3,
              right: 3,
              child: Text(
                "We help you to raise funds for your projects and any more text can be added here to make it look good",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
            ),
            Positioned(
                top: 470,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Button(
                      color: greenColor,
                        title: 'Raise Fund',
                        onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const LoginWithPhoneNumber(comingFrom: "signup")));
                    }),
                    Button(
                      color: Colors.blue.shade700,
                        title: 'Donate Now',
                        onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const CampaignsList()));
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Already have an acoount? ",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.none),
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
      ),
    );
  }
}
