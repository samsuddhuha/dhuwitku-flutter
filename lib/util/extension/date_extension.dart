import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toStringDate({String format = 'dd MMM yyyy, HH:mm'}) {
    final dateFormat = DateFormat(format);
    return dateFormat.format(this);
  }

  String getCurrentTimestamp() {
    return DateFormat('yyyyMMddHHmmss').format(this);
  }
}
