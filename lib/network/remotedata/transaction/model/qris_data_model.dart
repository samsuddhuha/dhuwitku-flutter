class QrisDataModel {
  final int amount;
  final String? paymentUrl;
  final String? content;
  final String? returnUrl;
  final String status;
  final String? rrn;
  final String reff;
  final String? clientReff;
  final String? name;
  final String? remark;
  final String? paidAt;
  final String expiredAt;
  final String createdAt;
  final String? customerPan;
  final String? merchantPan;
  final String? acquirerName;
  final String? issuerName;
  final String? acquirerId;
  final String? issuerId;

  QrisDataModel({
    required this.amount,
    this.paymentUrl,
    this.content,
    this.returnUrl,
    required this.status,
    this.rrn,
    required this.reff,
    this.clientReff,
    this.name,
    this.remark,
    this.paidAt,
    required this.expiredAt,
    required this.createdAt,
    this.customerPan,
    this.merchantPan,
    this.acquirerName,
    this.issuerName,
    this.acquirerId,
    this.issuerId,
  });

  factory QrisDataModel.fromJson(Map<String, dynamic> json) {
    return QrisDataModel(
      amount: json['amount'] ?? 0,
      paymentUrl: json['payment_url'],
      content: json['content'],
      returnUrl: json['return_url'],
      status: json['status'] ?? '',
      rrn: json['rrn'],
      reff: json['reff'] ?? '',
      clientReff: json['client_reff'],
      name: json['name'],
      remark: json['remark'],
      paidAt: json['paid_at'],
      expiredAt: json['expired_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      customerPan: json['customer_pan'],
      merchantPan: json['merchant_pan'],
      acquirerName: json['acquirer_name'],
      issuerName: json['issuer_name'],
      acquirerId: json['acquirer_id'],
      issuerId: json['issuer_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'payment_url': paymentUrl,
      'content': content,
      'return_url': returnUrl,
      'status': status,
      'rrn': rrn,
      'reff': reff,
      'client_reff': clientReff,
      'name': name,
      'remark': remark,
      'paid_at': paidAt,
      'expired_at': expiredAt,
      'created_at': createdAt,
      'customer_pan': customerPan,
      'merchant_pan': merchantPan,
      'acquirer_name': acquirerName,
      'issuer_name': issuerName,
      'acquirer_id': acquirerId,
      'issuer_id': issuerId,
    };
  }
}
