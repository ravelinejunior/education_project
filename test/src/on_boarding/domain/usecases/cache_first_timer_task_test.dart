/* 
  Creating the TDD for CacheFirstTimeTask 
*/

import 'package:dartz/dartz.dart';
import 'package:education_project/core/errors/failures.dart';
import 'package:education_project/on_boarding/domain/use_cases/cache_user_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repo.mock.dart';

/// Test the `CacheUserFirstTimerUseCase` class.
///
/// This function sets up the necessary dependencies and tests the behavior of
/// the `CacheUserFirstTimerUseCase` class. It tests two scenarios:
///
/// - Testing the case when the user is first time.
///   - It mocks the `cacheFirstTimer` method of the `OnBoardingRepository` to
///     return a `Right(null)` value.
///   - It asserts that the result of the `useCase` function is equal to
///     `Right(null)`.
///   - It verifies that the `cacheFirstTimer` method of the `repository` is
///     called once.
///   - It verifies that there are no more interactions with the `repository`.
///
/// - Testing the case when the `cacheFirstTimer` method of the `repository`
///   returns an error.
///   - It mocks the `cacheFirstTimer` method of the `OnBoardingRepository` to
///     return a `Left(CacheFailure(...))` value.
///   - It asserts that the result of the `useCase` function is equal to
///     `Left(CacheFailure(...))`.
///   - It verifies that the `cacheFirstTimer` method of the `repository` is
///     called once.
///   - It verifies that there are no more interactions with the `repository`.
void main() {
  late MockOnBoardingRepository repository;
  late CacheUserFirstTimerUseCase useCase;

  setUp(() {
    repository = MockOnBoardingRepository();
    useCase = CacheUserFirstTimerUseCase(repository);
  });

  group(
    'checkIfUserIsFirstTimer',
    () {
      test(
        'should return true if user is first time',
        () async {
          // arrange
          when(repository.cacheFirstTimer).thenAnswer(
            (_) async => const Right(null),
          );
          // act
          final result = await useCase();
          // assert
          expect(
            result,
            equals(
              const Right<Failure, dynamic>(null),
            ),
          );
          verify(repository.cacheFirstTimer).called(1);
          verifyNoMoreInteractions(repository);
        },
      );
      test('should call the [cacheFirstTimer] and return the right data',
          () async {
        // arrange
        when(() => repository.cacheFirstTimer()).thenAnswer(
          (_) async => const Left(
            CacheFailure(message: 'Error', statusCode: 500),
          ),
        );

        // act
        final result = await useCase();
        // assert
        expect(
          result,
          equals(
            const Left<Failure, dynamic>(
              CacheFailure(
                message: 'Error',
                statusCode: 500,
              ),
            ),
          ),
        );
        verify(repository.cacheFirstTimer).called(1);
        verifyNoMoreInteractions(repository);
      });
    },
  );
}
