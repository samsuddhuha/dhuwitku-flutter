// import 'package:inacash_bisnis/network/remotedata/withdrawal/model/inquiry_detail_model.dart';

// class InquiryModel {
//   final InquiryDetailModel item;
//   final String raw;
//   final String reff;
//   final String? clientReff;

//   InquiryModel({
//     required this.item,
//     required this.raw,
//     required this.reff,
//     this.clientReff,
//   });

//   factory InquiryModel.fromJson(Map<String, dynamic> json) {
//     return InquiryModel(
//       item: InquiryDetailModel.fromJson(json['item']),
//       raw: json['raw'] as String,
//       reff: json['reff'] as String,
//       clientReff: json['client_reff'] as String?,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'item': item.toJson(),
//       'raw': raw,
//       'reff': reff,
//       'client_reff': clientReff,
//     };
//   }
// }
