import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/donate_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/home_dashboard.dart';

import '../model/campaign_model.dart';

class CampaignCard extends StatelessWidget {
  final Campaign campaign;
  final bool isCurrentUserCampaign;
  final VoidCallback onUpdatePressed;
  final VoidCallback onDeletePressed;

  CampaignCard({
    required this.campaign,
    required this.isCurrentUserCampaign,
    required this.onUpdatePressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('cause: '+campaign.category),
          // SizedBox(height: 8.0), Text('realtion: '+campaign.relation),
          // SizedBox(height: 8.0), Text('Photo: '+campaign.photoUrl),
          // SizedBox(height: 8.0), Text('age: '+campaign.age),
          SizedBox(height: 8.0), Text('hello user "This is the overview of your campaign..."'),
          SizedBox(height: 8.0), Text('Amount Raised/Goal Amount'),
          SizedBox(height: 8.0), Text('Setup Date'),
          SizedBox(height: 8.0), Text('End Date'),
          SizedBox(height: 8.0), Text('Number of Donars'),
          SizedBox(height: 8.0), Text('Share button'),
          SizedBox(height: 8.0), Text('FAQ Button'),
          SizedBox(height: 8.0), Text('Our Suggestion Button'),
          // SizedBox(height: 8.0), Text('city: '+campaign.city),
          SizedBox(height: 8.0), Text('Place: '+campaign.schoolOrHospital),
          SizedBox(height: 8.0), Text('Location: '+campaign.location),
          SizedBox(height: 8.0), Text('coverPhoto: '+campaign.coverPhoto),
          SizedBox(height: 8.0),
          ListTile(
            title: Text(campaign.title),
            subtitle: Text(campaign.description),
            trailing: isCurrentUserCampaign
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isCurrentUserCampaign)
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: onUpdatePressed,
                        ),
                      if (isCurrentUserCampaign)
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: onDeletePressed,
                        ),
                    ],
                  )
                : TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeDashboard()));
                },
                child: Text("Donate",
                style: TextStyle(color: Colors.purple[200])),
          ),
          // Add other campaign details as needed
          )],
      ),
    );
  }
}
