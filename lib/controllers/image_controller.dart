import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageController extends ChangeNotifier {
  List<File>? _imageList = [];
  List<File>? get imageList => _imageList;

  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  uploadImage(ImageSource source) async {
    XFile? _pickedFile = await ImagePicker().pickImage(source: source);
    if (_pickedFile != null) {
      _selectedImage = File(_pickedFile.path);
      notifyListeners();
    }
  }

  removeUploadPhoto() {
    _selectedImage = null;
    notifyListeners();
  }

  Future<File> convertToPNG(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final directory = await getApplicationDocumentsDirectory();
    final fileLength = await imageFile.length();
    final codec = await ui.instantiateImageCodec(bytes, targetWidth: fileLength, targetHeight: fileLength);
    final frameInfo = await codec.getNextFrame();
    final pngBytes = await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    final file = await File('${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png').create();
    await file.writeAsBytes(pngBytes!.buffer.asUint8List());
    return file;
  }
}
