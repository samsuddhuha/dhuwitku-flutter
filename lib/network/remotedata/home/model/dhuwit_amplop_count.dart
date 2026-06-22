import 'package:dhuwitku/network/remotedata/home/model/dhuwit_amplop_count_detail.dart';

class DhuwitAmplopCount {
  final DhuwitAmplopCountDetail? inCount;
  final DhuwitAmplopCountDetail? outCount;

  DhuwitAmplopCount({this.inCount, this.outCount});

  factory DhuwitAmplopCount.fromJson(Map<String, dynamic> json) {
    return DhuwitAmplopCount(
      inCount: json['in'] != null && json['in'] is Map
          ? DhuwitAmplopCountDetail.fromJson(json['in'])
          : null,
      outCount: json['out'] != null && json['out'] is Map
          ? DhuwitAmplopCountDetail.fromJson(json['out'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'in': inCount?.toJson(), 'out': outCount?.toJson()};
  }
}
