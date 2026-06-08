class PriceTypeModel {
  final int id;
  final String name;

  PriceTypeModel({required this.id, required this.name});

  factory PriceTypeModel.fromJson(Map<String, dynamic> json) {
    return PriceTypeModel(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
