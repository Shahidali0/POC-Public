import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

class MyChipTheme {
  MyChipTheme._();

  static MyChipTheme get instance => MyChipTheme._();

  ///#### LIGHT CHIP THEME #####
  ChipThemeData lightChipTheme(BuildContext context) {
    return Theme.of(context).chipTheme.copyWith(
          backgroundColor: AppColors.lightGrey,
          labelStyle: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
          checkmarkColor: AppColors.white,
          surfaceTintColor: AppColors.orange,
          color: WidgetStateProperty.resolveWith(
            (state) {
              if (state.contains(WidgetState.selected)) {
                return AppColors.orange;
              }
              return AppColors.white;
            },
          ),
          elevation: 2,
          pressElevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
          ),
        );
  }

  ///#### DARK CHIP THEME #####
  ChipThemeData darkChipTheme(BuildContext context) {
    return Theme.of(context).chipTheme.copyWith();
  }
}
