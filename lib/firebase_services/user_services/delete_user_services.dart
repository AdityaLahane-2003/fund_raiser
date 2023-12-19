import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';

import '../../screens/auth_screens/email_auth/login_screen.dart';

class DeleteUserServices {

  Future deleteAccountAndData(BuildContext context) async {
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
        Utils().toastMessage("Account Deleted Successfully", color:Colors.green);
        Navigator.pop(context); // Close the dialog
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      } else {
        print("Error deleting account: User is not signed in.");
        Utils().toastMessage("User is not signed in.", color:Colors.red);
        // Handle the case where the user is not signed in.
      }
    } catch (e) {
      Utils().toastMessage("Error deleting account: $e", color:Colors.red);
      // Handle errors (show a message, log the error, etc.)
    }
  }

}