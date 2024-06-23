import 'package:fpdart/fpdart.dart';
import 'package:todoapp/core/cores.dart';
import 'package:todoapp/features/auth/domain/repositories/auth_repository.dart';

class UserForgotPasswordUseCase implements UseCase<String, UserForgotPasswordParams> {
  final AuthRepository authRepository;
  const UserForgotPasswordUseCase(this.authRepository);

  @override
  Future<Either<Failure, String>> call(UserForgotPasswordParams params) async {
    return await authRepository.forgotPassword(email: params.email);
  }

}

class UserForgotPasswordParams {
  final String email;
  const UserForgotPasswordParams({required this.email});
}