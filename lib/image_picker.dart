import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mmreactiveform/controllers/image_controller.dart';
import 'package:provider/provider.dart';

class ImagePickingWidget extends StatelessWidget {
  final String? imageName;
  const ImagePickingWidget({Key? key, this.imageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 32,
        ),
        Center(
          child: Consumer<ImagePickerController>(
            builder: (context, imagePickerController, _) => GestureDetector(
                onTap: () {
                  _showPicker(context, imagePickerController);
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: const Color(0xffFDCF09),
                  child: (imagePickerController.xFileImage != null)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            File(imagePickerController.xFileImage!.path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ))
                      : (imageName != "null" && imageName != "")
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                  File(
                                      '${imagePickerController.getDirectoryPath!}/$imageName'),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fill),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)),
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              ),
                            ),
                )),
          ),
        )
      ],
    );
  }

  void _showPicker(context, ImagePickerController controller) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      controller.imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    controller.imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
