import 'package:chairty_platform/components/drawer/drawer_list_tile.dart';
import 'package:chairty_platform/screens/profile_screen.dart';
import 'package:chairty_platform/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(
        0xffE2F1F2,
      ),
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(
                0xff034956,
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage:
                        AssetImage('assets/images/avatar_placeholder.png'),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Belal Salem',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.varelaRound(
                        color: const Color(
                          0xffE2F1F2,
                        ),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          DrawerListTile(
            tileText: 'Profile',
            tileIcon: Icons.person_outline,
            onTileClicked: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => const ProfileScreen()));
            },
          ),
          DrawerListTile(
            tileText: 'History',
            tileIcon: Icons.history,
            onTileClicked: () {
                Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => const ProfileScreen()));
            },
          ),
          DrawerListTile(
            tileText: 'Settings',
            tileIcon: Icons.settings,
            onTileClicked: () {
                Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => const SettingsScreen()));
            },
          ),
        ],
      ),
    );
  }
}
