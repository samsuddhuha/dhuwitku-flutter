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

  Future<Map<String, dynamic>> getDhuwitSummary({
    required int month,
    required int year,
  }) async {
    try {
      final response = await _client.dioMain.post(
        'dashboard/dhuwit-summary',
        data: {'month': month, 'year': year},
      );

      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'failed');
    }
  }
}
