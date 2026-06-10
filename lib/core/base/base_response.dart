class BaseResponse {
  static Map<String, dynamic> handle(Map<String, dynamic> json) {
    final code = json['code'];
    final message = json['message'];

    if (code == '200') {
      return json;
    }

    final errorMessage = _extractFirstError(json);

    if (errorMessage != null) {
      throw Exception(errorMessage);
    }

    throw Exception(message ?? 'Terjadi kesalahan');
  }

  static String? _extractFirstError(Map<String, dynamic> json) {
    try {
      final data = json['data'];
      if (data == null) return null;

      final error = data['error'];
      if (error == null) return null;

      final firstKey = error.keys.first;

      final firstList = error[firstKey];
      if (firstList is List && firstList.isNotEmpty) {
        return firstList.first.toString();
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
