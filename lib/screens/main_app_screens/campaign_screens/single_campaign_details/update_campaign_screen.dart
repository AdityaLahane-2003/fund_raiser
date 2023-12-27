import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/campaign_settings_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/update_info_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/upload_docs_and_media_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/single_campaign_details/write_updates_screen.dart';

class UpdateCampaignScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Campaign'),
        backgroundColor: Colors.blue[300],
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.info),
            subtitle: Text('Follow the following instructions'),
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('Update Info'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateInfoScreen()),
              );
            },
          ),ListTile(
            leading: Icon(Icons.document_scanner),
            subtitle: Text('Follow the following instructions'),
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('Upload Documents'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UploadMediaScreen()),
              );
            },
          ),ListTile(
            leading: Icon(Icons.photo),
            subtitle: Text('Follow the following instructions'),
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('Add Media'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UploadMediaScreen()),
              );
            },
          ),ListTile(
            leading: Icon(Icons.update),
            subtitle: Text('Follow the following instructions'),
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('Write updates'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WriteUpdatesScreen()),
              );
            },
          ),ListTile(
            leading: Icon(Icons.settings),
            subtitle: Text('Follow the following instructions'),
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CampaignSettingsScreen()),
              );
            },
          ),
          // Add more list items
        ],
      ),
    );
  }
}
