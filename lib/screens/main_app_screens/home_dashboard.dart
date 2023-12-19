import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
    String getCurrentUserId() {
      User? user = FirebaseAuth.instance.currentUser;
      return user?.uid ?? '';
    }

    String userId = getCurrentUserId();
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        automaticallyImplyLeading: false,
        title: Text('Fundraiser or Donate'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
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
                      CircleAvatar(
                        minRadius: 20,
                        maxRadius: 40,
                        backgroundImage: NetworkImage(
                            'https://avatars.githubusercontent.com/u/108022893?v=4'),
                      ),
                      SizedBox(height: 8),
                      Text('User Name'),
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
                        child: Text("My Profile"),
                      )
                    ],
                  ),
                ),
              ]),
            ),
            ListTile(
              leading: Icon(Icons.home_filled),
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeDashboard()),
                );
              },
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              child: ListTile(
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
                leading: Icon(Icons.upload_outlined),
                title: Text('Create Campaign'),
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
                leading: Icon(Icons.upload_outlined),
                title: Text('My Campaigns'),
                // Add functionality for raising funds
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyCampaigns()));
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.download_outlined),
              title: Text('Donate'),
              // Add functionality for donating
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CampaignsList()));
              },
            ),
            ListTile(
              leading: Icon(Icons.lan_outlined),
              title: Text('Language'),
              // Add functionality for donating
              onTap: () {
                // Add your logic for donating
              },
            ),
            ListTile(
              leading: Image(image: AssetImage('assets/logo.png'), height: 24),
              title: Text('About Us'),
              // Add functionality for about us
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.help_outline_outlined),
              title: Text('Help'),
              // Add functionality for help
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HelpScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('Logout'),
              // Add functionality for help
              onTap: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image at the top
            Image.network(
              'https://firebasestorage.googleapis.com/v0/b/hrtaa-fund-raiser.appspot.com/o/images%2Fl.jpeg?alt=media&token=df3db6fa-894b-4c6c-97a0-869d4496d243',
              // Replace with your image URL
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              "Update UI",
              textAlign: TextAlign.center,
            ),
            // Toggle button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Select Option:'),
                  SizedBox(width: 10),
                  ToggleButtons(
                    children: [
                      Text('Fundraiser'),
                      Text('Donate'),
                    ],
                    isSelected: [isFundraiserSelected, !isFundraiserSelected],
                    onPressed: (index) {
                      setState(() {
                        isFundraiserSelected = index == 0;
                      });
                    },
                  ),
                ],
              ),
            ),
            // Button based on toggle selection
            isFundraiserSelected
                ? Column(
                    children: [
                      Text(
                        'Raise Fund for a Cause',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CampaignCreation(
                                      campaignService: campaignService)));
                        },
                        child: Text('Raise Fund'),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Text(
                        'Donate for a Cause',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CampaignsList()));
                        },
                        child: Text('Donate Now'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
