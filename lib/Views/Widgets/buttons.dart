import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

abstract class _PlatformWidget<C extends Widget, M extends Widget>
    extends StatelessWidget {
  const _PlatformWidget({super.key});

  C buildCupertinoWidget(BuildContext context);
  M buildMaterialWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return buildCupertinoWidget(context);
    }

    return buildMaterialWidget(context);
  }
}

///Common Buttton Widget-- Platform specific widget
///to show cupertino and material style button widgets
class CommonButton extends _PlatformWidget {
  const CommonButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.iconData,
    this.backgroundColor = AppColors.appTheme,
    this.minButtonWidth,
    this.borderRadius,
    this.textColor,
    this.dense = false,
  });

  final void Function()? onPressed;
  final String text;
  final bool isLoading;
  final IconData? iconData;
  final Color backgroundColor;
  final double? minButtonWidth;
  final BorderRadius? borderRadius;
  final Color? textColor;
  final bool dense;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return SizedBox(
      width: _minButtonWidthValue(context),
      child: CupertinoButton(
        disabledColor: backgroundColor.withOpacity(0.14),
        padding: EdgeInsets.zero,
        color: backgroundColor,
        borderRadius: _borderRadius,
        minSize: dense ? Sizes.buttonHeight * 0.7 : Sizes.buttonHeight,
        onPressed: onPressed,
        child: getChild,
      ),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: backgroundColor.withOpacity(0.14),
        backgroundColor: backgroundColor,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: _borderRadius),
        minimumSize: Size(
          _minButtonWidthValue(context),
          dense ? Sizes.buttonHeight * 0.7 : Sizes.buttonHeight,
        ),
      ),
      onPressed: onPressed,
      child: getChild,
    );
  }

  ///CHILD WIDGET
  Widget get getChild => isLoading
      ? const ShowPlatformLoader(color: AppColors.white)
      : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconData != null) ...[
              Icon(
                iconData,
                color: textColor,
              ),
              const SizedBox(width: Sizes.spaceMed),
            ],

            ///FittedBox --> To fix the fontoverflow issue on buttons
            FittedBox(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.fontSize16,
                  fontWeight: FontWeight.w800,
                  color: textColor ?? AppColors.white,
                ),
              ),
            ),
          ],
        );

  BorderRadius get _borderRadius =>
      borderRadius ?? BorderRadius.circular(Sizes.borderRadius);

  double _minButtonWidthValue(context) =>
      minButtonWidth ?? MediaQuery.of(context).size.width - 20;
}

///Common Text Buttton Widget-- Platform specific widget
///to show cupertino and material style widgets
class CommonTextButton extends _PlatformWidget {
  const CommonTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textColor,
    this.decoration,
  });

  final void Function()? onPressed;
  final String text;
  final Color? textColor;
  final TextDecoration? decoration;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.only(right: Sizes.space),
      onPressed: onPressed,
      child: FittedBox(
        child: Text(
          text,
          style: _style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return TextButton(
      onPressed: onPressed,

      ///FittedBox --> To fix the font-overflow issue on buttons
      child: Text(
        text,
        style: _style,
      ),
    );
  }

  TextStyle get _style => TextStyle(
        fontSize: Sizes.defaultSize,
        fontWeight: FontWeight.w700,
        color: textColor ?? AppColors.appTheme,
        decoration: decoration,
      );
}

///Common outline Buttton Widget-- Platform specific widget
///to show cupertino and material style widgets
class CommonOutlineButton extends StatelessWidget {
  const CommonOutlineButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = AppColors.white,
    this.minButtonWidth,
    this.borderRadius,
    this.foregroundColor = AppColors.blueGrey,
    this.dense = false,
  });

  final void Function()? onPressed;
  final String text;
  final Color backgroundColor;
  final double? minButtonWidth;
  final BorderRadius? borderRadius;
  final Color foregroundColor;
  final bool dense;

  TextStyle get _style => TextStyle(
        fontSize: Sizes.fontSize16,
        fontWeight: FontWeight.w700,
        color: foregroundColor,
      );

  BorderRadius get _borderRadius =>
      borderRadius ?? BorderRadius.circular(Sizes.borderRadius);

  double _minButtonWidthValue(context) =>
      minButtonWidth ?? MediaQuery.of(context).size.width - 20;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: AppColors.white,
        side: BorderSide(color: foregroundColor),
        shape: RoundedRectangleBorder(borderRadius: _borderRadius),
        minimumSize: Size(
          _minButtonWidthValue(context),
          dense ? Sizes.buttonHeight * 0.7 : Sizes.buttonHeight,
        ),
      ),
      onPressed: onPressed,
      child: FittedBox(
        child: Text(
          text,
          style: _style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

///Common Icon Buttton Widget-- Platform specific widget
///to show cupertino and material style widgets
class CommonIconButton extends _PlatformWidget {
  const CommonIconButton({
    super.key,
    required this.onPressed,
    required this.iconData,
    this.iconColor = AppColors.appTheme,
    this.iconSize = 26,
  });

  final void Function()? onPressed;
  final IconData iconData;
  final Color iconColor;
  final double iconSize;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Icon(
        iconData,
        size: iconSize,
        color: iconColor,
      ),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      color: iconColor,
      iconSize: iconSize,
      icon: Icon(iconData),
    );
  }
}
