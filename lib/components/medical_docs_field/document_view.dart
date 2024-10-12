import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

class DocumentView extends StatelessWidget {
  final File? documentImage;
  final String? documentUrl;
  final String documentName;
  const DocumentView({
    required this.documentName,
    this.documentImage,
    this.documentUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          documentName,
          style: GoogleFonts.varelaRound(
            color: const Color(
              0xffE2F1F2,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff034956),
      ),
      body: PhotoView(
          imageProvider: (documentImage != null)
              ? FileImage(documentImage!)
              : (documentUrl != null)
                  ? NetworkImage(documentUrl!)
                  : null),
    );
  }
}
