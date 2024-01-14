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
                  "a.We do not provide any financial return in any form whatsoever, including but not limited to financial securities (debt or equity), interest, dividend, profit share, rewards in cash,"
                  " to individuals who contribute on Hrtaa.org.\n"
                  "\nb.Any contribution on Hrtaa.org, by an individual, should not be construed as an investment in any form whatsoever.\n"
                 ),
            ),
          ],
        ),
      ),
    );
  }
}
