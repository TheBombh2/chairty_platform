import 'dart:io';

import 'package:chairty_platform/components/medical_docs_field/document_preview.dart';
import 'package:chairty_platform/models/document.dart';
import 'package:flutter/material.dart';
import 'package:chairty_platform/components/style.dart';
import 'package:image_picker/image_picker.dart';

class MedicalDocsField extends StatefulWidget {
  MedicalDocsField({super.key});

  @override
  State<MedicalDocsField> createState() => _MedicalDocsFieldState();
  final List<Document> uploadedDocuments = [];
}

class _MedicalDocsFieldState extends State<MedicalDocsField> {
  @override
  Widget build(BuildContext context) {
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
      String? docName;
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Name for document'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  docName = value;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'))
            ],
          ),
        ),
      );
      if (docName == null || docName!.isEmpty) {
        return;
      }
      setState(() {
        widget.uploadedDocuments.add(
          Document(
            documentName: docName!,
            documentPath: File(
              pickedImage.path,
            ),
          ),
        );
      });
    }

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: darkColor,
            width: 2,
          )),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.feed_outlined),
            title: const Text('Medical Reports',
                style: TextStyle(fontWeight: FontWeight.bold)),
            iconColor: deepOrange,
            trailing: IconButton(
              onPressed: disablePickImage ? null : _pickImage,
              icon: const Icon(
                Icons.add_a_photo,
              ),
            ),
          ),
          if (widget.uploadedDocuments.isNotEmpty) ...[
            Divider(
              thickness: 2,
              color: darkColor,
            ),
            ...widget.uploadedDocuments.map(
              (ele) => DocumentPreview(
                docName: ele.documentName,
                docFile: ele.documentPath,
                onRemoveDocument: () {
                  setState(() {
                    widget.uploadedDocuments.remove(ele);
                  });
                },
              ),
            ),
          ]
        ],
      ),
    );
  }
}
