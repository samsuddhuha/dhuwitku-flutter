// import 'package:inacash_bisnis/network/remotedata/transaction/model/qris_data_model.dart';

// class QrisModel {
//   final QrisDataModel data;
//   final String reff;
//   final String clientReff;
//   final String productCode;

//   QrisModel({
//     required this.data,
//     required this.reff,
//     required this.clientReff,
//     required this.productCode,
//   });

//   factory QrisModel.fromJson(Map<String, dynamic> json) {
//     return QrisModel(
//       data: QrisDataModel.fromJson(json['data']),
//       reff: json['reff'] as String,
//       clientReff: json['client_reff'] as String,
//       productCode: json['product_code'] as String,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'data': data.toJson(),
//       'reff': reff,
//       'client_reff': clientReff,
//       'product_code': productCode,
//     };
//   }
// }
