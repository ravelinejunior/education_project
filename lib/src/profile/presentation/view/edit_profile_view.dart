import 'dart:convert';
import 'dart:io';

import 'package:education_project/core/common/widgets/custom_alert_dialog.dart';
import 'package:education_project/core/enum/update_user_enum.dart';
import 'package:education_project/core/extensions/context_extensions.dart';
import 'package:education_project/core/res/icons.dart';
import 'package:education_project/core/utils/core_utils.dart';
import 'package:education_project/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:education_project/src/profile/presentation/view/commons/edit_profile_form.dart';
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

  bool get didSomethingChange =>
      nameChanged ||
      emailChanged ||
      passwordChanged ||
      bioChanged ||
      imageChanged;

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
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async {
            if (!didSomethingChange) {
              await showCustomDialog(
                context,
                title: 'Leave Editing Profile',
                content:
                    'Are You Sure You Wanna Leave Without Saving Your Changes?',
                positiveButtonText: 'Confirm',
                negativeButtonText: 'Cancel',
                onPositivePressed: () {
                  Navigator.of(context).pop();
                  context.pop();
                },
                onNegativePressed: () {
                  Navigator.of(context).pop();
                },
              );
            }

            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Edit Profile'),
              centerTitle: true,
              actions: [
                TextButton(
                  onPressed: () {
                    if (nothingChanged) {
                      context.pop();
                    }
                    final bloc = context.read<AuthBloc>();
                    if (nameChanged) {
                      bloc.add(
                        UpdateUserEvent(
                          action: UpdateUserAction.displayName,
                          userData: fullNameController.text.trim(),
                        ),
                      );
                    }
                    if (emailChanged) {
                      bloc.add(
                        UpdateUserEvent(
                          action: UpdateUserAction.email,
                          userData: emailController.text.trim(),
                        ),
                      );
                    }
                    if (passwordChanged) {
                      if (oldPasswordController.text.isEmpty) {
                        CoreUtils.showSnackBar(
                          context,
                          'Please enter your old password',
                        );
                        return;
                      }

                      bloc.add(
                        UpdateUserEvent(
                          action: UpdateUserAction.password,
                          userData: jsonEncode({
                            'oldPassword': oldPasswordController.text.trim(),
                            'newPassword': passwordController.text.trim(),
                          }),
                        ),
                      );
                    }
                    if (bioChanged) {
                      bloc.add(
                        UpdateUserEvent(
                          action: UpdateUserAction.bio,
                          userData: bioController.text.trim(),
                        ),
                      );
                    }
                    if (imageChanged) {
                      bloc.add(
                        UpdateUserEvent(
                          action: UpdateUserAction.profileImage,
                          userData: pickedImage,
                        ),
                      );
                    }
                  },
                  child: state is AuthLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : StatefulBuilder(
                          builder: (_, refreshState) {
                            fullNameController.addListener(() => refreshState);
                            emailController.addListener(() => refreshState);
                            bioController.addListener(() => refreshState);
                            passwordController.addListener(() => refreshState);
                            return Text(
                              'Done',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: nothingChanged
                                    ? Colors.grey
                                    : Colors.blueAccent,
                                fontSize: 16,
                              ),
                            );
                          },
                        ),
                ),
              ],
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
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                Builder(
                  builder: (context) {
                    final user = context.currentUser!;
                    final userImage = user.profileImageUrl == null ||
                            user.profileImageUrl!.isEmpty
                        ? null
                        : user.profileImageUrl;

                    return CircleAvatar(
                      radius: 90,
                      backgroundColor: Colors.transparent,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.onSurface,
                                width: 2,
                              ),
                            ),
                          ),
                          ClipOval(
                            child: pickedImage != null
                                ? Image.file(
                                    pickedImage!,
                                    width: 180,
                                    height: 180,
                                    fit: BoxFit.fill,
                                  )
                                : userImage != null
                                    ? Image.network(
                                        userImage,
                                        width: 180,
                                        height: 180,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        MediaRes.homeIcon,
                                        width: 180,
                                        height: 180,
                                        fit: BoxFit.cover,
                                      ),
                          ),
                          IconButton(
                            onPressed: pickImageFromGallery,
                            icon: Icon(
                              (pickedImage != null ||
                                      user.profileImageUrl != null)
                                  ? Icons.edit
                                  : Icons.add_a_photo_outlined,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    '*We recommend an image of at least 400x400 px',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                EditProfileForm(
                  nameController: fullNameController,
                  emailController: emailController,
                  passwordController: passwordController,
                  oldPasswordController: oldPasswordController,
                  bioController: bioController,
                )
              ],
            ),
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
