import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/button.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';
import 'package:share/share.dart';

import '../../../../../../models/campaign_model.dart';
import '../../../../../../utils/constants/color_code.dart';

class ShareCampaignScreen extends StatefulWidget {
  final Campaign campaign;

  const ShareCampaignScreen({super.key, required this.campaign});

  @override
  State<ShareCampaignScreen> createState() => _ShareCampaignScreenState();
}

class _ShareCampaignScreenState extends State<ShareCampaignScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Campaign'),
        backgroundColor: greenColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Help us reach our goal by sharing this campaign!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(widget.campaign.photoUrl),
                backgroundColor: Colors.transparent,
              ),
              title: Text(
                widget.campaign.title, style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
              subtitle: Text(widget.campaign.status, style: TextStyle(
                fontSize: 13.0,
              ),),
            ),
            const SizedBox(height: 16.0),
            TextFormFieldArea(
                title: "Tell your friends and family",
                controller: controller,
                textInputType: TextInputType.multiline,
                maxLines: 5,
              prefixIcon: Icons.message,
            ),
            const SizedBox(height: 16.0),
           Button(
             color: secondColor,
               title: "Share",
               onTap:(){
                 Share.share(
                   'Check out this fundraising campaign: ${widget.campaign.title}\n\n'
                       'Amount Raised: ${widget.campaign.amountRaised} ₹\n'
                       'Goal Amount: ${widget.campaign.amountGoal} ₹\n'
                       + controller.text +'\n\n'
                       'To donate, follow the link:https://adityalahane-2003.github.io/PrivacyPolicy_TAARN/ \n\n'
                       'Donate now and support the cause!',
                 );
                 setState(() {
                    controller.clear();
                 });
               }),
            const SizedBox(height: 16.0),
            // Text information regarding what you are sharing at the bottom
            const Text(
              'You are sharing a fundraising campaign to support a cause. '
                  'Encourage your friends and family to donate and make a difference!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }
}
