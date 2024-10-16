import 'package:chairty_platform/Firebase/auth_interface.dart';
import 'package:chairty_platform/components/drawer/drawer_list_tile.dart';
import 'package:chairty_platform/cubits/messages/messages_cubit.dart';
import 'package:chairty_platform/models/user.dart';
import 'package:chairty_platform/screens/profile_screen.dart';
import 'package:chairty_platform/screens/request_history_screen.dart';
import 'package:chairty_platform/screens/users_list_screen.dart';
import 'package:chairty_platform/screens/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerMenu extends StatelessWidget {
  final bool showHistory;
  const DrawerMenu({
    this.showHistory = true,
    super.key,
  });

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
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(
                        AuthInterface.getCurrentCharityUser().imageUrl),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${AuthInterface.getCurrentCharityUser().firstName} ${AuthInterface.getCurrentCharityUser().lastName}',
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => ProfileScreen(
                        viewOnly: false,
                        user: AuthInterface.getCurrentCharityUser(),
                      )));
            },
          ),
          if (showHistory)
            DrawerListTile(
              tileText: 'History',
              tileIcon: Icons.history,
              onTileClicked: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const RequestHistoryScreen()));
              },
            ),
         /* DrawerListTile(
            tileText: 'Settings',
            tileIcon: Icons.settings,
            onTileClicked: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const SettingsScreen()));
            },
          ),
          */
          DrawerListTile(
            tileText: (AuthInterface.getCurrentCharityUser().userType ==
                    UserType.donator)
                ? 'Patients'
                : 'Donaters',
            tileIcon: Icons.people,
            onTileClicked: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => UsersListScreen()));
            },
          ),
          AuthInterface.getCurrentCharityUser().userType == UserType.patient
              ? DrawerListTile(
                  tileText: 'Wallet',
                  tileIcon: Icons.wallet,
                  onTileClicked: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const WalletScreen(),
                      ),
                    );
                  })
              : const SizedBox.shrink(),
          DrawerListTile(
              tileText: 'Log out',
              tileIcon: Icons.logout,
              onTileClicked: () async {
                final messagesCubit = context.read<MessagesCubit>();
                if (MessagesCubit.messageStream != null) {
                  await MessagesCubit.messageStream!.cancel();
                  MessagesCubit.messageStream = null;
                }
                messagesCubit.clearState();
                await AuthInterface.firebaseInstance.signOut();
              }),
        ],
      ),
    );
  }
}
