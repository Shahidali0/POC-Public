import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cricket_poc/lib_exports.dart';

class Utils {
  Utils._();

  //* Base Api URL
  static String get baseUrl =>
      "https://44lsjdxksc.execute-api.ap-southeast-2.amazonaws.com/";

  //* Hide Focus of TextFormField
  static void hideFoucs(BuildContext context) {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  //* Vibrate Screen
  static void vibrate() {
    HapticFeedback.heavyImpact();
    HapticFeedback.vibrate();
  }

  //* FormatDate to String
  static String formatDateToString(DateTime? dateTime) {
    if (dateTime == null) return "";
    final formattedDate = DateFormat.yMMMd().format(dateTime);
    return formattedDate;
  }

  //* Format String to DateTime
  static DateTime formatStringToDateTime(String dateString) {
    DateFormat dateFormat = DateFormat.yMMMd();

    // Convert the string to DateTime
    DateTime dateTime = dateFormat.parse(dateString);

    return dateTime;
  }
}
