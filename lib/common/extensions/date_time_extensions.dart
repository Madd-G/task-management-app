extension DateExtension on DateTime {

  /// 12 May 2000
  String toDate() {
    String day = this.day.toString().padLeft(2, '0');
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    String month = months[this.month - 1];
    String year = this.year.toString();
    return '$day $month $year';
  }

  /// 12 May
  String toDateWithoutYear() {
    String day = this.day.toString().padLeft(2, '0');
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    String month = months[this.month - 1];
    return '$day $month';
  }

  /// 12:00
  String toTime() {
    String hour = this.hour.toString().padLeft(2, '0');
    String minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  /// 12d 5h
  /// 2h 3m
  String differenceDate(DateTime other) {
    Duration diff = difference(other).abs();
    int days = diff.inDays;
    int hours = diff.inHours.remainder(24);
    int minutes = diff.inMinutes.remainder(60);

    if (days > 0) {
      return '${days}d ${hours}h';
    } else {
      return '${hours}h ${minutes}m';
    }
  }
}
