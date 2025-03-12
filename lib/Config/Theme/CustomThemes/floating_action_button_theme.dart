import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

class MyFloatingActionButtonTheme {
  MyFloatingActionButtonTheme._();

  static MyFloatingActionButtonTheme get instance =>
      MyFloatingActionButtonTheme._();

  ///#### LIGHT FLOATING-ACTION-BUTTON THEME #####
  FloatingActionButtonThemeData lightFabTheme(BuildContext context) {
    return Theme.of(context).floatingActionButtonTheme.copyWith(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.appTheme,
          splashColor: AppColors.blueLight,
          iconSize: 26,
        );
  }

  ///#### DARK FLOATING-ACTION-BUTTON THEME #####
  FloatingActionButtonThemeData darkFabTheme(BuildContext context) {
    return Theme.of(context).floatingActionButtonTheme.copyWith(
          backgroundColor: AppColors.black,
          elevation: 8,
        );
  }
}
