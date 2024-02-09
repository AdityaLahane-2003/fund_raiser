import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import 'package:provider/provider.dart';
import '../../../../../components/selectAndUploadMedia.dart';
import '../../../../../providers/permission_provider.dart';
import '../../../../../utils/utils_toast.dart';

class UploadMediaScreen extends StatefulWidget {
  final String campaignId;
  const UploadMediaScreen({super.key, required this.campaignId});

  @override
  State<UploadMediaScreen> createState() => _UploadMediaScreenState();
}

class _UploadMediaScreenState extends State<UploadMediaScreen> {
  bool isSelectImageSelected = true;
  bool isSelectMediaSelected = true;
  List<bool> isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Text('Upload Media'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ToggleButtons(
                  borderRadius: BorderRadius.circular(50),
                  selectedColor: Colors.white,
                  fillColor: secondColor,
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
                  children: const [
                    Text("Images"),
                    Text("Videos"),
                    Text("Documents"),
                  ],
                ),
              ],
            ),
            isSelected[0]
                ?  SelectAndUploadmedia(
              campaignId: widget.campaignId,
              uploadingMedia: 'Image',
              fieldToUpdate: 'mediaImageUrls',
              pathToStore: 'campaigns_mediaImages',
            ): isSelected[1]
                ?SelectAndUploadmedia(
              campaignId: widget.campaignId,
              uploadingMedia: 'Video',
              fieldToUpdate: 'mediaVideoUrls',
              pathToStore: 'campaigns_mediaVideos',
            ):SelectAndUploadmedia(
              campaignId: widget.campaignId,
              uploadingMedia: 'Document',
              fieldToUpdate: 'documentUrls',
              pathToStore: 'campaigns_mediaDocuments',
            ),
          ],
        ),
      ),
    );
  }
}
