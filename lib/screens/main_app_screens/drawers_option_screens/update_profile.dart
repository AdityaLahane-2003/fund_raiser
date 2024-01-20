import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';

import '../../../components/button.dart';
import '../../../firebase_services/user_services/update_user_info_services.dart';
import '../../../utils/utils_toast.dart';
class UpdateUserInfoPage extends StatefulWidget {
  final String userId;
  final String currentName;
  final String currentEmail;
  final String currentPhone;
  final String? currentAge;
  final String currentBio;

  const UpdateUserInfoPage({super.key,
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
bool loading = false;
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
        backgroundColor: greenColor,
        title: const Text('Update User Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                minRadius: 30,
                maxRadius: 65,
                child: Image.asset('assets/logo.png'),),
              const SizedBox(height: 15.0),
              TextFormFieldArea(
                controller: nameController,
                textInputType: TextInputType.text, // Text color
                title: 'Name',
                prefixIcon: Icons.person,
              ),const SizedBox(height: 12.0),
              TextFormFieldArea(
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                  title: 'Email',
                  prefixIcon: Icons.email_outlined
              ),
              const SizedBox(height: 12.0),
              TextFormFieldArea(
                controller: phoneController,
                textInputType: TextInputType.number,
                  title: 'Phone',
                  prefixIcon: Icons.phone,
              ),
              const SizedBox(height: 12.0),
              TextFormFieldArea(
                controller: ageController,
                textInputType: TextInputType.number,
                  title: 'Age',
                  prefixIcon:Icons.calendar_today,
              ),
              const SizedBox(height: 12.0),
              TextFormFieldArea(
                controller: bioController,
                textInputType: TextInputType.number,
                  title: 'Bio',
                  prefixIcon: Icons.abc_outlined,
              ),
              const SizedBox(height: 16.0),
              Button(
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  await firebaseService.updateUser(widget.userId, {
                    'name': nameController.text.trim(),
                    'email': emailController.text.trim(),
                    'phone': phoneController.text.trim(),
                    'age': int.tryParse(ageController.text.trim()) ?? 0,
                    'bio': bioController.text.trim(),
                  });

                  Utils().toastMessage("Info Upadated", color: greenColor);
                  Navigator.pop(context); // Pop this page to go back to UserInfoPage
                },
                title: 'Update Info',
                color: secondColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
