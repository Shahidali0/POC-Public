import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

class AppTheme {
  AppTheme._();

  ///---- LIGHT THEME ------
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: "ProximaNova",
      brightness: Brightness.light,
      primaryColor: AppColors.appTheme,
      scaffoldBackgroundColor: AppColors.scaffoldBackColor,
      appBarTheme: MyAppbarTheme.instance.lightAppbarTheme(),
      tabBarTheme: MyAppbarTheme.instance.lightTabbarTheme(),
      textTheme: MyTextThemes.instance.lighTextTheme(),
      colorScheme: MyColorScheme.instance.lightColorScheme(context),
      dropdownMenuTheme:
          MyDropDownTheme.instance.lightDropdownMenuTheme(context),
      inputDecorationTheme:
          MyInputDecorationTheme.instance.lightInputDecorationTheme(context),
      textButtonTheme: MyTextButtonTheme.instance.lightTextButtonTheme(context),
      cardTheme: MyCardTheme.instance.lightCardTheme(context),
      checkboxTheme: MyCheckBoxTheme.instance.lightCheckBoxTheme(context),
      chipTheme: MyChipTheme.instance.lightChipTheme(context),
      dividerTheme: MyDividerTheme.instance.lightDividerTheme(context),
      navigationBarTheme:
          MyNavigationBarTheme.instance.lightNavigationBarTheme(context),
      bottomNavigationBarTheme:
          MyNavigationBarTheme.instance.lightBottomNavBarTheme(context),
      floatingActionButtonTheme:
          MyFloatingActionButtonTheme.instance.lightFabTheme(context),
    );
  }

  ///---- DARK THEME ------
  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: "ProximaNova",
      brightness: Brightness.dark,
      primaryColor: AppColors.appTheme,
      scaffoldBackgroundColor: AppColors.black,
      appBarTheme: MyAppbarTheme.instance.darkAppbarTheme(),
      tabBarTheme: MyAppbarTheme.instance.darkTabbarTheme(),
      textTheme: MyTextThemes.instance.darkTextTheme(),
      colorScheme: MyColorScheme.instance.darkColorScheme(context),
      dropdownMenuTheme:
          MyDropDownTheme.instance.darkDropdownMenuTheme(context),
      inputDecorationTheme:
          MyInputDecorationTheme.instance.darkInputDecorationTheme(context),
      textButtonTheme: MyTextButtonTheme.instance.darkTextButtonTheme(context),
      cardTheme: MyCardTheme.instance.darkCardTheme(context),
      checkboxTheme: MyCheckBoxTheme.instance.darkCheckBoxTheme(context),
      chipTheme: MyChipTheme.instance.darkChipTheme(context),
      dividerTheme: MyDividerTheme.instance.darkDividerTheme(context),
      navigationBarTheme:
          MyNavigationBarTheme.instance.darkNavigationBarTheme(context),
      bottomNavigationBarTheme:
          MyNavigationBarTheme.instance.darkBottomNavBarTheme(context),
      floatingActionButtonTheme:
          MyFloatingActionButtonTheme.instance.darkFabTheme(context),
    );
  }
}
