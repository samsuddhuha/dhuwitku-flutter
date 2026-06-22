import 'package:dhuwitku/core/base/base_response.dart';
import 'package:dhuwitku/network/config/app_client.dart';
import 'package:dio/dio.dart';

class ReportRemoteData {
  final _client = AppClient.instance;

  Future<Map<String, dynamic>> getDhuwitHistory({
    int? limit,
    int? month,
    int? year,
  }) async {
    try {
      final data = <String, dynamic>{};

      if (limit != null) {
        data['limit'] = limit;
      }

      if (month != null && year != null) {
        data['month'] = month;
        data['year'] = year;
      }

      final response = await _client.dioMain.post(
        'dhuwit/list',
        data: data.isEmpty ? null : data,
      );

      return BaseResponse.handle(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'failed');
    }
  }
}
