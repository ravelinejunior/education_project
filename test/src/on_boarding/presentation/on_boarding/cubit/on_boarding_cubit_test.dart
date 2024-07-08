import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:education_project/core/errors/failures.dart';
import 'package:education_project/on_boarding/domain/use_cases/cache_user_first_timer.dart';
import 'package:education_project/on_boarding/domain/use_cases/check_user_is_first_timer.dart';
import 'package:education_project/on_boarding/presentation/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_on_boarding_cubit.mock.dart';

void main() {
  late CheckUserIsFirstTimerUseCase checkUserIsFirstTimerUseCase;
  late CacheUserFirstTimerUseCase cacheUserFirstTimer;
  late OnBoardingCubit cubitState;

  const tFailure =
      CacheFailure(message: 'Unable to store the operation', statusCode: 4032);

  setUp(() {
    checkUserIsFirstTimerUseCase = MockCheckingIsUserFirstTimerUseCase();
    cacheUserFirstTimer = MockCacheFirstTimerUseCase();
    cubitState = OnBoardingCubit(
      checkUserIsFirstTimerUseCase: checkUserIsFirstTimerUseCase,
      cacheUserFirstTimerUseCase: cacheUserFirstTimer,
    );
  });

  test('initial state should be [OnBoardingInitial]', () {
    expect(cubitState.state, const OnBoardingCubitInitial());
  });

  group(
    'cacheFirstTimer',
    () {
      blocTest<OnBoardingCubit, OnBoardingCubitState>(
        'should emit [CachingFirstTimer, UserCached] when successful',
        build: () {
          when(cacheUserFirstTimer.call).thenAnswer(
            (_) async => const Right(null),
          );
          return cubitState;
        },
        act: (cubit) => cubit.cacheFirstTimer(),
        expect: () => const <OnBoardingCubitState>[
          CachingFirstTimer(),
          UserCached(),
        ],
        verify: (_) {
          verify(() => cacheUserFirstTimer()).called(1);
          verifyNoMoreInteractions(cacheUserFirstTimer);
        },
      );

      blocTest<OnBoardingCubit, OnBoardingCubitState>(
        'should emit [CachingFirstTimer, OnBoardingError] when caching gets '
        'some error',
        build: () {
          when(() => cacheUserFirstTimer()).thenAnswer(
            (_) async => const Left(
              tFailure,
            ),
          );
          return cubitState;
        },
        act: (cubit) => cubit.cacheFirstTimer(),
        expect: () => [
          const CachingFirstTimer(),
          OnBoardingError(
            message: tFailure.errorMessage,
          ),
        ],
        verify: (_) {
          verify(() => cacheUserFirstTimer()).called(1);
          verifyNoMoreInteractions(cacheUserFirstTimer);
        },
      );
    },
  );
}
