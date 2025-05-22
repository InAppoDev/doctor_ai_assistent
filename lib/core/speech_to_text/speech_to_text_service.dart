import 'dart:async';

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextService {
  final SpeechToText _speechToText = SpeechToText();
  bool isListening = false;
  Function(String)? onTranscription;

  // Initialize the speech service
  Future<void> init() async {
    bool available = await _speechToText.initialize();
    if (!available) {}
  }

  // Start listening for speech input
  Future<void> startListening(
      Function(SpeechRecognitionResult) onResult) async {
    if (!_speechToText.isAvailable || _speechToText.isListening) return;

    _speechToText.listen(
      onResult: onResult,
      listenOptions: SpeechListenOptions(
        listenMode: ListenMode.confirmation,
        cancelOnError: true,
      ),
    );
    isListening = true;

    _speechToText.statusListener = (status) {
      if (isListening && (status == 'done' || status == 'notListening')) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (isListening && !_speechToText.isListening) {
            _startListening(onResult);
          }
        });
      }
    };
  }

  // Stop listening and reset state
  void stopListening() {
    _speechToText.stop();
    isListening = false;
  }

  // Cancel listening process if needed
  void cancelListening() {
    _speechToText.cancel();
    isListening = false;
  }

  // Private method to start listening again
  void _startListening(Function(SpeechRecognitionResult) onResult) {
    _speechToText.listen(
      onResult: onResult,
      listenOptions: SpeechListenOptions(
        listenMode: ListenMode.confirmation,
        cancelOnError: true,
      ),
    );
    isListening = true;
  }
}
