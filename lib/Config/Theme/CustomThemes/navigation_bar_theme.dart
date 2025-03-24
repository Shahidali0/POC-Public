import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

class MyNavigationBarTheme {
  MyNavigationBarTheme._();

  static MyNavigationBarTheme get instance => MyNavigationBarTheme._();

  ///#### LIGHT NAVIGATION-BAR THEME #####
  NavigationBarThemeData lightNavigationBarTheme(BuildContext context) {
    return Theme.of(context).navigationBarTheme.copyWith(
          backgroundColor: AppColors.white,
          indicatorColor: AppColors.appTheme,
          shadowColor: AppColors.black,
          surfaceTintColor: AppColors.white,
          elevation: 20,
          indicatorShape: const CircleBorder(),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          iconTheme: WidgetStateProperty.resolveWith(
            (state) {
              if (state.contains(WidgetState.selected)) {
                return const IconThemeData(
                  color: AppColors.white,
                  size: 22,
                );
              }
              return const IconThemeData(
                color: AppColors.black,
                size: 26,
              );
            },
          ),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (state) {
              if (state.contains(WidgetState.selected)) {
                return const TextStyle(
                  color: AppColors.appTheme,
                  fontStyle: FontStyle.italic,
                  fontSize: Sizes.fontSize12,
                  overflow: TextOverflow.ellipsis,
                );
              }
              return const TextStyle(
                color: AppColors.black,
                fontSize: Sizes.fontSize12,
              );
            },
          ),
        );
  }

  ///#### DARK NAVIGATION-BAR THEME #####
  NavigationBarThemeData darkNavigationBarTheme(BuildContext context) {
    return Theme.of(context).navigationBarTheme.copyWith();
  }

  ///##################################################################################
  ///##################################################################################
  ///

  ///#### LIGHT BOTTOM-NAV BAR THEME #####
  BottomNavigationBarThemeData lightBottomNavBarTheme(BuildContext context) {
    return Theme.of(context).bottomNavigationBarTheme.copyWith(
          backgroundColor: AppColors.white,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          elevation: 20,
          unselectedLabelStyle: const TextStyle(
            color: AppColors.black,
            fontSize: Sizes.fontSize12,
          ),
          selectedLabelStyle: const TextStyle(
            color: AppColors.appTheme,
            fontStyle: FontStyle.italic,
            fontSize: Sizes.fontSize12,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.ellipsis,
          ),
          unselectedIconTheme: const IconThemeData(color: AppColors.black),
          selectedIconTheme: const IconThemeData(color: AppColors.appTheme),
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        );
  }

  ///#### DARK BOTTOM-NAV BAR THEME #####
  BottomNavigationBarThemeData darkBottomNavBarTheme(BuildContext context) {
    return Theme.of(context).bottomNavigationBarTheme.copyWith(
          backgroundColor: AppColors.black,
          elevation: 10,
        );
  }
}
