import 'package:intl/intl.dart';

extension IntExtension on int {
  String get twoDigits => toString().padLeft(2, '0');

  String toRupiah({bool withSymbol = false}) {
    final formatted = NumberFormat.decimalPattern('id_ID').format(this);

    return withSymbol ? "Rp $formatted" : formatted;
  }
}
