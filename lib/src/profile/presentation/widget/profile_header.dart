import 'dart:math';

import 'package:education_project/core/common/app/providers/user_provider.dart';
import 'package:education_project/core/extensions/context_extensions.dart';
import 'package:education_project/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        final user = provider.user;
        final image =
            user?.profileImageUrl == null || user!.profileImageUrl!.isEmpty
                ? null
                : user.profileImageUrl;

        final randomImageIndex =
            Random().nextInt(kHeaderProfileImageDefault.length);
        return Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: image == null || image.isEmpty
                  ? NetworkImage(kHeaderProfileImageDefault[randomImageIndex])
                      as ImageProvider
                  : NetworkImage(image),
            ),
            const SizedBox(height: 16),
            Text(
              user?.fullName ?? 'No User',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              user?.email ?? 'No Email',
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            if (user?.bio != null && user!.bio!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.15,
                ),
                child: Text(
                  user.bio ?? '',
                  style: GoogleFonts.lato(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
