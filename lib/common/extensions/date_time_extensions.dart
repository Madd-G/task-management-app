extension DateTimeExtension on DateTime {
  String toCustomFormat() {
    String day = this.day.toString().padLeft(2, '0');
    List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June', 'July',
      'August', 'September', 'October', 'November', 'December'
    ];
    String month = months[this.month - 1];
    String year = this.year.toString();

    String hour = this.hour.toString().padLeft(2, '0');
    String minute = this.minute.toString().padLeft(2, '0');

    return '$hour:$minute - $day $month $year';
  }
}

void main() {
  // Contoh penggunaan extension
  DateTime dateTime = DateTime.now();
  print(dateTime.toCustomFormat()); // Output: 17:32 - 01 March 2024
}
