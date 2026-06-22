import 'package:dhuwitku/core/base/base_response.dart';
import 'package:dhuwitku/network/config/app_client.dart';
import 'package:dio/dio.dart';

class ReportRemoteData {
  final _client = AppClient.instance;

  Future<Map<String, dynamic>> getDhuwitHistory({int? limit}) async {
    try {
      final response = await _client.dioMain.post(
        'dhuwit/list',
        queryParameters: limit != null ? {'limit': limit} : null,
      );

      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'failed');
    }
  }
}
