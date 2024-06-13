import 'package:go_router/go_router.dart';
import 'package:todoapp/features/user/presentation/pages/login/login_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: LoginScreen.route(),
    routes: [
      GoRoute(
        path: LoginScreen.route(),
        builder: (context, _) => const LoginScreen(),
      )
    ],
    // redirect: (context, state) {
    //   final publicRoutes = [
    //
    //   ];
    //
    //   if()
    // },
  );
}