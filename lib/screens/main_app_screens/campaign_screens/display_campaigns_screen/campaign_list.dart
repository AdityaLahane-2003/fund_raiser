import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/firebase_services/campaign_services/delete_campaign_services.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/update_campaign.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import 'package:provider/provider.dart';

import '../../../../components/campaign_card.dart';
import '../../../../models/campaign_model.dart';
import '../../../../providers/campaigns_provider.dart';

class CampaignsList extends StatefulWidget {
  const CampaignsList({Key? key}) : super(key: key);

  @override
  _CampaignsListState createState() => _CampaignsListState();
}

class _CampaignsListState extends State<CampaignsList> {
  late CampaignProvider campaignProvider;
  late User? currentUser;
  @override
  void initState() {
    super.initState();
    campaignProvider = Provider.of<CampaignProvider>(context, listen: false);
    currentUser = FirebaseAuth.instance.currentUser;
    _loadCampaigns();
  }

  Future<void> _loadCampaigns() async {
    await campaignProvider.loadCampaigns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Text('Campaigns List'),
      ),
      body: Consumer<CampaignProvider>(
        builder: (context, provider, child) {
          final campaigns = provider.campaigns;

          return campaigns.isEmpty
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
          );
        },
      ),
    );
  }
}


