import 'package:education_project/core/use_cases/use_case.dart';
import 'package:education_project/core/utils/typedef.dart';
import 'package:education_project/on_boarding/domain/repository/on_boarding_repository.dart';

class CacheUserFirstTimerUseCase extends UseCaseWithoutParams<void> {
  CacheUserFirstTimerUseCase(this._onBoardingRepository);

  final OnBoardingRepository _onBoardingRepository;

  @override

  /// Calls the [_onBoardingRepository] to cache the first timer.
  ///
  /// This function does not take any parameters.
  ///
  /// Returns a [ResultFuture] that completes with `void` when the caching is
  /// done.
  ResultFuture<void> call() async {
    return _onBoardingRepository.cacheFirstTimer();
  }
}
