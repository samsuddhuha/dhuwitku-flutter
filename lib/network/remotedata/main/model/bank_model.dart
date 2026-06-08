class BankModel {
  final int id;
  final String vendor;
  final String code;
  final String account;
  final String name;
  final String createdAt;
  final String updatedAt;

  const BankModel({
    required this.id,
    required this.vendor,
    required this.code,
    required this.account,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      id: json['id'] as int,
      vendor: json['vendor'] as String,
      code: json['code'] as String,
      account: json['account'] as String,
      name: json['name'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendor': vendor,
      'code': code,
      'account': account,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
