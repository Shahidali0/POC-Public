///These are the extension which used to capitalizeFirst letter of string and
///capitalize the sentence using [YourString.capitalize]
extension AppExtensions on String {
  String get capitalizeFirst => _CustomUtils.capitalizeFirst(this);
  String get capitalize => _CustomUtils.capitalize(this);
}

class _CustomUtils {
  ///Check isEmpty
  static bool _isEmpty(dynamic value) => value.toString().trim().isEmpty;

  ///Check For IsNull/Empty
  static bool _isNullOrEmpty(dynamic value) {
    if (value == null) return true;

    return _isEmpty(value);
  }

  /// Uppercase first letter and the others to lowercase
  /// Example: your name => Your name
  static String capitalizeFirst(String s) {
    if (_isNullOrEmpty(s)) return "N/A";

    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  /// Uppercase first letter of every sentence
  /// Example: your name => Your Name
  static String capitalize(String s) {
    if (_isNullOrEmpty(s)) return "N/A";

    return s.split(" ").map(capitalizeFirst).join(' ');
  }
}
