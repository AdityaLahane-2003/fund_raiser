import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fund_raiser_second/components/footer.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';

import '../../../../../components/button.dart';
import '../../../../../models/campaign_model.dart';

class UpdateInfoScreen extends StatefulWidget {
  final Campaign campaign;

  const UpdateInfoScreen({super.key, required this.campaign});

  @override
  State<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  late TextEditingController titleController;
  late TextEditingController goalAmountController;
  late TextEditingController storyController;
  final List<String> statuses = [
    'Urgent Need of Funds',
    'Needs funds for the near future',
    'Need funds for the upcoming event'];
  late String selectedStatus;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    selectedStatus=widget.campaign.status;
    titleController = TextEditingController(text: widget.campaign.title);
    storyController = TextEditingController(text: widget.campaign.description);
    goalAmountController =
        TextEditingController(text: widget.campaign.amountGoal.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: const [
        Footer()
      ],
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Text('Update Campaign Info'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.campaign.photoUrl),
              ),
              const SizedBox(height: 16),
              TextFormFieldArea(
                controller: titleController,
                title: 'Title',
                textInputType: TextInputType.text,
                prefixIcon: Icons.title,
              ),
              const SizedBox(height: 16),
              TextFormFieldArea(
                controller: goalAmountController,
                title: 'Goal Amount',
                textInputType: TextInputType.number,
                prefixIcon: FontAwesomeIcons.indianRupeeSign,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter goal amount';
                  }else if(int.parse(value)<1000){
                    return 'Goal amount should be greater than 1000';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormFieldArea(
                controller: storyController,
                title: 'Story',
                textInputType: TextInputType.multiline,
                prefixIcon: Icons.description,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter story';
                  }
                  return null;
                },
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              const Text(
                'Update Status of your Financial Need',
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.black),
                ),
                child: DropdownButton<String>(
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
                    selectedStatus = value??selectedStatus;
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(height: 16),
             Button(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await FirebaseFirestore.instance
                      .collection('campaigns')
                      .doc(widget.campaign.id)
                      .update({
                    'title': titleController.text,
                    'description': storyController.text,
                    'status':selectedStatus,
                    'amountGoal': int.parse(goalAmountController.text),
                  });
                  setState(() {
                    isLoading = false;
                  });
                  Utils().toastMessage('Campaign Updated Successfully', color: Colors.green);
                  Navigator.pop(context);
                },
                title: 'Update Campaign',
               color: secondColor,
               loading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
