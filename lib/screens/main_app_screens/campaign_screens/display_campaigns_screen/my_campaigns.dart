import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fund_raiser_second/components/loading.dart';
import 'package:fund_raiser_second/firebase_services/campaign_services/load_campaigns.dart';
import 'package:fund_raiser_second/models/campaign_model.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/update_campaign.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';

import '../../../../components/campaign_card.dart';
import '../../../../firebase_services/campaign_services/delete_campaign_services.dart';
import '../../../../providers/fundRaiserData_Provider.dart';

class MyCampaigns extends StatefulWidget {
  const MyCampaigns({super.key});

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
        backgroundColor: Colors.green[300],
        title: const Text('My Campaigns'),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: _campaigns,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading(size: 25,color:Colors.black);
          } else if (snapshot.hasError) {
            Utils().toastMessage('Error: ${snapshot.error}');
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data!.isEmpty) {
            // User has no campaigns
            return const Center(
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
                  name: campaign['name'],
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
                  amountRaised: campaign['amountRaised'],
                  amountGoal: campaign['amountGoal'],
                  amountDonors: campaign['amountDonors'],
                  dateCreated: campaign['dateCreated'].toDate(),
                  status: campaign['status'],
                  dateEnd: campaign['dateEnd'].toDate(),
                  tipAmount: campaign['tipAmount'],
                  documentUrls: List<String>.from(campaign['documentUrls']),
                  mediaUrls: List<String>.from(campaign['mediaUrls']),
                  updates: List<String>.from(campaign['updates']),
                );
                return CampaignCard(
                  campaign: campaign2,
                  isCurrentUserCampaign: true,
                  onUpdatePressed: () {
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
                                await loadCampaigns();
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
            );
          }
        },
      ),
    );
  }
}
