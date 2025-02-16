
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

// image_picker_service.dart
import 'dart:io';


class ImagePickerService with ChangeNotifier {
  File? _image;

  File? get image => _image;

  // Return the file or the file path when an image is picked
  Future<File?> pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        notifyListeners();
        return _image; // Return the File object
      } else {
        print('No image selected.');
        return null; // Return null if no image is selected
      }
    } catch (e) {
      print('Error picking image: $e');
      return null; // Return null if there's an error
    }
  }
}
