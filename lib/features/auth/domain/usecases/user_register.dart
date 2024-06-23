import 'package:fpdart/fpdart.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/auth/domain/repositories/auth_repository.dart';

class UserRegisterUseCase implements UseCase<String, UserRegisterParams> {
  final AuthRepository authRepository;
  const UserRegisterUseCase(this.authRepository);

  @override
  Future<Either<Failure, String>> call(UserRegisterParams params) async {
    return await authRepository.registerWithEmailAndPassword(email: params.email, password: params.password);
  }
}

class UserRegisterParams {
  final String email;
  final String password;
  const UserRegisterParams({required this.email, required this.password});
}