import 'package:flutter/material.dart';

class ThankDonorsPage extends StatelessWidget {
  // Dummy data for demonstration purposes
  final List<Donor> donors = [
    Donor(name: 'John Doe', amountDonated: 100),
    Donor(name: 'Jane Smith', amountDonated: 50),
    Donor(name: 'Alice Johnson', amountDonated: 200),
    // Add more dummy data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thank Donars'),
        backgroundColor: Colors.red[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'List of Donors:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            // Display the list of donors
            Expanded(
              child: ListView.builder(
                itemCount: donors.length,
                itemBuilder: (context, index) {
                  Donor donor = donors[index];
                  return ListTile(
                    title: Text('${donor.name}'),
                    subtitle: Text('Amount Donated: ${donor.amountDonated} ₹'),
                    trailing: IconButton(
                      icon: Icon(Icons.message),
                      onPressed: () {
                        // Handle sending a message to the donor
                        // You can navigate to a messaging screen or implement your logic
                        // to send a message to the donor
                        showSnackBar(context, 'Message sent to ${donor.name}');
                      },
                    ),
                  );
                },
              ),
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

class Donor {
  final String name;
  final int amountDonated;

  Donor({required this.name, required this.amountDonated});
}
