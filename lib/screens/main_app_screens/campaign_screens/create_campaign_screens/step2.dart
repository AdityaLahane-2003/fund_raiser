import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/loading.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';
import 'package:fund_raiser_second/providers/fundraiser_data_provider.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import 'package:provider/provider.dart';
import '../../../../components/button.dart';
import '../../../../firebase_services/Image_services/pick_image.dart';
import '../../../../firebase_services/Image_services/upload_image_to_storage.dart';
import '../../../../providers/permission_provider.dart';
import '../../../../utils/utils_toast.dart';

class Step2 extends StatefulWidget {
  final Function(String) onRelationSelected;
  final Function(String, String, String, String) onPersonalInfoEntered;
  final Function onPrevious;
  final Function onNext;

  const Step2({
    super.key,
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
bool loading = false;
  final TextEditingController photoUrlController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  String _imageUrl = '';
  late FundraiserDataProvider fundraiserDataProvider;
  bool isPhotoPermissionGranted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fundraiserDataProvider = Provider.of<FundraiserDataProvider>(context, listen: false);
    selectedRelation = fundraiserDataProvider.fundraiserData.relation;
    selectedGender = fundraiserDataProvider.fundraiserData.gender;
    checkPermission();
  }
  checkPermission() async{
    var permissionProvider = Provider.of<PermissionProvider>(context, listen: false);
    isPhotoPermissionGranted = await permissionProvider.requestPhotosPermission();
    if(!isPhotoPermissionGranted){
      Utils().toastMessage("Images Permission Denied !");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<FundraiserDataProvider>(
      builder: (BuildContext context, fundRaiserProvider, Widget? child) {
        WidgetsBinding.instance.addPostFrameCallback((_){
          ageController.text = fundRaiserProvider.fundraiserData.age;
          cityController.text = fundRaiserProvider.fundraiserData.city;
        });

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
                            ? fundRaiserProvider.isBeneficiaryPhotoUploaded?CircleAvatar(
                          minRadius: 30,
                          backgroundColor: Colors.white,
                          maxRadius: 50,
                          child:Image.network(fundRaiserProvider.fundraiserData.photoUrl),
                        ): CircleAvatar(
                          minRadius: 30,
                          backgroundColor: Colors.white,
                          maxRadius: 50,
                          child:Image.asset('assets/logo.png'),
                        )
                            : CircleAvatar(
                          minRadius: 30,
                          backgroundColor: Colors.white,
                          maxRadius: 50,
                          child:loading?const Loading(size: 20,color: Colors.black,):Image(image: FileImage(_selectedImage!),),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if(isPhotoPermissionGranted==false){
                              AppSettings.openAppSettings();
                              setState(() {
                                checkPermission();
                              });
                              Utils().toastMessage("Please grant permission to access photos !");
                              return;
                            }{
                              _selectedImage = await ImagePickerUtils.pickImage();
                              if (_selectedImage != null) {
                                setState(() {
                                  loading = true;
                                });
                                _imageUrl = await ImageUploadUtils
                                    .uploadImageToFirebaseStorage(_selectedImage!,
                                    'campaigns_beneficiaryImages');
                              } else {
                                Utils().toastMessage('Please pick an image first.');
                              }
                              setState(() {
                                _imageUrl!=''?fundRaiserProvider.updateBeneficiaryPhoto(true,_imageUrl):'';
                                loading = false;
                              });
                            }
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
                    child: Text("Benificiary Image"),
                  ),
                   Visibility(
                      visible: fundRaiserProvider.isBeneficiaryPhotoUploaded,
                     child: const Align(
                      alignment: Alignment.topCenter,
                      child: Text("Image uploaded successfully !"),
                                       ),
                   ),
                  const SizedBox(height: 16),
                  const Text(
                    'Select Relation*',
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.grey.shade800),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(20.0),
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 36.0,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      value: selectedRelation,
                      hint: const Text('Select Relation'),
                      items: relations.map((relation) {
                        return DropdownMenuItem<String>(
                          value: relation,
                          child: Center(
                            child: Text(
                              relation,
                              style: const TextStyle(
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
                  const SizedBox(height: 16),
                  const Text(
                    'Select Gender*',
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.grey.shade800),
                    ),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(20.0),
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 36.0,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      value: selectedGender,
                      hint: const Text('Select Gender'),
                      isExpanded: true,
                      items: genders.map((gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Center(
                            child: Text(
                              gender,
                              style: const TextStyle(
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
                  const SizedBox(height: 16),
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
                    onChanged: (value) {
                      fundRaiserProvider.updateAge(value);
                    },
                  ),
                  const SizedBox(height: 16),
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
                    onChanged: (value) {
                      fundRaiserProvider.updateCity(value);
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
                        color: greenColor,
                      ),
                      Button(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                                  fundRaiserProvider.updateFundraiserDataStep2(
                                      selectedRelation,
                                      selectedGender);
                            if (_imageUrl.isEmpty && fundRaiserProvider.isBeneficiaryPhotoUploaded==false) {
                              Utils().toastMessage('Please select an image');
                              return;
                            }
                            widget.onPersonalInfoEntered(
                              _imageUrl,
                              ageController.text,
                              genderController.text,
                              cityController.text,
                            );
                            widget.onNext();
                          }
                        },
                        title: 'Next',
                        color: secondColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
