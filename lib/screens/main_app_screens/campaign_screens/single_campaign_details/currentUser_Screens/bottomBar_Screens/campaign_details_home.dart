import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/currentUser_Screens/bottomBar_Screens/share_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/currentUser_Screens/upload_docs_and_media_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/currentUser_Screens/write_updates_screen.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';

import '../../../../../../models/campaign_model.dart';
import '../../donar_Screens/viewPDF.dart';

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
          children: [
            const SizedBox(height: 10.0),
            const Text(
              'Welcome !',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text(
              "Here's the progress of your campaign.",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10.0),
            ListTile(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
              ),),
              tileColor: Colors.grey.shade200,
              leading: CircleAvatar(
                backgroundImage: campaign.photoUrl == ""
                    ? const NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/hrtaa-fund-raiser.appspot.com/o/images%2Fuser_profile.png?alt=media&token=1492c8e6-c68f-4bc3-8ff0-58fca5485d4e")
                    : NetworkImage(campaign.photoUrl),
              ),
              title: Text(campaign.title),
              trailing: const Icon(Icons.share),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShareCampaignScreen(campaign: campaign,)));
              },
            ),
            const SizedBox(height: 10.0),
            ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),),
                tileColor: Colors.grey.shade200,
              leading: const FaIcon(FontAwesomeIcons.checkCircle),
              subtitle: const Text('Complete the instructions in the checklist for better results.',
                style: TextStyle(
                  fontSize: 13.0,
                ),),
              trailing: const Icon(Icons.arrow_forward_ios),
              title: const Text('Your TAARN Checklist',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),),
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
                            title: Text(campaign.title,style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShareCampaignScreen(campaign: campaign)));
                            },
                          ),
                          ListTile(
                            leading:const FaIcon(FontAwesomeIcons.fileUpload),
                            subtitle:
                                const Text('Upload the required documents for better results'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            title:  const Text('Upload Documents',style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
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
                                const Text('Upload the required media for better results.'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            title:  const Text('Add Media',style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
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
                                const Text('Write updates for your campaign.'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            title:  const Text('Write updates',style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WriteUpdatesScreen(
                                            campaign: campaign,
                                          )));
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  const SizedBox(height: 16.0),
                  CircularProgressIndicator(
                    value: campaign.amountRaised / campaign.amountGoal,
                    color: Colors.green,
                    backgroundColor: Colors.grey.shade300,
                    strokeWidth: 10.0,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "${(campaign.amountRaised / campaign.amountGoal) * 100} %",
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text:'₹ ${campaign.amountRaised}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                          text: " raised out of ",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '₹ ${campaign.amountGoal}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(FontAwesomeIcons.peopleGroup),
                      const SizedBox(width: 10.0),
                      const Text("Donors : ",style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),),
                      Text('${campaign.amountDonors} Donors'),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(FontAwesomeIcons.clock),
                      const SizedBox(width: 10.0),
                      campaign.dateEnd.difference(DateTime.now()).inDays < 0
                        ?const Text( ' Campaign Expired '):
                      Text(campaign.dateEnd
                          .difference(DateTime.now())
                          .inDays<0 ? " Done ":"${campaign.dateEnd
                          .difference(DateTime.now())
                          .inDays} Days Left "
                      ),

                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const SizedBox(
                    height: 20,
                  ),
                  campaign.documentUrls.isEmpty
                      ? const SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("Upload Documents for better results !"),
                    ),
                  )
                      : Column(
                    children: [
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      const Text(
                        "Documents",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: campaign.documentUrls
                            .map((documentUrl) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ViewPDF(url: documentUrl),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  height:
                                  130.0, // Set the desired height
                                  width:
                                  130.0, // Set the desired width
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(
                                        8.0),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/PDF.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text("View PDF"),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  campaign.mediaImageUrls.isEmpty
                      ? const SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("Upload Images for better results !"),
                    ),
                  )
                      : Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Images",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children:campaign.mediaImageUrls
                            .map((mediaUrl) {
                          return Container(
                            height:
                            150.0, // Set the desired height
                            width: 150.0, // Set the desired width
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(mediaUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  campaign.mediaVideoUrls.isEmpty
                      ? const SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("Upload Videos for better results !"),
                    ),
                  )
                      : Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Videos",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("${campaign.mediaVideoUrls.length} Videos Uploaded"),
                        ],
                      )
                ],
              ),
            ),
            // Graph
            // const Padding(
            //   padding: EdgeInsets.all(16.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       // Text(
            //       //   'Donation History',
            //       //   style: TextStyle(
            //       //     fontSize: 20.0,
            //       //     fontWeight: FontWeight.bold,
            //       //   ),
            //       // ),
            //       // SizedBox(height: 16.0),
            //       // Container(
            //       //   height: 200.0, // Set a fixed height
            //       //   child: LineChart(
            //       //     LineChartData(
            //       //       gridData: FlGridData(show: false),
            //       //       titlesData: FlTitlesData(show: false),
            //       //       borderData: FlBorderData(
            //       //         show: true,
            //       //         border: Border.all(color: const Color(0xff37434d), width: 1),
            //       //       ),
            //       //       minX: 0,
            //       //       maxX: 7,
            //       //       minY: 0,
            //       //       maxY: 6,
            //       //       lineBarsData: [
            //       //         LineChartBarData(
            //       //           spots: [
            //       //             FlSpot(0, 3),
            //       //             FlSpot(1, 1),
            //       //             FlSpot(2, 4),
            //       //             FlSpot(3, 2),
            //       //             FlSpot(4, 5),
            //       //             FlSpot(5, 1),
            //       //             FlSpot(6, 3),
            //       //             FlSpot(7, 4),
            //       //           ],
            //       //           isCurved: true,
            //       //           dotData: FlDotData(show: false),
            //       //           belowBarData: BarAreaData(show: false),
            //       //         ),
            //       //       ],
            //       //     ),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
