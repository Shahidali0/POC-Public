import 'package:flutter/material.dart';

class Sizes {
  Sizes._();

  ///Font Sizes
  static const double fontSize10 = 10.5;
  static const double fontSize12 = 12;
  static const double defaultSize = 14;
  static const double fontSize16 = 16;
  static const double fontSize18 = 18;
  static const double fontSize20 = 20;
  static const double fontSize22 = 22;
  static const double fontSize24 = 24;

  ///BorderRadis
  static const double borderRadiusL = 16;
  static const double borderRadius = 8;
  static const double borderRadiusMd = 4;

  ///Button Sizes
  static const double buttonHeight = 52.0;

  /// Durations
  static const Duration duration = Duration(milliseconds: 350);
  static const Duration durationS = Duration(milliseconds: 150);
  static const Duration durationL = Duration(milliseconds: 600);

  /// Curves
  static const Curve curve = Curves.easeInOut;

  ///Spacing
  static const double space = 12.0;
  static const double spaceMed = 6.0;
  static const double spaceSmall = 3.0;
  static const double spaceHeightSm = 10.0;
  static const double spaceHeight = 16.0;
  static const double letterSpacing = 0.05;

  ///Screen Sizes--- Width,Height
  static Size screenSize(BuildContext context) => MediaQuery.of(context).size;

  static double screenWidth(BuildContext context) => screenSize(context).width;

  ///Global App Spacing (Margin)
  static const EdgeInsets globalMargin = EdgeInsets.only(
    left: space,
    right: space,
    top: space,
  );

  static const EdgeInsets globalPadding = EdgeInsets.all(space);

  static EdgeInsets cupertinoScaffoldPadding(BuildContext context) =>
      EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + kToolbarHeight,
        left: Sizes.space,
        bottom: Sizes.space,
        right: Sizes.space,
      );
}
