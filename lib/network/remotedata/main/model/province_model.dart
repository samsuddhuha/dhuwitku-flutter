class ProvinceModel {
  String id;
  String name;

  ProvinceModel({this.id = '', this.name = ''});

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(id: json['id'] ?? '', name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
