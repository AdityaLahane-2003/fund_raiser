import 'package:flutter/material.dart';

import '../../../../components/footer.dart';
import '../../../../utils/constants/color_code.dart';

class AboutUsDetailsScreen extends StatefulWidget {
  const AboutUsDetailsScreen({Key? key}) : super(key: key);

  @override
  _AboutUsDetailsScreenState createState() => _AboutUsDetailsScreenState();
}

class _AboutUsDetailsScreenState extends State<AboutUsDetailsScreen> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Footer(),
      ],
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Text('About Us Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Replace with your image asset
              height: 100,
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                 """ a.We do not provide any financial return in any form whatsoever, including but not limited to financial securities (debt or equity), interest, dividend, profit share, rewards in cash,to individuals who contribute on Hrtaa.org.
                 
 b.Any contribution on Hrtaa.org, by an individual, should not be construed as an investment in any form whatsoever.\n
                
                
                
                TAARN Charity Foundation: Empowering Lives, Ensuring Trust

At TAARN, our mission is to facilitate a seamless, successful, and secure fundraising process for all. Is TAARN Genuine? Absolutely! Transparency and authenticity are non-negotiable for us. We vehemently oppose contribution pages attempting to bypass the required donation process by sharing direct links to different payment options. Instead, we guide visitors to each TAARN contribution page's prominent "Contribute Now" button.

At TAARN, safeguarding your privacy is paramount. We ensure that sensitive information such as names, phone numbers, and addresses remains confidential.

Why Choose TAARN?

Genuine and Transparent: We uphold the highest standards of transparency and authenticity in our fundraising processes.
Privacy Protection: Your private information is treated with utmost confidentiality.
User-Friendly Experience: We guide donors through a straightforward process, ensuring a positive and hassle-free experience.
Our Track Record:

Over 1,000 campaigners and more than 1 Lakh donors have placed their trust in TAARN.
Positive impact stories and successful campaigns underscore our commitment to making a difference.
Join Us:

We invite you to become part of our community and make a meaningful impact.
Empower lives, contribute to positive change, and trust in TAARN for a genuine and secure fundraising experience.
""" ),
            ),
          ],
        ),
      ),
    );
  }
}
