import 'dart:io';

import 'package:chairty_platform/components/medical_docs_field/document_preview.dart';
import 'package:chairty_platform/models/document.dart';
import 'package:flutter/material.dart';
import 'package:chairty_platform/components/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chairty_platform/components/style.dart';

class MedicalDocsField extends StatefulWidget {
  const MedicalDocsField({
    required this.uploadedDocuments,
    super.key,
  });

  @override
  State<MedicalDocsField> createState() => _MedicalDocsFieldState();
  final List<Document> uploadedDocuments;
}

class _MedicalDocsFieldState extends State<MedicalDocsField> {
  @override
  Widget build(BuildContext context) {
    bool disablePickImage = false;

    void pickImage() async {
      bool? useCamera;

      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Choose an image soruce.',
            style: GoogleFonts.varelaRound(fontSize: 16),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    useCamera = true;
                    Navigator.of(ctx).pop();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: lightColor),
                  child: Text(
                    'Camera',
                    style: GoogleFonts.varelaRound(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    useCamera = false;
                    Navigator.of(ctx).pop();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: lightColor),
                  child: Text(
                    'Gallery',
                    style: GoogleFonts.varelaRound(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
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
        imageQuality: 100,
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
          title: Text(
            'Enter a name for document',
            style: GoogleFonts.varelaRound(fontSize: 16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: darkColor,
                        width: 2,
                      )),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: deepOrange,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  docName = value;
                },
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: lightColor),
                child: Text(
                  'Add',
                  style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              )
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
              onPressed: disablePickImage ? null : pickImage,
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
