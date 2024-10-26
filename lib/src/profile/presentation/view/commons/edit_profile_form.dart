import 'package:education_project/core/extensions/context_extensions.dart';
import 'package:education_project/core/extensions/string_extensions.dart';
import 'package:education_project/src/profile/presentation/view/commons/edit_profile_form_text_field.dart';
import 'package:flutter/material.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.oldPasswordController,
    required this.bioController,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController oldPasswordController;
  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    final user = context.currentUser;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditProfileFormTextField(
          fieldText: 'NAME',
          label: user?.fullName ?? 'NAME',
          controller: nameController,
          hintText: 'NAME',
          prefixIcon: const Icon(Icons.person_4),
        ),
        EditProfileFormTextField(
          fieldText: 'EMAIL',
          label: user?.email.obscureEmailText ?? 'EMAIL',
          controller: emailController,
          hintText: 'EMAIL',
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        EditProfileFormTextField(
          fieldText: 'CURRENT PASSWORD',
          label: 'CURRENT PASSWORD',
          controller: oldPasswordController,
          hintText: '***********',
          prefixIcon: const Icon(Icons.lock_outline_rounded),
        ),
        StatefulBuilder(
          builder: (_, setState) {
            oldPasswordController.addListener(
              () {
                setState(
                  () {},
                );
              },
            );
            return EditProfileFormTextField(
              fieldText: 'NEW PASSWORD',
              label: 'NEW PASSWORD',
              controller: passwordController,
              hintText: '***********',
              readOnly: oldPasswordController.text.isEmpty,
              prefixIcon: const Icon(Icons.lock_outline_rounded),
            );
          },
        ),
        EditProfileFormTextField(
          fieldText: 'BIO',
          controller: bioController,
          hintText: 'BIO',
          minHeight: 8,
          maxLines: 10,
          prefixIcon: const Icon(Icons.info_outline_rounded),
        ),
      ],
    );
  }
}
