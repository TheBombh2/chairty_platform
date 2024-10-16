import 'package:chairty_platform/components/request_details_view/document_tile.dart';
import 'package:chairty_platform/models/document.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DocumentsListSection extends StatelessWidget {
  const DocumentsListSection({
    required this.documents,
    super.key,
  });
  final List<Document> documents;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Documents',
            style: GoogleFonts.varelaRound(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          for (final item in documents)
            DocumentTile(
              name: item.documentName,
              documentUrl: item.documentPath.path,
            ),
        ],
      ),
    );
  }
}
