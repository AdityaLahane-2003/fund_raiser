import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fund_raiser_second/model/campaign_model.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/update_campaign.dart';

import '../../../components/campaign_card.dart';
import '../../../firebase_services/delete_campaign_services.dart';

class MyCampaigns extends StatefulWidget {
  @override
  _MyCampaignsState createState() => _MyCampaignsState();
}

class _MyCampaignsState extends State<MyCampaigns> {
  late Future<List<DocumentSnapshot>> _campaigns;

  @override
  void initState() {
    super.initState();
    _campaigns = _loadCampaigns();
  }

  Future<List<DocumentSnapshot>> _loadCampaigns() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
      DocumentSnapshot userDoc = await userCollection.doc(user.uid).get();

      List<String> campaignIds =
      List<String>.from(userDoc['campaigns'] ?? []);

      if (campaignIds.isNotEmpty) {
        CollectionReference campaignsCollection =
        FirebaseFirestore.instance.collection('campaigns');
        QuerySnapshot campaignQuery = await campaignsCollection
            .where(FieldPath.documentId, whereIn: campaignIds)
            .get();

        return campaignQuery.docs;
      } else {
        return [];
      }
    } else {
      return [];
    }
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
            return CircularProgressIndicator();
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
                      _loadCampaigns();
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
                                await _loadCampaigns();
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

// class CampaignCard extends StatelessWidget {
//   final String title;
//   final String description;
//
//   const CampaignCard({
//     Key? key,
//     required this.title,
//     required this.description,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(8),
//       child: ListTile(
//         title: Text(title),
//         subtitle: Text(description),
//         // Add more details or actions as needed
//       ),
//     );
//   }
// }
