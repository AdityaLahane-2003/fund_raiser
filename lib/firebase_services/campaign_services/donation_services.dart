import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fund_raiser_second/providers/donationData_Provider.dart';

class DonationService {
  final String campaignId;
  DonationData donationData = DonationData();
  DonationService(this.campaignId);

  Future<void> createDonation(DonationData donationData) async {
    CollectionReference donations = FirebaseFirestore.instance.collection('donations');

    // Add a new campaign document
    DocumentReference donationRef = await donations.add({
      'name': donationData.name,
      'email': donationData.email,
      'phone':donationData.phone,
      'location':donationData.address,
      'amountDonated': donationData.amountDonated,
      'tipDonated':donationData.tipDonated,
      'campaignId':campaignId
    });

    // Update campaigns's field with the Donation ID
    await FirebaseFirestore.instance.collection('campaigns').doc(campaignId).update({
      'donations': FieldValue.arrayUnion([donationRef.id]),
      'amountDonors': FieldValue.increment(1),
        'amountRaised': FieldValue.increment(donationData.amountDonated + donationData.tipDonated,),
        'tipAmount': FieldValue.increment(donationData.tipDonated),
    });
  }
}
