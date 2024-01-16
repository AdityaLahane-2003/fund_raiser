import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<DocumentSnapshot>> loadUpdates(String campaignId) async {

  CollectionReference campaignCollection =
  FirebaseFirestore.instance.collection('campaigns');
  DocumentSnapshot campaignDoc = await campaignCollection.doc(campaignId).get();

  List<String> updatesIds = List<String>.from(campaignDoc['updates'] ?? []);

  if (updatesIds.isNotEmpty) {
    CollectionReference updatesCollection =
    FirebaseFirestore.instance.collection('updates');
    QuerySnapshot updatesQuery = await updatesCollection
        .where(FieldPath.documentId, whereIn: updatesIds)
        .get();

    return updatesQuery.docs;
  } else {
    return [];
  }
}
