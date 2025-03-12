import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class LogHelper {
  ///General Dialog Box--With Animation
  static Future<String?> showGeneralDialogBox({
    required BuildContext context,
    required String barrierLabel,
    required Widget child,
  }) async {
    return showGeneralDialog<String>(
      barrierDismissible: false,
      barrierLabel: barrierLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 350),
      context: context,
      pageBuilder: (context, _, __) => SafeArea(
        child: Dialog(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.borderRadius),
          ),
          insetPadding: const EdgeInsets.all(Sizes.space * 2),
          child: SizedBox(
            width: double.infinity,
            child: child,
          ),
        ),
      ),
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }
}
