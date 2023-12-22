import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';
import '../../../components/button.dart';
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
  final List<String> genders = [
    'Male',
    'Female',
    'Prefer Not to tell',
    'Other'
  ];

  late String selectedRelation = 'Myself';
  late String selectedGender = 'Male';

  final TextEditingController photoUrlController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController genderController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  String _imageUrl = '';

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
                        ? CircleAvatar(
                            backgroundColor: Colors.white,
                            maxRadius: 50,
                            backgroundImage: AssetImage('assets/logo.png'))
                        : CircleAvatar(
                            maxRadius: 50,
                            backgroundImage: FileImage(_selectedImage!),
                          ),
                    GestureDetector(
                      onTap: () async {
                        _selectedImage = await ImagePickerUtils.pickImage();
                        if (_selectedImage != null) {
                          _imageUrl = await ImageUploadUtils
                              .uploadImageToFirebaseStorage(
                                  _selectedImage!, 'campaigns_user');
                        } else {
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
              Text(
                'Select Relation*',
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.grey.shade800),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(20.0),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36.0,
                  elevation: 16,
                  style: TextStyle(color: Colors.black),
                  value: selectedRelation,
                  hint: Text('Select Relation'),
                  items: relations.map((relation) {
                    return DropdownMenuItem<String>(
                      value: relation,
                      child: Center(
                        child: Text(
                          relation,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    widget.onRelationSelected(value!);
                    selectedRelation = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Select Gender*',
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.grey.shade800),
                ),
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(20.0),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36.0,
                  elevation: 16,
                  style: TextStyle(color: Colors.black),
                  value: selectedGender,
                  hint: Text('Select Gender'),
                  isExpanded: true,
                  items: genders.map((gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Center(
                        child: Text(
                          gender,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedGender = value!;
                    setState(() {
                      genderController.text = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
              TextFormFieldArea(
                controller: ageController,
                textInputType: TextInputType.number,
                title: 'Age',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
                prefixIcon: Icons.numbers,
              ),
              SizedBox(height: 16),
              TextFormFieldArea(
                prefixIcon: Icons.location_city,
                controller: cityController,
                textInputType: TextInputType.text,
                title: 'City Of Resident',
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
                  Button(
                    onTap: () {
                      widget.onPrevious();
                    },
                    title: 'Previous',
                    color: Colors.blue.shade700,
                  ),
                  Button(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        widget.onPersonalInfoEntered(
                          _imageUrl == '' ? 'https://www.thermaxglobal.com/wp-content/uploads/2020/05/image-not-found.jpg' : _imageUrl,
                          ageController.text,
                          genderController.text,
                          cityController.text,
                        );
                        widget.onNext();
                      }
                    },
                    title: 'Next',
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
