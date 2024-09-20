import 'package:chairty_platform/components/drawer_menu.dart';
import 'package:chairty_platform/components/requests_list/request_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DonatorHomePage extends StatelessWidget {
  const DonatorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Find people to help",
          style: GoogleFonts.varelaRound(
            color: const Color(
              0xffE2F1F2,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff034956),
        leading: Builder(builder: (ctx) {
          return IconButton(
            onPressed: () {
              Scaffold.of(ctx).openDrawer();
            },
            icon: const Icon(
              Icons.menu_rounded,
              size: 40,
              color: Color(
                0xffE2F1F2,
              ),
            ),
          );
        }),
      ),
      backgroundColor: const Color(0xFFF6FAF7),
      drawer: DrawerMenu(),
      body: RequestList(),
    );
  }
}
