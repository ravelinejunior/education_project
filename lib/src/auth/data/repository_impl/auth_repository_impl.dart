import 'package:dartz/dartz.dart';
import 'package:education_project/core/enum/update_user_enum.dart';
import 'package:education_project/core/errors/exceptions.dart';
import 'package:education_project/core/errors/failures.dart';
import 'package:education_project/core/utils/typedef.dart';
import 'package:education_project/src/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:education_project/src/auth/domain/entity/local_user.dart';
import 'package:education_project/src/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);
  final AuthRemoteDataSource _remoteDataSource;
  @override
  // Function to initiate the password recovery process for the provided email.
  ResultFuture<void> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  // Sign in with the provided email and password, returning a Future that will
  // resolve to a LocalUser.
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final signedUser = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );
      return Right(signedUser);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  // Sign out the current user. Returns a ResultFuture<void> that resolves to
  // null on success.
  ResultFuture<void> signOut() async {
    try {
      await _remoteDataSource.signOut();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  // Initiates the sign-up process with the provided email, password,
  // and full name.
  // Returns a ResultFuture<LocalUser> that resolves to the signed-up user
  // on success.
  ResultFuture<LocalUser> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final signupUser = await _remoteDataSource.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );
      return Right(signupUser);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  // Updates user information based on the provided action and user data.
  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      await _remoteDataSource.updateUser(
        action: action,
        userData: userData,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }
}
