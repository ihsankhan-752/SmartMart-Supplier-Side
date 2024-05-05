import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends ChangeNotifier {
  List<File>? _imageList = [];
  List<File>? get imageList => _imageList;

  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  uploadImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: 50,
    );
    _selectedImage = File(pickedFile!.path);
    notifyListeners();
  }

  deleteUploadPhoto() {
    _selectedImage = null;
    notifyListeners();
  }
}
