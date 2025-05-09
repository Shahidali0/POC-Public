import 'package:cricket_poc/lib_exports.dart';

///These are the extension on DateTime --to convert them into Strings
extension AppDateExtensions on DateTime? {
  //*Format Date to YMMM Format
  String get formatDateToYMMMFormat {
    if (this == null) return "";

    final formattedDate = DateFormat.yMMM().format(this!);
    return formattedDate;
  }

  //* FormatDate to String
  String get formatDateToString {
    if (this == null) return "";

    final formattedDate = DateFormat.yMMMd().format(this!);

    return formattedDate;
  }

  //* Get HashCodes based on dates
  int get getHashCode {
    return this!.day * 1000000 + this!.month * 10000 + this!.year;
  }
}
