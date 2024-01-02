import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/firebase_services/user_services/UserInfoUtils.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/verify_email.dart';
import 'package:fund_raiser_second/screens/main_app_screens/drawers_option_screens/update_profile.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';
import '../../../components/button.dart';
import '../../../components/loading.dart';
import '../../../firebase_services/Image_services/pick_image.dart';
import '../../../firebase_services/Image_services/store_img_url.dart';
import '../../../firebase_services/Image_services/upload_image_to_storage.dart';
import '../../../firebase_services/user_services/delete_user_services.dart';

class UserInfoPage extends StatefulWidget {
  final String userId;

  const UserInfoPage({super.key, required this.userId});

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  late Map<String, dynamic> userData;
  DeleteUserServices deleteUserServices = DeleteUserServices();
  File? _selectedImage;
  late UserInfoUtils userInfoUtils;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    userInfoUtils = UserInfoUtils(userId: widget.userId);
    userData = {};
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    userData = await userInfoUtils.loadUserInfo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: const Text('My Profile'),
      ),
      body: userData.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: userData['imageUrl'] != ""
                            ? NetworkImage(userData['imageUrl'])
                            : const NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/hrtaa-fund-raiser.appspot.com/o/images%2Fl2.webp?alt=media&token=7be46cf5-ec6b-42b3-9a2b-9d8d6e1a4be3"), // Provide a default image
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: TextButton(
                          onPressed: () async {
                            _selectedImage = await ImagePickerUtils.pickImage();
                            setState(() {});
                            if (_selectedImage != null) {
                              _imageUrl = await ImageUploadUtils
                                  .uploadImageToFirebaseStorage(
                                      _selectedImage!, 'user_images');
                              await ImageStoreUtils.storeImageUrlInFirestore(
                                  _imageUrl!);
                            } else {
                              Utils()
                                  .toastMessage('Please pick an image first.');
                            }
                          },
                          child: Text(
                            'UPDATE',
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontSize: 12,
                            ),
                          ))),
                  ListTile(
                      leading: const Icon(Icons.person),
                      title: Text('Name: ${userData['name']}')),
                  ListTile(
                      leading: const Icon(Icons.email_outlined),
                      title: userData['email'] != ""
                          ? Text('Email: ${userData['email']}')
                          : const Text('Email: Not provided'),
                      subtitle: FirebaseAuth.instance.currentUser!.emailVerified
                          ? const SizedBox(
                              height: 0,
                            )
                          : Text(
                              "We've sent link to verify email, please check and verify!",
                              style: TextStyle(color: Colors.red.shade200)),
                      trailing: FirebaseAuth.instance.currentUser!.emailVerified
                          ? const Icon(Icons.verified_outlined,
                              color: Colors.green)
                          : TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const VerifyEmail(
                                      isSignUp: false,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "Verify",
                                style: TextStyle(color: Colors.red),
                              ))),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text('Phone: ${userData['phone']}'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.abc_outlined),
                    title: Text('Bio: ${userData['bio']}'),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Button(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateUserInfoPage(
                                  userId: widget.userId,
                                  currentName: userData['name'],
                                  currentEmail: userData['email'],
                                  currentPhone: userData['phone'],
                                  currentAge: userData['age']?.toString(),
                                  currentBio: userData['bio'],
                                ),
                              ),
                            ).then((_) {
                              // Refresh user data after returning from the update page
                              loadUserInfo();
                            });
                          },
                         title: 'Update Info',
                        color: Colors.green.shade700,
                        ),
                      Button(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Delete Account !!!"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/logo.png',
                                        // Replace with your image asset
                                        height: 100,
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Are you sure you want to delete your account? This action is irreversible.",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  actionsAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  actions: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.grey[400],
                                      ),
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // Close the dialog
                                      },
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        // Call a function to delete the account and data
                                        await deleteUserServices
                                            .deleteAccountAndData(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red),
                                      child: const Text("Delete",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          title: 'Delete Account',
                      color: Colors.red.shade500,)
                    ],
                  ),
                ],
              ),
            )
          : Center(
              child: Loading(
                size: 50,
                color: Colors.green.shade700,
              ),
            ),
    );
  }
}
