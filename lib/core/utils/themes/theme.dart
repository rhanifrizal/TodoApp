import 'package:flutter/material.dart';

class AppTheme{

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
  // static ThemeData lightTheme {
  //   return ThemeData(
  //     useMaterial3: true,
  //     brightness: Brightness.light,
  //     visualDensity: VisualDensity.adaptivePlatformDensity,
  //   );
  // }
}