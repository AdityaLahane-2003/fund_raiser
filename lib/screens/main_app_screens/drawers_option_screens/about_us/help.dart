import 'package:flutter/material.dart';

import '../../../../utils/constants/color_code.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 50,
            ),
            const Text(
              'Made with ',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 12,
            ),
          ],
        ),
      ],
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Text('Help'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FAQs:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            buildFAQ('How can I create a fundraising campaign?', 'To create a campaign, go to the Home screen and tap on the "Create Campaign" button. Follow the prompts to provide details about your cause, set a fundraising goal, and share your story.'),
            buildFAQ('How can I donate to a campaign?', 'To donate to a campaign, navigate to the campaign details page and tap on the "Donate" button. Select the donation amount and complete the payment process.'),
            buildFAQ('Can I edit my campaign details after creation?', 'Yes, you can edit your campaign details by going to the campaign details page and selecting the "Edit" option. Make the necessary changes and save your updates.'),
            buildFAQ('How can I contact support?', 'For support inquiries, please email us at support@fundraisingapp.com or call our helpline at +1 (123) 456-7890.'),
            const SizedBox(height: 16.0),
            const Text(
              'For additional assistance, please contact us:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Email: support@fundraisingapp.com\nPhone: +1 (123) 456-7890',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFAQ(String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(answer),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
