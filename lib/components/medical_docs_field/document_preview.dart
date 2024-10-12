import 'dart:io';

import 'package:chairty_platform/components/medical_docs_field/document_view.dart';
import 'package:chairty_platform/components/style.dart';
import 'package:flutter/material.dart';

class DocumentPreview extends StatelessWidget {
  final File docFile;
  final String docName;
  const DocumentPreview({
    super.key,
    required this.docFile,
    required this.docName,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: deepOrange,
      leading: const Icon(
        Icons.image,
      ),
      title: Text(docName),
      trailing: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => DocumentView(
                  documentName:docName,
                  documentImage: docFile,
                ),
              ),
            );
          },
          icon: const Icon(Icons.remove_red_eye_outlined)),
    );
  }
}
