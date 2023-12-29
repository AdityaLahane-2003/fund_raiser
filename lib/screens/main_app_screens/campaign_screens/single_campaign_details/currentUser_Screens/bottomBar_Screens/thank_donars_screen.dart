import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../../components/loading.dart';
import '../../../../../../firebase_services/campaign_services/load_donations.dart';
import '../../../../../../utils/utils_toast.dart';

class ThankDonorsPage extends StatefulWidget {
final String campaignId;
   ThankDonorsPage({super.key,required this.campaignId});

  @override
  State<ThankDonorsPage> createState() => _ThankDonorsPageState();
}

class _ThankDonorsPageState extends State<ThankDonorsPage> {
  late Future<List<DocumentSnapshot>> _donations;

  @override
  void initState() {
    super.initState();
    _donations = loadDonations(widget.campaignId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[300],
        title: const Text('Thank Donars'),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: _donations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading(size: 25,color:Colors.black);
          } else if (snapshot.hasError) {
            Utils().toastMessage('Error: ${snapshot.error}');
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data!.isEmpty) {
            // User has no campaigns
            return const Center(
              child: Text('No Donars, Share and get Donars.'),
            );
          } else {
            // User has campaigns
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                DocumentSnapshot donation = snapshot.data![index];
                return ListTile(
                  title: Text(donation['name']),
                  subtitle: Text(donation['amountDonated'].toString()),
                );
              },
            );
          }
        },
      ),
    );
  }
}