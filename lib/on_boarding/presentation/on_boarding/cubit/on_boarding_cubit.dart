import 'package:bloc/bloc.dart';
import 'package:education_project/on_boarding/domain/use_cases/cache_user_first_timer.dart';
import 'package:education_project/on_boarding/domain/use_cases/check_user_is_first_timer.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_cubit_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingCubitState> {
  OnBoardingCubit({
    required CacheUserFirstTimerUseCase cacheUserFirstTimerUseCase,
    required CheckUserIsFirstTimerUseCase checkUserIsFirstTimerUseCase,
  })  : _cacheFirstTimer = cacheUserFirstTimerUseCase,
        _checkingUserFirstTimer = checkUserIsFirstTimerUseCase,
        super(const OnBoardingCubitInitial());

  final CacheUserFirstTimerUseCase _cacheFirstTimer;
  final CheckUserIsFirstTimerUseCase _checkingUserFirstTimer;

  // Asynchronous function that caches the first timer.
  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());

    final result = await _cacheFirstTimer();

    result.fold(
      (l) => emit(
        OnBoardingError(
          message: l.errorMessage,
        ),
      ),
      (r) => emit(const UserCached()),
    );
  }

  // Asynchronous function to check if the user is a first-time user.
  Future<void> checkIfUserIsFirstTimer() async {
    emit(const CheckingIfUserIsFirstTimer());
    final result = await _checkingUserFirstTimer();

    result.fold(
      (l) => emit(OnBoardingError(message: l.errorMessage)),
      (r) => emit(
        OnBoardingStatus(isFirstTimer: r),
      ),
    );
  }
}
