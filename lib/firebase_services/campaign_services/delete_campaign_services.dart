import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';

class DeleteCampaignServices {
  static Future<void> deleteCampaign(String campaignId) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
        await userCollection.doc(user.uid).update({
          'campaigns': FieldValue.arrayRemove([campaignId]),
        });

        CollectionReference campaignsCollection =
        FirebaseFirestore.instance.collection('campaigns');
        await campaignsCollection.doc(campaignId).delete();
      } catch (e) {
      Utils().toastMessage('Error deleting campaign: $e');
        // Handle error as needed
        throw Exception('Error deleting campaign');
      }
    }
  }
}
