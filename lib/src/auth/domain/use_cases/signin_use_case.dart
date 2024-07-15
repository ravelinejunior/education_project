import 'package:education_project/core/use_cases/use_case.dart';
import 'package:education_project/core/utils/typedef.dart';
import 'package:education_project/src/auth/domain/entity/local_user.dart';
import 'package:education_project/src/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SigninUseCase extends UseCaseWithParams<LocalUser, SignInParams> {
  SigninUseCase(this._repo);
  final AuthRepository _repo;
  @override
  // Perform a sign-in operation with the provided email and password parameters
  // and return a future result containing a LocalUser.
  ResultFuture<LocalUser> call(SignInParams params) =>
      _repo.signIn(email: params.email, password: params.password);
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });
  factory SignInParams.empty() => const SignInParams(email: '', password: '');
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
