import 'package:education_project/core/use_cases/use_case.dart';
import 'package:education_project/core/utils/typedef.dart';
import 'package:education_project/src/auth/domain/repository/auth_repository.dart';

class ForgotPasswordUseCase extends UseCaseWithParams<void, String> {
  const ForgotPasswordUseCase(this._repo);

  final AuthRepository _repo;

  @override
  // Calls the forgot password method on the AuthRepository with the provided
  // parameters.
  ResultFuture<void> call(String params) {
    return _repo.forgotPassword(params);
  }
}
