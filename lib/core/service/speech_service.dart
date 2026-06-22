import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  SpeechService._();

  static final SpeechService instance = SpeechService._();

  final SpeechToText speech = SpeechToText();

  Future<bool> initSpeech() async {
    return await speech.initialize();
  }

  Future<void> startListening({required Function(String text) onResult}) async {
    await speech.listen(
      listenOptions: SpeechListenOptions(localeId: 'id_ID'),
      onResult: (result) {
        onResult(result.recognizedWords);
      },
    );
  }

  Future<void> stopListening() async {
    await speech.stop();
  }

  bool get isListening => speech.isListening;
}
