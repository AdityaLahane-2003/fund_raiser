import 'package:flutter/material.dart';

class ShareCampaignScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share Campaign'),
        backgroundColor: Colors.orange[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text information regarding the importance of sharing at the top
            Text(
              'Help us reach our goal by sharing this campaign!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            // Central share button
            ElevatedButton(
              onPressed: () {
                // Handle the logic for sharing the campaign
                // You can use the share package or implement your custom sharing logic
                showSnackBar(context, 'Campaign shared successfully!');
              },
              child: Text('Share Now'),
            ),
            SizedBox(height: 16.0),
            // Text information regarding what you are sharing at the bottom
            Text(
              'You are sharing a fundraising campaign to support a cause. '
                  'Encourage your friends and family to donate and make a difference!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ));
  }
}
