import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/loading.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/donate_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/drawers_option_screens/about_us/terms_and_conditions_screen.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';
import '../../../../../components/button.dart';
import '../../../../../firebase_services/campaign_services/load_donations.dart';
import '../../../../../firebase_services/campaign_services/load_updates.dart';
import '../../../../../models/campaign_model.dart';
import '../../../../../utils/constants/color_code.dart';
import 'viewPDF.dart';
import '../../../../../utils/utils_toast.dart';

class OnlyCampaignDetailsPage extends StatefulWidget {
  final Campaign campaign;

  const OnlyCampaignDetailsPage({
    super.key,
    required this.campaign,
  });

  @override
  State<OnlyCampaignDetailsPage> createState() =>
      _OnlyCampaignDetailsPageState();
}

class _OnlyCampaignDetailsPageState extends State<OnlyCampaignDetailsPage> {
  List<bool> isSelected = [true, false, false];
  late Future<List<DocumentSnapshot>> _donations;
  late Future<List<DocumentSnapshot>> _updates;
  bool isDonationsVisible = false;
  late List<VideoPlayerController> videoControllers;
  // late final url;
  @override
  void initState() {
    super.initState();
    _donations = loadDonations(widget.campaign.id);
    _updates = loadUpdates(widget.campaign.id);
    // url = 'https://wa.me/${widget.campaign.email}?text=${Uri.parse('Your message')}';

    if (widget.campaign.mediaVideoUrls.isNotEmpty) {
      videoControllers = widget.campaign.mediaVideoUrls.map((videoUrl) {
        return VideoPlayerController.network(videoUrl);
      }).toList();

      // Initialize the controllers and update the state when ready
      Future.wait(videoControllers.map((controller) => controller.initialize()))
          .then((_) {
        setState(() {});
      });
    } else {
      videoControllers = [];
    }
  }

