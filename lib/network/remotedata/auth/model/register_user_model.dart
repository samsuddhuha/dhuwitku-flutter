class RegisterUserModel {
  String fullname;
  String email;
  String phone;
  int provinceID;
  int cityID;
  int districtID;
  int villageID;
  String address;
  String password;
  String referal;

  RegisterUserModel({
    this.fullname = '',
    this.email = '',
    this.phone = '',
    this.provinceID = 0,
    this.cityID = 0,
    this.districtID = 0,
    this.villageID = 0,
    this.address = '',
    this.password = '',
    this.referal = '',
  });

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) {
    return RegisterUserModel(
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      provinceID: json['province_id'] ?? 0,
      cityID: json['city_id'] ?? 0,
      districtID: json['district_id'] ?? 0,
      villageID: json['village_id'] ?? 0,
      address: json['address'] ?? '',
      password: json['password'] ?? '',
      referal: json['referal'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'province_id': provinceID,
      'city_id': cityID,
      'district_id': districtID,
      'village_id': villageID,
      'address': address,
      'password': password,
      'referal': referal,
    };
  }
}
