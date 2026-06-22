import 'package:dhuwitku/core/base/base_response.dart';
import 'package:dhuwitku/network/config/app_client.dart';
import 'package:dio/dio.dart';

class DhuwitRemoteData {
  final _client = AppClient.instance;

  Future<Map<String, dynamic>> createFromText({
    required String speechText,
  }) async {
    try {
      final response = await _client.dioMain.post(
        "dhuwit/create-from-text",
        data: {"text": speechText},
      );
      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'failed');
    }
  }

  Future<Map<String, dynamic>> submitDhuwit({
    required int status,
    required int nominal,
    required String dateTime,
    required String information,
  }) async {
    try {
      final response = await _client.dioMain.post(
        "dhuwit/create",
        data: {
          "date_dhuwit": dateTime,
          "nominal": nominal,
          "status": status,
          "information": information,
        },
      );
      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'failed');
    }
  }

  Future<Map<String, dynamic>> updateDhuwit({
    required String id,
    required int status,
    required int nominal,
    required String dateTime,
    required String information,
  }) async {
    try {
      final response = await _client.dioMain.post(
        "dhuwit/update",
        data: {
          "id": id,
          "date_dhuwit": dateTime,
          "nominal": nominal,
          "status": status,
          "information": information,
        },
      );
      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'failed');
    }
  }

  Future<Map<String, dynamic>> daleteDhuwit({required String id}) async {
    try {
      final response = await _client.dioMain.post(
        "dhuwit/delete",
        data: {"id": id},
      );
      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'failed');
    }
  }
}
