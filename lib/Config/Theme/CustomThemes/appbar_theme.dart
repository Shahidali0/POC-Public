import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

class MyAppbarTheme {
  MyAppbarTheme._();

  static MyAppbarTheme get instance => MyAppbarTheme._();

  ///#### LIGHT APPBAR THEME #####
  AppBarTheme lightAppbarTheme() {
    return const AppBarTheme(
      shadowColor: AppColors.border,
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.appTheme,
      surfaceTintColor: AppColors.blueLight,
      scrolledUnderElevation: 6,
      titleTextStyle: TextStyle(
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w700,
        fontSize: Sizes.fontSize18,
        color: AppColors.appTheme,
      ),
    );
  }

  ///TabBarTheme ---LIGHT
  TabBarTheme lightTabbarTheme() {
    return TabBarTheme(
      dividerColor: AppColors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      labelPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
        color: AppColors.appTheme,
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
        border: Border.all(color: AppColors.appTheme),
      ),
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        color: AppColors.white,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.blueGrey,
      ),
    );
  }

  ///
  ///
  ///#### DARK APPBAR THEME #####
  AppBarTheme darkAppbarTheme() {
    return const AppBarTheme();
  }

  ///TabBarTheme--DARK
  TabBarTheme darkTabbarTheme() {
    return const TabBarTheme();
  }
}
