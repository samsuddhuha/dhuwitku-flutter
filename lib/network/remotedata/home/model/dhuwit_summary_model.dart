class DhuwitSummaryModel {
  final int month;
  final int year;
  final int totalIncome;
  final int totalSpend;
  final int balance;
  final int incomeCount;
  final int spendCount;

  const DhuwitSummaryModel({
    required this.month,
    required this.year,
    required this.totalIncome,
    required this.totalSpend,
    required this.balance,
    required this.incomeCount,
    required this.spendCount,
  });

  factory DhuwitSummaryModel.fromJson(Map<String, dynamic> json) {
    return DhuwitSummaryModel(
      month: json['month'] ?? 0,
      year: json['year'] ?? 0,
      totalIncome: json['total_income'] ?? 0,
      totalSpend: json['total_spend'] ?? 0,
      balance: json['balance'] ?? 0,
      incomeCount: json['income_count'] ?? 0,
      spendCount: json['spend_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'year': year,
      'total_income': totalIncome,
      'total_spend': totalSpend,
      'balance': balance,
      'income_count': incomeCount,
      'spend_count': spendCount,
    };
  }

  DhuwitSummaryModel copyWith({
    int? month,
    int? year,
    int? totalIncome,
    int? totalSpend,
    int? balance,
    int? incomeCount,
    int? spendCount,
  }) {
    return DhuwitSummaryModel(
      month: month ?? this.month,
      year: year ?? this.year,
      totalIncome: totalIncome ?? this.totalIncome,
      totalSpend: totalSpend ?? this.totalSpend,
      balance: balance ?? this.balance,
      incomeCount: incomeCount ?? this.incomeCount,
      spendCount: spendCount ?? this.spendCount,
    );
  }
}
