import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/loading.dart';
import 'package:fund_raiser_second/screens/main_app_screens/home_dashboard.dart';
import '../../firebase_services/Image_services/pick_image.dart';
import '../../firebase_services/Image_services/upload_image_to_storage.dart';
import '../../firebase_services/user_services/add_user_details_service.dart';
import '../../firebase_services/user_services/update_user_info_services.dart';
import '../../utils/utils_toast.dart';

class TakeUserInfoScreen extends StatefulWidget {
  const TakeUserInfoScreen({super.key});

  @override
  State<TakeUserInfoScreen> createState() => _TakeUserInfoScreenState();
}

class _TakeUserInfoScreenState extends State<TakeUserInfoScreen> {
  final FirebaseService firebaseService = FirebaseService();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  String userEmail = getCurrentUserEmail();
  String userId = getCurrentUserId();
  String userPhone = getCurrentUserPhone();
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.verified_user),
        automaticallyImplyLeading: false,
        title: Text('User Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  _selectedImage == null
                      ? CircleAvatar(
                          maxRadius: 70,
                          backgroundImage:  AssetImage('assets/logo.png')
                  )
                      :  CircleAvatar(
                      maxRadius: 70,
                      backgroundImage:  FileImage(_selectedImage!),
                  ),
                  GestureDetector(
                    onTap: () async {
                      _selectedImage = await ImagePickerUtils.pickImage();
                      setState(() {});
                    },
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.0),
              Text("Update UI"),
              SizedBox(height: 16.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Name TextField
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    // Age TextField
                    TextFormField(
                      controller: ageController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Age';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    // Phone TextField
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        }else if(!value.contains('@')){
                          return 'Enter Valid Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: userEmail!=''?userEmail:'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),SizedBox(height: 16.0),

                    // Phone TextField
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Phone';
                        }else if(value.length<9){
                          return 'Enter Valid Phone';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: userPhone!=''?userPhone:'Phone',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: bioController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Bio';
                        }else if(value.length<20){
                          return 'Enter At least 20 characters !';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Bio',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
              // Button to display entered values
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    loading = true;
                    if (_selectedImage != null) {
                      await ImageUploadUtils.uploadImageToFirebaseStorage(
                          _selectedImage!, 'user_images');
                    } else {
                      _imageUrl='';
                      Utils().toastMessage('You have not selected profile photo!',color: Colors.amberAccent);
                    }
                    await firebaseService.updateUser(userId, {
                      'name': nameController.text.trim(),
                      'email': userEmail==''?emailController.text.trim():userEmail,
                      'phone': userPhone==''?phoneController.text.trim():userPhone,
                      'age': int.tryParse(ageController.text.trim()) ?? 0,
                      'bio': bioController.text.trim(),
                    });
                    Utils().toastMessage("Info Upadated", color: Colors.green);
                    // addUserDetails(
                    //     nameController.text.trim() != ""
                    //         ? nameController.text.trim()
                    //         : "User",
                    //     userEmail,
                    //     phoneController.text.trim() != ""
                    //         ? phoneController.text.trim()
                    //         : "Not Provided",
                    //     int.parse(ageController.text.trim()) != ""
                    //         ? int.parse(ageController.text.trim())
                    //         : 0,
                    //     bioController.text.trim() != ""
                    //         ? bioController.text.trim()
                    //         : "Not Provided");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeDashboard()));
                  }
                },
                child: Center(
                  child: loading
                      ? Loading(size: 15,color: Colors.black,)
                      : Text(
                          'Save My Data',
                          style: TextStyle(color: Colors.black),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
