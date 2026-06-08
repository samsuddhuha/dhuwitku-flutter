class BalanceCashInModel {
  final String amount;
  final String total;
  final int count;

  BalanceCashInModel({
    required this.amount,
    required this.total,
    required this.count,
  });

  factory BalanceCashInModel.fromJson(Map<String, dynamic> json) {
    return BalanceCashInModel(
      amount: json['amount'] as String,
      total: json['total'] as String,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'amount': amount, 'total': total, 'count': count};
  }
}
