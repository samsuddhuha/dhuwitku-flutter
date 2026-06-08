class UserModel {
  final int id;
  final String fullname;
  final String email;
  final String phone;
  final String? info;
  final String? referal;
  final String? avatar;
  final String? born;
  final String? gender;
  final int roleId;
  final int mobileAppId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int? addressId;
  final int? priceGroupId;
  final String? fcmToken;
  final int? ktpAddressId;
  final String? referal1;
  final String? referal2;
  final String? referal3;
  final String? referal4;
  final String? referal5;
  final String? pin;
  final String? urlCallback;
  final String? ips;
  final String? urlCallbackCashin;

  UserModel({
    required this.id,
    required this.fullname,
    required this.email,
    required this.phone,
    this.info,
    this.referal,
    this.avatar,
    this.born,
    this.gender,
    required this.roleId,
    required this.mobileAppId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.addressId,
    this.priceGroupId,
    this.fcmToken,
    this.ktpAddressId,
    this.referal1,
    this.referal2,
    this.referal3,
    this.referal4,
    this.referal5,
    this.pin,
    this.urlCallback,
    this.ips,
    this.urlCallbackCashin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      phone: json['phone'],
      info: json['info'],
      referal: json['referal'],
      avatar: json['avatar'],
      born: json['born'],
      gender: json['gender'],
      roleId: json['role_id'],
      mobileAppId: json['mobile_app_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      addressId: json['address_id'],
      priceGroupId: json['price_group_id'],
      fcmToken: json['fcm_token'],
      ktpAddressId: json['ktp_address_id'],
      referal1: json['referal_1'],
      referal2: json['referal_2'],
      referal3: json['referal_3'],
      referal4: json['referal_4'],
      referal5: json['referal_5'],
      pin: json['pin'],
      urlCallback: json['url_callback'],
      ips: json['ips'],
      urlCallbackCashin: json['url_callback_cashin'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullname': fullname,
    'email': email,
    'phone': phone,
    'info': info,
    'referal': referal,
    'avatar': avatar,
    'born': born,
    'gender': gender,
    'role_id': roleId,
    'mobile_app_id': mobileAppId,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'deleted_at': deletedAt,
    'address_id': addressId,
    'price_group_id': priceGroupId,
    'fcm_token': fcmToken,
    'ktp_address_id': ktpAddressId,
    'referal_1': referal1,
    'referal_2': referal2,
    'referal_3': referal3,
    'referal_4': referal4,
    'referal_5': referal5,
    'pin': pin,
    'url_callback': urlCallback,
    'ips': ips,
    'url_callback_cashin': urlCallbackCashin,
  };
}
