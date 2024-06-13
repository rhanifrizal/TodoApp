import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/utils/utils.dart';
import 'package:todoapp/features/user/presentation/pages/login/login_screen.dart';

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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {setState(() {});});
    _focusNode2.addListener(() {setState(() {});});
    _focusNode3.addListener(() {setState(() {});});
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              image(),
              const SizedBox(height: 50),
              textField(emailController, _focusNode1, AppStrings.emailString, Icons.email),
              const SizedBox(height: 10),
              textField(passwordController, _focusNode2, AppStrings.passwordString, Icons.password),
              const SizedBox(height: 10),
              textField(passwordConfirmController, _focusNode3, AppStrings.confirmPasswordString, Icons.password),
              const SizedBox(height: 8),
              account(),
              const SizedBox(height: 20),
              signupButton()
            ],
          )
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
                color: AppColors.secondaryColor,
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
    );
  }

  Widget textField(
    TextEditingController controller,
    FocusNode focusNode,
    String name,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: focusNode.hasFocus
                ? AppColors.primaryColor
                : AppColors.outlineColor,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: name,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.outlineColor,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 2.0,
              )
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
}
