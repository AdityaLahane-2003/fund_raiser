import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import 'package:video_player/video_player.dart';

import '../firebase_services/Image_services/upload_image_to_storage.dart';
import '../utils/utils_toast.dart';

class SelectAndUploadmedia extends StatefulWidget {
  final String uploadingMedia;
  final String campaignId;
  final String pathToStore;
  final String fieldToUpdate;

  const SelectAndUploadmedia({
    super.key,
    required this.uploadingMedia,
    required this.campaignId,
    required this.pathToStore,
    required this.fieldToUpdate,
  });

  @override
  State<SelectAndUploadmedia> createState() => _SelectAndUploadmediaState();
}

class _SelectAndUploadmediaState extends State<SelectAndUploadmedia> {
  List<PlatformFile>? _pickedFiles;
  bool isuploadingStarted = false;
 late VideoPlayerController _controller;
 @override
  void initState() {
    // TODO: implement initState
   _controller=VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
   ..initialize().then((_) {
     setState(() {});
  });
    super.initState();
 }
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      final List<PlatformFile> files = result.files;
      setState(() {
        _pickedFiles = files;
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text("Upload ${widget.uploadingMedia}"),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: selectFile,
              child: Container(
                height: 100,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Tap to Select ${widget.uploadingMedia}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_pickedFiles != null)
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: _pickedFiles!.length,
                  itemBuilder: (context, index) {
                    final PlatformFile pickedFile = _pickedFiles![index];
                    final String fileType = getFileType(pickedFile.path!);

                    if (fileType == 'Image') {
                      return Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: [
                          Image.file(
                            File(pickedFile.path!),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ],
                      );
                    }else if(fileType == 'Video'){
                      // _controller=VideoPlayerController.file(File(pickedFile.path!))
                      //   ..initialize().then((_) {
                      //     setState(() {});
                      //   });
                      return Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Center(
                              child:
                             _controller.value.isInitialized? VideoPlayer(_controller):Container(),
                            ),
                          ),
                          ElevatedButton(onPressed: (){
                            setState(() {
                              _controller.value.isPlaying?_controller.pause():_controller.play();
                            });
                          }, child: Text(_controller.value.isPlaying?'Pause':'Play'))
                        ],
                      );
                    }else {
                      return ListTile(
                        title: Text(pickedFile.name),
                      );
                    }
                  },
                ),
              ),
            const SizedBox(height: 20),
            isuploadingStarted
                ?  Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    color:greenColor,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Uploading Document... Please Wait !!! ',
                  style: TextStyle(color: greenColor),
                )
              ],
            )
                : ElevatedButton(
              onPressed: () async {
                if (_pickedFiles != null) {
                  String? _fileUrl;
                  setState(() {
                    isuploadingStarted = true;
                  });

                  for (int i = 0; i < _pickedFiles!.length; i++) {
                    if (getFileType(_pickedFiles![i].path!) !=
                        widget.uploadingMedia) {
                      Utils().toastMessage(
                        'Please Select ${widget.uploadingMedia} !\n '
                            'You have selected some ${getFileType(_pickedFiles![i].path!)}',
                        color: Colors.red,
                      );
                      setState(() {
                        _pickedFiles = null;
                        isuploadingStarted = false;
                      });
                      return;
                    }
                  }

                  for (int i = 0; i < _pickedFiles!.length; i++) {
                    final String fileExtension =
                    getFileType(_pickedFiles![i].path!) == 'Image'
                        ? 'jpg'
                        : getFileType(_pickedFiles![i].path!) == 'Video'
                        ? 'mp4'
                        : 'pdf';

                    _fileUrl = await ImageUploadUtils.uploadFileToFirebaseStorage(
                      File(_pickedFiles![i].path!),
                      widget.pathToStore,
                      fileExtension,
                    );

                    CollectionReference campaigns =
                    FirebaseFirestore.instance.collection('campaigns');
                    await campaigns.doc(widget.campaignId).update({
                      widget.fieldToUpdate:
                      FieldValue.arrayUnion([_fileUrl]),
                    });

                    Utils().toastMessage(
                      'Uploaded ${widget.uploadingMedia}  ${i + 1} Successfully ! ',
                      color: greenColor,
                    );
                  }

                  setState(() {
                    _pickedFiles = null;
                  });

                  Navigator.pop(context);
                } else {
                  Utils().toastMessage(
                    'Please Select ${widget.uploadingMedia} !',
                    color: Colors.red,
                  );
                }
              },
              child: Text('Upload ${widget.uploadingMedia}'),
            ),
          ],
        ),
      ],
    );
  }
}

String getFileType(String filePath) {
  final String extension = filePath.split('.').last.toLowerCase();

  if (extension == 'jpg' ||
      extension == 'jpeg' ||
      extension == 'png' ||
      extension == 'gif') {
    return 'Image';
  } else if (extension == 'mp4' ||
      extension == 'avi' ||
      extension == 'mov' ||
      extension == 'mkv') {
    return 'Video';
  } else {
    return 'Document';
  }
}
