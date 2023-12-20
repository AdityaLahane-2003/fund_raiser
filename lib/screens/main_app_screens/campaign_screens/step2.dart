import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/loading.dart';

import '../../../firebase_services/Image_services/pick_image.dart';
import '../../../firebase_services/Image_services/upload_image_to_storage.dart';
import '../../../utils/utils_toast.dart';

class Step2 extends StatefulWidget {
  final Function(String) onRelationSelected;
  final Function(String, String, String, String) onPersonalInfoEntered;
  final Function onPrevious;
  final Function onNext;

  Step2({
    required this.onRelationSelected,
    required this.onPersonalInfoEntered,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  final List<String> relations = ['Myself', 'My Family', 'My Friend', 'Other'];
  final List<String> genders = ['Male', 'Female', 'Prefer Not to tell', 'Other'];

  late String selectedRelation = 'Myself';
  late String selectedGender = 'Male';

  final TextEditingController photoUrlController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController genderController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

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
              DropdownButton<String>(
                value: selectedRelation,
                hint: Text('Select Relation'),
                items: relations.map((relation) {
                  return DropdownMenuItem<String>(
                    value: relation,
                    child: Text(relation),
                  );
                }).toList(),
                onChanged: (value) {
                  widget.onRelationSelected(value!);
                  selectedRelation = value;
                  setState(() {});
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
                              _selectedImage!, 'campaigns_user');
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
              child: Text("Benificiary Image"),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButton<String>(
                value: selectedGender,
                hint: Text('Select Gender'),
                items: genders.map((gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedGender = value!;
                  setState(() {
                    genderController.text = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city';
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
                        widget.onPersonalInfoEntered(
                          _imageUrl==''?'notProvided' : _imageUrl,
                          ageController.text,
                          genderController.text,
                          cityController.text,
                        );
                        widget.onNext();
                      }
                    },
                    child: Text('Next'),
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
