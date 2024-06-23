part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final String? message;
  final User user;
  const AuthSuccessState({required this.message, required this.user});
}

final class AuthVerifyEmailState extends AuthState {
  final String? message;
  const AuthVerifyEmailState({this.message});
}

final class AuthFailureState extends AuthState {
  final String message;
  const AuthFailureState(this.message);
}
