import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/features/auth/domain/usecases/user_forgot_password.dart';
import 'package:todoapp/features/auth/domain/usecases/user_initialize.dart';
import 'package:todoapp/features/auth/domain/usecases/user_login.dart';
import 'package:todoapp/features/auth/domain/usecases/user_login_google.dart';
import 'package:todoapp/features/auth/domain/usecases/user_register.dart';
import 'package:todoapp/features/auth/domain/usecases/user_logout.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/auth/domain/usecases/user_send_verification_email.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserInitializeUseCase userInitialized;
  final UserRegisterUseCase userRegister;
  final UserLoginUseCase userLogin;
  final UserSendVerificationEmailUseCase userSendVerificationEmail;
  final UserLoginGoogleUseCase userLoginGoogle;
  final UserForgotPasswordUseCase userForgotPasswordUseCase;
  final UserLogoutUseCase userLogout;

  AuthBloc({
    required this.userInitialized,
    required this.userRegister,
    required this.userLogin,
    required this.userSendVerificationEmail,
    required this.userLoginGoogle,
    required this.userForgotPasswordUseCase,
    required this.userLogout,
  }) : super(AuthInitialState()) {
    on<AuthEvent>(_onAuth);
    on<AuthInitializedEvent>(_onAuthInitialized);
    on<AuthRegisterEvent>(_onAuthRegister);
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthSendVerificationEmailEvent>(_onAuthSendVerificationEmail);
    on<AuthLoginGoogleEvent>(_onAuthLoginGoogle);
    on<AuthForgotPasswordEvent>(_onAuthForgotPassword);
    on<AuthLogoutEvent>(_onAuthLogout);
  }

  void _onAuth(AuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
  }

  FutureOr<void> _onAuthInitialized(AuthInitializedEvent event, Emitter<AuthState> emit) async {
    final result = await userInitialized(NoParams());
    result.fold(
      (failure) => emit(AuthInitialState()),
      (user) => emit(AuthSuccessState(message: "Welcome ${user.displayName}!", user: user)),
    );
  }

  FutureOr<void> _onAuthRegister(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    final result = await userRegister(UserRegisterParams(email: event.email, password: event.password));
    result.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (response) => emit(AuthVerifyEmailState(message: response)),
    );
  }

  FutureOr<void> _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    final result = await userLogin(UserLoginParams(email: event.email, password: event.password));
    result.fold(
      (failure) {
        if(failure.message == "Please verify email before continue!") {
          emit(AuthVerifyEmailState(message: failure.message));
        } else {
          emit(AuthFailureState(failure.message));
        }
      },
      (user) => emit(AuthSuccessState(message: "Welcome ${user.displayName}!",user: user)),
    );
  }

  FutureOr<void> _onAuthSendVerificationEmail(AuthSendVerificationEmailEvent event, Emitter<AuthState> emit) async {
    final result = await userSendVerificationEmail(NoParams());
    result.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (response) => emit(AuthVerifyEmailState(message: response)),
    );
  }

  FutureOr<void> _onAuthLoginGoogle(AuthLoginGoogleEvent event, Emitter<AuthState> emit) async {
    final result = await userLoginGoogle(NoParams());
    result.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (user) => emit(AuthSuccessState(message: "Welcome ${user.displayName}!",user: user)),
    );
  }

  FutureOr<void> _onAuthForgotPassword(AuthForgotPasswordEvent event, Emitter<AuthState> emit) async {
    final result = await userForgotPasswordUseCase(UserForgotPasswordParams(email: event.email));
    result.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (response) => emit(AuthFailureState(response)),
    );
  }

  FutureOr<void> _onAuthLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    final result = await userLogout(NoParams());
    result.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (_) => emit(AuthInitialState()),
    );
  }
}
