import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Replace with your image asset
              height: 200,
            ),
            SizedBox(height: 16.0),
            Text(
              'Welcome to our Fundraising App!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Our Mission:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'To make a positive impact by connecting people with meaningful causes and empowering them to contribute to the greater good.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),Text(
              'To make a positive impact by connecting people with meaningful causes and empowering them to contribute to the greater good.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'About Our App:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Our Fundraising App is dedicated to providing a platform for individuals and organizations to raise funds for their projects, events, and charitable initiatives. We believe in the power of collective giving to bring positive change to communities around the world.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Contact Us:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Email: info@fundraisingapp.com\nPhone: +1 (123) 456-7890',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}