import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/utils/utils.dart';
import 'package:todoapp/features/auth/presentation/pages/forgotpassword/forgot_password_screen.dart';
import 'package:todoapp/features/auth/presentation/pages/signup/signup_screen.dart';
import 'package:todoapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:todoapp/core/widgets/widgets.dart';
import 'package:todoapp/features/auth/presentation/pages/verifyemail/verify_email_screen.dart';
import 'package:todoapp/features/task/presentation/pages/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static String route() => '/login';
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {setState(() {});});
    _focusNode2.addListener(() {setState(() {});});
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if(state is AuthSuccessState) {
                if(state.message!.isNotEmpty && state.message != "") {
                  showSnackbar(context, state.message!);
                }
                context.go(HomeScreen.route());
              }

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
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
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
                        updateObscure: (){},
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
                        controller: passwordController,
                        focusNode: _focusNode2,
                        textInput: TextInputType.text,
                        name: AppStrings.passwordString,
                        icon: Icons.password,
                        isPassword: true,
                        isObscure: isObscure,
                        updateObscure: () {setState(() {isObscure = !isObscure;});},
                        validator: (value) {
                          if(value == "") {
                            return "Password field is required";
                          }
                          if(value != "" && value!.length < 6) {
                            return "Password requires at least six characters";
                          }
                          return null;
                        }
                      ),
                      const SizedBox(height: 8),
                      account(),
                      const SizedBox(height: 50),
                      loginButton(),
                      const SizedBox(height: 10),
                      loginWithGoogle(),
                      const SizedBox(height: 10),
                      forgotPassword(),
                    ],
                  ),
                )
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
            image: AssetImage(Assets.loginPath),
            fit: BoxFit.cover,
          ),
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
            AppStrings.dontHaveAccountString,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () => context.go(SignupScreen.route()),
            child: Text(
              AppStrings.signupString,
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

  Widget loginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          if(formKey.currentState!.validate()) {
            context.read<AuthBloc>().add(AuthLoginEvent(email: emailController.text.trim(), password: passwordController.text.trim()));
          }
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

  Widget loginWithGoogle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () => context.read<AuthBloc>().add(AuthLoginGoogleEvent()),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(FontAwesomeIcons.google, color: Colors.white),
        ),
      ),
    );
  }

  Widget forgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () => context.push(ForgotPasswordScreen.route()),
        child: Text(
          AppStrings.forgotPasswordString,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
