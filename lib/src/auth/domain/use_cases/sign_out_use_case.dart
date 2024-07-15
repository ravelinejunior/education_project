import 'package:education_project/core/use_cases/use_case.dart';
import 'package:education_project/core/utils/typedef.dart';
import 'package:education_project/src/auth/domain/repository/auth_repository.dart';

class SignOutUseCase extends UseCaseWithoutParams<void> {
  const SignOutUseCase(this._repo);

  final AuthRepository _repo;
  @override
  ResultFuture<void> call() => _repo.signOut();
}
