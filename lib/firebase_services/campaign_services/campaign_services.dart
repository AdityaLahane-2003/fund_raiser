import 'package:cloud_firestore/cloud_firestore.dart';
import '../../providers/fundRaiserData_Provider.dart';

class CampaignService {
  final String userId;
  // FundraiserData fundraiserData = FundraiserData();
  CampaignService(this.userId);

  Future<void> createCampaign(FundraiserData fundraiserData) async {
    CollectionReference campaigns = FirebaseFirestore.instance.collection('campaigns');

    // Add a new campaign document
    DocumentReference campaignRef = await campaigns.add({
      'name': fundraiserData.name,
      'title': fundraiserData.title,
      'category': fundraiserData.category,
      'email': fundraiserData.email,
      'relation': fundraiserData.relation,
      'photoUrl': fundraiserData.photoUrl,
      'age':fundraiserData.age,
      'gender':fundraiserData.gender,
      'city':fundraiserData.city,
      'schoolOrHospital':fundraiserData.schoolOrHospital,
      'location':fundraiserData.location,
      'coverPhoto':fundraiserData.coverPhoto,
      'description':  fundraiserData.story,
      'ownerId': userId,
      'amountRaised': fundraiserData.amountRaised,
      'amountGoal': fundraiserData.amountGoal,
      'amountDonors': fundraiserData.amountDonors,
      'dateCreated': fundraiserData.dateCreated,
      'status': fundraiserData.status,
      'dateEnd': fundraiserData.dateEnd,
      'tipAmount':fundraiserData.tipAmount,
      'documentUrls':fundraiserData.documentUrls,
      'mediaImageUrls':fundraiserData.mediaImageUrls,
      'mediaVideoUrls':fundraiserData.mediaVideoUrls,
      'updates':fundraiserData.updates,
      'donations':fundraiserData.donations,
      'supporters':fundraiserData.supporters,
    });

    // Update user's campaigns field with the campaign ID
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'campaigns': FieldValue.arrayUnion([campaignRef.id]),
    });
  }
}
