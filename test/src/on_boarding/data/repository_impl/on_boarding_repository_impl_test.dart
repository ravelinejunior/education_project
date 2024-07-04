import 'package:dartz/dartz.dart';
import 'package:education_project/core/errors/exceptions.dart';
import 'package:education_project/core/errors/failures.dart';
import 'package:education_project/on_boarding/data/datasource/local_data_source.dart';
import 'package:education_project/on_boarding/data/repository_impl/on_boarding_repository_impl.dart';
import 'package:education_project/on_boarding/domain/repository/on_boarding_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'local_data_source.mock.dart';

void main() {
  late OnBoardingLocalDataSource dataSource;
  late OnBoardingRepositoryImpl repository;

  setUp(
    () {
      dataSource = MockLocalDataSource();
      repository = OnBoardingRepositoryImpl(localDataSource: dataSource);
    },
  );

  test(
    'should be a subclass of [OnBoardingRepository]',
    () async {
      // Assert
      expect(repository, isA<OnBoardingRepository>());
    },
  );

  group(
    'cacheFirstTimer',
    () {
      test(
        'should return Right(null) when cacheFirstTimer is called',
        () async {
          // Arrange
          when(dataSource.cacheFirstTimer).thenAnswer(
            (_) async => Future.value(),
          );
          // Act
          final result = await repository.cacheFirstTimer();
          // Assert
          expect(
            result,
            equals(
              const Right<dynamic, void>(null),
            ),
          );
          verify(dataSource.cacheFirstTimer).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );

      test(
        'should return [CacheFailure] when storage is full',
        () async {
          // Arrange
          when(dataSource.cacheFirstTimer).thenThrow(
            const CacheException(message: 'Storage is full', statusCode: 500),
          );
          // Act
          final result = await repository.cacheFirstTimer();
          // Assert
          expect(
            result,
            const Left<CacheFailure, dynamic>(
              CacheFailure(
                message: 'Storage is full',
                statusCode: 500,
              ),
            ),
          );
          verify(dataSource.cacheFirstTimer);
          verifyNoMoreInteractions(dataSource);
        },
      );
    },
  );

  group(
    'checkIsUserFirstTimer',
    () {
      test(
        'should return [Right(true)] when [checkUserFirstTimer] called and is '
        'successful',
        () async {
          // Arrange
          when(dataSource.checkIfUserIsFirstTimer).thenAnswer(
            (_) async => Future.value(true),
          );

          // Act
          final result = await repository.checkIfUserIsFirstTimer();

          // Assert
          expect(
            result,
            const Right<dynamic, bool>(true),
          );
          verify(dataSource.checkIfUserIsFirstTimer).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );

      test(
        'should return [CacheFailure] when [checkIfUserIsFirstTimer] and'
        ' throw an exception',
        () async {
          // Arrange
          when(dataSource.checkIfUserIsFirstTimer).thenThrow(
            const CacheException(
              message: 'User is not checked',
              statusCode: 500,
            ),
          );

          // Act
          final result = await repository.checkIfUserIsFirstTimer();

          // Assert
          expect(
            result,
            const Left<CacheFailure, bool>(
              CacheFailure(
                message: 'User is not checked',
                statusCode: 500,
              ),
            ),
          );
          verify(dataSource.checkIfUserIsFirstTimer).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );
    },
  );
}
