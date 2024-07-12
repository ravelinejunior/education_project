import 'package:dartz/dartz.dart';
import 'package:education_project/core/errors/exceptions.dart';
import 'package:education_project/core/errors/failures.dart';
import 'package:education_project/core/utils/typedef.dart';
import 'package:education_project/src/on_boarding/data/datasource/local_data_source.dart';
import 'package:education_project/src/on_boarding/domain/repository/on_boarding_repository.dart';

class OnBoardingRepositoryImpl implements OnBoardingRepository {
  const OnBoardingRepositoryImpl({required this.localDataSource});

  final OnBoardingLocalDataSource localDataSource;

  /// Caches the first timer.
  ///
  /// This function attempts to cache the first timer. If a [CacheException] is
  /// thrown, it is caught and handled.
  ///
  /// Returns a [ResultFuture] that completes with `void` when the caching is
  /// done.
  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          message: e.message,
          statusCode: e.statusCode!,
        ),
      );
    }
  }

  /// Checks if the user is the first timer.
  ///
  /// This function checks if the user is the first timer by querying the local
  /// data source.
  ///
  /// Returns a [ResultFuture] that completes with a [bool] indicating whether
  /// the user is the first timer.
  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
      final result = await localDataSource.checkIfUserIsFirstTimer();
      return Right(result);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          message: e.message,
          statusCode: e.statusCode!,
        ),
      );
    }
  }
}
