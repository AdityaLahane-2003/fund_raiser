import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/loading.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/donate_screen.dart';
import 'package:share/share.dart';
import '../../../../../components/button.dart';
import '../../../../../models/campaign_model.dart';
import '../../../../../utils/constants/color_code.dart';

class OnlyCampaignDetailsPage extends StatefulWidget {
  final Campaign campaign;
  final bool isExpired;

  const OnlyCampaignDetailsPage({super.key, required this.campaign,required this.isExpired});

  @override
  State<OnlyCampaignDetailsPage> createState() => _OnlyCampaignDetailsPageState();
}

class _OnlyCampaignDetailsPageState extends State<OnlyCampaignDetailsPage> {
  // bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    List<String>items=[];
    items.add(widget.campaign.coverPhoto);
    widget.campaign.mediaImageUrls.isNotEmpty?items = widget.campaign.mediaImageUrls:items=[widget.campaign.coverPhoto];
    return Scaffold(
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [widget.campaign.amountGoal - widget.campaign.amountRaised <= 0
              ? Text( 'Campaign Completed',
              style:TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color:Colors.green.shade300
              ))
              :
            widget.isExpired?
            Text("Campaign Expired",
            style:TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
                color:Colors.red.shade300
            )
            ):
            Button(
              onTap: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DonateScreen(campaignId: widget.campaign.id),
                  ),
                );
              },
              title: 'Donate Now',
              color: greenColor,
            ), Button(
              onTap: () {
                Share.share(
                  'Check out this fundraising campaign: ${widget.campaign.title}\n\n'
                      'Amount Raised: ${widget.campaign.amountRaised} ₹\n'
                      'Goal Amount: ${widget.campaign.amountGoal} ₹\n'
                      'Start Date: ${widget.campaign.dateCreated.day}/${widget.campaign.dateCreated.month}/${widget.campaign.dateCreated.year}\n'
                      'End Date: ${widget.campaign.dateEnd.day}/${widget.campaign.dateEnd.month}/${widget.campaign.dateEnd.year}\n'
                      'Number of Donors: ${widget.campaign.amountDonors}\n'
                      'Place: ${widget.campaign.schoolOrHospital}\n'
                      'Location: ${widget.campaign.location}\n\n'
                      'Donate now and support the cause!',
                );
              },
              title: 'Share Now',
              color: greenColor,
            ),
          ],
        ),
      ],
      appBar: AppBar(
        backgroundColor: greenColor,
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
                enlargeCenterPage: false,
              ),
              items: items.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Image.network(
                          item,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: Loading(size: 20,color: Colors.black,),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            )
            ,
            // Campaign details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.campaign.title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Amount Raised: ${widget.campaign.amountRaised} ₹',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Goal Amount: ${widget.campaign.amountGoal} ₹',
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
                    widget.campaign.description,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  // InkWell(
                  //   onTap: () async {
                  //     setState(() {
                  //       isLiked = !isLiked;
                  //     });
                  //     if(isLiked){
                  //       await FirebaseFirestore.instance
                  //           .collection('campaigns')
                  //           .doc(widget.campaign.id)
                  //           .update({
                  //         'supporters': FieldValue.increment(1),
                  //       });
                  //     }else{
                  //       await FirebaseFirestore.instance
                  //           .collection('campaigns')
                  //           .doc(widget.campaign.id)
                  //           .update({
                  //         'supporters': FieldValue.increment(-1),
                  //       });
                  //     }
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Icon(Icons.thumb_up,
                  //           size:isLiked?30.0: 20.0,
                  //           color:isLiked?Colors.green:Colors.grey),
                  //       const SizedBox(width: 8.0),
                  //       Text(
                  //         isLiked?"You are supporting !":'Support this campaign',
                  //         style: TextStyle(
                  //           fontSize: 16.0,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ],
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
