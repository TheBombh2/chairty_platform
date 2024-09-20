import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.tileText,
    required this.tileIcon,
    required this.onTileClicked,
  });
  final IconData tileIcon;
  final String tileText;
  final void Function() onTileClicked;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      color: const Color(0xff034956),
      child: ListTile(
        onTap: onTileClicked,
        title: Text(
          tileText,
          style: GoogleFonts.varelaRound(
            color: const Color(
              0xffE2F1F2,
            ),
            fontSize: 20,
          ),
        ),
        trailing: Icon(
          tileIcon,
          size: 40,
          color: const Color(0xffE2F1F2),
        ),
      ),
    );
  }
}
