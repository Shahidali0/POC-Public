import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

class MyTextThemes {
  MyTextThemes._();

  static MyTextThemes get instance => MyTextThemes._();

  ///---- LIGHT THEME ------
  TextTheme lighTextTheme() {
    return const TextTheme().copyWith(
      //TextForm Field Theme
      bodyLarge: const TextStyle(
        color: AppColors.blueGrey,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  ///---- DARK THEME ------
  TextTheme darkTextTheme() {
    return const TextTheme().copyWith(
      //TextForm Field TextColor
      bodyLarge: const TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
