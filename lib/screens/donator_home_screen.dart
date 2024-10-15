import 'package:chairty_platform/Firebase/auth_interface.dart';
import 'package:chairty_platform/components/drawer/drawer_menu.dart';
import 'package:chairty_platform/components/requests_list/request_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubits/messages/messages_cubit.dart';
import 'inbox_screen.dart';

class DonatorHomeScreen extends StatelessWidget {
  const DonatorHomeScreen({super.key});

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
        actions: [
          IconButton(
              onPressed: () {
                final messagesCubit = context.read<MessagesCubit>();
                messagesCubit.getOtherUsers();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InboxScreen()));
              },
              icon: const Icon(
                Icons.inbox_rounded,
                size: 30,
                color: Colors.white,
              )),
        ],
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
      body: const RequestList(),
    );
  }
}
