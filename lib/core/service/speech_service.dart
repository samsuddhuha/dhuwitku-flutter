import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  SpeechService._();

  static final SpeechService instance = SpeechService._();

  final SpeechToText _speech = SpeechToText();

  bool _isInitialized = false;
  String? _localeId;
  Timer? _silenceTimer;
  String _lastWords = '';

  bool get isListening => _speech.isListening;

  Future<bool> initSpeech() async {
    if (_isInitialized) return true;

    final available = await _speech.initialize();

    if (!available) {
      return false;
    }

    _isInitialized = true;

    final locales = await _speech.locales();

    final indonesiaLocale = locales
        .where((locale) {
          final id = locale.localeId.toLowerCase();
          return id.startsWith('id');
        })
        .cast()
        .cast<dynamic>()
        .firstOrNull;

    if (indonesiaLocale != null) {
      _localeId = indonesiaLocale.localeId;
      print('Using detected locale: $_localeId');
    } else {
      _localeId = 'id-ID';
      print('No Indonesian locale found, fallback to $_localeId');
    }
    return true;
  }

  Future<void> startListening({
    required Function(String text) onResult,
    VoidCallback? onStop,
  }) async {
    if (!_isInitialized) {
      final success = await initSpeech();

      if (!success) {
        throw Exception('Speech recognition is not available');
      }
    }

    await _speech.listen(
      listenOptions: SpeechListenOptions(localeId: _localeId),
      onResult: (result) {
        if (result.recognizedWords == _lastWords) {
          return;
        }

        _lastWords = result.recognizedWords;
        onResult(result.recognizedWords);

        _silenceTimer?.cancel();

        _silenceTimer = Timer(Duration(seconds: 3), () async {
          _lastWords = '';
          await _speech.stop();
          onStop?.call();
        });
      },
    );
  }

  Future<void> stopListening() async {
    _lastWords = '';
    await _speech.stop();
  }
}
