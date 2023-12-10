import 'package:flutter/material.dart';

import '../../../firebase_services/update_user_info_services.dart';
import '../../../utils/utils_toast.dart';
class UpdateUserInfoPage extends StatefulWidget {
  final String userId;
  final String currentName;
  final String currentEmail;
  final String currentPhone;
  final String? currentAge;
  final String currentBio;

  const UpdateUserInfoPage({
    required this.userId,
    required this.currentName,
    required this.currentEmail,
    required this.currentPhone,
    required this.currentAge,
    required this.currentBio,
  });

  @override
  _UpdateUserInfoPageState createState() => _UpdateUserInfoPageState();
}

class _UpdateUserInfoPageState extends State<UpdateUserInfoPage> {
  final FirebaseService firebaseService = FirebaseService();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController ageController;
  late TextEditingController bioController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current user data
    nameController = TextEditingController(text: widget.currentName);
    emailController = TextEditingController(text: widget.currentEmail);
    phoneController = TextEditingController(text: widget.currentPhone);
    ageController = TextEditingController(text: widget.currentAge ?? '');
    bioController = TextEditingController(text: widget.currentBio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: bioController,
                decoration: InputDecoration(labelText: 'Bio'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {

                  await firebaseService.updateUser(widget.userId, {
                    'name': nameController.text.trim(),
                    'email': emailController.text.trim(),
                    'phone': phoneController.text.trim(),
                    'age': int.tryParse(ageController.text.trim()) ?? 0,
                    'bio': bioController.text.trim(),
                  });
                  Utils().toastMessage("Info Upadated", color: Colors.green);
                  Navigator.pop(context); // Pop this page to go back to UserInfoPage
                },
                child: Text('Update Info'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
