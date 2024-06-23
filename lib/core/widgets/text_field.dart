import 'package:flutter/material.dart';
import 'package:todoapp/core/utils/utils.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({required this.controller, required this.focusNode, required this.textInput, required this.name, required this.icon, required this.isPassword, required this.isObscure, required this.updateObscure, required this.validator, super.key});
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType textInput;
  final String name;
  final IconData icon;
  final bool isPassword;
  final bool isObscure;
  final void Function() updateObscure;
  final String? Function(String?) validator;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.textInput,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          obscureText: widget.isObscure ? true : false,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              widget.icon,
              color: widget.focusNode.hasFocus
                  ? AppColors.primaryColor
                  : AppColors.outlineColor,
            ),
            suffixIcon: widget.isPassword ? IconButton(
              icon: Icon(widget.isObscure ? Icons.visibility_off : Icons.visibility, color: AppColors.outlineColor),
              onPressed: () {
                widget.updateObscure(); // Call the update function
              },
            ) : const SizedBox.shrink(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: widget.name,
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
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2.0,
                )
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 2.0,
                )
            ),
          ),
          validator: widget.validator,
        ),
      )
    );
  }
}
