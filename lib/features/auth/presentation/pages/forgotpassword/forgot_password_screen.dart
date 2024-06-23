import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/cores.dart';
import 'package:todoapp/features/auth/presentation/bloc/auth_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String route() => "/forgotPassword";
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if(state is AuthFailureState) {
                showSnackbar(context, state.message);
              }

              if(state is AuthLoadingState) {
                Dialogs.showLoading(context);
              } else {
                Dialogs.dismissLoading(context);
              }
            },
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    image(),
                    const SizedBox(height: 50),
                    AppTextField(
                      controller: emailController,
                      focusNode: _focusNode,
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
                      }
                    ),
                    const SizedBox(height: 50),
                    forgotPasswordButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
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
            image: AssetImage(Assets.forgotPasswordPath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget forgotPasswordButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          if(formKey.currentState!.validate()) {
            context.read<AuthBloc>().add(AuthForgotPasswordEvent(email: emailController.text.trim()));
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
            AppStrings.resetPasswordString,
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
