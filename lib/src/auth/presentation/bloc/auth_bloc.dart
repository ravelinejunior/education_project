import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:education_project/core/enum/update_user_enum.dart';
import 'package:education_project/src/auth/domain/entity/local_user.dart';
import 'package:education_project/src/auth/domain/use_cases/forgot_password_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/signin_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/signup_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/update_user_use_case.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
      {required SigninUseCase signinUseCase,
      required SignupUseCase signupUseCase,
      required ForgotPasswordUseCase forgotPasswordUseCase,
      required SignOutUseCase signOutUseCase,
      required UpdateUserUseCase updateUserUseCase})
      : _signinUseCase = signinUseCase,
        _signupUseCase = signupUseCase,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        _signOutUseCase = signOutUseCase,
        _updateUserUseCase = updateUserUseCase,
        super(const AuthInitialState()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoadingState());
    });

    on<SignInEvent>(_signInHandler);
  }

  final SigninUseCase _signinUseCase;
  final SignupUseCase _signupUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final SignOutUseCase _signOutUseCase;
  final UpdateUserUseCase _updateUserUseCase;

  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  )async {
     final result = await _signinUseCase(
        SignInParams(
          email: event.email,
          password: event.password,
        ),
      );

      result.fold(
        (failure) => emit(AuthErrorState(failure.message)),
        (user) => emit(AuthSignedInState(user)),
      );
  }

  Future<void> _signUpHandler(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async{}

  Future<void> _forgotPasswordHandler(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  )async {}

  Future<void> _signOutHandler(
    SignOutEvent event,
    Emitter<AuthState> emit,
  )async {}

  Future<void> _updateUserHandler(
    UpdateUserEvent event,
    Emitter<AuthState> emit,
  ) async{}
}
