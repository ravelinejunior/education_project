import 'package:education_project/core/enum/update_user_enum.dart';
import 'package:education_project/core/use_cases/use_case.dart';
import 'package:education_project/core/utils/typedef.dart';
import 'package:education_project/src/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateUserUseCase extends UseCaseWithParams<void, UpdateUserParams> {
  const UpdateUserUseCase(this._repo);

  final AuthRepository _repo;

  @override
  ResultFuture<void> call(UpdateUserParams params) => _repo.updateUser(
        action: params.action,
        userData: params.userData,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.action,
    required this.userData,
  });

  factory UpdateUserParams.empty() {
    return const UpdateUserParams(
      action: UpdateUserAction.displayName,
      userData: {
        'name': 'Name',
      },
    );
  }

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<Object?> get props => [action, userData];

  
}
