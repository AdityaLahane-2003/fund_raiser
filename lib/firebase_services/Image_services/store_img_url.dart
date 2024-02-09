import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';

class ImageStoreUtils {
  static Future<void> storeImageUrlInFirestore(String imageUrl) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Store the image URL in Firestore for the current user
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      await users.doc(user.uid).update({
        'imageUrl': imageUrl,
      });

      Utils().toastMessage('Image stored for the current user',color: Colors.green);
    } else {
      Utils().toastMessage('User Not Authenticated', color: Colors.red);
    }
  }
}
