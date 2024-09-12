part of 'injection_container.dart';

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
