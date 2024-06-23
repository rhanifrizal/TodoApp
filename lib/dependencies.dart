import 'package:get_it/get_it.dart';
import 'package:todoapp/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:todoapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:todoapp/features/auth/domain/usecases/user_forgot_password.dart';
import 'package:todoapp/features/auth/domain/usecases/user_initialize.dart';
import 'package:todoapp/features/auth/domain/usecases/user_login_google.dart';
import 'package:todoapp/features/auth/domain/usecases/user_logout.dart';
import 'package:todoapp/features/auth/domain/usecases/user_register.dart';
import 'package:todoapp/features/auth/domain/usecases/user_send_verification_email.dart';
import 'package:todoapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/user_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todoapp/core/utils/utils.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {

  /// Initialize firebase
  // serviceLocator.registerLazySingleton(() async => await Firebase.initializeApp());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Initialize authentication
  _initAuth();
}

void _initAuth() {
  /// Data source
  serviceLocator.registerFactory<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSourceImpl(),
  );

  /// Repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator<FirebaseAuthDataSource>(),
    ),
  );

  /// Use cases
  serviceLocator.registerFactory(
    () => UserInitializeUseCase(
      serviceLocator<AuthRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserRegisterUseCase(
      serviceLocator<AuthRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLoginUseCase(
      serviceLocator<AuthRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSendVerificationEmailUseCase(
      serviceLocator<AuthRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLoginGoogleUseCase(
      serviceLocator<AuthRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserForgotPasswordUseCase(
      serviceLocator<AuthRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLogoutUseCase(
      serviceLocator<AuthRepository>(),
    ),
  );


  /// Bloc
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userInitialized: serviceLocator<UserInitializeUseCase>(),
      userRegister: serviceLocator<UserRegisterUseCase>(),
      userLogin: serviceLocator<UserLoginUseCase>(),
      userSendVerificationEmail: serviceLocator<UserSendVerificationEmailUseCase>(),
      userLoginGoogle: serviceLocator<UserLoginGoogleUseCase>(),
      userForgotPasswordUseCase: serviceLocator<UserForgotPasswordUseCase>(),
      userLogout: serviceLocator<UserLogoutUseCase>(),
    ),
  );
}