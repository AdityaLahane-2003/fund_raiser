import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CampaignService {
  final String userId;

  CampaignService(this.userId);

  Future<void> createCampaign(String title, String description) async {
    CollectionReference campaigns = FirebaseFirestore.instance.collection('campaigns');

    // Add a new campaign document
    DocumentReference campaignRef = await campaigns.add({
      'title': title,
      'description': description,
      'ownerId': userId,
      // Add other campaign details as needed
    });

    // Update user's campaigns field with the campaign ID
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'campaigns': FieldValue.arrayUnion([campaignRef.id]),
    });
  }
}
