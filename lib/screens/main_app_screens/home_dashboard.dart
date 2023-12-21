import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/campaign_list.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/create_campaign.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/my_campaigns.dart';
import 'package:fund_raiser_second/screens/main_app_screens/drawers_option_screens/about_us.dart';
import 'package:fund_raiser_second/screens/main_app_screens/drawers_option_screens/help.dart';

import '../../firebase_services/user_services/add_user_details_service.dart';
import '../../firebase_services/campaign_services/campaign_services.dart';
import '../../utils/utils_toast.dart';
import '../auth_screens/email_auth/login_screen.dart';
import 'drawers_option_screens/my_profile.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  bool isFundraiserSelected = true; // Default selection
  bool _isVisible = false;
  final CampaignService campaignService = CampaignService(getCurrentUserId());

  @override
  Widget build(BuildContext context) {

    String userId = getCurrentUserId();
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Text('Dashboard'),
      ),
      drawer: Drawer(
        backgroundColor: Colors.green[100],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        width: MediaQuery.of(context).size.width * 0.75,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/hrtaa-fund-raiser.appspot.com/o/images%2Ftop-view-collection-green-leaves-background.jpg?alt=media&token=8619d05c-b5ff-43a3-9d3b-4fcfb57a026b'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView(children: [
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        minRadius: 20,
                        maxRadius: 40,
                        backgroundImage: NetworkImage(
                            'https://avatars.githubusercontent.com/u/108022893?v=4'),
                      ),
                      const SizedBox(height: 8),
                      const Text("userName"),
                      InkWell(
                        onTap: () {
                          Utils().toastMessage("Opening - My Profile",
                              color: Colors.green);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UserInfoPage(userId: userId)));
                        },
                        child:  const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_outline_outlined),
                            Text("My Profile"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
            ListTile(
              leading: const Icon(Icons.home_filled),
              title: const Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeDashboard()),
                );
              },
            ),
            Divider(
              height: 2,  // You can adjust the height of the divider
              color: Colors.grey,  // You can set the color of the divider
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              child: const ListTile(
                leading: Icon(Icons.upload_outlined),
                title: Text('Raise Fund'),
                trailing: Icon(Icons.arrow_downward),
              ),
            ),
            Visibility(
              visible: _isVisible,
              child: ListTile(
                textColor: Colors.teal[400],
                iconColor: Colors.green,
                leading: const Icon(Icons.add_circle_outline_outlined),
                title: const Text('Create Campaign'),
                // Add functionality for raising funds
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CampaignCreation(
                              campaignService: campaignService)));
                },
              ),
            ),
            Visibility(
              visible: _isVisible,
              child: ListTile(
                textColor: Colors.teal[400],
                iconColor: Colors.green,
                leading: const Icon(Icons.list_alt_outlined),
                title: const Text('My Campaigns'),
                // Add functionality for raising funds
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyCampaigns()));
                },
              ),
            ),
            Divider(
              height: 2,  // You can adjust the height of the divider
              color: Colors.grey,  // You can set the color of the divider
            ),
            ListTile(
              leading: const Icon(Icons.handshake_outlined),
              title: const Text('Donate'),
              // Add functionality for donating
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CampaignsList()));
              },
            ),
            Divider(
              height: 2,  // You can adjust the height of the divider
              color: Colors.grey,  // You can set the color of the divider
            ),
            ListTile(
              leading: const Icon(Icons.lan_outlined),
              title: const Text('Language'),
              // Add functionality for donating
              onTap: () {
                // Add your logic for donating
              },
            ), Divider(
              height: 2,  // You can adjust the height of the divider
              color: Colors.grey,  // You can set the color of the divider
            ),
            ListTile(
              leading: const Image(image: AssetImage('assets/logo.png'), height: 24),
              title: const Text('About Us'),
              // Add functionality for about us
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUsScreen()));
              },
            ), Divider(
              height: 2,  // You can adjust the height of the divider
              color: Colors.grey,  // You can set the color of the divider
            ),
            ListTile(
              leading: const Icon(Icons.help_outline_outlined),
              title: const Text('Help'),
              // Add functionality for help
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HelpScreen()));
              },
            ), Divider(
              height: 2,  // You can adjust the height of the divider
              color: Colors.grey,  // You can set the color of the divider
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Logout'),
              // Add functionality for help
              onTap: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
            ),
            CircleAvatar(
              minRadius: 30,
              backgroundColor: Colors.green[100],
              maxRadius: 50,
              child: Image.asset('assets/logo.png'),),
          ],
        ),
      ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image at the top
              Container(
                height: 400,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/hrtaa-fund-raiser.appspot.com/o/images%2Fl.jpeg?alt=media&token=df3db6fa-894b-4c6c-97a0-869d4496d243',
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20), // Optional: Add border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
              // Toggle button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Select:'),
                    const SizedBox(width: 10),
                    ToggleButtons(
                      borderRadius: BorderRadius.circular(50),
                      isSelected: [isFundraiserSelected, !isFundraiserSelected],
                      onPressed: (index) {
                        setState(() {
                          isFundraiserSelected = index == 0;
                        });
                      },
                      selectedColor: Colors.white,
                      fillColor: Colors.green[400],
                      children: const [
                        Text('   Fundraiser   '),
                        Text('   Donate    '),
                      ], // Adjust the color as needed
                    ),
                  ],
                ),
              ),
              // Button based on toggle selection
              isFundraiserSelected
                  ? Column(
                children: [
                   const Text(
                    'Raise Fund for a Cause',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold, // Adjust the color as needed
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CampaignCreation(
                            campaignService: campaignService,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[400], // Adjust the color as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                    ),
                    child: const Text('Raise Fund',style: TextStyle(color: Colors.white),),
                  ),
                ],
              )
                  : Column(
                children: [
                  const Text(
                    'Donate for a Cause',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold, // Adjust the color as needed
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CampaignsList(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[400], // Adjust the color as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                    ),
                    child: const Text('Donate Now',style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyCampaigns(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[400], // Adjust the color as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                  ),
                  child: const Text('Explore Your Campaigns',style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
