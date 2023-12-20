import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  static Future<File?> pickImage() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);

    if (pickedImage != null) {
      return File(pickedImage.path);
    } else {
      print('No image selected.');
      return null;
    }
  }
}
