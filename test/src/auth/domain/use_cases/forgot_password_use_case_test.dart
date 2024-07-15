import 'package:dartz/dartz.dart';
import 'package:education_project/core/errors/failures.dart';
import 'package:education_project/src/auth/domain/use_cases/forgot_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late ForgotPasswordUseCase forgotPasswordUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    forgotPasswordUseCase = ForgotPasswordUseCase(mockAuthRepository);
  });

  group('ForgotPasswordUseCase', () {
    test('should call forgotPassword from AuthRepository', () async {
      // arrange
      const email = 'email';
      when(() => mockAuthRepository.forgotPassword(email))
          .thenAnswer((_) async => const Right(null));

      // act
      await forgotPasswordUseCase(email);

      // assert
      verify(() => mockAuthRepository.forgotPassword(email)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test(
      'should return [Left] when call [forgotPassword] is unsuccessful',
      () async {
        // arrange
        const email = 'email';
        when(() => mockAuthRepository.forgotPassword(email)).thenAnswer(
          (_) async => const Left(
            CacheFailure(message: 'Error', statusCode: 500),
          ),
        );

        // act
        final result = await forgotPasswordUseCase(email);

        // assert
        expect(
          result,
          const Left<Failure, dynamic>(
            CacheFailure(message: 'Error', statusCode: 500),
          ),
        );
        verify(() => mockAuthRepository.forgotPassword(email)).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );
  });
}
