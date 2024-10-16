import 'package:chairty_platform/components/request_history_list/request_history_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class RequestHistoryScreen extends StatelessWidget {
  const RequestHistoryScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor:const Color(0xffE2F1F2),
        title: Text(
          "Requests History",
          style: GoogleFonts.varelaRound(),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff034956),
        
      ),
      backgroundColor: const Color(0xFFF6FAF7),
      body: const RequestHistoryList(),
    );
  }
}
