import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';
import 'package:fund_raiser_second/screens/main_app_screens/home_dashboard.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import '../../components/button.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    if(userEmail!=''){
    emailController = TextEditingController(text: userEmail);
    }
    if(userPhone!=''){
      phoneController = TextEditingController(text: userPhone);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.verified_user),
        automaticallyImplyLeading: false,
        title: const Text('User Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                          backgroundImage:  const AssetImage('assets/logo.png'),
                          backgroundColor: Colors.green.shade100,
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
                    child: const Icon(
                      Icons.add_a_photo,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Name TextField
                    TextFormFieldArea(
                      prefixIcon: Icons.person,
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Name';
                        }
                        return null;
                      },
                      title: 'Name',
                      textInputType: TextInputType.name,
                    ),
                    const SizedBox(height: 16.0),

                    // Age TextField
                    TextFormFieldArea(
                      prefixIcon: Icons.format_list_numbered,
                      controller: ageController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Age';
                        }
                        return null;
                      },
                      title: 'Age',
                      textInputType: TextInputType.number,
                    ),
                    const SizedBox(height: 16.0),
                    // Phone TextField
                    TextFormFieldArea(
                      prefixIcon: Icons.email,
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        }else if(!value.contains('@')){
                          return 'Enter Valid Email';
                        }
                        return null;
                      },
                      title:'Email',
                    ),
                    const SizedBox(height: 16.0),
                    // Phone TextField
                    TextFormFieldArea(
                      prefixIcon: Icons.phone,
                      controller: phoneController,
                      textInputType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Phone';
                        }else if(value.length<9){
                          return 'Enter Valid Phone';
                        }
                        return null;
                      },
                       title:'Phone',
                    ),
                    const SizedBox(height: 16.0),
                    TextFormFieldArea(
                      prefixIcon: Icons.info,
                      controller: bioController,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Bio';
                        }else if(value.length<20){
                          return 'Enter At least 20 characters !';
                        }
                        return null;
                      },
                        title: 'Bio',
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
              // Button to display entered values
             Button(
               loading: loading,
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    if (_selectedImage != null) {
                      _imageUrl = await ImageUploadUtils.uploadImageToFirebaseStorage(
                          _selectedImage!, 'users_profilePhoto');
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
                      'imageUrl': _imageUrl!=''?_imageUrl:'',
                    });
                    Utils().toastMessage("Info Upadated", color: Colors.green);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeDashboard()));
                  }
                },
                title: 'Save My Data',
                color: greenColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
