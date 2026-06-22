class DhuwitAmplopCountDetail {
  final int count;
  final int total;

  DhuwitAmplopCountDetail({required this.count, required this.total});

  factory DhuwitAmplopCountDetail.fromJson(Map<String, dynamic> json) {
    return DhuwitAmplopCountDetail(
      count: _parseInt(json['count']),
      total: _parseInt(json['total']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'count': count, 'total': total};
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }
}
