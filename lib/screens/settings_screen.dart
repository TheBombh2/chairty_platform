import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.varelaRound(
            color: const Color(
              0xffE2F1F2,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff034956),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Change language'),
            trailing: Text(
              'EN',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
