import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

class MyCardTheme {
  MyCardTheme._();

  static MyCardTheme get instance => MyCardTheme._();

  ///#### LIGHT CARD THEME #####
  CardTheme lightCardTheme(BuildContext context) {
    return Theme.of(context).cardTheme.copyWith(
          margin: const EdgeInsets.symmetric(horizontal: Sizes.space),
          color: AppColors.white,
          elevation: 1,
          shadowColor: AppColors.border,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.borderRadius),
            side: const BorderSide(color: AppColors.border),
          ),
        );
  }

  ///#### DARK CARD THEME #####
  CardTheme darkCardTheme(BuildContext context) {
    return Theme.of(context).cardTheme.copyWith(
          margin: Sizes.globalMargin,
        );
  }
}
