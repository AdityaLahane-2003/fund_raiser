import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/share_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/thank_donars_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/update_campaign_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/withdraw_screen.dart';
import '../../../../models/campaign_model.dart';
import 'campaign_details_home.dart';

class SingleCampaignHomeScreen extends StatefulWidget {
  final Campaign campaign;
  const SingleCampaignHomeScreen({super.key,required this.campaign});

  @override
  _SingleCampaignHomeScreenState createState() => _SingleCampaignHomeScreenState();
}

class _SingleCampaignHomeScreenState extends State<SingleCampaignHomeScreen> {
  int _currentIndex = 0;
  late List<Widget> _pages;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      CampaignDetailsPage(campaign: widget.campaign,),
      UpdateCampaignScreen(),
      WithdrawScreen(),
      ThankDonorsPage(),
      const ShareCampaignScreen(),
    ];
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.info, color: Colors.green.shade700,),
            backgroundColor: Colors.green.shade300,
            icon: const Icon(Icons.info, ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue.shade300,
            activeIcon: Icon(Icons.edit, color: Colors.blue.shade700,),
            icon: const Icon(Icons.edit),
            label: 'Story',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.monetization_on, color: Colors.yellow.shade700,),
            backgroundColor: Colors.yellow.shade300,
            icon: const Icon(Icons.monetization_on),
            label: 'Withdraw',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.favorite, color: Colors.red.shade700,),
            backgroundColor: Colors.red.shade300,
            icon: const Icon(Icons.favorite),
            label: 'Thank Donors',
          ), BottomNavigationBarItem(
            activeIcon: Icon(Icons.share, color: Colors.orange.shade700,),
            backgroundColor: Colors.orange.shade300,
            icon: const Icon(Icons.share),
            label: 'Share Campaign',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
