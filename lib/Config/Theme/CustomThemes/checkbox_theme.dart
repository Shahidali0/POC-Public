import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

class MyCheckBoxTheme {
  MyCheckBoxTheme._();

  static MyCheckBoxTheme get instance => MyCheckBoxTheme._();

  ///#### LIGHT CHECKBOX THEME #####
  CheckboxThemeData lightCheckBoxTheme(BuildContext context) {
    return Theme.of(context).checkboxTheme.copyWith(
          fillColor: const WidgetStatePropertyAll(AppColors.appTheme),
          checkColor: const WidgetStatePropertyAll(AppColors.white),
        );
  }

  ///#### DARK CHECKBOX THEME #####
  CheckboxThemeData darkCheckBoxTheme(BuildContext context) {
    return Theme.of(context).checkboxTheme.copyWith();
  }
}
