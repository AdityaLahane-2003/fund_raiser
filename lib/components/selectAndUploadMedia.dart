import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fund_raiser_second/components/button.dart';
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
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text("Upload ${widget.uploadingMedia}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 20),
        Column(
          children: [
            GestureDetector(
              onTap: selectFile,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: FaIcon(
                    widget.uploadingMedia == 'Image'
                        ? FontAwesomeIcons.image
                        : widget.uploadingMedia == 'Video'
                            ? FontAwesomeIcons.video
                            : FontAwesomeIcons.file,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Select ${widget.uploadingMedia} by clicking on the above icon',
            ),
            // const SizedBox(height: 10),
            // Text(
            //   'You can select multiple ${widget.uploadingMedia}s at once',),
            // const SizedBox(height: 10),
            // Text("Size of ${widget.uploadingMedia} should be less than 10MB"),
            const SizedBox(height: 20),
            if (_pickedFiles != null)
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _pickedFiles!.map((documentUrl) {
                  final PlatformFile pickedFile = documentUrl;
                  final String fileType = getFileType(pickedFile.path!);
                  return fileType == 'Image'
                      ? Container(
                    height: 100.0,
                    width: 100.0,
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: FileImage(File(pickedFile.path!)),
                        fit: BoxFit.fill,
                      ),
                    ),
                      )
                      : fileType == 'Video'
                          ? Container(
                            height: 100.0,
                            width: 100.0,
                            margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                               FaIcon(FontAwesomeIcons.video,color: Colors.grey,),
                                Text(pickedFile.name,
                                  style: TextStyle(color: Colors.grey),),
                              ],
                            ),
                          )
                          : Container(
                    height: 100.0,
                    width: 100.0,
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.file,color: Colors.grey,),
                        Text(pickedFile.name,
                          style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                  );
                }).toList(),
              ),
            // SizedBox(
            //   height: 100,
            //   child: ListView.builder(
            //     itemCount: _pickedFiles!.length,
            //     itemBuilder: (context, index) {
            //       final PlatformFile pickedFile = _pickedFiles![index];
            //       final String fileType = getFileType(pickedFile.path!);
            //
            //       if (fileType == 'Image') {
            //         return Wrap(
            //           spacing: 8.0,
            //           runSpacing: 4.0,
            //           children: [
            //             Image.file(
            //               File(pickedFile.path!),
            //               height: 100,
            //               width: 100,
            //               fit: BoxFit.cover,
            //             ),
            //           ],
            //         );
            //       }else if(fileType == 'Video'){
            //         // _controller=VideoPlayerController.file(File(pickedFile.path!))
            //         //   ..initialize().then((_) {
            //         //     setState(() {});
            //         //   });
            //         return Column(
            //           children: [
            //             Container(
            //               height: 100,
            //               width: 100,
            //               decoration: BoxDecoration(
            //                 border: Border.all(color: Colors.black),
            //               ),
            //               child: Center(
            //                 child:
            //                _controller.value.isInitialized? VideoPlayer(_controller):Container(),
            //               ),
            //             ),
            //             ElevatedButton(onPressed: (){
            //               setState(() {
            //                 _controller.value.isPlaying?_controller.pause():_controller.play();
            //               });
            //             }, child: Text(_controller.value.isPlaying?'Pause':'Play'))
            //           ],
            //         );
            //       }else {
            //         return ListTile(
            //           title: Text(pickedFile.name),
            //         );
            //       }
            //     },
            //   ),
            // ),
            const SizedBox(height: 20),
            isuploadingStarted
                ? Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          color: secondColor,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Uploading Document... Please Wait !!! ',
                        style: TextStyle(color: secondColor),
                      )
                    ],
                  )
                : Button(
                    onTap: () async {
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
                                  : getFileType(_pickedFiles![i].path!) ==
                                          'Video'
                                      ? 'mp4'
                                      : 'pdf';

                          _fileUrl = await ImageUploadUtils
                              .uploadFileToFirebaseStorage(
                            File(_pickedFiles![i].path!),
                            widget.pathToStore,
                            fileExtension,
                          );

                          CollectionReference campaigns = FirebaseFirestore
                              .instance
                              .collection('campaigns');
                          await campaigns.doc(widget.campaignId).update({
                            widget.fieldToUpdate:
                                FieldValue.arrayUnion([_fileUrl]),
                          });

                          Utils().toastMessage(
                            'Uploaded ${widget.uploadingMedia}  ${i + 1} Successfully ! ',
                            color: secondColor,
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
                    title:'Upload ${widget.uploadingMedia}',
                    color: secondColor,
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
