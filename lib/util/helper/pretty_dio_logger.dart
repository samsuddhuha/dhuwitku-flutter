import 'package:dio/dio.dart';

class PrettyDioLogger extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _printLong(
      '✅ RESPONSE [${response.statusCode}] => ${response.requestOptions.uri}',
    );
    _printLong(response.data.toString());
    super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _printLong('➡️ REQUEST [${options.method}] => ${options.uri}');
    _printLong('Headers: ${options.headers}');
    if (options.data != null) _printLong('Body: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _printLong('❌ ERROR => ${err.message}');
    if (err.response != null) _printLong(err.response!.data.toString());
    super.onError(err, handler);
  }

  void _printLong(String text) {
    const chunkSize = 800;
    for (var i = 0; i < text.length; i += chunkSize) {
      print(
        text.substring(
          i,
          i + chunkSize > text.length ? text.length : i + chunkSize,
        ),
      );
    }
  }
}
