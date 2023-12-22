import 'package:flutter/material.dart';

class OurSuggestionsPage extends StatelessWidget {
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
            Text(
              'Made with ',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Icon(
              Icons.favorite,
              color: Colors.red,
              size: 12,
            ),
          ],
        ),
      ],
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text('Our Suggestions'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Our Suggestions to Raise More Funds',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              buildSuggestionPoint(
                '1. Share on Social Media:',
                'Leverage the power of social media platforms to spread the word about your campaign. Share updates, photos, and success stories to engage your audience.',
              ),
              buildSuggestionPoint(
                '2. Regularly Update Your Campaign:',
                'Keep your supporters informed by regularly updating your campaign with progress, achievements, and future plans. Transparency builds trust.',
              ),
              buildSuggestionPoint(
                '3. Personalize Your Campaign:',
                'Tell a compelling story. Share why your cause is important to you. People connect more with personal and heartfelt stories.',
              ),
              buildSuggestionPoint(
                '4. Engage with Your Supporters:',
                'Respond to comments, messages, and donations. Make your supporters feel appreciated and involved in your journey.',
              ),
              buildSuggestionPoint(
                '5. Utilize Email Campaigns:',
                'Send targeted emails to friends, family, and potential supporters. Provide updates and encourage them to share your campaign.',
              ),
              // Add more suggestion points as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSuggestionPoint(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(description),
        ],
      ),
    );
  }
}

