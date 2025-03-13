import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

class MyInputDecorationTheme {
  MyInputDecorationTheme._();

  static MyInputDecorationTheme get instance => MyInputDecorationTheme._();

  ///#### LIGHT INPUT DECORATION THEME #####
  InputDecorationTheme lightInputDecorationTheme(BuildContext context) {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
      alignLabelWithHint: true,
      errorMaxLines: 4,
      prefixIconColor: AppColors.grey,
      suffixIconColor: AppColors.black.withOpacity(0.7),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.appTheme),
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.appTheme),
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
        borderSide: BorderSide(color: AppColors.blueLight.withOpacity(0.75)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.red),
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
      ),
      fillColor: AppColors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
      ),
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.blueGrey,
      ),
      hintStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.blueGrey,
      ),
    );
  }

  ///#### DARK INPUT DECORATION THEME #####
  InputDecorationTheme darkInputDecorationTheme(BuildContext context) {
    return InputDecorationTheme(
      alignLabelWithHint: true,
      errorMaxLines: 4,
      isDense: true,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.appTheme),
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.appTheme),
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.red),
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
      ),
      fillColor: AppColors.black,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
      ),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.white.withOpacity(0.4),
      ),
      hintStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.white.withOpacity(0.4),
      ),
    );
  }
}
