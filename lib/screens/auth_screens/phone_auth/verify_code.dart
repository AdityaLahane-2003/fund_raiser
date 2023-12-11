import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/main_app_screens/home_dashboard.dart';
import 'package:fund_raiser_second/screens/post_auth_screens/take_user_info.dart';
import '../../../components/round_button.dart';
import '../../../utils/constants/isPhoneVerified.dart';
import '../../../utils/utils_toast.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  final String phone;
  final String comingFrom;

  const VerifyCodeScreen({required this.verificationId,required this.phone,required this.comingFrom});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;

  final verificationCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;

  Future<bool> checkUserExists(String phoneNumber) async {
    try {
      // Reference to the "users" collection in Firestore
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      // Query to check if a user with the given phone number exists
      QuerySnapshot querySnapshot = await users.where('phone', isEqualTo: phoneNumber).get();

      // Check if any documents match the query
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      // Handle errors (e.g., network issues, Firebase errors)
      print('Error checking user existence: $e');
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            TextFormField(
              controller: verificationCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: '6 digit code'),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(
                title: 'Verify',
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  final crendital = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: verificationCodeController.text.toString());

                  try {
                    await auth.signInWithCredential(crendital);
                    isPhoneverified=true;
                    widget.comingFrom=="signup"?Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TakeUserInfoScreen())):
                     await checkUserExists(widget.phone)?Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeDashboard())):
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TakeUserInfoScreen()));
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(e.toString());
                  }
                })
          ],
        ),
      ),
    );
  }
}
