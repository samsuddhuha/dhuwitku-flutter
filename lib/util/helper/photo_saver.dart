import 'package:flutter/services.dart';

class PhotoSaver {
  static const _channel = MethodChannel('photo_saver');

  static Future<void> saveImage(Uint8List bytes) async {
    await _channel.invokeMethod('saveImage', bytes);
  }
}
