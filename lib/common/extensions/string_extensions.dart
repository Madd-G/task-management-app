extension StringFileNameExtension on String {
  String get fileName => substring(lastIndexOf('-') + 1);
}
