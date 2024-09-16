import 'package:education_project/core/common/app/providers/user_provider.dart';
import 'package:education_project/src/auth/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;

  UserProvider get userProvider => read<UserProvider>();

  LocalUserModel? get currentUser => userProvider.user;
}
