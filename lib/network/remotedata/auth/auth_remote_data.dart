import 'package:dhuwitku/core/base/base_response.dart';
import 'package:dhuwitku/network/config/app_client.dart';
import 'package:dhuwitku/network/remotedata/auth/model/register_user_model.dart';
import 'package:dio/dio.dart';

class AuthRemoteData {
  final _client = AppClient.instance;

  Future<bool> validateUser(String email) async {
    try {
      final response = await _client.dioDeleteAccount.get(
        '/exec',
        queryParameters: {'email': email},
        options: Options(
          validateStatus: (status) => status != null && status < 400,
        ),
      );

      if (response.data is Map) {
        return response.data['found'] == true;
      }

      return false;
    } on DioException {
      return false;
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required String fcm,
  }) async {
    try {
      final response = await _client.dioAuth.post(
        'user/login',
        data: {'email': email, 'password': password, 'fcmtoken': fcm},
      );

      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'failed');
    }
  }

  Future<Map<String, dynamic>> register({
    required RegisterUserModel registerData,
  }) async {
    try {
      final response = await _client.dioAuth.post(
        'user/register',
        data: registerData.toJson(),
      );

      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'failed');
    }
  }
}
