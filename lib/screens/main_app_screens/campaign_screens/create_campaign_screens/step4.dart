import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';
import 'package:fund_raiser_second/providers/fundraiser_data_provider.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import 'package:provider/provider.dart';
import '../../../../components/button.dart';
import '../../../../components/loading.dart';
import '../../../../firebase_services/Image_services/pick_image.dart';
import '../../../../firebase_services/Image_services/upload_image_to_storage.dart';
import '../../../../utils/utils_toast.dart';

class Step4 extends StatefulWidget {
  final Function(String, String, String) onCoverPhotoStoryEntered;
  final Function onRaiseFundPressed;
  final Function onPrevious;

  const Step4({
    super.key,
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
  bool _loading = false;
  String _imageUrl = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Consumer<FundraiserDataProvider>(
            builder: (context, Provider, child) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                titleController.text = Provider.fundraiserData.title;
                storyController.text = Provider.fundraiserData.story;
              });
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        _selectedImage == null
                            ? CircleAvatar(
                                minRadius: 30,
                                backgroundColor: Colors.white,
                                maxRadius: 50,
                                child: Provider.isCoverPhotoUploaded
                                    ? Image.network(
                                        Provider.fundraiserData.coverPhoto)
                                    : Image.asset('assets/logo.png'),
                              )
                            : CircleAvatar(
                                minRadius: 30,
                                backgroundColor: Colors.white,
                                maxRadius: 50,
                                child: _loading
                                    ? Loading(
                                        size: 20,
                                        color: Colors.black,
                                      )
                                    : Image(
                                        image: FileImage(_selectedImage!),
                                      ),
                              ),
                        GestureDetector(
                          onTap: () async {
                            _selectedImage = await ImagePickerUtils.pickImage();
                            if (_selectedImage != null) {
                              setState(() {
                                _loading = true;
                              });
                              _imageUrl = await ImageUploadUtils
                                  .uploadImageToFirebaseStorage(
                                      _selectedImage!, 'campaigns_coverPhoto');
                            } else {
                              Utils()
                                  .toastMessage('Please pick an image first.');
                            }
                            setState(() {
                              _imageUrl != ''
                                  ? Provider.updateCoverPhoto(true, _imageUrl)
                                  : '';
                              _loading = false;
                            });
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
                  Visibility(
                    visible: Provider.isCoverPhotoUploaded,
                    child: const Align(
                      alignment: Alignment.topCenter,
                      child: Text("Image uploaded successfully !"),
                    ),
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
                    onChanged: (value) {
                      value != '' ? Provider.updateTitle(value) : '';
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
                      floatingLabelStyle: TextStyle(color: greenColor),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a story';
                      } else if (value.length < 20) {
                        return 'Please enter a story of atleast 50 characters';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      value != '' ? Provider.updateStory(value) : '';
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
                        onTap: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (_imageUrl.isEmpty &&
                                Provider.isCoverPhotoUploaded == false) {
                              Utils().toastMessage('Please select an image');
                              return;
                            }
                            setState(() {
                              loading = true;
                            });
                            await widget.onCoverPhotoStoryEntered(_imageUrl,
                                storyController.text, titleController.text);
                            widget.onRaiseFundPressed();
                          }
                        },
                        title: 'Raise Fund',
                        color: greenColor,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
