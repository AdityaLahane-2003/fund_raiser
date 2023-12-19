import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/step1.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/step2.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/step3.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/step4.dart';

import '../../../firebase_services/campaign_services/campaign_services.dart';


class FundraiserData {
  late String category='Medical';
  late String name;
  late String email;
  late String relation='Myself';
  late String photoUrl;
  late String age;
  late String gender;
  late String city;
  late String schoolOrHospital;
  late String location;
  late String coverPhoto;
  late String story;
}

class CampaignCreation extends StatefulWidget {
  final CampaignService campaignService;

  const CampaignCreation({Key? key, required this.campaignService}) : super(key: key);

  @override
  State<CampaignCreation> createState() => _CampaignCreationState();
}

class _CampaignCreationState extends State<CampaignCreation> {
  int currentStep = 1;
  FundraiserData fundraiserData = FundraiserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fundraiser Setup'),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (currentStep - 1) / 4,
            backgroundColor: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Fundraiser Setup', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Step $currentStep of 4'),
              ],
            ),
          ),
          Expanded(
            child: _buildStep(currentStep),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(int step) {
    switch (step) {
      case 1:
        return Step1(
          onCategorySelected: (category) {
            fundraiserData.category = category;
          },
          onNameEmailEntered: (name, email) {
            fundraiserData.name = name;
            fundraiserData.email = email;
          },
          onNext: () {
            setState(() {
              currentStep++;
            });
          },
        );
      case 2:
        return Step2(
          onRelationSelected: (relation) {
            fundraiserData.relation = relation;
          },
          onPersonalInfoEntered: (photoUrl, age, gender, city) {
            fundraiserData.photoUrl = photoUrl;
            fundraiserData.age = age;
            fundraiserData.gender = gender;
            fundraiserData.city = city;
          },
          onPrevious: () {
            setState(() {
              currentStep--;
            });
          },
          onNext: () {
            setState(() {
              currentStep++;
            });
          },
        );
      case 3:
        return Step3(
          onSchoolOrHospitalEntered: (name, location) {
            fundraiserData.schoolOrHospital = name;
            fundraiserData.location = location;
          },
          onPrevious: () {
            setState(() {
              currentStep--;
            });
          },
          onNext: () {
            setState(() {
              currentStep++;
            });
          },
        );
      case 4:
        return Step4(
          onCoverPhotoStoryEntered: (coverPhoto, story) {
            fundraiserData.coverPhoto = coverPhoto;
            fundraiserData.story = story;
          },
          onRaiseFundPressed: () async {
            await widget.campaignService.createCampaign(fundraiserData);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Campaign Created"),
                  content: Text(
                      "Congrats! Your campaign has been created. You can view it in the campaigns tab."),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text("Share"),
                    ),
                  ],
                );
              },
            );

              // Navigator.pop(context);
          },
          onPrevious: () {
            setState(() {
              currentStep--;
            });
          },
        );
      default:
        return Container();
    }
  }
}


// ElevatedButton(
// onPressed: () async {
// String title = titleController.text;
// String description = descriptionController.text;
//
// if (title.isNotEmpty && description.isNotEmpty) {
// await widget.campaignService.createCampaign(title, description);
// Navigator.pop(context); // Close the create campaign page after creation
// } else {
// // Show an error message or handle the case where fields are empty
// }
// },
// child: Text('Create Campaign'),
// ),