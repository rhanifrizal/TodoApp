import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todoapp/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> initializedUser();

  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> sendVerificationEmail();

  Future<Either<Failure, User>> loginWithGoogle();

  Future<Either<Failure, String>> forgotPassword({
    required String email,
  });

  Future<Either<Failure, void>> logout();
}