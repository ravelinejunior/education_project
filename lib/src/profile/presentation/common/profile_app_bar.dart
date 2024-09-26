import 'dart:async';

import 'package:education_project/core/common/widgets/custom_alert_dialog.dart';
import 'package:education_project/core/utils/core_utils.dart';
import 'package:education_project/src/profile/presentation/common/profile_popup_menu_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Profile'),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      actions: [
        PopupMenuButton<void>(
          clipBehavior: Clip.antiAlias,
          offset: const Offset(0, 36),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(24),
            ),
          ),
          itemBuilder: (context) => [
            PopupMenuItem<void>(
              child: ProfilePopupMenuItem(
                itemTitle: 'Edit Profile',
                iconData: Icon(
                  Icons.edit_outlined,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              onTap: () => CoreUtils.showSnackBar(context, 'Edit Profile'),
            ),
            const PopupMenuDivider(),
            PopupMenuItem<void>(
              child: ProfilePopupMenuItem(
                itemTitle: 'Notification',
                iconData: Icon(
                  IconlyBold.notification,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              onTap: () => CoreUtils.showSnackBar(context, 'Notification'),
            ),
            const PopupMenuDivider(),
            PopupMenuItem<void>(
              child: ProfilePopupMenuItem(
                itemTitle: 'Help',
                iconData: Icon(
                  Icons.help_outline_outlined,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              onTap: () => CoreUtils.showSnackBar(context, 'Help'),
            ),
            const PopupMenuDivider(),
            PopupMenuItem<void>(
              child: ProfilePopupMenuItem(
                itemTitle: 'Logout',
                iconData: Icon(
                  Icons.logout_outlined,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              onTap: () {
                final navigator = Navigator.of(context);
                showCustomDialog(
                  context,
                  title: 'Logout',
                  content: 'Are you sure you want to leave?',
                  positiveButtonText: 'Confirm',
                  negativeButtonText: 'Cancel',
                  onPositivePressed: () async {
                    await FirebaseAuth.instance.signOut();
                    unawaited(
                      navigator.pushNamedAndRemoveUntil(
                        '/login',
                        (route) => false,
                      ),
                    );
                  },
                  onNegativePressed: navigator.pop,
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
