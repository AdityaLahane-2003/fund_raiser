import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/share_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/upload_docs_and_media_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/write_updates_screen.dart';
// import 'package:fl_chart/fl_chart.dart';

class CampaignDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.green[300],
      ),
      bottomSheet:  // Checklist
      ListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        leading: Icon(Icons.check),
        subtitle: Text('Follow the following instructions'),
        trailing: Icon(Icons.arrow_forward_ios),
        title: Text('Checklist'),
        onTap: () {
          // Open checklist from the bottom
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.share),
                      subtitle: Text('Follow the following instructions'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      title: Text('Share'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ShareCampaignScreen()));
                      },
                    ),ListTile(
                      leading: Icon(Icons.document_scanner),
                      subtitle: Text('Follow the following instructions'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      title: Text('Upload Documents'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => UploadMediaScreen()));
                      },
                    ),ListTile(
                      leading: Icon(Icons.photo),
                      subtitle: Text('Follow the following instructions'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      title: Text('Add Media'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => UploadMediaScreen()));
                      },
                    ),ListTile(
                      leading: Icon(Icons.update),
                      subtitle: Text('Follow the following instructions'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      title: Text('Write updates'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => WriteUpdatesScreen()));
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              leading: Icon(Icons.share),
              subtitle: Text('Follow the following instructions'),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('Share'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShareCampaignScreen()));
              },
            ),

            // Circular Progress Indicator
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Amount Raised',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: 0.7, // Replace with actual progress value
                        color: Colors.green,
                        strokeWidth: 10.0,
                      ),
                      Text(
                        '70%', // Replace with actual percentage
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text('Goal Amount: \$5000'), // Replace with actual goal amount
                ],
              ),
            ),
            // Graph
            Padding(
              padding: const EdgeInsets.all(16.0),
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
