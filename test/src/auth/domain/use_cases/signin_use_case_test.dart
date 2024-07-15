import 'package:dartz/dartz.dart';
import 'package:education_project/core/errors/failures.dart';
import 'package:education_project/src/auth/domain/entity/local_user.dart';
import 'package:education_project/src/auth/domain/use_cases/signin_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late SigninUseCase signinUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signinUseCase = SigninUseCase(mockAuthRepository);
  });

  const tParams = SignInParams(email: 'email', password: 'password');

  group('SigninUseCase', () {
    test('should call signin from AuthRepository', () async {
      // arrange
      when(
        () => mockAuthRepository.signIn(
          email: tParams.email,
          password: tParams.password,
        ),
      ).thenAnswer((_) async => Right(LocalUser.empty()));

      // act
      final result = await signinUseCase(tParams);

      // assert
      expect(result, Right<dynamic, LocalUser>(LocalUser.empty()));
      verify(
        () => mockAuthRepository.signIn(
          email: tParams.email,
          password: tParams.password,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return [Left] when call [signin] is unsuccessful', () async {
      // arrange
      when(
        () => mockAuthRepository.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => const Left(
          ServerFailure(
            message: 'Server Failure',
            statusCode: 500,
          ),
        ),
      );

      // act
      final result = await signinUseCase(tParams);

      // assert
      expect(
        result,
        const Left<dynamic, Failure>(
          ServerFailure(
            message: 'Server Failure',
            statusCode: 500,
          ),
        ),
      );
      verify(
        () => mockAuthRepository.signIn(
          email: tParams.email,
          password: tParams.password,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
