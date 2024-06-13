import 'package:flutter/material.dart';

class Screen {
  Size screenSize;
  Screen(BuildContext context) : screenSize = MediaQuery.of(context).size;

  double wp(percentage) {
    return percentage / 100 * screenSize.width;
  }

  double hp(percentage) {
    return percentage / 100 * screenSize.height;
  }

  double getWidthPx(int pixels) {
    return (pixels / 3.61) / 100 * screenSize.width;
  }
}