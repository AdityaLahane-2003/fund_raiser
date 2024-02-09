import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fund_raiser_second/components/button.dart';
import 'package:fund_raiser_second/components/loading.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import 'package:provider/provider.dart';

import '../firebase_services/Image_services/upload_image_to_storage.dart';
import '../providers/permission_provider.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPermission();
  }

  bool isPhotoPermissionGranted = false;
  bool isVideoPermissionGranted = false;
  bool isDocumentPermissionGranted = false;

  void checkPermission() async {
    var permissionProvider =
        Provider.of<PermissionProvider>(context, listen: false);
    isPhotoPermissionGranted =
        await permissionProvider.requestPhotosPermission();
    if (!isPhotoPermissionGranted) {
      Utils().toastMessage("Images Permission denied !");
    }
    isVideoPermissionGranted =
        await permissionProvider.requestVideosPermission();
    if (!isVideoPermissionGranted) {
      Utils().toastMessage("Videos Permission denied !");
    }
  }

  Future selectFile() async {
    if (widget.uploadingMedia == 'Image' || widget.uploadingMedia == 'Video') {
      if (!isPhotoPermissionGranted) {
        Utils().toastMessage("Please grant Images and Videos Permission !");
        AppSettings.openAppSettings();
        setState(() {
          checkPermission();
        });
        return;
      }
    }

    if (widget.uploadingMedia == "Document") {
      if (!isDocumentPermissionGranted) {
        Utils().toastMessage(
            "Please grant Document Permission by selecting checkbox!");
        return;
      }
    }
    List<String>? allowedExtensions;
    if (widget.uploadingMedia == 'Image') {
      allowedExtensions = ['jpg', 'jpeg', 'png'];
    } else if (widget.uploadingMedia == 'Video') {
      allowedExtensions = ['mp4', 'avi', 'mov', 'mkv'];
    } else if (widget.uploadingMedia == 'Document') {
      allowedExtensions = ['pdf'];
    }

    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );
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
        const SizedBox(height: 20),
        Text("Upload ${widget.uploadingMedia}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 20),
        Column(
          children: [
            GestureDetector(
              onTap: selectFile,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
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
                  const FaIcon(
                    FontAwesomeIcons.plusCircle,
                    color: Colors.grey,
                    size: 30,
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Select ${widget.uploadingMedia} by clicking on the above icon',
            ),
            widget.uploadingMedia == "Document"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: isDocumentPermissionGranted,
                        onChanged: (value) {
                          setState(() {
                            isDocumentPermissionGranted = value!;
                          });
                        },
                      ),
                      Flexible(
                        child: GestureDetector(
                            child: const Text(
                              "I agree to the give access to docs. (𝑽𝒊𝒆𝒘)",
                              style: TextStyle(fontSize: 12),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Terms and Conditions"),
                                    content: const Text(
                                        "By clicking on the checkbox, you agree to give access to your external file storage,\n\n This will help us to upload your documents to the server, which will be used for the campaign."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }),
                      ),
                    ],
                  )
                : Container(),
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

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _pickedFiles!.remove(documentUrl);
                      });
                    },
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          fileType == 'Image'
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: FileImage(File(pickedFile.path!)),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: fileType == 'Video'
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const FaIcon(
                                              FontAwesomeIcons.video,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              pickedFile.name,
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const FaIcon(
                                              FontAwesomeIcons.file,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              pickedFile.name,
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _pickedFiles!.remove(documentUrl);
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

            const SizedBox(height: 20),
            isuploadingStarted
                ? Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Loading(
                          size: 25,
                          color: greenColor,
                        ),
                      ),
                      const SizedBox(height: 20),
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
                    title: 'Upload ${widget.uploadingMedia}',
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
