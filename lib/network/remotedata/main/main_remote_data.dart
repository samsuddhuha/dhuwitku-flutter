import 'package:dhuwitku/core/base/base_response.dart';
import 'package:dhuwitku/network/config/app_client.dart';
import 'package:dio/dio.dart';

class MainRemoteData {
  final _client = AppClient.instance;

  Future<Map<String, dynamic>> getBank() async {
    try {
      final response = await _client.dioMain.get('bank/list');

      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'failed');
    }
  }

  Future<Map<String, dynamic>> getProvince() async {
    try {
      final response = await _client.dioAuth.post('address/provinces');

      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'failed');
    }
  }

  Future<Map<String, dynamic>> getCity({required String provinceID}) async {
    try {
      final response = await _client.dioAuth.post(
        'address/cities',
        data: {'id': provinceID},
      );

      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'failed');
    }
  }

  Future<Map<String, dynamic>> getDistrict({required String cityID}) async {
    try {
      final response = await _client.dioAuth.post(
        'address/districts',
        data: {'id': cityID},
      );

      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'failed');
    }
  }

  Future<Map<String, dynamic>> getVillage({required String districtID}) async {
    try {
      final response = await _client.dioAuth.post(
        'address/villages',
        data: {'id': districtID},
      );

      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'failed');
    }
  }
}
