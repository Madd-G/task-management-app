extension DateExtension on DateTime {
  String toDate() {
    String day = this.day.toString().padLeft(2, '0');
    List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June', 'July',
      'August', 'September', 'October', 'November', 'December'
    ];
    String month = months[this.month - 1];
    String year = this.year.toString();
    return '$day $month $year';
  }
}

extension TimeExtension on DateTime {
  String toTime() {
    String hour = this.hour.toString().padLeft(2, '0');
    String minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}