import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  File? _selectedImage;
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage == null
                ?Image(image: AssetImage('assets/logo.png'),height: 200.0)
                : Image.file(_selectedImage!),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _pickImage();
              },
              child: Text('Pick Image'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_selectedImage != null) {
                  _uploadImageToFirebaseStorage();
                  Navigator.pop(context);
                } else {
                  print('Please pick an image first.');
                }
              },
              child: Text('Use This Photo'),
            ),
            SizedBox(height: 16.0),
            _imageUrl != null
                ? Image.network(
              _imageUrl!,
              height: 200.0,
            )
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _selectedImage = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImageToFirebaseStorage() async {
    final String uid = Uuid().v4();
    final Reference storageReference = FirebaseStorage.instance.ref().child('user_images/$uid.jpg');
    final UploadTask uploadTask = storageReference.putFile(_selectedImage!);

    await uploadTask.whenComplete(() async {
      Utils().toastMessage('Image Updated Successfully !', color: Colors.green);
      _imageUrl = await storageReference.getDownloadURL();
      _storeImageUrlInFirestore();
    });
  }

  Future<void> _storeImageUrlInFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Store the image URL in Firestore for the current user
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      await users.doc(user.uid).update({
        'imageUrl': _imageUrl,
        // Add other user data as needed
      });

      setState(() {
        print('Image URL stored in Firestore for the current user');
      });
    } else {
      Utils().toastMessage('User Not Authenticated', color: Colors.red);
    }
  }
}