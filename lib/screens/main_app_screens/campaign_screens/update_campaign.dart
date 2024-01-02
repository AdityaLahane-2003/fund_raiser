import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/campaign_model.dart';

class UpdateCampaignPage extends StatefulWidget {
  final Campaign campaign;

  const UpdateCampaignPage({super.key, required this.campaign});

  @override
  _UpdateCampaignPageState createState() => _UpdateCampaignPageState();
}

class _UpdateCampaignPageState extends State<UpdateCampaignPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final List<String> statuses = ['Urgent Need of Funds',
    'Needs funds for the near future',
    'Need funds for the upcoming event'];
  late String selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus=widget.campaign.status;
    titleController = TextEditingController(text: widget.campaign.title);
    descriptionController = TextEditingController(text: widget.campaign.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Campaign'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16), const Text(
              'Select Status of your Financial Need',
            ),
            DropdownButton<String>(
              borderRadius: BorderRadius.circular(12.0),
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 36.0,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              value: selectedStatus,
              hint: const Text('Select Category'),
              isExpanded: true,
              items: statuses.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Center(
                    child: Text(
                      category,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                selectedStatus = value??'Urgent Need of Funds';
                setState(() {});
              },
            ),
            const SizedBox(height: 16),
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
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
