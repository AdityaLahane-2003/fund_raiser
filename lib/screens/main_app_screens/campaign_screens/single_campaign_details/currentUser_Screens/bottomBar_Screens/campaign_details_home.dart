import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/currentUser_Screens/bottomBar_Screens/share_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/currentUser_Screens/upload_docs_and_media_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/currentUser_Screens/write_updates_screen.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';

import '../../../../../../models/campaign_model.dart';

class CampaignDetailsPage extends StatelessWidget {
  final Campaign campaign;

  const CampaignDetailsPage({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: greenColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              subtitle: const Text('Follow the following instructions'),
              trailing: const Icon(Icons.arrow_forward_ios),
              title: const Text('Share'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShareCampaignScreen()));
              },
            ),
            ListTile(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              leading: const Icon(Icons.check),
              subtitle: const Text('Follow the following instructions'),
              trailing: const Icon(Icons.arrow_forward_ios),
              title: const Text('Checklist'),
              onTap: () {
                // Open checklist from the bottom
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.share),
                            subtitle:
                                const Text('Follow the following instructions'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            title: const Text('Share'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ShareCampaignScreen()));
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.document_scanner),
                            subtitle:
                                const Text('Follow the following instructions'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            title: const Text('Upload Documents'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UploadMediaScreen(
                                          campaignId: campaign.id)));
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo),
                            subtitle:
                                const Text('Follow the following instructions'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            title: const Text('Add Media'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UploadMediaScreen(
                                          campaignId: campaign.id)));
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.update),
                            subtitle:
                                const Text('Follow the following instructions'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            title: const Text('Write updates'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WriteUpdatesScreen(
                                            campaign: campaign,
                                          )));
                            },
                          ),
                          // Add more list items
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            // Circular Progress Indicator
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    campaign.title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Amount Raised',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  CircularProgressIndicator(
                    value: campaign.amountRaised / campaign.amountGoal,
                    color: Colors.green,
                    backgroundColor: Colors.grey.shade300,
                    strokeWidth: 10.0,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    ((campaign.amountRaised / campaign.amountGoal) * 100)
                            .toString() +
                        " %", // Replace with actual percentage
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text('Raised Amount: \$ ${campaign.amountRaised}'),
                  SizedBox(height: 10.0),
                  Text('Goal Amount: \$ ${campaign.amountGoal}'),
                  SizedBox(height: 10.0),
                  Text('STORY \n' + campaign.description),
                  SizedBox(height: 10.0),
                  Text(campaign.amountDonors.toString() + ' Donors'),
                  SizedBox(height: 10.0),
                  Text(campaign.dateEnd.difference(DateTime.now()).inDays < 0
                      ? ' Campaign Expired '
                      : campaign.dateEnd
                              .difference(DateTime.now())
                              .inDays
                              .toString() +
                          ' Days Left'),
                  SizedBox(height: 10.0),
                  Text("Tip Amount Raised: " + campaign.tipAmount.toString()),
                  SizedBox(height: 10.0),
                  campaign.mediaImageUrls.isNotEmpty?
                  Column(
                    children: [
                      SizedBox(height: 10.0),
                      Text("Media Files"),
                      SizedBox(height: 10.0),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: campaign.mediaImageUrls.map((mediaUrl) {
                          return Container(
                            height: 100.0, // Set the desired height
                            width: 100.0, // Set the desired width
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(mediaUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ):
                Text("No media available. Please upload."),
                  SizedBox(height: 10.0),
                  campaign.documentUrls.isNotEmpty?
                  Column(
                    children: [
                      SizedBox(height: 10.0),
                      Text("Document Files"),
                      SizedBox(height: 10.0),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: campaign.documentUrls.map((documentUrl) {
                          // You can customize the display of documents here
                          return TextButton(
                            onPressed: () {
                              // Handle document click action
                            },
                            child: Text("Document"),
                          );
                        }).toList(),
                      ),
                    ],
                  ):
                Text("No documents available. Please upload."),
                ],
              ),
            ),
            // Graph
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Donation History',
                  //   style: TextStyle(
                  //     fontSize: 20.0,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // SizedBox(height: 16.0),
                  // Container(
                  //   height: 200.0, // Set a fixed height
                  //   child: LineChart(
                  //     LineChartData(
                  //       gridData: FlGridData(show: false),
                  //       titlesData: FlTitlesData(show: false),
                  //       borderData: FlBorderData(
                  //         show: true,
                  //         border: Border.all(color: const Color(0xff37434d), width: 1),
                  //       ),
                  //       minX: 0,
                  //       maxX: 7,
                  //       minY: 0,
                  //       maxY: 6,
                  //       lineBarsData: [
                  //         LineChartBarData(
                  //           spots: [
                  //             FlSpot(0, 3),
                  //             FlSpot(1, 1),
                  //             FlSpot(2, 4),
                  //             FlSpot(3, 2),
                  //             FlSpot(4, 5),
                  //             FlSpot(5, 1),
                  //             FlSpot(6, 3),
                  //             FlSpot(7, 4),
                  //           ],
                  //           isCurved: true,
                  //           dotData: FlDotData(show: false),
                  //           belowBarData: BarAreaData(show: false),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
