import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cricket_poc/lib_exports.dart';

class Utils {
  Utils._();

  static Utils get instance => Utils._();

  // //* Hide Focus of TextFormField
  void hideFoucs(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild!.unfocus();
    }
  }

  //* Vibrate Screen
  void vibrate() {
    HapticFeedback.heavyImpact();
    HapticFeedback.vibrate();
  }

  // //* FormatDate to String
  // String formatDateToString(DateTime? dateTime) {
  //   if (dateTime == null) return "";
  //   final formattedDate = DateFormat.yMMMd().format(dateTime);
  //   return formattedDate;
  // }

  // //* FormatDate to Specific String Format (Month, Year)
  // String formatDateYMMM(DateTime? dateTime) {
  //   if (dateTime == null) return "";

  //   final formattedDate = DateFormat.yMMM().format(dateTime);
  //   return formattedDate;
  // }

  // //* Format String to DateTime
  // DateTime formatyMMMdToDateTime(String dateString) {
  //   DateFormat dateFormat = DateFormat.yMMMd();

  //   // Convert the string to DateTime
  //   DateTime dateTime = dateFormat.parse(dateString);

  //   return dateTime;
  // }

  // //* FormatDate to Specific String Format (Month, Year)
  // String getDuration(List<String>? data) {
  //   final duration =
  //       data!.map((e) => "$e min").toString().replaceAll(RegExp(r"[()]"), "");

  //   return duration;
  // }

  //* DatePicker Theme --For Android
  Theme datePickerTheme({
    required BuildContext context,
    required Widget child,
  }) =>
      Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            brightness: Brightness.light,
            primary: AppColors.appTheme,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.appTheme,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        child: child,
      );
}
