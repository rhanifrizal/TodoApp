import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:todoapp/core/cores.dart';
import 'package:todoapp/features/auth/presentation/pages/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static String route() => "/homeScreen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
      ),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is AuthInitialState) {
              showSnackbar(context, "Successfully logged out");
              context.go(LoginScreen.route());
            }

            if(state is AuthFailureState) {
              showSnackbar(context, state.message);
            }

            if(state is AuthLoadingState) {
              Dialogs.showLoading(context);
            } else {
              Dialogs.dismissLoading(context);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: () => context.read<AuthBloc>().add(AuthLogoutEvent()),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        AppStrings.logoutString,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
