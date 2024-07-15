import 'package:dartz/dartz.dart';
import 'package:education_project/core/errors/failures.dart';
import 'package:education_project/src/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignOutUseCase signOutUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signOutUseCase = SignOutUseCase(mockAuthRepository);
  });

  group('SignOutUseCase', () {
    test('should call [signOut] from [AuthRepository]', () async {
      // arrange
      when(() => mockAuthRepository.signOut())
          .thenAnswer((_) async => const Right(null));

      // act
      await signOutUseCase();

      // assert
      verify(() => mockAuthRepository.signOut()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test(
      'should return [Left] when call [signOut] is unsuccessful',
      () async {
        // arrange
        when(() => mockAuthRepository.signOut()).thenAnswer(
          (_) async => const Left(
            CacheFailure(message: 'Error', statusCode: 500),
          ),
        );

        // act
        final result = await signOutUseCase();

        // assert
        expect(
          result,
          const Left<Failure, dynamic>(
            CacheFailure(message: 'Error', statusCode: 500),
          ),
        );
        verify(() => mockAuthRepository.signOut()).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );
  });
}
