import 'package:flutter/material.dart';
import 'package:todoapp/core/utils/utils.dart';

class Dialogs {
  static Future<void> showLoading(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(10),
          content: SingleChildScrollView(
            child: SizedBox(
              child: Image.asset(
                Assets.loadingPath,
                fit: BoxFit.contain,
              ),
            )
          ),
        );
      }
    );
  }

  static void dismissLoading(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}