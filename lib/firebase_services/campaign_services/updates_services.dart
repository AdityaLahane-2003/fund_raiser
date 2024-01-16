import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fund_raiser_second/providers/updates_model.dart';

class UpdatesServices {
  final String campaignId;
  UpdatesData updatesData = UpdatesData();
  UpdatesServices(this.campaignId);

  Future<void> createUpdate(UpdatesData updatesData) async {
    CollectionReference updates = FirebaseFirestore.instance.collection('updates');

    DocumentReference updatesRef = await updates.add({
      'title': updatesData.title,
      'description': updatesData.description,
      'updateDate': updatesData.updateDate,
      'campaignId':campaignId
    });

    await FirebaseFirestore.instance.collection('campaigns').doc(campaignId).update({
      'updates': FieldValue.arrayUnion([updatesRef.id]),
    });
  }
}
