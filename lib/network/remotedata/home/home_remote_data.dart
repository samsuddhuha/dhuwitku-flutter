import 'package:dhuwitku/core/base/base_response.dart';
import 'package:dhuwitku/network/config/app_client.dart';
import 'package:dio/dio.dart';

class HomeRemoteData {
  final _client = AppClient.instance;

  Future<Map<String, dynamic>> getDashboardSummary() async {
    try {
      final response = await _client.dioMain.get('dashboard');
      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'failed');
    }
  }
}
