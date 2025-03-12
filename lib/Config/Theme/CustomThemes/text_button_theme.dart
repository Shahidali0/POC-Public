import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

class MyTextButtonTheme {
  MyTextButtonTheme._();

  static MyTextButtonTheme get instance => MyTextButtonTheme._();

  ///#### LIGHT TEXT BUTTON THEME #####
  TextButtonThemeData lightTextButtonTheme(BuildContext context) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.blueGrey,
        backgroundColor: AppColors.transparent,
        overlayColor: AppColors.appTheme,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: Sizes.defaultSize,
          letterSpacing: Sizes.letterSpacing,
        ),
      ),
    );
  }

  ///#### DARK TEXT BUTTON THEME #####
  TextButtonThemeData darkTextButtonTheme(BuildContext context) {
    return const TextButtonThemeData();
  }
}
