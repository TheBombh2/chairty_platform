import 'dart:io';

import 'package:chairty_platform/components/medical_docs_field/document_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DocumentTile extends StatelessWidget {
  const DocumentTile({
    required this.name,
    required this.documentUrl,
    super.key,
  });
  final String name;
  final String documentUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) =>
                DocumentView(documentName: name, documentUrl: documentUrl)));
      },
      leading: Container(
        decoration: BoxDecoration(
          color: Colors.green.shade300,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.image,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        name,
        style: GoogleFonts.varelaRound(fontSize: 18),
      ),
      trailing: const Icon(Icons.remove_red_eye_outlined),
    );
  }
}
