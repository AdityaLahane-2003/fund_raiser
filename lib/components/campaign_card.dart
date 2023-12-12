import 'package:flutter/material.dart';

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
                    icon: Icon(Icons.delete,color: Colors.red,),
                    onPressed: onDeletePressed,
                  ),
              ],
            )
                : null,
          ),
          // Add other campaign details as needed
        ],
      ),
    );
  }
}
