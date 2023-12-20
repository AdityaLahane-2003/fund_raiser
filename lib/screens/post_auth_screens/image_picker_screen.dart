// import 'dart:io';
//
// import 'package:flutter/material.dart';
//
// import '../../firebase_services/Image_services/pick_image.dart';
// import '../../firebase_services/Image_services/upload_image_to_storage.dart';
//
// class ImagePickerPage extends StatefulWidget {
//   @override
//   _ImagePickerPageState createState() => _ImagePickerPageState();
// }
//
// class _ImagePickerPageState extends State<ImagePickerPage> {
//   File? _selectedImage;
//   String? _imageUrl;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Picker'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _selectedImage == null
//                 ? Image(image: AssetImage('assets/logo.png'), height: 100.0, width: 100)
//                 : Image.file(_selectedImage!, height: 100.0, width: 100),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () async {
//                 _selectedImage = await ImagePickerUtils.pickImage();
//                 setState(() {});
//               },
//               child: Text('Pick Image'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () async {
//                 if (_selectedImage != null) {
//                   await ImageUploadUtils.uploadImageToFirebaseStorage(
//                       _selectedImage!, 'user_images');
//                   Navigator.pop(context);
//                 } else {
//                   print('Please pick an image first.');
//                 }
//               },
//               child: Text('Use This Photo'),
//             ),
//             SizedBox(height: 16.0),
//             _imageUrl != null
//                 ? Image.network(
//               _imageUrl!,
//               height: 200.0,
//             )
//                 : Container(),
//           ],
//         ),
//       ),
//     );
//   }
// }
