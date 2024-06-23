import 'package:fpdart/fpdart.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/auth/domain/repositories/auth_repository.dart';

class UserSendVerificationEmailUseCase implements UseCase<String, NoParams> {
  final AuthRepository authRepository;
  const UserSendVerificationEmailUseCase(this.authRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await authRepository.sendVerificationEmail();
  }

}