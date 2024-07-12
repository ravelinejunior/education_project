import 'package:dartz/dartz.dart';
import 'package:education_project/core/errors/failures.dart';
import 'package:education_project/src/on_boarding/domain/repository/on_boarding_repository.dart';
import 'package:education_project/src/on_boarding/domain/use_cases/check_user_is_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repo.mock.dart';

/// Test the `CheckUserIsFirstTimerUseCase` class.
///
/// This test group contains two test cases:
///
/// - `should return a true response when [checkIfUserIsFirstTimer] is called`:
///   This test case verifies that the `useCase` returns a `Right` response
///   with the value `true` when the `checkIfUserIsFirstTimer` method of the
///   `repository` is called.
///
/// - `should return false when [checkIfUserIsFirstTimer] is called and fails`:
///   This test case verifies that the `useCase` returns a `Left` response
///   with a `CacheFailure` when the `checkIfUserIsFirstTimer` method of the
///   `repository` is called and fails.
///
/// The test group sets up the necessary dependencies and mocks the
/// `checkIfUserIsFirstTimer` method to return different responses.
///
/// The test group uses the `expect` function to verify the expected results.
/// It also uses the `verify` and `verifyNoMoreInteractions` functions to
/// ensure that the `repository` methods are called as expected.
void main() {
  late OnBoardingRepository repository;
  late CheckUserIsFirstTimerUseCase useCase;

  setUp(() {
    repository = MockOnBoardingRepository();
    useCase = CheckUserIsFirstTimerUseCase(repository);
  });

  group(
    'CheckUserIsFirstTimerUseCase',
    () {
      test(
        'should return a true response when [checkIfUserIsFirstTimer] '
        'is called',
        () async {
          // Arrange
          when(() => repository.checkIfUserIsFirstTimer()).thenAnswer(
            (_) async => const Right(true),
          );

          // Act
          final result = await useCase();

          // Assert
          expect(result, const Right<Failure, dynamic>(true));
          verify(() => repository.checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(repository);
        },
      );

      test(
        'should return false when [checkIfUserIsFirstTimer] is called and '
        'fails',
        () async {
          // Arrange
          when(() => repository.checkIfUserIsFirstTimer()).thenAnswer(
            (_) async => const Left(
              CacheFailure(
                message: 'Error',
                statusCode: 500,
              ),
            ),
          );

          // Act
          final result = await useCase();

          // Assert
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
          verify(() => repository.checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(repository);
        },
      );
    },
  );
}
