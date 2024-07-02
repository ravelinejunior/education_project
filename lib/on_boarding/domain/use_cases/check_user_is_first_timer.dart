import 'package:education_project/core/use_cases/use_case.dart';
import 'package:education_project/core/utils/typedef.dart';
import 'package:education_project/on_boarding/domain/repository/on_boarding_repository.dart';

class CheckUserIsFirstTimer extends UseCaseWithoutParams<bool> {
  CheckUserIsFirstTimer(this._onBoardingRepository);

  final OnBoardingRepository _onBoardingRepository;

  @override
  // Asynchronously calls the method to check if the user is a first-time user
  // and returns a ResultFuture<bool>.
  ResultFuture<bool> call() async {
    return _onBoardingRepository.checkIfUserIsFirstTimer();
  }
}
