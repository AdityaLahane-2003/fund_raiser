import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/footer.dart';
import 'package:fund_raiser_second/screens/main_app_screens/drawers_option_screens/about_us/privacy_policy_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/drawers_option_screens/about_us/terms_and_conditions_screen.dart';

import '../../../../utils/constants/color_code.dart';
import 'about_us_screen.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Footer(),
      ],
      appBar: AppBar(
      backgroundColor: greenColor,
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Replace with your image asset
              height: 200,
            ),
            const SizedBox(height: 16.0),
            Material(
              elevation: 5.0,
              shadowColor: Colors.blueGrey,
              child: ListTile(
                leading: Icon(Icons.info),
                title: const Text(
                  'About Us',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutUsDetailsScreen(),
                    ),
                  );
                },
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            const SizedBox(height: 10.0),
            Material(
              elevation: 5.0,
              shadowColor: Colors.blueGrey,
              child: ListTile(
                leading: Icon(Icons.assignment),
                title: const Text(
                  'Terms and Conditions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TermsAndConditionsScreen(),
                    ),
                  );
                },
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            const SizedBox(height: 10.0),
            Material(
              elevation: 5.0,
              shadowColor: Colors.blueGrey,
              child: ListTile(
                leading: Icon(Icons.lock),
                title: const Text(
                  'Privacy Policy',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyScreen(),
                    ),
                  );
                },
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            const SizedBox(height: 10.0),
            Material(
              elevation: 5.0,
              shadowColor: Colors.blueGrey,
              child: ListTile(
                leading: Icon(Icons.star),
                title: const Text(
                  'Rate Us',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                },
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
    );
  }
}