import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../firebase_services/Image_services/pick_image.dart';
import '../../../firebase_services/Image_services/upload_image_to_storage.dart';
import '../../../utils/utils_toast.dart';

class Step4 extends StatefulWidget {
  final Function(String, String,String) onCoverPhotoStoryEntered;
  final Function onRaiseFundPressed;
  final Function onPrevious;

  Step4({
    required this.onCoverPhotoStoryEntered,
    required this.onRaiseFundPressed,
    required this.onPrevious,
  });

  @override
  State<Step4> createState() => _Step4State();
}

class _Step4State extends State<Step4> {
  final TextEditingController coverPhotoController = TextEditingController();

  final TextEditingController storyController = TextEditingController();

  final TextEditingController titleController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  File? _selectedImage;

  String _imageUrl='';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title(Help Hari complete his education)',labelStyle: TextStyle(fontSize: 13)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Align(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    _selectedImage == null
                        ? CircleAvatar(
                        maxRadius: 50,
                        backgroundImage:  AssetImage('assets/logo.png')
                    )
                        :  CircleAvatar(
                      maxRadius: 50,
                      backgroundImage: FileImage(_selectedImage!),
                    ),
                    GestureDetector(
                      onTap: () async {
                        _selectedImage = await ImagePickerUtils.pickImage();
                        if (_selectedImage != null) {
                          _imageUrl = await ImageUploadUtils.uploadImageToFirebaseStorage(
                              _selectedImage!, 'campaigns_cover_photo');
                        }else{
                          Utils().toastMessage('Please pick an image first.');
                        }
                        setState(() {});
                      },
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text("Cover Image"),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: storyController,
                maxLines: 5,
                decoration: InputDecoration(labelText: 'Story'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a story';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      widget.onPrevious();
                    },
                    child: Text('Previous'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        widget.onCoverPhotoStoryEntered(_imageUrl, storyController.text,titleController.text);
                        widget.onRaiseFundPressed();
                      }
                    },
                    child: Text('Raise Fund'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
