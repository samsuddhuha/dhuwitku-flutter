import 'package:dhuwitku/core/base/base_response.dart';
import 'package:dhuwitku/network/config/app_client.dart';
import 'package:dio/dio.dart';

class AuthRemoteData {
  final _client = AppClient.instance;

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required String fcm,
  }) async {
    try {
      final response = await _client.dioAuth.post(
        'login',
        data: {'email': email, 'password': password, 'fcm': fcm},
      );

      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ??
            'ERROR: ${e.type} || ${e.message} || ${e.response}',
      );
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.dioAuth.post(
        'register',
        data: {'name': name, 'email': email, 'password': password},
      );

      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'failed');
    }
  }

  Future<Map<String, dynamic>> checkAccount({required String email}) async {
    try {
      final response = await _client.dioAuth.post(
        'check-account',
        data: {'email': email},
      );

      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'failed');
    }
  }

  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.dioAuth.post(
        'reset-password',
        data: {'email': email, 'password': password},
      );

      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'failed');
    }
  }
}
