import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todoapp/core/error/exceptions.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/features/auth/data/datasources/firebase_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;
  const AuthRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, User>> initializedUser() async {
    try {
      User user = await dataSource.initializedUser();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> registerWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    try {
      String response = await dataSource.registerWithEmailPassword(email: email, password: password);
      return right(response);
    } on ServerException catch(e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password
  }) async {
    try {
      User user = await dataSource.loginWithEmailPassword(email: email, password:password);
      return right(user);
    } on ServerException catch(e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> sendVerificationEmail() async {
    try {
      String response = await dataSource.sendVerificationEmail();
      return right(response);
    } on ServerException catch(e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithGoogle() async {
    try {
      User user = await dataSource.loginWithGoogle();
      return right(user);
    } on ServerException catch(e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword({
    required String email,
  }) async {
    try{
      String response = await dataSource.forgotPassword(email: email);
      return right(response);
    } on ServerException catch(e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async{
    try {
      await dataSource.logout();
      return right(null);
    } on ServerException catch(e) {
      return left(Failure(e.message));
    }
  }
}