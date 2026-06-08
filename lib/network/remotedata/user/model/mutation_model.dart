class MutationModel {
  final int id;
  final String? info;
  final int debit;
  final int credit;
  final int total;
  final String? prosesBy;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final String? clientReff;
  final String? reff;

  MutationModel({
    required this.id,
    this.info,
    required this.debit,
    required this.credit,
    required this.total,
    this.prosesBy,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.clientReff,
    this.reff,
  });

  factory MutationModel.fromJson(Map<String, dynamic> json) {
    return MutationModel(
      id: json['id'],
      info: json['info'],
      debit: json['debit'],
      credit: json['credit'],
      total: json['total'],
      prosesBy: json['prosesby'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      clientReff: json['client_reff'],
      reff: json['reff'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'info': info,
      'debit': debit,
      'credit': credit,
      'total': total,
      'prosesby': prosesBy,
      'user_id': userId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'client_reff': clientReff,
      'reff': reff,
    };
  }
}
