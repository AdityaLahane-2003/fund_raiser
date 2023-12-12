import 'package:flutter/material.dart';

import '../model/campaign_model.dart';

class CampaignCard extends StatelessWidget {
  final Campaign campaign;
  final bool isCurrentUserCampaign;
  final VoidCallback onUpdatePressed;

  CampaignCard({
    required this.campaign,
    required this.isCurrentUserCampaign,
    required this.onUpdatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(campaign.title),
            subtitle: Text(campaign.description),
            trailing: isCurrentUserCampaign
                ? IconButton(
              icon: Icon(Icons.edit),
              onPressed: onUpdatePressed,
            )
                : null,
          ),
          // Add other campaign details as needed
        ],
      ),
    );
  }
}
