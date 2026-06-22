import 'package:dhuwitku/network/remotedata/home/model/dhuwit_amplop_count.dart';

class DashboardSummaryModel {
  final DhuwitAmplopCount? totalCountDhuwit;
  final DhuwitAmplopCount? totalCountAmplop;
  final int totalSpendMonth;
  final int totalSpendDay;

  DashboardSummaryModel({
    this.totalCountDhuwit,
    this.totalCountAmplop,
    required this.totalSpendMonth,
    required this.totalSpendDay,
  });

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    return DashboardSummaryModel(
      totalCountDhuwit:
          json['total_count_dhuwit'] != null &&
              json['total_count_dhuwit'] is Map &&
              (json['total_count_dhuwit'] as Map).isNotEmpty
          ? DhuwitAmplopCount.fromJson(json['total_count_dhuwit'])
          : null,

      totalCountAmplop:
          json['total_count_amplop'] != null &&
              json['total_count_amplop'] is Map &&
              (json['total_count_amplop'] as Map).isNotEmpty
          ? DhuwitAmplopCount.fromJson(json['total_count_amplop'])
          : null,

      totalSpendMonth: _parseInt(json['total_spend_month']),
      totalSpendDay: _parseInt(json['total_spend_day']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_count_dhuwit': totalCountDhuwit?.toJson(),
      'total_count_amplop': totalCountAmplop?.toJson(),
      'total_spend_month': totalSpendMonth,
      'total_spend_day': totalSpendDay,
    };
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }
}
