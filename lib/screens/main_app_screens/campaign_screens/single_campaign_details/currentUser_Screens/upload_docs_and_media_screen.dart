import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../firebase_services/Image_services/upload_image_to_storage.dart';
import '../../../../../utils/utils_toast.dart';

class UploadMediaScreen extends StatefulWidget {
  final String campaignId;
  const UploadMediaScreen({super.key,required this.campaignId});

  @override
  State<UploadMediaScreen> createState() => _UploadMediaScreenState();
}

class _UploadMediaScreenState extends State<UploadMediaScreen> {
  bool isSelectImageSelected = true;
  bool isSelectMediaSelected = true;
  bool isuploadingStarted=false;
  List<File>? _pickedImages;
  List<File>? _pickedVideos;

  Future<void> _pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? pickedImages = await _picker.pickMultiImage();
    if (pickedImages != null) {
      final List<File> files = pickedImages.map((image) => File(image.path)).toList();
      setState(() {
        _pickedImages = files;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          ToggleButtons(
            borderRadius: BorderRadius.circular(50),
            isSelected: [isSelectMediaSelected, !isSelectMediaSelected],
            onPressed: (index) {
              setState(() {
                isSelectMediaSelected = index == 0;
              });
            },
            selectedColor: Colors.white,
            fillColor: Colors.green[700],
            children: const [
              Text('   Select Media   '),
              Text('   Select Documents    '),
            ], // Adjust the color as needed
          ),
          isSelectMediaSelected
              ? Column(children: [
                  SizedBox(height: 20),
                  ToggleButtons(
                    borderRadius: BorderRadius.circular(50),
                    isSelected: [isSelectImageSelected, !isSelectImageSelected],
                    onPressed: (index) {
                      setState(() {
                        isSelectImageSelected = index == 0;
                      });
                    },
                    selectedColor: Colors.white,
                    fillColor: Colors.green[700],
                    children: const [
                      Text('   Select Images   '),
                      Text('   Select Videos    '),
                    ], // Adjust the color as needed
                  ),
                  isSelectImageSelected
                      ? Column(
                          children: [
                            SizedBox(height: 20),
                            Text("Upload Images"),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                GestureDetector(
                                  onTap: _pickImages,
                                  child: Container(
                                    height: 100, // Set the desired height
                                    color: Colors.blue,
                                    child: Center(
                                      child: Text(
                                        'Tap to Select Images',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                if (_pickedImages != null)
                                  SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                      itemCount: _pickedImages!.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Image.file(
                                            File(_pickedImages![index].path),
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                const SizedBox(height: 20),
                                isuploadingStarted?
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 4,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      'Uploading Images... Please Wait !!! ',
                                      style: TextStyle(color: Colors.green),
                                    )
                                  ],
                                ):
                                ElevatedButton(
                                  onPressed: () async{
                                    if(_pickedImages!=null){
                                      String? _imageUrl;
                                      setState(() {
                                        isuploadingStarted=true;
                                      });
                                      for(int i=0;i<_pickedImages!.length;i++){
                                        _imageUrl = await ImageUploadUtils.uploadImageToFirebaseStorage(_pickedImages![i], 'campaigns_mediaImages');
                                        CollectionReference campaigns = FirebaseFirestore.instance.collection('campaigns');
                                        await campaigns.doc(widget.campaignId).update({
                                          'mediaImageUrls': FieldValue.arrayUnion([_imageUrl]),
                                        });
                                        Utils().toastMessage('Uploaded Image ${i+1} Successfully ! ', color: Colors.green);
                                      }
                                    setState(() {
                                      _pickedImages = null;
                                    });
                                      Navigator.pop(context);
                                    }
                                    else{
                                      Utils().toastMessage('Please Select Images !', color: Colors.red);
                                    }
                                  },
                                  child: const Text('Upload Media'),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(height: 20),
                            Text("Upload Videos")],
                        )
                ])
              : Column(
                  children: [SizedBox(height: 20), Text("Upload Docs")],
                )
        ],
      ),
    );
  }
}
