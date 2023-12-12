import 'package:flutter/material.dart';

import '../../../firebase_services/campaign_services.dart';

class CampaignCreation extends StatefulWidget {
  final CampaignService campaignService;

  const CampaignCreation({Key? key, required this.campaignService}) : super(key: key);

  @override
  State<CampaignCreation> createState() => _CampaignCreationState();
}

class _CampaignCreationState extends State<CampaignCreation> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Campaign'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String title = titleController.text;
                String description = descriptionController.text;

                if (title.isNotEmpty && description.isNotEmpty) {
                  await widget.campaignService.createCampaign(title, description);
                  Navigator.pop(context); // Close the create campaign page after creation
                } else {
                  // Show an error message or handle the case where fields are empty
                }
              },
              child: Text('Create Campaign'),
            ),
          ],
        ),
      ),
    );
  }
}
