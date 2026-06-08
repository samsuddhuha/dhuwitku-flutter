// import 'package:dio/dio.dart';
// import 'package:inacash_bisnis/core/base/base_response.dart';
// import 'package:inacash_bisnis/network/config/app_client.dart';
// import 'package:inacash_bisnis/util/extension/date_extension.dart';

// class WithdrawalRemoteData {
//   final _client = AppClient.instance;

//   Future<Map<String, dynamic>> getProducts() async {
//     try {
//       final response = await _client.dioMain.post('product');

//       return BaseResponse.handle(response.data);
//     } on DioException catch (e) {
//       throw Exception(e.response?.data['message'] ?? 'failed');
//     }
//   }

//   Future<Map<String, dynamic>> inquiryCashOut({
//     required String productCode,
//     required String number,
//     required String amount,
//     required String userID,
//   }) async {
//     try {
//       String clientReff = '$userID-${DateTime.now().getCurrentTimestamp()}';
//       final response = await _client.dioMain.post(
//         'transaction/inquiry',
//         data: {
//           'product_code': productCode,
//           'amount': amount,
//           'custno': number,
//           'client_reff': clientReff,
//         },
//       );

//       return BaseResponse.handle(response.data);
//     } on DioException catch (e) {
//       throw Exception(e.response?.data['message'] ?? 'failed');
//     }
//   }

//   Future<Map<String, dynamic>> paymentCashOut({
//     required String reff,
//     required String pin,
//   }) async {
//     try {
//       final response = await _client.dioMain.post(
//         'transaction/payment',
//         data: {'reff': reff, 'pin': pin},
//       );

//       return BaseResponse.handle(response.data);
//     } on DioException catch (e) {
//       throw Exception(e.response?.data['message'] ?? 'failed');
//     }
//   }
// }
