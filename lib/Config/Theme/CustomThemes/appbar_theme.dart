import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/services.dart';

class MyAppbarTheme {
  MyAppbarTheme._();

  static MyAppbarTheme get instance => MyAppbarTheme._();

  ///#### LIGHT APPBAR THEME #####
  AppBarTheme lightAppbarTheme() {
    return const AppBarTheme(
      shadowColor: AppColors.border,
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.appTheme,
      surfaceTintColor: AppColors.lightBlue,
      scrolledUnderElevation: 6,
      titleTextStyle: TextStyle(
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w700,
        fontSize: Sizes.fontSize18,
        color: AppColors.appTheme,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  ///TabBarTheme ---LIGHT
  TabBarTheme lightTabbarTheme() {
    return const TabBarTheme(
      dividerColor: AppColors.border,
      indicatorSize: TabBarIndicatorSize.tab,
      labelPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: AppColors.appTheme,
            width: 2,
          ),
        ),
      ),
      labelColor: AppColors.appTheme,
      unselectedLabelColor: AppColors.blueGrey,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: AppColors.white,
      ),
      unselectedLabelStyle: TextStyle(
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
