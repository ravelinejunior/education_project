import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_project/src/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:education_project/src/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:education_project/src/auth/domain/repository/auth_repository.dart';
import 'package:education_project/src/auth/domain/use_cases/forgot_password_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/signin_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/signup_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/update_user_use_case.dart';
import 'package:education_project/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:education_project/src/on_boarding/data/datasource/local_data_source.dart';
import 'package:education_project/src/on_boarding/data/repository_impl/on_boarding_repository_impl.dart';
import 'package:education_project/src/on_boarding/domain/repository/on_boarding_repository.dart';
import 'package:education_project/src/on_boarding/domain/use_cases/cache_user_first_timer.dart';
import 'package:education_project/src/on_boarding/domain/use_cases/check_user_is_first_timer.dart';
import 'package:education_project/src/on_boarding/presentation/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _onBoardingInit();
  await _authInit();
}

/// Initializes the authentication services by registering the necessary
/// factories and singletons.
///
/// Registers the AuthBloc factory, and the SigninUseCase, SignupUseCase,
/// ForgotPasswordUseCase,
/// SignOutUseCase, and UpdateUserUseCase lazy singletons. Also registers the
/// AuthRepositoryImpl,
/// AuthRemoteDataSourceImpl, FirebaseAuth, FirebaseFirestore, and
/// FirebaseStorage lazy singletons.
///
/// Returns a Future that completes when the initialization is done.
Future<void> _authInit() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        signinUseCase: sl(),
        signupUseCase: sl(),
        forgotPasswordUseCase: sl(),
        signOutUseCase: sl(),
        updateUserUseCase: sl(),
      ),
    )
    ..registerLazySingleton(
      () => SigninUseCase(sl()),
    )
    ..registerLazySingleton(
      () => SignupUseCase(sl()),
    )
    ..registerLazySingleton(
      () => ForgotPasswordUseCase(sl()),
    )
    ..registerLazySingleton(
      () => SignOutUseCase(sl()),
    )
    ..registerLazySingleton(
      () => UpdateUserUseCase(sl()),
    )
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        firebaseAuth: sl(),
        firebaseFirestore: sl(),
        firebaseStorage: sl(),
      ),
    )
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}

/// Initializes the onboarding services by registering the necessary factories
/// and singletons.
///
/// Registers the OnBoardingCubit factory, and the CacheUserFirstTimerUseCase,
/// CheckUserIsFirstTimerUseCase, OnBoardingRepositoryImpl,
/// OnBoardingLocalDataSourceImpl,
/// and SharedPreferences lazy singletons.
///
/// Returns a Future that completes when the initialization is done.
Future<void> _onBoardingInit() async {
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
