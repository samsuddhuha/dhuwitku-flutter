class InquiryDetailModel {
  final String custno;
  final String custname;
  final String code;
  final String name;
  final String? info;
  final int price;
  final int admin;
  final int markup;
  final int merchantAdmin;
  final int total;
  final int totalPrice;

  InquiryDetailModel({
    required this.custno,
    required this.custname,
    required this.code,
    required this.name,
    this.info,
    required this.price,
    required this.admin,
    required this.markup,
    required this.merchantAdmin,
    required this.total,
    required this.totalPrice,
  });

  factory InquiryDetailModel.fromJson(Map<String, dynamic> json) {
    return InquiryDetailModel(
      custno: json['custno']?.toString() ?? '',
      custname: json['custname']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      info: json['info'] as String?,
      price: int.parse(json['price'].toString()),
      admin: json['admin'] ?? 0,
      markup: json['markup'] ?? 0,
      merchantAdmin: json['merchant_admin'] ?? 0,
      total: json['total'] ?? 0,
      totalPrice: json['total_price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'custno': custno,
      'custname': custname,
      'code': code,
      'name': name,
      'info': info,
      'price': price,
      'admin': admin,
      'markup': markup,
      'merchant_admin': merchantAdmin,
      'total': total,
      'total_price': totalPrice,
    };
  }
}
