class CityModel {
  String id;
  String provinceCode;
  String name;

  CityModel({this.id = '', this.provinceCode = '', this.name = ''});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] ?? '',
      provinceCode: json['province_code'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'province_code': provinceCode, 'name': name};
  }
}
