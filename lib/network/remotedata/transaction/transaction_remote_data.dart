// import 'package:dio/dio.dart';
// import 'package:inacash_bisnis/core/base/base_response.dart';
// import 'package:inacash_bisnis/network/config/app_client.dart';
// import 'package:inacash_bisnis/util/extension/date_extension.dart';

// class TransactionRemoteData {
//   final _client = AppClient.instance;

//   Future<Map<String, dynamic>> historyCashIn({
//     required int page,
//     required String startDate,
//     required String endDate,
//     String? userQrisId,
//   }) async {
//     try {
//       final response = await _client.dioMainV2.get(
//         'transaction/cashin/history',
//         queryParameters: {
//           'page': page,
//           'per_page': 20,
//           'start_date': startDate,
//           'end_date': endDate,
//           if (userQrisId != null) 'user_qris_id': userQrisId,
//         },
//       );

//       return BaseResponse.handle(response.data);
//     } on DioException catch (e) {
//       throw Exception(e.response?.data['message'] ?? 'failed');
//     }
//   }

//   Future<Map<String, dynamic>> historyCashOut({
//     required int page,
//     required String startDate,
//     required String endDate,
//   }) async {
//     try {
//       final response = await _client.dioMainV2.get(
//         'transaction/cashout/history',
//         queryParameters: {
//           'page': page,
//           'per_page': 20,
//           'start_date': startDate,
//           'end_date': endDate,
//         },
//       );

//       return BaseResponse.handle(response.data);
//     } on DioException catch (e) {
//       throw Exception(e.response?.data['message'] ?? 'failed');
//     }
//   }

//   Future<Map<String, dynamic>> createCashIn({
//     required int amount,
//     required String mid,
//   }) async {
//     try {
//       String clientReff = '$mid-${DateTime.now().getCurrentTimestamp()}';
//       final response = await _client.dioMain.post(
//         'transaction/cashin/create',
//         data: {
//           'product_code': 'QRIS_DIRECT',
//           'amount': amount,
//           'remark': '',
//           'client_reff': clientReff,
//           'expiry_time': '5',
//           'return_url': '',
//           'merchant_id': mid,
//         },
//       );

//       return BaseResponse.handle(response.data);
//     } on DioException catch (e) {
//       throw Exception(e.response?.data['message'] ?? 'failed');
//     }
//   }

//   Future<Map<String, dynamic>> checkCashIn({
//     required String reff,
//     required String clientReff,
//   }) async {
//     try {
//       final response = await _client.dioMain.post(
//         'transaction/cashin/check',
//         data: {'reff': reff, 'client_reff': clientReff},
//       );

//       return BaseResponse.handle(response.data);
//     } on DioException catch (e) {
//       throw Exception(e.response?.data['message'] ?? 'failed');
//     }
//   }
// }