  @override
  void dispose() {
    for (var controller in videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = [];
    items.add(widget.campaign.coverPhoto);
    widget.campaign.mediaImageUrls.isNotEmpty
        ? items = widget.campaign.mediaImageUrls
        : items = [widget.campaign.coverPhoto];
    return Scaffold(
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            widget.campaign.amountGoal - widget.campaign.amountRaised <= 0
                ? Text('Campaign Completed',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.green.shade300))
                : widget.campaign.dateEnd.isBefore(DateTime.now())
                    ? Text("Campaign Expired",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.red.shade300))
                    : Button(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DonateScreen(campaignId: widget.campaign.id),
                            ),
                          );
                        },
                        title: 'Donate Now',
                        color: secondColor,
                      ),
            Button(
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
              color: secondColor,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ToggleButtons(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width / 3.1,
                    minHeight: 40,
                  ),
                  isSelected: isSelected,
                  onPressed: (index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < isSelected.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected[buttonIndex] = true;
                        } else {
                          isSelected[buttonIndex] = false;
                        }
                      }
                    });
                  },
                  children: [
                    Text("Overview"),
                    Text("Documents"),
                    Text("Updates"),
                  ],
                ),
              ],
            ),
            isSelected[0]
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
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
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(
                                          child: Loading(
                                            size: 20,
                                            color: Colors.black,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.watch_later,
                                    size: 20.0, color: Colors.red),
                                const SizedBox(width: 8.0),
                                Text(
                                  widget.campaign.dateEnd
                                          .difference(DateTime.now())
                                          .inDays
                                          .toString() +
                                      " days left",
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              widget.campaign.title,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  widget.campaign.photoUrl,
                                ),
                              ),
                              title: Text(
                                "Beneficiary : " + widget.campaign.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "Phone : " + widget.campaign.email,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            RichText(
                              text: TextSpan(
                                text: widget.campaign.amountRaised.toString() +
                                    " ₹ ",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade700,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "raised out of " +
                                          widget.campaign.amountGoal
                                              .toString() +
                                          " ₹",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            LinearProgressIndicator(
                              minHeight: 10.0,
                              value: widget.campaign.amountRaised /
                                  widget.campaign.amountGoal,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.green.shade300),
                            ),
                            const SizedBox(height: 30.0),
                            Text(
                              "About the fundraiser",
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              widget.campaign.description,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            const SizedBox(height: 30.0),
                            ListTile(
                              leading: Text(
                                "❤️",
                                style: TextStyle(fontSize: 20),
                              ),
                              title: Text(
                                "Supporters:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_down,
                                size: 20.0,
                                color: Colors.grey,
                              ),
                              onTap: () {
                                setState(() {
                                  isDonationsVisible = !isDonationsVisible;
                                });
                              },
                            ),
                            Visibility(
                              visible: isDonationsVisible,
                              child: FutureBuilder<List<DocumentSnapshot>>(
                                future: _donations,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Loading(
                                        size: 25, color: Colors.black);
                                  } else if (snapshot.hasError) {
                                    Utils().toastMessage(
                                        'Error: ${snapshot.error}');
                                    return Text('Error: ${snapshot.error}');
                                  } else if (snapshot.data!.isEmpty) {
                                    return const Center(
                                      child: Text('No Donars, Share and Help.'),
                                    );
                                  } else {
                                    // User has campaigns
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      height: 200,
                                      child: ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot donation =
                                              snapshot.data![index];
                                          return ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor:
                                                  Colors.grey.shade300,
                                              child: Text(donation['name'][0]),
                                            ),
                                            title: Text(donation['name']),
                                            subtitle: Text(
                                              donation['amountDonated']
                                                      .toString() +
                                                  " ₹",
                                              style: TextStyle(
                                                  color: Colors.green.shade700),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            // const SizedBox(height: 30.0),
                            // lInkWel(
                            //   onTap: () async{
                            //     await launch(url);
                            //   },
                            //   child: Container(
                            //     height: 45,
                            //     width: MediaQuery.of(context).size.width,
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(18.0),
                            //       color: Colors.green,
                            //     ),
                            //     child: const Center(
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           FaIcon(FontAwesomeIcons.whatsapp,
                            //               color: Colors.white),
                            //           const SizedBox(width: 10.0),
                            //           Text(
                            //             "Share Via Whatsapp",
                            //             style: TextStyle(
                            //               color: Colors.white,
                            //               fontSize: 18.0,
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TermsAndConditionsScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(" © Terms and Conditions",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 15))),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : isSelected[1]
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          widget.campaign.documentUrls.isEmpty
                              ? SizedBox(
                                  height: 50,
                                  child: const Center(
                                    child: Text("No Documents Uploaded"),
                                  ),
                                )
                              : Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
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
                                      children: widget.campaign.documentUrls
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
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/PDF.png"),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text("View PDF"),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                          widget.campaign.mediaImageUrls.isEmpty
                              ? SizedBox(
                                  height: 50,
                                  child: const Center(
                                    child: Text("No Images Uploaded"),
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
                                      children: widget.campaign.mediaImageUrls
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
                          widget.campaign.mediaVideoUrls.isEmpty
                              ? SizedBox(
                                  height: 50,
                                  child: const Center(
                                    child: Text("No Videos Uploaded"),
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
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                        height: 400,
                                        child: ListView.builder(
                                          itemCount: videoControllers.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              height: 200.0,
                                              margin: const EdgeInsets.only(
                                                  bottom: 10.0),
                                              child: Chewie(
                                                controller: ChewieController(
                                                  videoPlayerController:
                                                      videoControllers[index],
                                                  autoPlay: false,
                                                  // Set to true if you want videos to auto-play
                                                  looping:
                                                      false, // Set to true if you want videos to loop
                                                ),
                                              ),
                                            );
                                          },
                                        )

                                        // ListView.builder(
                                        //   itemCount: widget.campaign.mediaVideoUrls.length,
                                        //   itemBuilder: (context, index) {
                                        //     return Padding(
                                        //       padding: const EdgeInsets.all(8.0),
                                        //       child: Card(
                                        //         child: Padding(
                                        //           padding: const EdgeInsets.all(8.0),
                                        //           child: Column(
                                        //             children: [
                                        //               Text(
                                        //                 widget.campaign
                                        //                     .mediaVideoUrls[index],
                                        //                 style: const TextStyle(
                                        //                   fontSize: 20.0,
                                        //                   fontWeight: FontWeight.bold,
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     );
                                        //   },
                                        // ),
                                        ),
                                  ],
                                ),
                        ],
                      )
                    : Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          widget.campaign.updates.isEmpty
                              ? const Center(
                                  child: Text("No Updates"),
                                )
                              : SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: FutureBuilder<List<DocumentSnapshot>>(
                                    future: _updates,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Loading(
                                            size: 25, color: Colors.black);
                                      } else if (snapshot.hasError) {
                                        Utils().toastMessage(
                                            'Error: ${snapshot.error}');
                                        return Text('Error: ${snapshot.error}');
                                      } else if (snapshot.data!.isEmpty) {
                                        return const Center(
                                          child: Text('No Updates !'),
                                        );
                                      } else {
                                        return Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.8,
                                          child: ListView.builder(
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, index) {
                                              snapshot.data!.sort((a, b) =>
                                                  b['updateDate'].compareTo(
                                                      a['updateDate']));
                                              DocumentSnapshot update =
                                                  snapshot.data![index];
                                              String daysAgo =DateTime.now().difference(
                                                  update['updateDate'].toDate())
                                                      .inDays
                                                      .toString();
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            daysAgo +
                                                                " days ago ",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .red)),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          update['title'],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          update['description'],
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: secondColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                )
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}
