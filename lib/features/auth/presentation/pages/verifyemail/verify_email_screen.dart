import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:todoapp/core/widgets/widgets.dart';
import 'package:todoapp/core/utils/utils.dart';
import 'package:todoapp/features/auth/presentation/pages/login/login_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  static String route() => "/verifyEmail";
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEnabled = true;
  int time = 60;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if(state is AuthVerifyEmailState) {
                if(state.message != "" && state.message!.isNotEmpty) {
                  showSnackbar(context, state.message!);
                }
              }

              if(state is AuthFailureState) {
                if(state.message != "" && state.message.isNotEmpty) {
                  showSnackbar(context, state.message);
                }
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  image(),
                  const SizedBox(height: 30),
                  texts(),
                  const SizedBox(height: 50),
                  resendButton(),
                  const SizedBox(height: 10),
                  loginButton(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget image() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.verifyEmailPath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget texts() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "A verification email has been sent to your email. Press Resend Email button if you didn't receive the email. Press login button to continue",
        textAlign: TextAlign.justify,
        style: TextStyle(
            fontSize: 16
        ),
      ),
    );
  }

  Widget resendButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: isEnabled ? () {
          context.read<AuthBloc>().add(AuthSendVerificationEmailEvent());
          setState(() {
            isEnabled = false;
            time = 60;
          });
          _timer = Timer.periodic(const Duration(seconds: 1), (_) {
            if (time > 0) {
              setState(() {
                time--;
              });
            } else {
              setState(() {
                isEnabled = true;
                _timer?.cancel();
              });
            }
          });
        }: null,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: isEnabled ? AppColors.secondaryColor : Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            isEnabled ? AppStrings.resendEmailString : "Resend in $time",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          context.pop();
          context.go(LoginScreen.route());
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            AppStrings.loginString,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

}
