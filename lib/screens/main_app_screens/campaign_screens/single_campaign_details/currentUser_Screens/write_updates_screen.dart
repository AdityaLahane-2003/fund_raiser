import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/button.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';
import 'package:fund_raiser_second/models/campaign_model.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';

class WriteUpdatesScreen extends StatefulWidget {
  final Campaign campaign;

  const WriteUpdatesScreen({super.key, required this.campaign});

  @override
  State<WriteUpdatesScreen> createState() => _WriteUpdatesScreenState();
}

class _WriteUpdatesScreenState extends State<WriteUpdatesScreen> {
  TextEditingController updateController = TextEditingController();
  List<String> updates = [];

  @override
  void initState() {
    super.initState();
    fetchUpdates();
  }

  Future<void> fetchUpdates() async {
    List<String> fetchedUpdates =
        await FirebaseFunctions.getUpdates(widget.campaign.id);
    setState(() {
      updates = fetchedUpdates;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Write Updates"),
        toolbarHeight: 30,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormFieldArea(
                title: "Write Update",
                controller: updateController,
                textInputType: TextInputType.text,
              ),
              Button(
                title: "Post Update",
                onTap: () async {
                  if (updateController.text.trim().isNotEmpty) {
                    await FirebaseFirestore.instance
                        .collection('campaigns')
                        .doc(widget.campaign.id)
                        .update({
                      'updates':
                          FieldValue.arrayUnion([updateController.text.trim()]),
                    });
                    updateController.clear();
                    fetchUpdates(); // Update the displayed updates after posting a new one
                  } else {
                    Utils().toastMessage("Write Something!");
                  }
                },
              ),
              if (updates.isNotEmpty)
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Text("Updates:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    for (String update in updates)
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green,
                        ),
                        title: Text(update),
                        subtitle: Text("some text"),
                        trailing: Icon(Icons.abc_outlined),
                      ),
                  ],
                )
              else
                Text("No updates", style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

class FirebaseFunctions {
  static Future<List<String>> getUpdates(String campaignId) async {
    try {
      final DocumentSnapshot campaignDoc = await FirebaseFirestore.instance
          .collection('campaigns')
          .doc(campaignId)
          .get();
      final List<dynamic> updates = campaignDoc['updates'];
      return updates.map((update) => update.toString()).toList();
    } catch (e) {
      Utils().toastMessage('Error fetching updates: $e');
      return [];
    }
  }
}
