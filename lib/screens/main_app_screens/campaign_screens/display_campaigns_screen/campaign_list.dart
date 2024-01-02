import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/firebase_services/campaign_services/delete_campaign_services.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/update_campaign.dart';

import '../../../../components/campaign_card.dart';
import '../../../../models/campaign_model.dart';

class CampaignsList extends StatefulWidget {
  const CampaignsList({super.key});

  @override
  _CampaignsListState createState() => _CampaignsListState();
}

class _CampaignsListState extends State<CampaignsList> {
  late List<Campaign> campaigns=[];
  late User? currentUser;
  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    _loadCampaigns();
  }
  Future<void> _loadCampaigns() async {
    final campaignsCollection = FirebaseFirestore.instance.collection('campaigns');
    final snapshot = await campaignsCollection.get();

    setState(() {
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
          documentUrls: List<String>.from(doc['documentUrls']),
          mediaImageUrls: List<String>.from(doc['mediaImageUrls']),
          mediaVideoUrls: List<String>.from(doc['mediaVideoUrls']),
          updates: List<String>.from(doc['updates']),
        );
      }).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: const Text('Campaigns List'),
      ),
      body:campaigns.isEmpty
          ? const Center(
        child: Text("No Campaigns right now."),
      )
          : ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          Campaign campaign = campaigns[index];
          bool isCurrentUserCampaign;
          if(currentUser==null){
            isCurrentUserCampaign=false;
          }else{
            isCurrentUserCampaign = campaign.ownerId == currentUser?.uid;
          }

          return CampaignCard(
            campaign: campaign,
            isCurrentUserCampaign: isCurrentUserCampaign,
            onUpdatePressed: () {
              // Navigate to the update campaign page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateCampaignPage(campaign: campaign),
                ),
              ).then((_) {
                _loadCampaigns();
              });
            },
            onDeletePressed: () async{
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Delete Campaign !!!"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/logo.png', // Replace with your image asset
                          height: 100,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Are you sure you want to delete your Campaign? This action is irreversible.",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),alignment: Alignment.center,
                    actionsAlignment: MainAxisAlignment.spaceBetween,
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[400],
                        ),
                        onPressed: () {
                          Navigator.pop(
                              context); // Close the dialog
                        },
                        child: const Text("Cancel",style: TextStyle(color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () async {
                          await DeleteCampaignServices.deleteCampaign(campaign.id);
                          await _loadCampaigns();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: const Text("Delete",style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
