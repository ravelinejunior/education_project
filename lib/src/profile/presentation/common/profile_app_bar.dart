import 'package:education_project/core/utils/core_utils.dart';
import 'package:education_project/src/profile/presentation/common/profile_popup_menu_item.dart';
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
        PopupMenuButton(
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
            PopupMenuItem<void>(
              child: ProfilePopupMenuItem(
                itemTitle: 'Logout',
                iconData: Icon(
                  Icons.logout_outlined,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              onTap: () => CoreUtils.showSnackBar(context, 'Logout'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
