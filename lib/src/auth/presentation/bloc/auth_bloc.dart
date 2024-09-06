import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:education_project/core/enum/update_user_enum.dart';
import 'package:education_project/src/auth/domain/entity/local_user.dart';
import 'package:education_project/src/auth/domain/use_cases/forgot_password_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/signin_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/signup_use_case.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SigninUseCase signinUseCase,
    required SignupUseCase signupUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required SignOutUseCase signOutUseCase,
  })  : _signinUseCase = signinUseCase,
        _signupUseCase = signupUseCase,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        _signOutUseCase = signOutUseCase,
        super(const AuthInitialState()) {
    on<AuthEvent>((event, emit) {});
  }

  final SigninUseCase _signinUseCase;
  final SignupUseCase _signupUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final SignOutUseCase _signOutUseCase;
}
