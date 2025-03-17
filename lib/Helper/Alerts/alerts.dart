import 'dart:io';

import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogHelper {
  LogHelper._();

  static LogHelper get instance => LogHelper._();

  ///General Dialog Box--With Animation
  Future<String?> showGeneralDialogBox({
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

  ///Show Bottom Sheet
  Future showPlatformSpecificBottomSheet({
    required BuildContext context,
    required String title,
    required Widget child,
  }) {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
        barrierColor: AppColors.blueGrey.withOpacity(0.2),
        context: context,
        builder: (BuildContext context) {
          return MyCupertinoPageScaffold(
            title: title,
            body: child,
          );
        },
      );
    }
    return showModalBottomSheet(
      barrierLabel: title,
      barrierColor: AppColors.blueGrey.withOpacity(0.2),
      context: context,
      builder: (BuildContext context) {
        return MyCupertinoPageScaffold(
          title: title,
          body: child,
        );
      },
    );
  }

  ///Show DatePicker
  Future<DateTime?> showPlatformSpecificDatePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    String? headerText,
  }) async {
    DateTime? selectedDate;

    if (Platform.isIOS) {
      selectedDate = await showCupertinoModalPopup(
        context: context,
        builder: (context) => _CupertinoDatePickerWidget(
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
        ),
      );
    }

    ///For Android
    else {
      selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: firstDate ?? DateTime.now(),
        lastDate: lastDate ?? DateTime.now().add(const Duration(days: 365)),
        cancelText: "Close",
        confirmText: "Pick",
        helpText: headerText,
        builder: (context, child) => Utils.instance.datePickerTheme(
          context: context,
          child: child!,
        ),
      );
    }

    return selectedDate;
  }
}

///CupertinoDatePicker Widget
class _CupertinoDatePickerWidget extends StatefulWidget {
  const _CupertinoDatePickerWidget({
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });

  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  State<_CupertinoDatePickerWidget> createState() =>
      _CupertinoDatePickerWidgetState();
}

class _CupertinoDatePickerWidgetState
    extends State<_CupertinoDatePickerWidget> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.space),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: AppColors.red,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context, selectedDate),
                  ),
                  CupertinoButton(
                    child: const Text(
                      "Done",
                      style: TextStyle(
                        color: AppColors.appTheme,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context, selectedDate),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                backgroundColor: AppColors.white,
                initialDateTime: widget.initialDate,
                minimumDate: widget.firstDate ?? DateTime.now(),
                maximumDate: widget.lastDate ??
                    DateTime.now().add(const Duration(days: 365)),
                onDateTimeChanged: (date) => setState(() {
                  selectedDate = date;
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
