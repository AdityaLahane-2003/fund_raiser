import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/verify_email.dart';
import 'package:fund_raiser_second/screens/main_app_screens/drawers_option_screens/update_profile.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';
import '../../../firebase_services/Image_services/pick_image.dart';
import '../../../firebase_services/Image_services/upload_image_to_storage.dart';
import '../../../firebase_services/user_services/delete_user_services.dart';
import '../../../firebase_services/user_services/update_user_info_services.dart'; // Import your FirebaseService

class UserInfoPage extends StatefulWidget {
  final String userId;

  const UserInfoPage({required this.userId});

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final FirebaseService firebaseService = FirebaseService();
  late Map<String, dynamic> userData;
  DeleteUserServices deleteUserServices = DeleteUserServices();
  File? _selectedImage;
  @override
  void initState() {

    super.initState();
    userData = {};
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    userData = await firebaseService.getUser(widget.userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: userData.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: userData['imageUrl'] != ""
                                ? NetworkImage(userData['imageUrl'])
                                : NetworkImage(
                                    "https://firebasestorage.googleapis.com/v0/b/hrtaa-fund-raiser.appspot.com/o/images%2Fl2.webp?alt=media&token=7be46cf5-ec6b-42b3-9a2b-9d8d6e1a4be3"), // Provide a default image
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child:TextButton(
                          onPressed: () async {
                            _selectedImage = await ImagePickerUtils.pickImage();
                            setState(() {});
                            if (_selectedImage != null) {
                              await ImageUploadUtils.uploadImageToFirebaseStorage(
                                  _selectedImage!, 'user_images');
                            }else{
                              Utils().toastMessage('Please pick an image first.');
                            }
                          },
                          child: Text('UPDATE'),
                        )
                      ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: userData['name'] != ""
                        ? Text('Name: ${userData['name']}')
                        : Text('Name: User}'),
                  ),
                  ListTile(
                      leading: Icon(Icons.email_outlined),
                      title: userData['email'] != ""
                          ? Text('Email: ${userData['email']}')
                          : const Text('Email: Not provided}'),
                      subtitle:FirebaseAuth.instance.currentUser!.emailVerified
                          ? SizedBox(height: 0,):const Text("we've sent link to verify email, please check and verify!"),
                      trailing: FirebaseAuth.instance.currentUser!.emailVerified
                          ? const Icon(Icons.verified_outlined, color: Colors.green)
                          : TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const VerifyEmail(isSignUp: false,),
                                  ),
                                );
                              },
                              child: Text(
                                "Verify",
                                style: TextStyle(color: Colors.red),
                              ))),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Phone: ${userData['phone']}'),
                  ),
                  ListTile(
                    leading: Icon(Icons.abc_outlined),
                    title: Text('Bio: ${userData['bio']}'),
                  ),
                  ListTile(
                    leading: Icon(Icons.numbers),
                    title: Text('Age: ${userData['age']}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
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
                          child: Text('Update Info'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Delete Account"),
                                  content: Text(
                                      "Are you sure you want to delete your account? This action is irreversible."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // Close the dialog
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        // Call a function to delete the account and data
                                        await deleteUserServices
                                            .deleteAccountAndData(context);
                                      },
                                      child: Text("Delete"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text("Delete Account"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
