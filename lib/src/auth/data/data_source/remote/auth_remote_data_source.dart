import 'package:education_project/core/enum/update_user_enum.dart';
import 'package:education_project/src/auth/data/model/user_model.dart';
import 'package:education_project/src/auth/domain/entity/local_user.dart';

abstract class AuthRemoteDataSource {
  Future<void> forgotPassword(String email);

  Future<LocalUser> signIn({required String email, required String password});

  Future<void> signOut();

  Future<LocalUserModel> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}
