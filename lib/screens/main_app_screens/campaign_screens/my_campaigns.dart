import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fund_raiser_second/components/loading.dart';
import 'package:fund_raiser_second/firebase_services/campaign_services/load_campaigns.dart';
import 'package:fund_raiser_second/model/campaign_model.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/update_campaign.dart';

import '../../../components/campaign_card.dart';
import '../../../firebase_services/campaign_services/delete_campaign_services.dart';

class MyCampaigns extends StatefulWidget {
  @override
  _MyCampaignsState createState() => _MyCampaignsState();
}

class _MyCampaignsState extends State<MyCampaigns> {
  late Future<List<DocumentSnapshot>> _campaigns;

  @override
  void initState() {
    super.initState();
    _campaigns = loadCampaigns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Campaigns'),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: _campaigns,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading(size: 25,color:Colors.black);
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data!.isEmpty) {
            // User has no campaigns
            return Center(
              child: Text('You have no campaigns yet.'),
            );
          } else {
            // User has campaigns
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                DocumentSnapshot campaign = snapshot.data![index];
                Campaign campaign2 = Campaign(
                  id: campaign.id,
                  title: campaign['title'],
                  description: campaign['description'],
                  ownerId: campaign['ownerId'],
                  category: campaign['category'],
                  email: campaign['email'],
                  relation: campaign['relation'],
                  gender: campaign['gender'],
                  age: campaign['age'],
                  city: campaign['city'],
                  schoolOrHospital: campaign['schoolOrHospital'],
                  location: campaign['location'],
                  coverPhoto: campaign['coverPhoto'],
                  photoUrl: campaign['photoUrl'],
                );
                return CampaignCard(
                  campaign: campaign2,
                  isCurrentUserCampaign: true,
                  onUpdatePressed: () {
                    // Navigate to the update campaign page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateCampaignPage(campaign: campaign2),
                      ),
                    ).then((_) {
                      loadCampaigns();
                    });
                  },
                  onDeletePressed: () async{
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Delete Campaign"),
                          content: Text(
                              "Are you sure you want to delete your campaign? This action is irreversible."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                    context); // Close the dialog
                              },
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async {
                                await DeleteCampaignServices.deleteCampaign(campaign.id);
                                await loadCampaigns();
                                Navigator.pop(context);
                              },
                              child: Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
