import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';
import '../../../../components/button.dart';
import '../../../../firebase_services/Image_services/pick_image.dart';
import '../../../../firebase_services/Image_services/upload_image_to_storage.dart';
import '../../../../utils/utils_toast.dart';

class Step4 extends StatefulWidget {
  final Function(String, String,String) onCoverPhotoStoryEntered;
  final Function onRaiseFundPressed;
  final Function onPrevious;

  const Step4({super.key,
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

  bool loading = false;
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
              Align(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    _selectedImage == null
                        ? const CircleAvatar(
                      backgroundColor: Colors.white,
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
                      child: const Icon(
                        Icons.add_a_photo,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Text("Cover Image"),
              ),
              const SizedBox(height: 16),
              TextFormFieldArea(
                prefixIcon: Icons.title,
                controller: titleController,
                  title: 'Title(Help Hari complete his education)',
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: storyController,
                maxLines: 3,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  labelText: 'Write Story Here ...',
                  floatingLabelStyle: const TextStyle(color: Colors.green),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a story';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(
                    onTap: () {
                      widget.onPrevious();
                    },
                    title: 'Previous',
                    color: Colors.blue.shade700,
                  ),
                 Button(
                   loading: loading,
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        setState(() {
                          loading = true;
                        });
                        widget.onCoverPhotoStoryEntered(_imageUrl, storyController.text,titleController.text);
                        widget.onRaiseFundPressed();
                      }
                    },
                    title: 'Raise Fund',
                   color: Colors.green.shade700,
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
