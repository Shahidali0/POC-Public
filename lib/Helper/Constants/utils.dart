import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cricket_poc/lib_exports.dart';

class Utils {
  Utils._();

  static Utils get instance => Utils._();

  //* Base Api URL
  String get baseUrl =>
      "https://44lsjdxksc.execute-api.ap-southeast-2.amazonaws.com/staging/";

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

  //* Format String to DateTime
  DateTime formatStringToDateTime(String dateString) {
    DateFormat dateFormat = DateFormat.yMMMd();

    // Convert the string to DateTime
    DateTime dateTime = dateFormat.parse(dateString);

    return dateTime;
  }
}
