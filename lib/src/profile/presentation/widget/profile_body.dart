import 'package:education_project/core/common/app/providers/user_provider.dart';
import 'package:education_project/core/res/icons.dart';
import 'package:education_project/src/profile/presentation/widget/profile_body_item.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<UserProvider>(
        builder: (_, provider, __) {
          final user = provider.user!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ProfileBodyItem(
                      infoIcon: const Icon(IconlyLight.document, size: 28),
                      infoThemeColor: Theme.of(context).colorScheme.primary,
                      infoTitle: 'Courses',
                      infoValue: user.enrolledCourseIds.length.toString(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ProfileBodyItem(
                      infoIcon:  const Icon(IconlyBold.game, size: 28),
                      infoThemeColor: Theme.of(context).primaryColor,
                      infoTitle: 'Score',
                      infoValue: user.points.toString(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ProfileBodyItem(
                      infoIcon: const Icon(IconlyBold.user_3, size: 28),
                      infoThemeColor:
                          Theme.of(context).colorScheme.tertiary,
                      infoTitle: 'Followers',
                      infoValue: user.followers.length.toString(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ProfileBodyItem(
                      infoIcon: const Icon(IconlyBold.user_2, size: 28),
                      infoThemeColor: Colors.teal,
                      infoTitle: 'Following',
                      infoValue: user.following.length.toString(),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
