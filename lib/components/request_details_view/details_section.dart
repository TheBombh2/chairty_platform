import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsSection extends StatelessWidget {
  const DetailsSection(
      {required this.title,
      required this.body,
      required this.backgroundColor,
      super.key});
  final String title;
  final String body;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.varelaRound(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              body,
              textAlign: TextAlign.start,
              style: GoogleFonts.varelaRound(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
