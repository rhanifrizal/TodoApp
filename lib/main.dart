import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/router/app_router.dart';
import 'dependencies.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'package:todoapp/core/utils/utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  Bloc.observer = SimpleBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()..add(AuthInitializedEvent())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
