import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

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
      backgroundColor: Colors.green.shade300,
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Replace with your image asset
              height: 200,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Welcome to our Fundraising App!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Our Mission:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'To make a positive impact by connecting people with meaningful causes and empowering them to contribute to the greater good.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),const Text(
              'To make a positive impact by connecting people with meaningful causes and empowering them to contribute to the greater good.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'About Our App:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Our Fundraising App is dedicated to providing a platform for individuals and organizations to raise funds for their projects, events, and charitable initiatives. We believe in the power of collective giving to bring positive change to communities around the world.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Contact Us:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Email: info@fundraisingapp.com\nPhone: +1 (123) 456-7890',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}