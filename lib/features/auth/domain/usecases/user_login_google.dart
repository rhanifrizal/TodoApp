import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/auth/domain/repositories/auth_repository.dart';

class UserLoginGoogleUseCase implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  const UserLoginGoogleUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.loginWithGoogle();
  }
}