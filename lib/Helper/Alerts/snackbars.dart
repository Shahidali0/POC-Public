import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

//! Error Snackbar
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar({
  required BuildContext context,
  required String? content,
  String? title,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();

  Color backgroundColor = AppColors.red;
  Color textColor = AppColors.white;

  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: Sizes.fontSize16,
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
          ],
          Text(
            content ?? "",
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: textColor,
              fontSize: title != null ? Sizes.defaultSize : Sizes.fontSize16,
              fontWeight: title != null ? FontWeight.w500 : FontWeight.w700,
            ),
          ),
        ],
      ),
      showCloseIcon: true,
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
      ),
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.all(Sizes.space),
      margin: const EdgeInsets.all(Sizes.space),
    ),
  );
}

//* Success Snackbar
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccessSnackBar({
  required BuildContext context,
  required String? content,
  String? title,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();

  Color backgroundColor = AppColors.appTheme;
  Color textColor = AppColors.white;

  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: Sizes.fontSize18,
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
          ],
          Text(
            content ?? "",
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: textColor,
              fontSize: title != null ? Sizes.defaultSize : Sizes.fontSize18,
              fontWeight: title != null ? FontWeight.w500 : FontWeight.w700,
            ),
          ),
        ],
      ),
      showCloseIcon: true,
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
      ),
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.all(Sizes.space),
      margin: const EdgeInsets.all(Sizes.space),
    ),
  );
}
