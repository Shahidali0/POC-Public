import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

class MyColorScheme {
  MyColorScheme._();

  static MyColorScheme get instance => MyColorScheme._();

  ///#### LIGHT COLOR SCHEME #####
  ColorScheme lightColorScheme(BuildContext context) {
    return Theme.of(context).colorScheme.copyWith(
          brightness: Brightness.light,
          primary: AppColors.appTheme,
        );
  }

  ///#### DARK COLOR SCHEME #####
  ColorScheme darkColorScheme(BuildContext context) {
    return Theme.of(context).colorScheme.copyWith(
          brightness: Brightness.dark,
          primary: AppColors.appTheme,
        );
  }
}
