import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePopupMenuItem extends StatelessWidget {
  const ProfilePopupMenuItem(
      {required this.itemTitle, required this.iconData, super.key});

  final String itemTitle;
  final Widget iconData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: iconData,
      title: Text(
        itemTitle,
        style: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
