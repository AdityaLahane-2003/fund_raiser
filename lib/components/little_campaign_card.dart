import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/loading.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/donate_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/donar_Screens/only_campaign_details.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';
import '../models/campaign_model.dart';
import '../screens/main_app_screens/campaign_screens/single_campaign_details/currentUser_Screens/single_campaign_home.dart';
import '../utils/constants/color_code.dart';
import 'button.dart';

class LittleCampaignCard extends StatelessWidget {
  final Campaign campaign;
  final bool isCurrentUserCampaign;
  final VoidCallback onDeletePressed;

  const LittleCampaignCard({
    super.key,
    required this.campaign,
    required this.isCurrentUserCampaign,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    String status;
    String daysLeft = campaign.dateEnd
        .difference(DateTime.now())
        .inDays
        .toString();
    DateTime.now().isBefore(campaign.dateEnd)
        ? status = 'Active'
        : DateTime.now().isAfter(campaign.dateEnd)
        ? status = 'Expired'
        : status = 'Pending';
    return GestureDetector(
      onTap: () {
        if (isCurrentUserCampaign) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SingleCampaignHomeScreen(
                campaign: campaign,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OnlyCampaignDetailsPage(
                  campaign: campaign,),
            ),
          );
        }
      },
      child: Card(
        color: Colors.blue[50],
        shadowColor: secondColor,
        elevation: 10.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        // margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displaying cover photo using URL
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  campaign.coverPhoto == ""
                      ? 'https://www.thermaxglobal.com/wp-content/uploads/2020/05/image-not-found.jpg'
                      : campaign.coverPhoto,
                  height: 150,
                  width: 250,
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: Loading(size: 20, color: secondColor),
                    );
                  },
                ),

                Container(
                  margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: secondColor.withOpacity(0.5),
                    ),
                    child: Text((status == 'Expired' || campaign.amountGoal - campaign.amountRaised <= 0 ) ?" Done ": " $daysLeft Days Left",
                      style: const TextStyle(color: Colors.white,fontSize: 12),)
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5,1,1,3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      campaign.title.characters.length > 32
                          ? '${campaign.title.substring(0, 32)} ...'
                          : campaign.title,
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(campaign.status.characters.length > 32?'${campaign.status.substring(0, 32)} ...'
                    : campaign.status,
                      style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 12)),
                  Text(
                      '${campaign.amountGoal - campaign.amountRaised}' ' ₹ more to go',
                      style: TextStyle(
                          color: secondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(5.0,0,8,0),
              child: LinearProgressIndicator(
                minHeight: 10,
                borderRadius: BorderRadius.circular(100.0),
                value:1 - campaign.amountRaised / campaign.amountGoal,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(greenColor),
              ),
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0,0,8,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        size: 17.0,
                        color:secondColor,
                      ),
                      Text(
                        ' ${campaign.amountDonors} Donars',
                        style: TextStyle(
                          color: secondColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (isCurrentUserCampaign)
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: onDeletePressed,
                    ),
                  // Donate button for non-owners
                  if (!isCurrentUserCampaign)
                    campaign.amountGoal - campaign.amountRaised <= 0
                        ? Button(
                      onTap: () {
                        Utils().toastMessage(
                            "Campaign is already completed !",
                            color: Colors.red.shade300);
                      },
                      title: 'Completed',
                      color: Colors.green.shade700,
                    )
                        :
                    status == 'Expired'
                        ? Button(
                      onTap: () {
                        Utils().toastMessage("Campaign is Expired !",
                            color: Colors.red.shade300);
                      },
                      title: 'Expired',
                      color: Colors.red.shade700,
                    )
                        : Button(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DonateScreen(campaignId: campaign.id)),
                        );
                      },
                      title: 'Donate Now',
                      color: secondColor,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
