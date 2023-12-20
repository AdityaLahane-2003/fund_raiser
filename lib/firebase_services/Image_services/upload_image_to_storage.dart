import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/firebase_services/Image_services/store_img_url.dart';
import 'package:uuid/uuid.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';

class ImageUploadUtils {
  static Future<void> uploadImageToFirebaseStorage(File image, String folder) async {
    final String uid = Uuid().v4();
    final Reference storageReference =
    FirebaseStorage.instance.ref().child('$folder/$uid.jpg');
    final UploadTask uploadTask = storageReference.putFile(image);

    await uploadTask.whenComplete(() async {
      Utils().toastMessage('Image Updated Successfully !', color: Colors.green);
      final imageUrl = await storageReference.getDownloadURL();
      ImageStoreUtils.storeImageUrlInFirestore(imageUrl);
    });
  }
}
