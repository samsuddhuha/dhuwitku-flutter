class MerchantModel {
  final int id;
  final String? raw;
  final String name;
  final String? nmid;
  final String? barcodeImage;
  final String? printImage;
  final String? key;
  final String? secret;
  final String? notifyTelegram;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final String? notifyEmail;
  final String mpan;
  final String mid;
  final String? city;
  final String postalCode;
  final String criteria;
  final int? mcc;
  final int? terminalNumber;
  final String merchantType;
  final String? npwp;
  final String nik;
  final String qrType;
  final String? deletedAt;
  final String? accountVendor;
  final String? accountNumber;
  final String? accountName;

  MerchantModel({
    required this.id,
    this.raw,
    required this.name,
    this.nmid,
    this.barcodeImage,
    this.printImage,
    this.key,
    this.secret,
    this.notifyTelegram,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.notifyEmail,
    required this.mpan,
    required this.mid,
    this.city,
    required this.postalCode,
    required this.criteria,
    this.mcc,
    this.terminalNumber,
    required this.merchantType,
    this.npwp,
    required this.nik,
    required this.qrType,
    this.deletedAt,
    this.accountVendor,
    this.accountNumber,
    this.accountName,
  });

  factory MerchantModel.fromJson(Map<String, dynamic> json) {
    return MerchantModel(
      id: json['id'],
      raw: json['raw'],
      name: json['name'],
      nmid: json['nmid'],
      barcodeImage: json['barcode_image'],
      printImage: json['print_image'],
      key: json['key'],
      secret: json['secret'],
      notifyTelegram: json['notify_telegram'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      notifyEmail: json['notify_email'],
      mpan: json['mpan'],
      mid: json['mid'],
      city: json['city'],
      postalCode: json['postal_code'],
      criteria: json['criteria'],
      mcc: json['mcc'],
      terminalNumber: json['terminal_number'],
      merchantType: json['merchant_type'],
      npwp: json['npwp'],
      nik: json['nik'],
      qrType: json['qr_type'],
      deletedAt: json['deleted_at'],
      accountVendor: json['account_vendor'],
      accountNumber: json['account_number'],
      accountName: json['account_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'raw': raw,
      'name': name,
      'nmid': nmid,
      'barcode_image': barcodeImage,
      'print_image': printImage,
      'key': key,
      'secret': secret,
      'notify_telegram': notifyTelegram,
      'user_id': userId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'notify_email': notifyEmail,
      'mpan': mpan,
      'mid': mid,
      'city': city,
      'postal_code': postalCode,
      'criteria': criteria,
      'mcc': mcc,
      'terminal_number': terminalNumber,
      'merchant_type': merchantType,
      'npwp': npwp,
      'nik': nik,
      'qr_type': qrType,
      'deleted_at': deletedAt,
      'account_vendor': accountVendor,
      'account_number': accountNumber,
      'account_name': accountName,
    };
  }
}
