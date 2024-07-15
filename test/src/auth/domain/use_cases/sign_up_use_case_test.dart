import 'package:dartz/dartz.dart';
import 'package:education_project/core/errors/failures.dart';
import 'package:education_project/src/auth/domain/entity/local_user.dart';
import 'package:education_project/src/auth/domain/use_cases/signup_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignupUseCase signUpUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signUpUseCase = SignupUseCase(mockAuthRepository);
  });

  const tParams = SignUpParams(
    email: 'email',
    fullName: 'name',
    password: 'password',
  );

  group('SigninUseCase', () {
    test('should call signin from AuthRepository', () async {
      // arrange
      when(
        () => mockAuthRepository.signUp(
          email: tParams.email,
          fullName: tParams.fullName,
          password: tParams.password,
        ),
      ).thenAnswer((_) async => Right(LocalUser.empty()));

      // act
      final result = await signUpUseCase(tParams);

      // assert
      expect(result, Right<dynamic, LocalUser>(LocalUser.empty()));
      verify(
        () => mockAuthRepository.signUp(
          email: tParams.email,
          fullName: tParams.fullName,
          password: tParams.password,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return [Left] when call [signup] is unsuccessful', () async {
      // arrange
      when(
        () => mockAuthRepository.signUp(
          email: any(named: 'email'),
          fullName: any(named: 'fullName'),
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
      final result = await signUpUseCase(tParams);

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
        () => mockAuthRepository.signUp(
          email: tParams.email,
          fullName: tParams.fullName,
          password: tParams.password,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
