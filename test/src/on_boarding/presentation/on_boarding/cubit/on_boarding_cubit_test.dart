import 'package:education_project/on_boarding/domain/use_cases/cache_user_first_timer.dart';
import 'package:education_project/on_boarding/domain/use_cases/check_user_is_first_timer.dart';
import 'package:education_project/on_boarding/presentation/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock_on_boarding_cubit.mock.dart';

void main() {
  late CheckUserIsFirstTimerUseCase _checkUserIsFirstTimerUseCase;
  late CacheUserFirstTimerUseCase _cacheUserFirstTimer;
  late OnBoardingCubit _cubitState;

  setUp(() {
    _checkUserIsFirstTimerUseCase = MockCheckingIsUserFirstTimerUseCase();
    _cacheUserFirstTimer = MockCacheFirstTimerUseCase();
    _cubitState = OnBoardingCubit(
      checkUserIsFirstTimerUseCase: _checkUserIsFirstTimerUseCase,
      cacheUserFirstTimerUseCase: _cacheUserFirstTimer,
    );
  });

  test('initial state should be OnBoardingInitial', () {
    expect(_cubitState.state, const OnBoardingCubitInitial());
  });
}
