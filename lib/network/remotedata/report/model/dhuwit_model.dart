class DhuwitModel {
  final int? id;
  final int? idUser;
  final String? dateDhuwit;
  final int? nominal;
  final int? status;
  final String? information;

  DhuwitModel({
    this.id,
    this.idUser,
    this.dateDhuwit,
    this.nominal,
    this.status,
    this.information,
  });

  factory DhuwitModel.fromJson(Map<String, dynamic> json) {
    return DhuwitModel(
      id: json['id'],
      idUser: json['id_user'],
      dateDhuwit: json['date_dhuwit'],
      nominal: json['nominal'],
      status: json['status'],
      information: json['information'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_user': idUser,
      'date_dhuwit': dateDhuwit,
      'nominal': nominal,
      'status': status,
      'information': information,
    };
  }
}
