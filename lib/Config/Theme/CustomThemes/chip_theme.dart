import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

class MyChipTheme {
  MyChipTheme._();

  static MyChipTheme get instance => MyChipTheme._();

  ///#### LIGHT CHIP THEME #####
  ChipThemeData lightChipTheme(BuildContext context) {
    return Theme.of(context).chipTheme.copyWith(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.borderRadius),
            side: const BorderSide(color: AppColors.border),
          ),
          labelStyle: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
          checkmarkColor: AppColors.white,
          surfaceTintColor: AppColors.appTheme,
          color: WidgetStateProperty.resolveWith(
            (state) {
              if (state.contains(WidgetState.selected)) {
                return AppColors.black;
              }
              return AppColors.white;
            },
          ),
          elevation: 2,
          pressElevation: 20,
        );
  }

  ///#### DARK CHIP THEME #####
  ChipThemeData darkChipTheme(BuildContext context) {
    return Theme.of(context).chipTheme.copyWith();
  }
}
