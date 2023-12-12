import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/update_campaign.dart';

import '../../../components/campaign_card.dart';
import '../../../model/campaign_model.dart';

class CampaignsList extends StatefulWidget {
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
          title: doc['title'],
          description: doc['description'],
          ownerId: doc['ownerId'],
        );
      }).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campaigns List'),
      ),
      body:campaigns.isEmpty
          ? Center(
        child: Text("No Campaigns right now."),
      )
          : ListView.builder(
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          Campaign campaign = campaigns[index];
          bool isCurrentUserCampaign = campaign.ownerId == currentUser?.uid;

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
          );
        },
      ),
    );
  }
}
