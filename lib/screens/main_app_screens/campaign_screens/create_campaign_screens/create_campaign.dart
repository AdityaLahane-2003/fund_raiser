import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/create_campaign_screens/step1.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/create_campaign_screens/step2.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/create_campaign_screens/step3.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/create_campaign_screens/step4.dart';
import 'package:fund_raiser_second/screens/main_app_screens/home_dashboard.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../../../../firebase_services/campaign_services/campaign_services.dart';
import '../../../../firebase_services/notification_services/notification_service.dart';
import '../../../../providers/fundRaiserData_Provider.dart';
import '../../../../providers/fundraiser_data_provider.dart';

class CampaignCreation extends StatefulWidget {
  final CampaignService campaignService;

  const CampaignCreation({super.key, required this.campaignService});

  @override
  State<CampaignCreation> createState() => _CampaignCreationState();
}

class _CampaignCreationState extends State<CampaignCreation> {
  int currentStep = 1;
  FundraiserData fundraiserData = FundraiserData();
  NotificationServices notificationServices = NotificationServices();
  String? mToken = "";
  DateTime? lastBackPressedTime;

  @override
  void initState() {
    super.initState();
    notificationServices.requestPermission();
    notificationServices.getToken().then((value) {
      // print("TOKEN: " + value);
      mToken = value;
    });
    notificationServices.initLocalNotification();
    notificationServices.setContext(context);
  }

  Future<bool> _onBackPressed() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeDashboard(),));
     return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
            Consumer<FundraiserDataProvider>(
              builder: ( context, provider, child) {
                return Expanded(
                  child: _buildStep(currentStep, provider.fundraiserData),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(int step,FundraiserData campaignData) {
    switch (step) {
      case 1:
        return Step1(
          onCategorySelected: (category) {
            fundraiserData.category = category;
          },
          onStatusSelected: (status){
            fundraiserData.status=status;
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
            // print(fundraiserData.category+ "\n"+
            //     fundraiserData.status+ "\n");
            // print(campaignData.category+ "\n"+
            //     campaignData.status+ "\n");
            await widget.campaignService.createCampaign(campaignData);
            notificationServices.sendPushMessage(mToken.toString(), fundraiserData.title, "Campaign Created Successfully !");
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Campaign Created ! ! !"),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/taarn-690cb.appspot.com/o/images%2FCampaign_Create_Successful_Image.jpeg-removebg-preview.png?alt=media&token=a334b8fa-8e2a-4b4a-bff3-6140db1eaf3f"),
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
                        backgroundColor: secondColor,
                      ),
                      onPressed: () async {
                        Share.share(
                          'Check out this fundraising campaign: ${fundraiserData.title}\n\n'
                              'Amount Raised: ${fundraiserData.amountRaised} ₹\n'
                              'Goal Amount: ${fundraiserData.amountGoal} ₹\n'
                              'To donate, follow the link:https://adityalahane-2003.github.io/PrivacyPolicy_TAARN/ \n\n'
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
