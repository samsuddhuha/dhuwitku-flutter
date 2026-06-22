import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  SpeechService._();

  static final SpeechService instance = SpeechService._();

  final SpeechToText _speech = SpeechToText();

  bool _isInitialized = false;
  String? _localeId;

  bool get isListening => _speech.isListening;

  Future<bool> initSpeech() async {
    if (_isInitialized) return true;

    final available = await _speech.initialize();

    if (!available) {
      return false;
    }

    _isInitialized = true;

    final locales = await _speech.locales();

    // Debug: lihat semua locale yang tersedia
    for (final locale in locales) {
      print('Speech locale: ${locale.localeId} - ${locale.name}');
    }

    // Cari bahasa Indonesia
    final indonesiaLocale = locales.where((locale) {
      final id = locale.localeId.toLowerCase();

      return id == 'id_id' || id == 'id-id' || id.startsWith('id');
    });

    if (indonesiaLocale.isNotEmpty) {
      _localeId = indonesiaLocale.first.localeId;
      print('Using locale: $_localeId');
    } else {
      print('Indonesian locale not found. Using browser default language.');
    }

    return true;
  }

  Future<void> startListening({required Function(String text) onResult}) async {
    if (!_isInitialized) {
      final success = await initSpeech();

      if (!success) {
        throw Exception('Speech recognition is not available');
      }
    }

    await _speech.listen(
      listenOptions: SpeechListenOptions(localeId: _localeId),
      onResult: (result) {
        onResult(result.recognizedWords);
      },
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
  }
}
