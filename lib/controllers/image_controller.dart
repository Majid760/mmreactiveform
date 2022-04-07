import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerController extends ChangeNotifier {
  ImagePicker? _picker;
  String? directoryPath;
  XFile? image;
  ImagePickerController() {
    _picker = ImagePicker();
  }

  // getting image from camera
  void imgFromCamera() async {
    // Pick an image
    image = (await _picker?.pickImage(
        source: ImageSource.camera, maxWidth: 360, maxHeight: 860))!;
    _saveImageToLocalDirectory(image);
    notifyListeners();
  }

  XFile? get xFileImage => image;
  void setXFileImageToNull() {
    image = null;
    notifyListeners();
  }

  void imgFromGallery() async {
    image = (await _picker!.pickImage(
        source: ImageSource.gallery, maxWidth: 360, maxHeight: 860))!;
    _saveImageToLocalDirectory(image);
    notifyListeners();
  }

  void _saveImageToLocalDirectory(XFile? image) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = image!.name;
    await image.saveTo('${appDir.path}/$fileName');
  }

  void setDirectoryPath() async {
    final appDir = await getApplicationDocumentsDirectory();
    directoryPath = appDir.path;
    debugPrint('this is path');
    debugPrint(directoryPath);
    // notifyListeners();
  }

  String? get getDirectoryPath => directoryPath;
}
