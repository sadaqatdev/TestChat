import 'dart:io';

import 'package:image_picker/image_picker.dart';

class CommonMethods {
  static Future<String?> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      return File(image.path).path;
    } else {
      return null;
    }
  }
  
  static Future<String?> pickVideo(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickVideo(source: source);
    if (image != null) {
      return File(image.path).path;
    } else {
      return null;
    }
  }
}
