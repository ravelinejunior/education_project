import 'package:education_project/src/profile/presentation/widget/profile_app_bar.dart';
import 'package:education_project/src/profile/presentation/widget/profile_body.dart';
import 'package:education_project/src/profile/presentation/widget/profile_header.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const ProfileAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: const [
          ProfileHeader(),
          ProfileBody(),
        ],
      ),
    );
  }
}
