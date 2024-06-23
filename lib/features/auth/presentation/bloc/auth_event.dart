part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class AuthInitializedEvent extends AuthEvent {}

final class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;
  const AuthLoginEvent({required this.email, required this.password});
}

final class AuthLoginGoogleEvent extends AuthEvent {}

final class AuthRegisterEvent extends AuthEvent {
  final String email;
  final String password;
  const AuthRegisterEvent({required this.email, required this.password});
}

final class AuthSendVerificationEmailEvent extends AuthEvent {}

final class AuthForgotPasswordEvent extends AuthEvent {
  final String email;
  const AuthForgotPasswordEvent({required this.email});
}

final class AuthLogoutEvent extends AuthEvent {}
