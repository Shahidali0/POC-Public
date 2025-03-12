import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

///This class shows custom listtile with [minimal titlegap] and [visualdensity--compact]
class CustomTile extends StatelessWidget {
  const CustomTile(
      {super.key, required this.iconData, required this.text, this.fontSize});

  final IconData iconData;
  final String text;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 12,
      minVerticalPadding: 4,
      dense: true,
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 5,
      visualDensity: VisualDensity.compact,
      leading: Icon(
        iconData,
        size: 16,
      ),
      title: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize ?? kDefaultFontSize,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
