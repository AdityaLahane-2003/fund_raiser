import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List<DocumentSnapshot>> loadCampaigns() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    CollectionReference userCollection =
    FirebaseFirestore.instance.collection('users');
    DocumentSnapshot userDoc = await userCollection.doc(user.uid).get();

    List<String> campaignIds = List<String>.from(userDoc['campaigns'] ?? []);

    if (campaignIds.isNotEmpty) {
      CollectionReference campaignsCollection =
      FirebaseFirestore.instance.collection('campaigns');
      QuerySnapshot campaignQuery = await campaignsCollection
          .where(FieldPath.documentId, whereIn: campaignIds)
          .get();

      return campaignQuery.docs;
    } else {
      return [];
    }
  } else {
    return [];
  }
}
