import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/donate_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/drawers_option_screens/help.dart';
import 'package:fund_raiser_second/screens/main_app_screens/drawers_option_screens/our_suggestions.dart';
import 'package:share/share.dart';
import '../model/campaign_model.dart';

class CampaignCard extends StatelessWidget {
  final Campaign campaign;
  final bool isCurrentUserCampaign;
  final VoidCallback onUpdatePressed;
  final VoidCallback onDeletePressed;

  CampaignCard({
    required this.campaign,
    required this.isCurrentUserCampaign,
    required this.onUpdatePressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    String status = campaign.status;
    DateTime.now().isBefore(campaign.dateEnd)?
    status='Active':DateTime.now().isAfter(campaign.dateEnd)?
    status='Expired':status='Pending';
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Displaying cover photo using URL
          Image.network(
            campaign.coverPhoto,
            height: 200,// Adjust the height as needed
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 8.0),
          // Title of the campaign
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              campaign.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Progress bar slider for amount raised
          LinearProgressIndicator(
            minHeight: 10,
            borderRadius: BorderRadius.circular(100.0),
            value: campaign.amountRaised / campaign.amountGoal,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          SizedBox(height: 8.0),
          // Displaying amount raised and goal amount
          Text(
            'Amount Raised: ${campaign.amountRaised} ₹ / ${campaign.amountGoal} ₹',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          // Other campaign details
          Text('Start Date: ${campaign.dateCreated.day}/${campaign.dateCreated.month}/${campaign.dateCreated.year}'),
          Text('End Date: ${campaign.dateEnd.day}/${campaign.dateEnd.month}/${campaign.dateEnd.year}'),
          Text('Number of Donors: ${campaign.amountDonors}'),
          Text('Place: ${campaign.schoolOrHospital}'),
          Text('Location: ${campaign.location}'),

          Row(
            children: [
              Text('Status: ${status}'),
              SizedBox(width: 3,),
              status=='Active' ?
                Icon(Icons.circle, size: 15.0, color: Colors.green):
              status=='Expired'?
                Icon(Icons.circle, size: 15.0, color: Colors.red):
                Icon(Icons.circle, size: 15.0, color: Colors.yellow),

            ],
          ),
          SizedBox(height: 3.0),
          // If the user is the owner, show update and delete buttons
          if (isCurrentUserCampaign)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: (){
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
                  ), IconButton(
                    icon: Icon(Icons.question_mark),
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Help'),
                          content: Text('This is the help section'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),  TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpScreen()));
                              },
                              child: Text('FAQs'),
                            ),
                          ],
                        ),
                      );
                    },
                  ), IconButton(
                    icon: Icon(Icons.lightbulb),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OurSuggestionsPage()));
                    },
                  ), IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: onUpdatePressed,
                  ),
                  IconButton(
                    icon: Icon(
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
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DonateScreen(campaignId: campaign.id)),
                      );
                    },
                    child: Text(
                      'Donate',
                      style: TextStyle(color: Colors.purple[200]),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
