import 'package:dhuwitku/core/session/session.dart';
import 'package:dhuwitku/network/config/app_config.dart';
import 'package:dhuwitku/util/helper/pretty_dio_logger.dart';
import 'package:dio/dio.dart';

class AppClient {
  AppClient._();

  static final AppClient instance = AppClient._();

  late Dio dioAuth;
  late Dio dioMain;

  Future<void> init() async {
    dioAuth = await _createBaseDio(baseUrl);
    dioMain = await _createBaseDio(baseUrl, withAuth: true);
  }

  Future<Dio> _createBaseDio(String baseUrl, {bool withAuth = false}) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (withAuth) {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            final token = Session.instance.token;
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            handler.next(options);
          },
        ),
      );
    }

    dio.interceptors.add(PrettyDioLogger());

    return dio;
  }

  // (Google Script)
  static const String baseUrlDeleteAccount =
      'https://script.google.com/macros/s/AKfycby6k8eNalDIliv4Myj3QUhxTgLIKpZjrOP6a3_VhudHhlYE7SvsXIT44uL_yx6nzoMzmw';

  late final Dio dioDeleteAccount = Dio(
    BaseOptions(
      baseUrl: baseUrlDeleteAccount,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      validateStatus: (status) {
        return status != null && status < 400;
      },
      followRedirects: true,
    ),
  )..interceptors.add(PrettyDioLogger());
}
