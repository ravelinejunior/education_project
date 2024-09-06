part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitialState extends AuthState {
  const AuthInitialState();

  @override
  List<Object> get props => [];
}

final class AuthLoadingState extends AuthState {
  const AuthLoadingState();

  @override
  List<Object> get props => [];
}

final class AuthSignedInState extends AuthState {
  const AuthSignedInState(this.user);
  final LocalUser user;

  @override
  List<Object> get props => [user];
}

final class AuthSignedUpState extends AuthState{
  const AuthSignedUpState();

  @override
  List<Object> get props => [];
}

final class AuthSignedOutState extends AuthState {
  const AuthSignedOutState();

  @override
  List<Object> get props => [];
}

final class AuthUserUpdate extends AuthState{
  const AuthUserUpdate();

  @override
  List<Object> get props => [];
}

final class AuthErrorState extends AuthState {
  const AuthErrorState(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

final class AuthForgotPasswordState extends AuthState {
  const AuthForgotPasswordState();

  @override
  List<Object> get props => [];
}


