import 'package:cloud_firestore/cloud_firestore.dart';
import '../../provider/fundRaiserData_Provider.dart';
import '../../screens/main_app_screens/campaign_screens/create_campaign.dart';

class CampaignService {
  final String userId;
  FundraiserData fundraiserData = FundraiserData();
  CampaignService(this.userId);

  Future<void> createCampaign(FundraiserData fundraiserData) async {
    CollectionReference campaigns = FirebaseFirestore.instance.collection('campaigns');

    // Add a new campaign document
    DocumentReference campaignRef = await campaigns.add({
      'title': fundraiserData.name,
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
    });

    // Update user's campaigns field with the campaign ID
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'campaigns': FieldValue.arrayUnion([campaignRef.id]),
    });
  }
}
