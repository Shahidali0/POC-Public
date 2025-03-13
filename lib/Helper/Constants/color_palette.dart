import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///This class shows all colors used in application
class AppColors {
  ///Private Constructor
  AppColors._();

  static const Color appTheme = Color(0xFF537EEF);
  // static const Color appTheme = Color(0xFF5758d0);
  static const Color blueLight = Color(0xFF95ADF3);
  static const Color scaffoldBackColor = CupertinoColors.white;

  static const Color black = CupertinoColors.black;
  static const Color blueGrey = Color(0xFF3f556e);
  static const Color grey = Color(0xFFABBBCE);
  static Color lightGrey = CupertinoColors.extraLightBackgroundGray;
  static const Color button = Color(0xFF678CEA);
  static const Color border = Color(0xFFEDEDED);
  static const Color orange =
      CupertinoColors.systemOrange; // Color(0xFFF0A03C);
  static const Color green = CupertinoColors.systemGreen;

  static const Color red = Color.fromARGB(255, 181, 14, 2);
  static const Color transparent = Colors.transparent;
  static const Color white = CupertinoColors.white;

  ///Gradient
  static const LinearGradient homeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    // stops: [
    //   0.6,
    //   0.8,
    // ],
    colors: [
      Color(0xFF668df0),
      blueLight,
      // white,
    ],
  );
  static const LinearGradient homeGradient2 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      blueLight,
      white,
    ],
  );

  static const RadialGradient authGradient1 = RadialGradient(
    radius: 1,
    center: Alignment.topRight,
    colors: [
      Color(0xFFbef3fe),
      Color(0xFFbdccf0),
    ],
  );

  static const LinearGradient authGradient2 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFbdccf0),
      Color(0xFFebebfe),
      Color(0xFFffffff),
    ],
    stops: [
      0.02,
      0.3,
      1,
    ],
  );

  ///NavBar Indicator Color
  static const List<Color> indicatorColors = [
    Color(0xFF668df0),
    Color(0xFF29BAED),
    Color(0xFF752CAF),
    Color(0xFF333333),
    Color(0xFFFFD23F),
  ];

  ///Loading Color
  static const List<Color> loadingColors = [
    Color(0xFF752CAF),
    Color(0xFF29BAED),
    Color(0xFFA39C9C),
    Color(0xFF333333),
    Color(0xFF29BAED),
    Color(0xFFFFD23F),
  ];
}
