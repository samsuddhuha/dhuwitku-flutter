class CashOutModel {
  final String custno;
  final int price;
  final int admin;
  final int total;
  final String custname;
  final String sn;
  final String reff;
  final String? clientReff;
  final String? period;
  final String status;
  final String createdAt;
  final String productCode;
  final String productName;
  final String productInfo;
  final String? receiptHeader;
  final String? receiptFooter;
  final int? billNumber;
  final String? package;
  final String? category;
  final String? address;
  final int penalty;
  final String raw;
  final List<dynamic> transactionReportDetails;

  CashOutModel({
    required this.custno,
    required this.price,
    required this.admin,
    required this.total,
    required this.custname,
    required this.sn,
    required this.reff,
    this.clientReff,
    this.period,
    required this.status,
    required this.createdAt,
    required this.productCode,
    required this.productName,
    required this.productInfo,
    this.receiptHeader,
    this.receiptFooter,
    this.billNumber,
    this.package,
    this.category,
    this.address,
    required this.penalty,
    required this.raw,
    required this.transactionReportDetails,
  });

  factory CashOutModel.fromJson(Map<String, dynamic> json) {
    return CashOutModel(
      custno: json['custno'] ?? '',
      price: json['price'] ?? 0,
      admin: json['admin'] ?? 0,
      total: json['total'] ?? 0,
      custname: json['custname'] ?? '',
      sn: json['sn'] ?? '',
      reff: json['reff'] ?? '',
      clientReff: json['client_reff'],
      period: json['period'],
      status: json['status'] ?? '',
      createdAt: json['created_at'],
      productCode: json['product_code'] ?? '',
      productName: json['product_name'] ?? '',
      productInfo: json['product_info'] ?? '',
      receiptHeader: json['receipt_header'],
      receiptFooter: json['receipt_footer'],
      billNumber: json['bill_number'] ?? 0,
      package: json['package'],
      category: json['category'],
      address: json['address'],
      penalty: json['penalty'] ?? 0,
      raw: json['raw'] ?? '',
      transactionReportDetails: json['transaction_report_details'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'custno': custno,
      'price': price,
      'admin': admin,
      'total': total,
      'custname': custname,
      'sn': sn,
      'reff': reff,
      'client_reff': clientReff,
      'period': period,
      'status': status,
      'created_at': createdAt,
      'product_code': productCode,
      'product_name': productName,
      'product_info': productInfo,
      'receipt_header': receiptHeader,
      'receipt_footer': receiptFooter,
      'bill_number': billNumber,
      'package': package,
      'category': category,
      'address': address,
      'penalty': penalty,
      'raw': raw,
      'transaction_report_details': transactionReportDetails,
    };
  }
}
