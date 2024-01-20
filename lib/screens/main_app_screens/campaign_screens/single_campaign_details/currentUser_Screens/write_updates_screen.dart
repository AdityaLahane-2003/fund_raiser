import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/button.dart';
import 'package:fund_raiser_second/components/footer.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';
import 'package:fund_raiser_second/firebase_services/campaign_services/load_updates.dart';
import 'package:fund_raiser_second/firebase_services/campaign_services/updates_services.dart';
import 'package:fund_raiser_second/models/campaign_model.dart';
import 'package:fund_raiser_second/providers/updates_model.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';

import '../../../../../components/loading.dart';

class WriteUpdatesScreen extends StatefulWidget {
  final Campaign campaign;

  const WriteUpdatesScreen({super.key, required this.campaign});

  @override
  State<WriteUpdatesScreen> createState() => _WriteUpdatesScreenState();
}

class _WriteUpdatesScreenState extends State<WriteUpdatesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
 late UpdatesServices updatesServices;
 UpdatesData updatesData = UpdatesData();
  late Future<List<DocumentSnapshot>> _updates;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    updatesServices = UpdatesServices(widget.campaign.id);
    _updates = loadUpdates(widget.campaign.id);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Text("Write Updates"),
      ),
      persistentFooterButtons: const [
        Footer(),
      ],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const CircleAvatar(
                maxRadius: 50,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("assets/logo.png"),
              ),
              const SizedBox(height: 10),
              const Text("Post An Update",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("Write updates to share progress of your fundraiser with donars !",),
              const SizedBox(height: 20),
              const Divider(thickness: 1),
              const SizedBox(height: 20),
              TextFormFieldArea(
                title: "Title",
                controller: titleController,
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                prefixIcon: Icons.title,
              ),
              const SizedBox(height: 10),
              TextFormFieldArea(
                title: "Description",
                controller:descController,
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                prefixIcon: Icons.description,
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              Button(
                loading: isLoading,
                title: "Post Update",
                color: secondColor,
                onTap: () async {
                  if (titleController.text.trim().isNotEmpty &&
                      descController.text.trim().isNotEmpty) {
                    setState(() {
                      isLoading = true;
                    });
                    updatesData.title = titleController.text.trim();
                    updatesData.description = descController.text.trim();
                    updatesData.updateDate = DateTime.now();
                    await updatesServices.createUpdate(updatesData);
                    titleController.clear();
                    descController.clear();
                    Utils().toastMessage("Update Posted!");
                    setState(() {
                      isLoading = false;
                      _updates = loadUpdates(widget.campaign.id);
                    });
                  } else {
                    Utils().toastMessage("Write Something!");
                  }
                },
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<DocumentSnapshot>>(
                future: _updates,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Loading(
                        size: 25, color: Colors.black);
                  } else if (snapshot.hasError) {
                    Utils().toastMessage(
                        'Error: ${snapshot.error}');
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No Updates, Write updates and get help ! .'),
                    );
                  } else {
                    return Column(
                      children: [
                        const Text(
                          'Previous Updates',
                          style: TextStyle(
                            fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                            borderRadius:
                            BorderRadius.circular(8.0),
                          ),
                          height: MediaQuery.of(context)
                              .size
                              .height *
                              0.5,
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              snapshot.data!.sort((a, b) =>
                                  b['updateDate']
                                      .compareTo(a['updateDate']));
                              DocumentSnapshot update =
                              snapshot.data![index];

                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                  Colors.grey.shade300,
                                  child: Text((index+1).toString()),
                                ),
                                title: Text(update['title'],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight:
                                        FontWeight.bold)),
                                subtitle: Text(
                                  update['description'].length > 50
                                      ? update['description']
                                      .substring(0, 50) + " ..."
                                      : update['description'],
                                  style: TextStyle(
                                      color: Colors.green.shade700),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
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
