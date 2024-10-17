import 'dart:io';

import 'package:education_project/core/extensions/context_extensions.dart';
import 'package:education_project/core/utils/core_utils.dart';
import 'package:education_project/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:education_project/src/profile/presentation/widget/profile_body.dart';
import 'package:education_project/src/profile/presentation/widget/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final bioController = TextEditingController();

  File? pickedImage;

  bool get nameChanged =>
      fullNameController.text.trim() != context.currentUser!.fullName.trim();

  bool get emailChanged =>
      emailController.text.trim() != context.currentUser!.email.trim();

  bool get passwordChanged => passwordController.text.trim().isNotEmpty;

  bool get bioChanged =>
      bioController.text.trim() != (context.currentUser!.bio?.trim() ?? '');

  bool get imageChanged => pickedImage != null;

  bool get nothingChanged =>
      !nameChanged &&
      !emailChanged &&
      !passwordChanged &&
      !bioChanged &&
      !imageChanged;

  @override
  void initState() {
    super.initState();
    final user = context.currentUser!;
    emailController.text = user.email.trim();
    fullNameController.text = user.fullName.trim();
    bioController.text = user.bio?.trim() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          CoreUtils.showSnackBar(context, state.message);
        }
        if (state is AuthUserUpdate) {
          CoreUtils.showSnackBar(context, 'Profile Updated Successfully');
          context.pop();
        }
        if (state is AuthLoadingState) {
          CoreUtils.showSnackBar(context, 'Updating Profile...');
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
            centerTitle: true,
            leading: IconButton(
              tooltip: 'Back',
              icon: Theme.of(context).platform == TargetPlatform.android
                  ? const Icon(Icons.arrow_back)
                  : const Icon(
                      Icons.arrow_back_ios_new,
                    ),
              onPressed: () {
                try {
                  context.pop();
                } catch (e) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              const ProfileHeader(),
              const ProfileBody(),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      pickedImage = File(image.path);
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    oldPasswordController.dispose();
    bioController.dispose();
    super.dispose();
  }
}
