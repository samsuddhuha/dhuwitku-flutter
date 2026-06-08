import 'package:intl/intl.dart';

extension StringExtension on String {
  String toRupiah({bool withSymbol = false}) {
    // ambil digit saja
    final digits = replaceAll(RegExp(r'[^0-9]'), '');

    // normalize zero
    final value = int.tryParse(digits) ?? 0;
    if (value == 0) return withSymbol ? 'Rp0' : '0';

    final s = value.toString();
    final buf = StringBuffer();
    int counter = 0;

    for (int i = s.length - 1; i >= 0; i--) {
      buf.write(s[i]);
      counter++;

      if (counter == 3 && i != 0) {
        buf.write('.');
        counter = 0;
      }
    }

    final result = buf.toString().split('').reversed.join();
    return withSymbol ? 'Rp$result' : result;
  }

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

  bool isExpiredUtc() {
    try {
      final expiredUtc = DateTime.parse(this).toUtc();
      final nowUtc = DateTime.now().toUtc();
      return nowUtc.isAfter(expiredUtc);
    } catch (_) {
      return false;
    }
  }
}
