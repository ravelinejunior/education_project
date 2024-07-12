import 'package:education_project/core/enum/update_user_enum.dart';
import 'package:education_project/core/utils/typedef.dart';
import 'package:education_project/src/auth/domain/entity/local_user.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultFuture<LocalUser> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  });

  ResultFuture<void> signOut();

  ResultFuture<void> forgotPassword(String email);
}
