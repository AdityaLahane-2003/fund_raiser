import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../components/loading.dart';
import '../../../../../../firebase_services/campaign_services/load_donations.dart';
import '../../../../../../utils/constants/color_code.dart';
import '../../../../../../utils/utils_toast.dart';

class ThankDonorsPage extends StatefulWidget {
  final String campaignId;

  ThankDonorsPage({super.key, required this.campaignId});

  @override
  State<ThankDonorsPage> createState() => _ThankDonorsPageState();
}

class _ThankDonorsPageState extends State<ThankDonorsPage> {
  late Future<List<DocumentSnapshot>> _donations;
  late final url;

  @override
  void initState() {
    super.initState();
    _donations = loadDonations(widget.campaignId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Text('Thank Donars'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<DocumentSnapshot>>(
          future: _donations,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading(size: 25, color: Colors.black);
            } else if (snapshot.hasError) {
              Utils().toastMessage('Error: ${snapshot.error}');
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.data!.isEmpty) {
              // User has no campaigns
              return Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.8,
                color: Colors.grey[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.sadTear,
                      size: 70,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Share and get Donars.',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.share),
                      ],),
                  ],
                ),
              );
            } else {
              // User has campaigns
              return Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Donars',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Total Donars: ' +
                        snapshot.data!.length.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Thank donars for their contribution",
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius:
                      BorderRadius.circular(8.0),
                    ),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height *
                        0.7,
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
                          trailing: IconButton(
                              onPressed: ()async{
                                String phone = donation['phone'];
                                setState(() {
                                  url = 'https://wa.me/${phone}?text=${Uri.parse('Hello ${donation['name']}\n, Thank you ! for your contribution of ${donation['amountDonated']} to ${donation['name']}.')}';
                                });
                                await launch(url);
                              },
                              icon: FaIcon(FontAwesomeIcons.whatsapp,
                                color: Colors.green.shade700,)),
                        // CircleAvatar(
                        //     backgroundColor:secondColor,
                        //     child: Text((index+1).toString(),
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //     ),),),
                        title: Text(donation['name']),
                        subtitle: Text(
                        donation['amountDonated']
                            .toString() +
                        " ₹",
                        style: TextStyle(
                        color: Colors.green.
                        shade700
                        )
                        ,
                        )
                        ,
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}