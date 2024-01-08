import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fund_raiser_second/models/campaign_model.dart';

class CampaignProvider extends ChangeNotifier {
  late List<Campaign> campaigns = [];

  Future<void> loadCampaigns() async {
    final campaignsCollection = FirebaseFirestore.instance.collection('campaigns');
    final snapshot = await campaignsCollection.get();

    campaigns = snapshot.docs.map((doc) {
      return Campaign(
        id: doc.id,
        name: doc['name'],
        title: doc['title'],
        description: doc['description'],
        ownerId: doc['ownerId'],
        category: doc['category'],
        email: doc['email'],
        relation: doc['relation'],
        photoUrl: doc['photoUrl'],
        gender: doc['gender'],
        age: doc['age'],
        city: doc['city'],
        schoolOrHospital: doc['schoolOrHospital'],
        location: doc['location'],
        coverPhoto: doc['coverPhoto'],
        amountRaised: doc['amountRaised'],
        amountGoal: doc['amountGoal'],
        amountDonors: doc['amountDonors'],
        dateCreated: doc['dateCreated'].toDate(),
        status: doc['status'],
        dateEnd: doc['dateEnd'].toDate(),
        tipAmount: doc['tipAmount'],
        supporters: doc['supporters'],
        documentUrls: List<String>.from(doc['documentUrls']),
        mediaImageUrls: List<String>.from(doc['mediaImageUrls']),
        mediaVideoUrls: List<String>.from(doc['mediaVideoUrls']),
        updates: List<String>.from(doc['updates']),
      );
    }).toList();

    notifyListeners();
  }
}
