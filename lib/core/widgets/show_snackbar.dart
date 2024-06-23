import 'package:flutter/material.dart';
import 'package:todoapp/core/utils/utils.dart';

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 2,
      padding: const EdgeInsets.all(15),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.secondaryColor,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      content: Text(
        message,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      ),
    )
  );
}