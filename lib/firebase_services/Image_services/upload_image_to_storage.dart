import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';

class ImageUploadUtils {
  static Future<String> uploadImageToFirebaseStorage(File image, String folder) async {
    return uploadFileToFirebaseStorage(image, folder, 'jpg');
  }
  //
  // static Future<String> uploadVideoToFirebaseStorage(File video, String folder) async {
  //   return uploadFileToFirebaseStorage(video, folder, 'mp4');
  // }
  //
  // static Future<String> uploadDocumentToFirebaseStorage(File document, String folder) async {
  //   return uploadFileToFirebaseStorage(document, folder, 'pdf');
  // }

  static Future<String> uploadFileToFirebaseStorage(File file, String folder, String fileExtension) async {
    final String uid = const Uuid().v4();
    final Reference storageReference =
    FirebaseStorage.instance.ref().child('$folder/$uid.$fileExtension');
    final UploadTask uploadTask = storageReference.putFile(file);
    var fileUrl;

    await uploadTask.whenComplete(() async {
      Utils().toastMessage('File Updated Successfully !', color: Colors.green);
      fileUrl = await storageReference.getDownloadURL();
      // Additional processing if needed
    });

    return fileUrl;
  }
}
