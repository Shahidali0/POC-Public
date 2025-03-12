import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

class MyDividerTheme {
  MyDividerTheme._();

  static MyDividerTheme get instance => MyDividerTheme._();

  ///#### LIGHT DIVIDER THEME #####
  DividerThemeData lightDividerTheme(BuildContext context) {
    return Theme.of(context).dividerTheme.copyWith(
          color: AppColors.border,
          space: Sizes.spaceHeight,
        );
  }

  ///#### DARK DIVIDER THEME #####
  DividerThemeData darkDividerTheme(BuildContext context) {
    return Theme.of(context).dividerTheme.copyWith();
  }
}
