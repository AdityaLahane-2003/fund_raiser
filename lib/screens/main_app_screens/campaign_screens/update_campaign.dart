import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/campaign_model.dart';

class UpdateCampaignPage extends StatefulWidget {
  final Campaign campaign;

  UpdateCampaignPage({required this.campaign});

  @override
  _UpdateCampaignPageState createState() => _UpdateCampaignPageState();
}

class _UpdateCampaignPageState extends State<UpdateCampaignPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.campaign.title);
    descriptionController = TextEditingController(text: widget.campaign.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Campaign'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('campaigns')
                    .doc(widget.campaign.id)
                    .update({
                  'title': titleController.text,
                  'description': descriptionController.text,
                });
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
