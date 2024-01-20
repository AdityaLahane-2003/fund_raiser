import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/currentUser_Screens/update_info_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/currentUser_Screens/upload_docs_and_media_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/currentUser_Screens/write_updates_screen.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';

import '../../../../../../models/campaign_model.dart';

class CampaignStoryScreen extends StatelessWidget {
  final Campaign campaign;
  const CampaignStoryScreen({super.key,required this.campaign});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Campaign'),
        backgroundColor:greenColor,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
           const Text('Update your campaign to get more donations ! '
            ,style: TextStyle(fontSize: 18),
           textAlign: TextAlign.center,),
          const SizedBox(height: 20,),
          ListTile(
            leading: const Icon(Icons.info),
            subtitle: const Text('Update the information of your campaign.'),
            trailing: const Icon(Icons.arrow_forward_ios),
            title: const Text('Update Info',style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateInfoScreen(campaign: campaign,)),
              );
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
          // ListTile(
          //   leading: const Icon(Icons.settings),
          //   subtitle: const Text('Follow the following instructions'),
          //   trailing: const Icon(Icons.arrow_forward_ios),
          //   title: const Text('Settings'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const CampaignSettingsScreen()),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
