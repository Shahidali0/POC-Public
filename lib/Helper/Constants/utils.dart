import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cricket_poc/lib_exports.dart';

class Utils {
  Utils._();

  static Utils get instance => Utils._();

  //* Hide Focus of TextFormField
  void hideFoucs(BuildContext context) {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  //* Vibrate Screen
  void vibrate() {
    HapticFeedback.heavyImpact();
    HapticFeedback.vibrate();
  }

  //* FormatDate to String
  String formatDateToString(DateTime? dateTime) {
    if (dateTime == null) return "";
    final formattedDate = DateFormat.yMMMd().format(dateTime);
    return formattedDate;
  }

  //* FormatDate to Specific String Format (Month, Year)
  String formatDateYMMM(DateTime? dateTime) {
    if (dateTime == null) return "";

    final formattedDate = DateFormat.yMMM().format(dateTime);
    return formattedDate;
  }

  //* FormatDate to Specific String Format (Month, Year)
  String getDuration(List<String>? data) {
    final duration =
        data!.map((e) => "$e min").toString().replaceAll(RegExp(r"[()]"), "");

    return duration;
  }

  //* Format String to DateTime
  DateTime formatStringToDateTime(String dateString) {
    DateFormat dateFormat = DateFormat.yMMMd();

    // Convert the string to DateTime
    DateTime dateTime = dateFormat.parse(dateString);

    return dateTime;
  }

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

  //* Get HashCodes based on dates
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
