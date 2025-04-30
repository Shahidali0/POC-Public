import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

///This class shows custom listtile with [minimal titlegap] and [visualdensity--compact]
class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.iconData,
    required this.text,
    this.textColor,
    this.fontSize,
    this.iconSize = 18,
    this.fontWeight,
    this.maxLines = 2,
  });

  final IconData iconData;
  final String text;
  final Color? textColor;
  final double? fontSize;
  final double iconSize;
  final FontWeight? fontWeight;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 12,
      minVerticalPadding: 4,
      dense: true,
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: iconSize == 18 ? 10 : null,
      visualDensity: VisualDensity.compact,
      leading: Icon(
        iconData,
        size: iconSize,
      ),
      title: Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize ?? kDefaultFontSize,
          color: textColor ?? AppColors.black,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
      ),
    );
  }
}
