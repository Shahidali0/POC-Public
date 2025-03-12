import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

class MyDropDownTheme {
  MyDropDownTheme._();

  static MyDropDownTheme get instance => MyDropDownTheme._();

  ///#### LIGHT DROPDOWN THEME #####
  DropdownMenuThemeData lightDropdownMenuTheme(BuildContext context) {
    return Theme.of(context).dropdownMenuTheme.copyWith(
          textStyle: const TextStyle(
            color: AppColors.black,
            fontSize: Sizes.defaultSize,
            fontWeight: FontWeight.w600,
          ),
          menuStyle: MenuStyle(
            visualDensity: VisualDensity.comfortable,
            minimumSize: const WidgetStatePropertyAll(Size.fromWidth(120)),
            maximumSize: const WidgetStatePropertyAll(Size.fromWidth(700)),
            elevation: const WidgetStatePropertyAll(8),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.borderRadius),
              side: const BorderSide(color: AppColors.white),
            )),
          ),
          inputDecorationTheme: MyInputDecorationTheme.instance
              .lightInputDecorationTheme(context),
        );
  }

  ///#### DARK DROPDOWN THEME #####
  DropdownMenuThemeData darkDropdownMenuTheme(BuildContext context) {
    return Theme.of(context).dropdownMenuTheme.copyWith(
          textStyle: const TextStyle(
            color: AppColors.black,
            fontSize: Sizes.defaultSize,
            fontWeight: FontWeight.w600,
          ),
          menuStyle: MenuStyle(
            visualDensity: VisualDensity.comfortable,
            minimumSize: const WidgetStatePropertyAll(Size.fromWidth(120)),
            elevation: const WidgetStatePropertyAll(8),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.borderRadius),
              side: const BorderSide(color: AppColors.black),
            )),
          ),
          inputDecorationTheme:
              MyInputDecorationTheme.instance.darkInputDecorationTheme(context),
        );
  }
}
