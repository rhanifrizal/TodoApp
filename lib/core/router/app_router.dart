import 'package:go_router/go_router.dart';
import 'package:todoapp/features/auth/presentation/pages/forgotpassword/forgot_password_screen.dart';
import 'package:todoapp/features/auth/presentation/pages/login/login_screen.dart';
import 'package:todoapp/features/auth/presentation/pages/signup/signup_screen.dart';
import 'package:todoapp/features/auth/presentation/pages/verifyemail/verify_email_screen.dart';
import 'package:todoapp/features/task/presentation/pages/home_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: LoginScreen.route(),
    routes: [
      GoRoute(
        path: LoginScreen.route(),
        builder: (context, _) => const LoginScreen(),
      ),
      GoRoute(
        path: SignupScreen.route(),
        builder: (context, _) => const SignupScreen(),
      ),
      GoRoute(
        path: VerifyEmailScreen.route(),
        builder: (context, _) => const VerifyEmailScreen(),
      ),
      GoRoute(
        path: ForgotPasswordScreen.route(),
        builder: (context, _) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: HomeScreen.route(),
        builder: (context, _) => const HomeScreen(),
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