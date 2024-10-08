import 'package:education_project/core/use_cases/use_case.dart';
import 'package:education_project/core/utils/typedef.dart';
import 'package:education_project/src/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignupUseCase extends UseCaseWithParams<void, SignUpParams> {
  const SignupUseCase(this._repo);

  final AuthRepository _repo;

  @override
  ResultFuture<void> call(SignUpParams params) => _repo.signUp(
        email: params.email,
        password: params.password,
        fullName: params.fullName,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
  });

  factory SignUpParams.empty() {
    return const SignUpParams(
      email: '',
      password: '',
      fullName: '',
    );
  }

  final String email;
  final String password;
  final String fullName;

  @override
  List<Object> get props => [email, password, fullName];
}
