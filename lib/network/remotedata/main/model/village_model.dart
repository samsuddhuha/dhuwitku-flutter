class VillageModel {
  String id;
  String subDistrictCode;
  String name;

  VillageModel({this.id = '', this.subDistrictCode = '', this.name = ''});

  factory VillageModel.fromJson(Map<String, dynamic> json) {
    return VillageModel(
      id: json['id'] ?? '',
      subDistrictCode: json['district_code'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'district_code': subDistrictCode, 'name': name};
  }
}
