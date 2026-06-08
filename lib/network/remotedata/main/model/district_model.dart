class DistrictModel {
  String id;
  String cityCode;
  String name;

  DistrictModel({
    this.id = '',
    this.cityCode = '',
    this.name = '',
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json['id'] ?? '',
      cityCode: json['city_code'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city_code': cityCode,
      'name': name,
    };
  }
}
