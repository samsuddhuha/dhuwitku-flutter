// import 'package:camera/camera.dart';
// import 'package:dio/dio.dart';
// import 'package:inacash_bisnis/core/base/base_response.dart';
// import 'package:inacash_bisnis/network/config/app_client.dart';

// class UserRemoteData {
//   final _client = AppClient.instance;

//   Future<Map<String, dynamic>> registerMerchant({
//     required String name,
//     required String city,
//     required String postalCode,
//     required String criteria,
//     required String merchantType,
//     required String npwp,
//     required String nik,
//     required String accountNumber,
//     required String accountVendor,
//     required String accountName,
//     required XFile identityImage,
//     XFile? storeImage1,
//     XFile? storeImage2,
//     XFile? storeImage3,
//   }) async {
//     try {
//       final formData = FormData.fromMap({
//         "name": name,
//         "city": city,
//         "postal_code": postalCode,
//         "criteria": criteria,
//         "merchant_type": merchantType,
//         "npwp": npwp,
//         "nik": nik,
//         "account_number": accountNumber,
//         "account_vendor": accountVendor,
//         "account_name": accountName,

//         "identity_image": await MultipartFile.fromFile(
//           identityImage.path,
//           filename: identityImage.path.split('/').last,
//         ),

//         if (storeImage1 != null)
//           "store_image_1": await MultipartFile.fromFile(
//             storeImage1.path,
//             filename: storeImage1.path.split('/').last,
//           ),
//         if (storeImage2 != null)
//           "store_image_2": await MultipartFile.fromFile(
//             storeImage2.path,
//             filename: storeImage2.path.split('/').last,
//           ),
//         if (storeImage3 != null)
//           "store_image_3": await MultipartFile.fromFile(
//             storeImage3.path,
//             filename: storeImage3.path.split('/').last,
//           ),
//       });

//       final response = await _client.dioMain.post(
//         'user/register_qris',
//         data: formData,
//         options: Options(contentType: 'multipart/form-data'),
//       );

//       return BaseResponse.handle(response.data);
//     } on DioException catch (e) {
//       throw Exception(e.response?.data['message'] ?? 'failed');
//     }
//   }

//   Future<Map<String, dynamic>> getUserProfile() async {
//     try {
//       final response = await _client.dioMain.post('user/profile');
//       return BaseResponse.handle(response.data);
//     } on DioException catch (e) {
//       throw Exception(e.response?.data['message'] ?? 'failed');
//     }
//   }

//   Future<Map<String, dynamic>> getBalance({
//     required String startDate,
//     required String endDate,
//   }) async {
//     try {
//       final response = await _client.dioMainV2.get(
//         'user/balance',
//         queryParameters: {'start_date': startDate, 'end_date': endDate},
//       );
//       return BaseResponse.handle(response.data);
//     } on DioException catch (e) {
//       throw Exception(e.response?.data['message'] ?? 'failed');
//     }
//   }

//   Future<Map<String, dynamic>> getPinStatus() async {
//     try {
//       final response = await _client.dioMain.post('user/pin/status');
//       return BaseResponse.handle(response.data);
//     } on DioException catch (e) {
//       throw Exception(e.response?.data['message'] ?? 'failed');
//     }
//   }

//   Future<Map<String, dynamic>> getBalanceMutation({
//     required String startDate,
//     required String endDate,
//   }) async {
//     try {
//       final response = await _client.dioMain.post(
//         'user/balance_mutation',
//         data: {'start_date': startDate, 'end_date': endDate},
//       );
//       return BaseResponse.handle(response.data);
//     } on DioException catch (e) {
//       throw Exception(e.response?.data['message'] ?? 'failed');
//     }
//   }

//   Future<Map<String, dynamic>> updatePin({
//     required String newPin,
//     required String oldPin,
//   }) async {
//     try {
//       final response = await _client.dioMain.post(
//         'user/pin/update',
//         data: {'old_pin': oldPin, 'new_pin': newPin},
//       );
//       return BaseResponse.handle(response.data);
//     } on DioException catch (e) {
//       throw Exception(e.response?.data['message'] ?? 'failed');
//     }
//   }

//   Future<Map<String, dynamic>> editPassword({
//     required String oldPassword,
//     required String newPassword,
//   }) async {
//     try {
//       final response = await _client.dioMainV2.post(
//         'user/password/change',
//         data: {'old_password': oldPassword, 'new_password': newPassword},
//       );
//       return BaseResponse.handle(response.data);
//     } on DioException catch (e) {
//       throw Exception(e.response?.data['message'] ?? 'failed');
//     }
//   }

//   Future<Map<String, dynamic>> resetPassword({required String email}) async {
//     try {
//       final response = await _client.dioAuth.post(
//         'user/reset_password',
//         data: {'email': email},
//       );
//       return BaseResponse.handle(response.data);
//     } on DioException catch (e) {
//       throw Exception(e.response?.data['message'] ?? 'failed');
//     }
//   }

//   Future<void> deleteAccount({
//     required int id,
//     required String name,
//     required String email,
//   }) async {
//     try {
//       await _client.dioDeleteAccount.post(
//         '/exec',
//         data: {'id': id, 'name': name, 'email': email},
//       );
//     } on DioException catch (e) {
//       throw Exception(
//         e.response?.data?['message'] ?? 'Failed to delete account',
//       );
//     }
//   }
// }
