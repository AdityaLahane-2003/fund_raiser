import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/donate_screen.dart';
import 'package:share/share.dart';
import '../../../../../components/button.dart';
import '../../../../../models/campaign_model.dart';

class OnlyCampaignDetailsPage extends StatelessWidget {
  final Campaign campaign;

  const OnlyCampaignDetailsPage({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Button(
              onTap: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DonateScreen(campaignId: campaign.id),
                  ),
                );
              },
              title: 'Donate Now',
              color: Colors.green.shade700,
            ), Button(
              onTap: () {
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
              title: 'Share Now',
              color: Colors.green.shade700,
            ),
          ],
        ),
      ],
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: const Text('Campaign Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: [
                'Text 1',
                'Text 2',
                'Text 3',
              ].map((item) {
                return Container(
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            // Campaign details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    campaign.title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Amount Raised: ${campaign.amountRaised} ₹',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Goal Amount: ${campaign.amountGoal} ₹',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Add more campaign details
                ],
              ),
            ),
            // Story
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Story:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    campaign.description,
                    style: const TextStyle(fontSize: 16.0),
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
