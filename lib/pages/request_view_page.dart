import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestViewPage extends StatelessWidget {
  const RequestViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Donate to Belal Salem",
          style: GoogleFonts.varelaRound(
            color: const Color(
              0xffE2F1F2,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff034956),
      ),
    );
  }
}
