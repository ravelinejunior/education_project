import 'package:education_project/src/auth/data/model/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  LocalUserModel? _user;

  LocalUserModel? get user => _user;

  void initUser(LocalUserModel? user) {
    if (_user != user) _user = user;
  }

  void setUser(LocalUserModel? user) {
    if (_user != user) {
      _user = user;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
