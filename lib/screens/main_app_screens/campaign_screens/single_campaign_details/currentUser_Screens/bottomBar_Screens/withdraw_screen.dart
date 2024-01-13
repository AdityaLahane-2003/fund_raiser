import 'package:flutter/material.dart';

import '../aadhar_kyc_screen.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  _WithdrawScreen createState() => _WithdrawScreen();
}

class _WithdrawScreen extends State<WithdrawScreen> {
  // For demonstration purposes, randomly set whether KYC is done or not
  bool isKYCDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdraw Money'),
        backgroundColor: Colors.yellow[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display KYC status at the top
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isKYCDone ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                isKYCDone ? 'KYC Done' : 'KYC Not Done',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16.0),
            // Button to do KYC
            ElevatedButton(
              onPressed: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AadharKYCPage(),
                  ),
                );
                setState(() {
                  isKYCDone = !isKYCDone;
                });
              },
              child: const Text('Do KYC'),
            ),
            const SizedBox(height: 16.0),
            // If KYC is done, allow the user to add account details and proceed
            if (isKYCDone)
              Column(
                children: [
                  // Add account details form or components here
                  // ...

                  const SizedBox(height: 16.0),
                  // Button to proceed for money withdrawal
                  ElevatedButton(
                    onPressed: () {
                      // Handle money withdrawal process
                      // You can implement the logic to withdraw money here
                    },
                    child: const Text('Withdraw Money'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
