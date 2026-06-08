class SelectModel {
  bool isEnable;
  String name;

  SelectModel({this.isEnable = true, this.name = ''});

  factory SelectModel.fromJson(Map<String, dynamic> json) {
    return SelectModel(
      isEnable: json['isEnable'] ?? true,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'isEnable': isEnable, 'name': name};
  }
}
