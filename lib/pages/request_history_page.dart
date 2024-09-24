import 'package:chairty_platform/components/request_history_list/request_history_item.dart';
import 'package:chairty_platform/components/request_history_list/request_history_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/drawer/drawer_menu.dart';

class RequestHistoryPage extends StatelessWidget {
  const RequestHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Request History",
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
      drawer: const DrawerMenu(),
      body: RequestHistoryList(),);
  }
}
