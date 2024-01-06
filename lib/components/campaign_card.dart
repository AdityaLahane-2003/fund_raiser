import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/loading.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/donate_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/donar_Screens/only_campaign_details.dart';
import 'package:fund_raiser_second/screens/main_app_screens/drawers_option_screens/about_us/help.dart';
import 'package:fund_raiser_second/screens/main_app_screens/drawers_option_screens/about_us/our_suggestions.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';
import 'package:readmore/readmore.dart';
import 'package:share/share.dart';
import '../models/campaign_model.dart';
import '../screens/main_app_screens/campaign_screens/single_campaign_details/currentUser_Screens/single_campaign_home.dart';
import '../utils/constants/color_code.dart';
import 'button.dart';

class CampaignCard extends StatelessWidget {
  final Campaign campaign;
  final bool isCurrentUserCampaign;
  final VoidCallback onUpdatePressed;
  final VoidCallback onDeletePressed;

  const CampaignCard({
    super.key,
    required this.campaign,
    required this.isCurrentUserCampaign,
    required this.onUpdatePressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    String status;
    String daysLeft = campaign.dateEnd
        .difference(DateTime.now())
        .inDays
        .toString(); // Days left for the campaign to end
    DateTime.now().isBefore(campaign.dateEnd)
        ? status = 'Active'
        : DateTime.now().isAfter(campaign.dateEnd)
            ? status = 'Expired'
            : status = 'Pending';
    bool isExpired = status == 'Expired' ? true : false;
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
                  campaign: campaign, isExpired: isExpired),
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
        margin: const EdgeInsets.all(8.0),
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
                  height: 200, // Adjust the height as needed
                  width: double.infinity,
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: Loading(size: 20, color: secondColor),
                    );
                  },
                ),

                // Container(
                //   margin: const EdgeInsets.all(5.0),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: Colors.blue.withOpacity(0.5),
                //     ),
                //     child: Text(" ${campaign.supporters} Supporters",
                //       style: TextStyle(color: Colors.white,fontSize: 12),)
                // ),
              ],
            ),
            const SizedBox(height: 8.0),
            // Title of the campaign
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Text(
                          campaign.title,
                          style: const TextStyle(
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () {
                          Share.share(
                            'Check out this fundraising campaign: ${campaign.title}\n\n'
                            'Amount Raised: ${campaign.amountRaised} ₹\n'
                            'Goal Amount: ${campaign.amountGoal} ₹\n'
                            'Start Date: ${campaign.dateCreated.day}/${campaign.dateCreated.month}/${campaign.dateCreated.year}\n'
                            'End Date: ${campaign.dateEnd.day}/${campaign.dateEnd.month}/${campaign.dateEnd.year}\n'
                            'Number of Donors: ${campaign.amountDonors}\n'
                            'Place: ${campaign.schoolOrHospital}\n'
                            'Location: ${campaign.location}\n\n'
                            'Donate now and support the cause!',
                          );
                        },
                      ),
                    ],
                  ),
                  Text(campaign.status,
                      style: TextStyle(
                          color: greenColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                  Text(
                      '${campaign.amountGoal - campaign.amountRaised}' +
                          ' ₹ more to go',
                      style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                ],
              ),
            ),
            // Progress bar slider for amount raised
            LinearProgressIndicator(
              minHeight: 10,
              borderRadius: BorderRadius.circular(100.0),
              value:1 - campaign.amountRaised / campaign.amountGoal,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(greenColor),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text(
                      'Amount Raised:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' ${campaign.amountRaised} ₹ / ${campaign.amountGoal} ₹',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
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
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                        minRadius: 20,
                        backgroundImage: NetworkImage(
                          campaign.photoUrl == ""
                              ? 'https://www.thermaxglobal.com/wp-content/uploads/2020/05/image-not-found.jpg'
                              : campaign.photoUrl,
                        )),
                    Text(campaign.name),
                    const SizedBox(height: 8.0),
                    Text("$daysLeft Days Left",
                        style: TextStyle(
                          color:int.parse(daysLeft)<30? Colors.red:Colors.green,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            // Row(
            //   children: [
            //     Text('     Status: $status'),
            //     const SizedBox(
            //       width: 3,
            //     ),
            //     status == 'Active'
            //         ? Icon(Icons.circle, size: 15.0, color: greenColor)
            //         : status == 'Expired'
            //             ? const Icon(Icons.circle,
            //                 size: 15.0, color: Colors.red)
            //             : const Icon(Icons.circle,
            //                 size: 15.0, color: Colors.yellow),
            //   ],
            // ),
            const SizedBox(height: 3.0),
            ReadMoreText(
              '     Story:\n          ${campaign.description}',
              trimLines: 2,
              colorClickableText: Colors.pink,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: ' ...Show less',
              moreStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 3.0),
            if (isCurrentUserCampaign)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.question_mark),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Help'),
                            content: const Text('This is the help section'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HelpScreen()));
                                },
                                child: const Text('FAQs'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.lightbulb),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OurSuggestionsPage()));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: onUpdatePressed,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: onDeletePressed,
                    ),
                  ],
                ),
              ),
            // Donate button for non-owners
            if (!isCurrentUserCampaign)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                            color: greenColor,
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
