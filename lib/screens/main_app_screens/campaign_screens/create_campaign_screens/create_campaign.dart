import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/create_campaign_screens/step1.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/create_campaign_screens/step2.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/create_campaign_screens/step3.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/create_campaign_screens/step4.dart';
import 'package:fund_raiser_second/screens/main_app_screens/home_dashboard.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import 'package:share/share.dart';

import '../../../../firebase_services/campaign_services/campaign_services.dart';
import '../../../../providers/fundRaiserData_Provider.dart';

class CampaignCreation extends StatefulWidget {
  final CampaignService campaignService;

  const CampaignCreation({super.key, required this.campaignService});

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
        backgroundColor: greenColor,
        title: const Text('Create Campaign'),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(50),
            minHeight: 10,
            value: (currentStep - 1) / 4,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(secondColor),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Step ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: '$currentStep',
                        style: TextStyle(
                          color: greenColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: ' of 4',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
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
          onStatusSelected: (status){
            fundraiserData.status=status;
          },
          onCategorySelected: (category) {
            fundraiserData.category = category;
          },
          onNameEmailEntered: (name, email, amount, endDate) {
            fundraiserData.name = name;
            fundraiserData.email = email;
            fundraiserData.amountGoal = amount;
            fundraiserData.dateEnd = endDate;
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
          onCoverPhotoStoryEntered: (coverPhoto, story, title) {
            fundraiserData.coverPhoto = coverPhoto;
            fundraiserData.story = story;
            fundraiserData.title = title;
          },
          onRaiseFundPressed: () async {
            await widget.campaignService.createCampaign(fundraiserData);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Campaign Created ! ! !"),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        image: AssetImage('assets/img3.jpg'),
                      ),
                      Text(
                          "Congrats! Your campaign has been created. You can view it in the campaigns tab."),
                    ],
                  ),
                  alignment: Alignment.center,
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[400],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeDashboard(),
                          ),
                        );
                      },
                      child: const Text("Skip", style: TextStyle(color: Colors.white),),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: greenColor,
                      ),
                      onPressed: () async {
                        Share.share(
                          'Donate now and support the cause!',
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeDashboard(),
                          ),
                        );
                      },
                      child: const Text("Share", style: TextStyle(color: Colors.white),),
                    ),
                  ],
                );
              },
            );
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
