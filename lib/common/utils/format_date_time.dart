class FormatDateTime {
  static Map<String, dynamic> formatDateTime(DateTime? dateTime) =>
      dateTime != null
          ? {
        "_seconds": dateTime.millisecondsSinceEpoch ~/ 1000,
        "_nanoseconds":
        (dateTime.microsecondsSinceEpoch % 1000000) * 1000,
      }
          : {};

}