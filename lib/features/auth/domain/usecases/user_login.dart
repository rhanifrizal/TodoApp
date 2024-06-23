import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/auth/domain/repositories/auth_repository.dart';

class UserLoginUseCase implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;
  const UserLoginParams({required this.email, required this.password});
}