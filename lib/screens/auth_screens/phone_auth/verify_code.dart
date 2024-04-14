import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';
import 'package:fund_raiser_second/screens/auth_screens/phone_auth/login_with_phone_number.dart';
import 'package:fund_raiser_second/screens/main_app_screens/home_dashboard.dart';
import 'package:fund_raiser_second/screens/main_app_screens/take_user_info.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import '../../../components/button.dart';
import '../../../components/footer.dart';
import '../../../firebase_services/user_services/add_user_details_service.dart';
import '../../../utils/utils_toast.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  final String phone;
  final String comingFrom;

  const VerifyCodeScreen(
      {super.key, required this.verificationId,
      required this.phone,
      required this.comingFrom});

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
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Query to check if a user with the given phone number exists
      QuerySnapshot querySnapshot =
          await users.where('phone', isEqualTo: phoneNumber).get();

      // Check if any documents match the query
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      // Handle errors (e.g., network issues, Firebase errors)
      Utils().toastMessage('Error checking user existence: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: const [
      Footer(),
    ],
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/logo.png'),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormFieldArea(
              prefixIcon: Icons.numbers,
              controller: verificationCodeController,
              textInputType: TextInputType.number,
              title: '6 Digit Verification Code',
            ),
            const SizedBox(
              height: 20,
            ),
            Button(
                title: 'Verify',
                loading: loading,
                color: greenColor,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: verificationCodeController.text.toString());

                  try {
                    await auth.signInWithCredential(credential);
                    bool userExists = await checkUserExists(widget.phone);
                    if (widget.comingFrom == "signup") {
                      addUserDetails("User", "email",
                          widget.phone.toString(), 0, "bio");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TakeUserInfoScreen()));
                    } else {
                      if (userExists) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeDashboard()));
                      } else {
                        Utils().toastMessage(
                            "User does not exist, please sign up first");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginWithPhoneNumber(comingFrom: "signup",)));
                      }
                    }
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(e.toString().split(']')[1].trim());
                  }
                })
          ],
        ),
      ),
    );
  }
}
