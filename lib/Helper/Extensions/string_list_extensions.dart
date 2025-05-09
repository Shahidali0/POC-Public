extension AppStringListExtensions on List<String>? {
  //* FormatDate to Specific String Format (Month, Year)
  String get getDuration {
    if (this == null) return "";

    final duration =
        this!.map((e) => "$e min").toString().replaceAll(RegExp(r"[()]"), "");

    return duration;
  }
}
