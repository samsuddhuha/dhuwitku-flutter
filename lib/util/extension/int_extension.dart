extension IntExtension on int {
  String get twoDigits => toString().padLeft(2, '0');
}
