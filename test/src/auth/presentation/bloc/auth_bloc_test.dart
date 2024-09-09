import 'package:education_project/src/auth/domain/use_cases/forgot_password_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/signin_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/signup_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/update_user_use_case.dart';
import 'package:education_project/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignIn extends Mock implements SigninUseCase {}

class MockSignUp extends Mock implements SignupUseCase {}

class MockForgotPassword extends Mock implements ForgotPasswordUseCase {}

class MockSignOut extends Mock implements SignOutUseCase {}

class MockUpdateUser extends Mock implements UpdateUserUseCase {}

void main() {
  late SigninUseCase signinUseCase;
  late SignupUseCase signupUseCase;
  late ForgotPasswordUseCase forgotPasswordUseCase;
  late SignOutUseCase signOutUseCase;
  late UpdateUserUseCase updateUserUseCase;
  late AuthBloc authBloc;

  setUp(() {
    signinUseCase = MockSignIn();
    signupUseCase = MockSignUp();
    forgotPasswordUseCase = MockForgotPassword();
    signOutUseCase = MockSignOut();
    updateUserUseCase = MockUpdateUser();
    authBloc = AuthBloc(
      signinUseCase: signinUseCase,
      signupUseCase: signupUseCase,
      forgotPasswordUseCase: forgotPasswordUseCase,
      signOutUseCase: signOutUseCase,
      updateUserUseCase: updateUserUseCase,
    );
  });

  group('AuthBloc', () {
    test('initial state is AuthInitial', () {
      expect(authBloc.state, const AuthInitialState());
    });
  });

  tearDown(() => authBloc.close());
}
