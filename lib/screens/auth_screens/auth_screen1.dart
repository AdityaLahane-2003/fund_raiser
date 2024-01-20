import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/button.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/login_screen.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Image.asset(
              "assets/logo.png",
              height: 100,
              width: 100,
            ),
            SizedBox(height: MediaQuery.of(context).size.height/25,),
            Container(
              height: 150,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/taarn-690cb.appspot.com/o/images%2Fdownload-removebg-preview.png?alt=media&token=202dd953-7f6a-46f0-a001-14f7b0563aac"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/25,),
            const Align(
              alignment: Alignment.center,
              child:  Text(
                "Join TAARN and be part of a community \n that believes in the power of kindness.\n Together, we can bring hope, joy,\n and positive change to countless lives.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Button(
                color: greenColor,
                title: 'Raise Fund',
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LoginWithPhoneNumber(comingFrom: "signup")));
                }),
            Button(
                color: secondColor,
                title: 'Donate Now',
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const CampaignsList()));
                }),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an acoount?  ",
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
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      decoration: TextDecoration.none,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
