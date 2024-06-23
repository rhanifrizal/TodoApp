import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/utils/utils.dart';
import 'package:todoapp/features/auth/presentation/pages/login/login_screen.dart';
import 'package:todoapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/auth/presentation/pages/verifyemail/verify_email_screen.dart';
import 'package:todoapp/core/widgets/widgets.dart';

class SignupScreen extends StatefulWidget {
  static String route() => '/signup';
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  bool isObscure = true;
  bool isObscure2 = true;

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {setState(() {});});
    _focusNode2.addListener(() {setState(() {});});
    _focusNode3.addListener(() {setState(() {});});
    _focusNode4.addListener(() {setState(() {});});
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is AuthVerifyEmailState) {
              final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.last;
              if(state.message!.isNotEmpty && state.message != "") {
                showSnackbar(context, state.message!);
              }
              if (currentRoute.route.path != VerifyEmailScreen.route()) {
                context.push(VerifyEmailScreen.route());
              }
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
            return SingleChildScrollView(
              child: Column(children: [
                const SizedBox(height: 20),
                image(),
                const SizedBox(height: 50),
                AppTextField(
                  controller: emailController,
                  focusNode: _focusNode1,
                  textInput: TextInputType.emailAddress,
                  name: AppStrings.emailString,
                  icon: Icons.email,
                  isPassword: false,
                  isObscure: false,
                  updateObscure: () {},
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Email field is required";
                    }
                    if(validateEmail(value) != "") {
                      return validateEmail(value);
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                AppTextField(
                  controller: usernameController,
                  focusNode: _focusNode2,
                  textInput: TextInputType.name,
                  name: AppStrings.usernameString,
                  icon: Icons.person,
                  isPassword: false,
                  isObscure: false,
                  updateObscure: () {},
                  validator: (value) {
                    if(value!.isEmpty) {
                      return 'Username field is required';
                    }
                    if(value.isNotEmpty && value.length < 4) {
                      return 'Username requires at least four characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                AppTextField(
                  controller: passwordController,
                  focusNode: _focusNode3,
                  textInput: TextInputType.text,
                  name: AppStrings.passwordString,
                  icon: Icons.password,
                  isPassword: true,
                  isObscure: isObscure,
                  updateObscure: () {setState(() {isObscure = !isObscure;});},
                  validator: (value) {
                    if(value == "") {
                      return 'Password field is required';
                    }
                    if(value != "" && value!.length < 6) {
                      return 'Password requires at least six characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                AppTextField(
                  controller: passwordConfirmController,
                  focusNode: _focusNode4,
                  textInput: TextInputType.text,
                  name: AppStrings.confirmPasswordString,
                  icon: Icons.password,
                  isPassword: true,
                  isObscure: isObscure2,
                  updateObscure: () {setState(() {isObscure2 = !isObscure2;});},
                  validator: (value) {
                    if(value == "") {
                      return "Password field is required";
                    }
                    if(value != "" && value!.length < 6) {
                      return "Password requires at least six characters";
                    }
                    if(value != "" && value != passwordController.text) {
                      return "Password and confirm password is not the same";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                account(),
                const SizedBox(height: 50),
                signupButton()
              ]),
            );
          },
        ),
      ),
    );
  }

  Widget account() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            AppStrings.haveAccountString,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () => context.go(LoginScreen.route()),
            child: Text(
              AppStrings.loginString,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget signupButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () => _signUp(),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            AppStrings.signupString,
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

  Widget image() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.loginPath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    context.read<AuthBloc>().add(AuthRegisterEvent(email: emailController.text.trim(), password: passwordController.text.trim()));
  }
}

