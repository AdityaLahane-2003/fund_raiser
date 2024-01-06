import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../components/selectAndUploadMedia.dart';

class UploadMediaScreen extends StatefulWidget {
  final String campaignId;

  const UploadMediaScreen({super.key, required this.campaignId});

  @override
  State<UploadMediaScreen> createState() => _UploadMediaScreenState();
}

class _UploadMediaScreenState extends State<UploadMediaScreen> {
  bool isSelectImageSelected = true;
  bool isSelectMediaSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Media'),
        toolbarHeight: 30,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ToggleButtons(
            borderRadius: BorderRadius.circular(50),
            isSelected: [isSelectMediaSelected, !isSelectMediaSelected],
            onPressed: (index) {
              setState(() {
                isSelectMediaSelected = index == 0;
              });
            },
            selectedColor: Colors.white,
            fillColor: greenColor,
            children: const [
              Text('   Select Media   '),
              Text('   Select Documents    '),
            ], // Adjust the color as needed
          ),
          isSelectMediaSelected
              ? Column(children: [
                  SizedBox(height: 20),
                  ToggleButtons(
                    borderRadius: BorderRadius.circular(50),
                    isSelected: [isSelectImageSelected, !isSelectImageSelected],
                    onPressed: (index) {
                      setState(() {
                        isSelectImageSelected = index == 0;
                      });
                    },
                    selectedColor: Colors.white,
                    fillColor: greenColor,
                    children: const [
                      Text('   Select Images   '),
                      Text('   Select Videos    '),
                    ], // Adjust the color as needed
                  ),
                  isSelectImageSelected
                      ? SelectAndUploadmedia(
                    campaignId: widget.campaignId,
                    uploadingMedia: 'Image',
                    fieldToUpdate: 'mediaImageUrls',
                    pathToStore: 'campaigns_mediaImages',
                  )
                      : SelectAndUploadmedia(
                    campaignId: widget.campaignId,
                    uploadingMedia: 'Video',
                    fieldToUpdate: 'mediaVideoUrls',
                    pathToStore: 'campaigns_mediaVideos',
                  ),
                ])
              : SelectAndUploadmedia(
                  campaignId: widget.campaignId,
                  uploadingMedia: 'Document',
                  fieldToUpdate: 'documentUrls',
                  pathToStore: 'campaigns_mediaDocuments',
                ),
        ],
      ),
    );
  }
}
