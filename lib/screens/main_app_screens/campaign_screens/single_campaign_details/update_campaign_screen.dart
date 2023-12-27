import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/campaign_settings_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/update_info_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/upload_docs_and_media_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/write_updates_screen.dart';

class UpdateCampaignScreen extends StatelessWidget {
  const UpdateCampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Campaign'),
        backgroundColor: Colors.blue[300],
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.info),
            subtitle: const Text('Follow the following instructions'),
            trailing: const Icon(Icons.arrow_forward_ios),
            title: const Text('Update Info'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateInfoScreen()),
              );
            },
          ),ListTile(
            leading: const Icon(Icons.document_scanner),
            subtitle: const Text('Follow the following instructions'),
            trailing: const Icon(Icons.arrow_forward_ios),
            title: const Text('Upload Documents'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UploadMediaScreen()),
              );
            },
          ),ListTile(
            leading: const Icon(Icons.photo),
            subtitle: const Text('Follow the following instructions'),
            trailing: const Icon(Icons.arrow_forward_ios),
            title: const Text('Add Media'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UploadMediaScreen()),
              );
            },
          ),ListTile(
            leading: const Icon(Icons.update),
            subtitle: const Text('Follow the following instructions'),
            trailing: const Icon(Icons.arrow_forward_ios),
            title: const Text('Write updates'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WriteUpdatesScreen()),
              );
            },
          ),ListTile(
            leading: const Icon(Icons.settings),
            subtitle: const Text('Follow the following instructions'),
            trailing: const Icon(Icons.arrow_forward_ios),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CampaignSettingsScreen()),
              );
            },
          ),
          // Add more list items
        ],
      ),
    );
  }
}
