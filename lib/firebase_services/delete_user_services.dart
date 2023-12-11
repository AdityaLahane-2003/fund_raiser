import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> deleteAccountAndData() async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Delete data from Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();

      // Delete the user's account
      await user.delete();

      // Sign out the user
      await FirebaseAuth.instance.signOut();
    } else {
      print("User is not signed in.");
      // Handle the case where the user is not signed in.
    }
  } catch (e) {
    print("Error deleting account: $e");
    // Handle errors (show a message, log the error, etc.)
  }
}
