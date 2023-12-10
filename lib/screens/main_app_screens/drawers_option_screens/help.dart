import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FAQs:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            buildFAQ('How can I create a fundraising campaign?', 'To create a campaign, go to the Home screen and tap on the "Create Campaign" button. Follow the prompts to provide details about your cause, set a fundraising goal, and share your story.'),
            buildFAQ('How can I donate to a campaign?', 'To donate to a campaign, navigate to the campaign details page and tap on the "Donate" button. Select the donation amount and complete the payment process.'),
            buildFAQ('Can I edit my campaign details after creation?', 'Yes, you can edit your campaign details by going to the campaign details page and selecting the "Edit" option. Make the necessary changes and save your updates.'),
            buildFAQ('How can I contact support?', 'For support inquiries, please email us at support@fundraisingapp.com or call our helpline at +1 (123) 456-7890.'),
            SizedBox(height: 16.0),
            Text(
              'For additional assistance, please contact us:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(answer),
        SizedBox(height: 16.0),
      ],
    );
  }
}
