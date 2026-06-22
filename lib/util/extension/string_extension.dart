import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalized() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  DateTime toDate() {
    return DateTime.parse(this).toLocal();
  }

  DateTime parseToUtc() {
    if (contains('Z')) {
      return DateTime.parse(this).toUtc();
    }

    final normalized = replaceFirst('T', ' ');
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

    final dt = formatter.parse(normalized);

    return DateTime.utc(
      dt.year,
      dt.month,
      dt.day,
      dt.hour - 7,
      dt.minute,
      dt.second,
    );
  }

  int toIntFromRupiah() {
    final cleaned = replaceAll(RegExp(r'[^0-9]'), '');

    if (cleaned.isEmpty) return 0;

    final parsed = int.tryParse(cleaned);

    if (parsed == null) {
      return 0;
    }

    return parsed;
  }
}
