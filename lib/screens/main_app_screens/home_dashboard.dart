import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fund_raiser_second/components/footer.dart';
import 'package:fund_raiser_second/firebase_services/campaign_services/delete_campaign_services.dart';
import 'package:fund_raiser_second/providers/fundraiser_data_provider.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/display_campaigns_screen/campaign_list.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/create_campaign_screens/create_campaign.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/display_campaigns_screen/my_campaigns.dart';
import 'package:fund_raiser_second/screens/main_app_screens/drawers_option_screens/about_us/about_us.dart';
import 'package:fund_raiser_second/screens/main_app_screens/drawers_option_screens/about_us/help.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import 'package:provider/provider.dart';
import '../../components/button.dart';
import '../../components/little_campaign_card.dart';
import '../../components/loading.dart';
import '../../firebase_services/user_services/UserInfoUtils.dart';
import '../../firebase_services/user_services/add_user_details_service.dart';
import '../../firebase_services/campaign_services/campaign_services.dart';
import '../../providers/campaigns_provider.dart';
import '../../utils/utils_toast.dart';
import '../auth_screens/email_auth/login_screen.dart';
import 'campaign_screens/single_campaign_details/currentUser_Screens/single_campaign_home.dart';
import 'campaign_screens/single_campaign_details/donar_Screens/only_campaign_details.dart';
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
  late CampaignProvider campaignProvider;
  late User? currentUser;
  DateTime? lastBackPressedTime;
  late Map<String, dynamic> userData;
  late UserInfoUtils userInfoUtils;
  String? _imageUrl;
  @override
  void initState() {
    super.initState();
    campaignProvider = Provider.of<CampaignProvider>(context, listen: false);
    currentUser = FirebaseAuth.instance.currentUser;
    _loadCampaigns();
    userInfoUtils = UserInfoUtils(userId: getCurrentUserId());
    userData = {};
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    userData = await userInfoUtils.loadUserInfo();
    setState(() {});
  }
  Future<void> _loadCampaigns() async {
    await campaignProvider.loadCampaigns();
  }
  Future<bool> _onBackPressed() async {
    if (lastBackPressedTime == null ||
        DateTime.now().difference(lastBackPressedTime!) > const Duration(seconds: 2)) {
      lastBackPressedTime = DateTime.now();
      _showExitDialog();
      return false;
    } else {
      return true;
    }
  }
  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you really want to exit?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              SystemNavigator.pop();
              },
            child: const Text('Yes'),
          ),
        ],
      ),
    ).then((result) {
      if (result == true) {
        Navigator.of(context).pop(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String userId = getCurrentUserId();
    final auth = FirebaseAuth.instance;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        persistentFooterButtons: [
       Footer(),
        ],
        appBar: AppBar(
          backgroundColor: greenColor,
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
          backgroundColor: Colors.white,
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
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              minRadius: 30,
                              backgroundColor: Colors.white,
                              maxRadius: 40,
                              child: Image.asset('assets/logo.png'),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                 CircleAvatar(
                                  minRadius: 20,
                                  maxRadius: 30,
                                  backgroundImage:userData.isNotEmpty? NetworkImage(userData['imageUrl']):const NetworkImage('https://firebasestorage.googleapis.com/v0/b/hrtaa-fund-raiser.appspot.com/o/images%2Fuser_profile.png?alt=media&token=1492c8e6-c68f-4bc3-8ff0-58fca5485d4e'),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  children: [
                                     Text(
                                      userData.isNotEmpty? "Hi, "+userData['name']:'Hi, User',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Utils().toastMessage(
                                            "Opening - My Profile",
                                            color: greenColor);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserInfoPage(
                                                        userId: userId)));
                                      },
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.person_outline_outlined,
                                            size: 20,
                                          ),
                                          SizedBox(width: 3),
                                          Text(
                                            "My Profile",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
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
                    MaterialPageRoute(
                        builder: (context) => const HomeDashboard()),
                  );
                },
              ),
              const Divider(
                height: 2, // You can adjust the height of the divider
                color: Colors.grey, // You can set the color of the divider
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
                child: Consumer<FundraiserDataProvider>(builder:
                    (BuildContext context, FundraiserDataProvider value,
                        Widget? child) {
                  return ListTile(
                    textColor: secondColor,
                    iconColor: secondColor,
                    leading: const Icon(Icons.add_circle_outline_outlined),
                    title: const Text('Create Campaign'),
                    // Add functionality for raising funds
                    onTap: () {
                      value.initiateFundraiserData();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CampaignCreation(
                                  campaignService: campaignService)));
                    },
                  );
                }),
              ),
              Visibility(
                visible: _isVisible,
                child: ListTile(
                  textColor: secondColor,
                  iconColor: secondColor,
                  leading: const Icon(Icons.list_alt_outlined),
                  title: const Text('My Campaigns'),
                  // Add functionality for raising funds
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyCampaigns()));
                  },
                ),
              ),
              const Divider(
                height: 2, // You can adjust the height of the divider
                color: Colors.grey, // You can set the color of the divider
              ),
              ListTile(
                leading: const Icon(Icons.handshake_outlined),
                title: const Text('Donate'),
                // Add functionality for donating
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CampaignsList()));
                },
              ),
              const Divider(
                height: 2, // You can adjust the height of the divider
                color: Colors.grey, // You can set the color of the divider
              ),
              ListTile(
                leading: const Icon(Icons.lan_outlined),
                title: const Text('Language'),
                // Add functionality for donating
                onTap: () {
                  // Add your logic for donating
                },
              ),
              const Divider(
                height: 2, // You can adjust the height of the divider
                color: Colors.grey, // You can set the color of the divider
              ),
              ListTile(
                leading:
                    const Image(image: AssetImage('assets/logo.png'), height: 24),
                title: const Text('About Us'),
                // Add functionality for about us
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutUsScreen()));
                },
              ),
              const Divider(
                height: 2, // You can adjust the height of the divider
                color: Colors.grey, // You can set the color of the divider
              ),
              ListTile(
                leading: const Icon(Icons.help_outline_outlined),
                title: const Text('Help'),
                // Add functionality for help
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HelpScreen()));
                },
              ),
              const Divider(
                height: 2, // You can adjust the height of the divider
                color: Colors.grey, // You can set the color of the divider
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text('Logout'),
                // Add functionality for help
                onTap: () {
                  auth.signOut().then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
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
              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/home_dashboard.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const SizedBox(height: 20),
              userData.isNotEmpty? Center(
                child: Text(
                  'Welcome ${userData['name']} ! ',
                  style: TextStyle(
                    fontSize: 20,
                    color: secondColor,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Curved',
                  ),
                ),
              ): Text(
                'Welcome User !',
                style: TextStyle(
                  fontSize: 20,
                  color: secondColor,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Curved',
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
                      constraints: const BoxConstraints(
                        minWidth: 100,
                        minHeight: 40,
                      ),
                      borderRadius: BorderRadius.circular(50),
                      isSelected: [isFundraiserSelected, !isFundraiserSelected],
                      onPressed: (index) {
                        setState(() {
                          isFundraiserSelected = index == 0;
                        });
                      },
                      selectedColor: Colors.white,
                      fillColor: secondColor,
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
                  ? Consumer<FundraiserDataProvider>(
                      builder: (BuildContext context,
                          FundraiserDataProvider value, Widget? child) {
                        return Column(
                          children: [
                            const Text(
                              'Raise Fund for a Cause',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.bold, // Adjust the color as needed
                              ),
                            ),
                            const SizedBox(height: 10),
                            Button(
                              title: 'Raise Fund',
                              color: secondColor,
                              onTap: () {
                                value.initiateFundraiserData();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CampaignCreation(
                                      campaignService: campaignService,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    )
                  : Column(
                      children: [
                        const Text(
                          'Donate for a Cause',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold, // Adjust the color as needed
                          ),
                        ),
                        const SizedBox(height: 10),
                        Button(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CampaignsList(),
                              ),
                            );
                          },
                          title: 'Donate Now',
                          color: secondColor,
                        ),
                      ],
                    ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Top Stories 📰',
                  style: TextStyle(
                    fontSize: 20,
                    color: secondColor,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Curved',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 150,
                child: Consumer<CampaignProvider>(
                  builder: (context, provider, child) {
                    final campaigns = provider.campaigns;
                    campaigns.sort((a, b) => a.dateEnd.difference(DateTime.now()).inDays.compareTo(b.dateEnd.difference(DateTime.now()).inDays));

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: campaigns.length > 5 ? 5 : campaigns.length,
                      itemBuilder: (context, index) {
                        int remainingDays = campaigns[index].dateEnd.difference(DateTime.now()).inDays;
                        bool isCurrentUserCampaign =
                            campaigns[index].ownerId == currentUser?.uid;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width:100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  maxRadius: 50,
                                  minRadius: 40,
                                  backgroundImage:NetworkImage(campaigns[index].coverPhoto),
                               child: InkWell(
                                 onTap: (){
                                   if (isCurrentUserCampaign) {
                                     Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                         builder: (context) => SingleCampaignHomeScreen(
                                           campaign: campaigns[index],
                                         ),
                                       ),
                                     );
                                   } else {
                                     Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                         builder: (context) => OnlyCampaignDetailsPage(
                                           campaign: campaigns[index]),
                                       ),
                                     );
                                   }
                                 },
                                ),),
                                const SizedBox(height: 10),
                                Text(" $remainingDays Days Left",
                                  style: TextStyle(color: Colors.red,fontSize: 12),)
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Make A Change 💖',
                  style: TextStyle(
                    fontSize: 20,
                    color: secondColor,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Curved',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 310,
                child: Consumer<CampaignProvider>(
                  builder: (context, provider, child) {
                    final _campaigns = provider.campaigns;
                    // _campaigns.sort((a, b) => b.dateCreated.difference(DateTime.now()).inDays.compareTo(a.dateCreated.difference(DateTime.now()).inDays));

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _campaigns.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: secondColor,
                              ),
                              child: LittleCampaignCard(
                                campaign: _campaigns[index],
                                isCurrentUserCampaign:
                                _campaigns[index].ownerId == currentUser?.uid,
                                onDeletePressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Delete Campaign !!!"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              'assets/logo.png',
                                              // Replace with your image asset
                                              height: 100,
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              "Are you sure you want to delete your Campaign? This action is irreversible.",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        alignment: Alignment.center,
                                        actionsAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        actions: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.grey[400],
                                            ),
                                            onPressed: () {
                                              Navigator.pop(
                                                  context); // Close the dialog
                                            },
                                            child: const Text("Cancel",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await DeleteCampaignServices
                                                  .deleteCampaign(
                                                  _campaigns[index].id);
                                              await _loadCampaigns();
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red),
                                            child: const Text("Delete",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              )),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
