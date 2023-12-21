import 'package:flutter/material.dart';

import '../../../firebase_services/user_services/update_user_info_services.dart';
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
              CircleAvatar(
                backgroundColor: Colors.green[100],
                minRadius: 30,
                maxRadius: 65,
                child: Image.asset('assets/logo.png'),),
              SizedBox(height: 15.0),
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text, // Text color
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.green[800]),
                  // Label color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.person), // Prefix icon
                ),
              ),SizedBox(height: 12.0),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress, // Text color
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.green[800]),
                  // Label color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.email_outlined), // Prefix icon
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.number, // Text color
                decoration: InputDecoration(
                  labelText: 'Phone',
                  labelStyle: TextStyle(color: Colors.green[800]),
                  // Label color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.phone), // Prefix icon
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number, // Text color
                decoration: InputDecoration(
                  labelText: 'Age',
                  labelStyle: TextStyle(color: Colors.green[800]),// Label color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black!),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.calendar_today), // Prefix icon
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: bioController,
                keyboardType: TextInputType.number, // Text color
                decoration: InputDecoration(
                  labelText: 'Bio',
                  labelStyle: TextStyle(color: Colors.green[800]),// Label color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black!),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.abc_outlined), // Prefix icon
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[400],
                ),
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
                child: Text('Update Info',style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
