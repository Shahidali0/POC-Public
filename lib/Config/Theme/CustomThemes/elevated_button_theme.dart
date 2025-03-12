import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

class MyElevatedButtonTheme {
  MyElevatedButtonTheme._();

  static MyElevatedButtonTheme get instance => MyElevatedButtonTheme._();

  ///#### LIGHT ELEVATED BUTTON THEME #####
  ElevatedButtonThemeData lightElevatedButtonTheme(BuildContext context) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.button,
        overlayColor: AppColors.appTheme,
        elevation: 0,
        minimumSize: const Size(200, Sizes.buttonHeight),
        maximumSize: const Size(700, Sizes.buttonHeight),
        disabledBackgroundColor: AppColors.button.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadius),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: Sizes.fontSize18,
          letterSpacing: Sizes.letterSpacing,
        ),
      ),
    );
  }

  ///#### DARK INPUT DECORATION THEME #####
  ElevatedButtonThemeData darkTextButtonTheme(BuildContext context) {
    return const ElevatedButtonThemeData();
  }
}
