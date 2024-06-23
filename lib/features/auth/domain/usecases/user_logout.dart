import 'package:fpdart/fpdart.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:todoapp/core/usecases/usecase.dart';

class UserLogoutUseCase implements UseCase<void, NoParams> {
  final AuthRepository authRepository;
  const UserLogoutUseCase(this.authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.logout();
  }
}