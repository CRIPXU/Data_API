import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerExample extends StatefulWidget {
  const ImagePickerExample({super.key});

  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  File? _imageFile;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: (){},
        child: Stack(
          children: <Widget>[
            ButtonBar(
              mainAxisSize: MainAxisSize.max,
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  iconSize: 35,
                  icon: const Icon(Icons.photo_camera),
                  onPressed: () async => _pickImageFromCamera(),
                  tooltip: 'Shoot picture',
                ),
                IconButton(
                  iconSize: 35,
                  icon: const Icon(Icons.photo),
                  onPressed: () async => _pickImageFromGallery(),
                  tooltip: 'Pick from gallery',
                ),
              ],
            ),
            if (this._imageFile == null)
              const Placeholder()
            else
              Image.file(this._imageFile!),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => this._imageFile = File(pickedFile.path)
      );
    pickedFile.readAsBytes().toString();
    }
  }
  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => this._imageFile = File(pickedFile.path)
      );
      pickedFile.readAsBytes().toString();
    }
  }
}

