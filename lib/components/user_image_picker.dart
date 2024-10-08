import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    required this.onPickImage,
    super.key,
  });
  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;
  bool disablePickImage = false;

  void _pickImage() async {
    bool? useCamera;

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Choose an image soruce.'),
        content: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  useCamera = true;
                  Navigator.of(context).pop();
                },
                child: const Text('Camera'),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  useCamera = false;
                  Navigator.of(context).pop();
                },
                child: const Text('Gallery'),
              ),
            ),
          ],
        ),
      ),
    );

    if (useCamera == null) {
      return;
    }
    setState(() {
      disablePickImage = true;
    });

    final pickedImage = await ImagePicker().pickImage(
      source: useCamera! ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      disablePickImage = false;
    });
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey,
            foregroundImage:
                _pickedImageFile != null ? FileImage(_pickedImageFile!) : null),
        TextButton.icon(
          onPressed: disablePickImage ? null : _pickImage,
          icon: const Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
