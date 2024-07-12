import 'package:education_project/src/on_boarding/data/datasource/local_data_source.dart';
import 'package:education_project/src/on_boarding/data/repository_impl/on_boarding_repository_impl.dart';
import 'package:education_project/src/on_boarding/domain/repository/on_boarding_repository.dart';
import 'package:education_project/src/on_boarding/domain/use_cases/cache_user_first_timer.dart';
import 'package:education_project/src/on_boarding/domain/use_cases/check_user_is_first_timer.dart';
import 'package:education_project/src/on_boarding/presentation/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

/// Initializes the application by registering dependencies with the `sl`
/// instance of `GetIt`.
///
/// This function first retrieves an instance of `SharedPreferences` using
/// `SharedPreferences.getInstance()`.
///
/// Then, it registers the following dependencies:
/// - `OnBoardingCubit` with `CacheUserFirstTimerUseCase` and
/// `CheckUserIsFirstTimerUseCase` as dependencies.
/// - `CacheUserFirstTimerUseCase` with `sl` as a dependency.
/// - `CheckUserIsFirstTimerUseCase` with `sl` as a dependency.
/// - `OnBoardingRepository` with `OnBoardingRepositoryImpl` as a dependency.
/// - `OnBoardingLocalDataSource` with `OnBoardingLocalDataSourceImpl` as a
/// dependency.
/// - `SharedPreferences` with the retrieved `sharedPrefs` instance.
///
/// This function returns a `Future<void>` that completes when all dependencies
/// have been registered.
Future<void> init() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // For OnBoarding Feature
  sl
    ..registerFactory(
      () => OnBoardingCubit(
        cacheUserFirstTimerUseCase: sl(),
        checkUserIsFirstTimerUseCase: sl(),
      ),
    )
    ..registerLazySingleton(
      () => CacheUserFirstTimerUseCase(sl()),
    )
    ..registerLazySingleton(
      () => CheckUserIsFirstTimerUseCase(sl()),
    )
    ..registerLazySingleton<OnBoardingRepository>(
      () => OnBoardingRepositoryImpl(localDataSource: sl()),
    )
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSourceImpl(prefs: sl()),
    )
    ..registerLazySingleton<SharedPreferences>(
      () => sharedPrefs,
    );
}
