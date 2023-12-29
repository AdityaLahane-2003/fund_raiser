import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<DocumentSnapshot>> loadDonations(String campaignId) async {

    CollectionReference campaignCollection =
    FirebaseFirestore.instance.collection('campaigns');
    DocumentSnapshot campaignDoc = await campaignCollection.doc(campaignId).get();

    List<String> donationIds = List<String>.from(campaignDoc['donations'] ?? []);

    if (donationIds.isNotEmpty) {
      CollectionReference donationsCollection =
      FirebaseFirestore.instance.collection('donations');
      QuerySnapshot donationQuery = await donationsCollection
          .where(FieldPath.documentId, whereIn: donationIds)
          .get();

      return donationQuery.docs;
    } else {
      return [];
    }
}
