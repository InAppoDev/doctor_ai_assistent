import 'dart:async';
import 'dart:math';

import 'package:ecnx_ambient_listening/core/network/network.dart';
import 'package:ecnx_ambient_listening/core/speech_to_text/speech_to_text_service.dart';
import 'package:ecnx_ambient_listening/core/web_socket/web_socket_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordProvider extends ChangeNotifier {
  final SpeechToTextService _speechService = SpeechToTextService();
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final StreamController<Uint8List> _audioStreamController =
      StreamController<Uint8List>();
  final List<String> recordedText = [];

  late final SharedPreferences _prefs;
  late final WebSocketService _socketService;
  late final Network _network;

  String? _audioFilePath;
  int _status = 0;
  bool _showTextField = true;
  Timer? _timer;
  int seconds = 0;
  int minutes = 0;

  String? get audioFilePath => _audioFilePath;
  int get status => _status;
  bool get showTextField => _showTextField;
  Timer? get timer => _timer;

  RecordProvider() {
    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    _network = Network(_prefs);
    _socketService = WebSocketService(prefs: _prefs);
  }

  Future<String> _generateFilePath() async {
    final basePath = kIsWeb
        ? '/web_recordings'
        : (await getApplicationDocumentsDirectory()).path;
    final fileName = List.generate(10, (_) => _randomChar()).join();
    return p.join(basePath, '$fileName.wav');
  }

  String _randomChar() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return chars[Random().nextInt(chars.length)];
  }

  Future<bool> _hasMicrophonePermission() async {
    final status = await Permission.microphone.status;
    return status.isGranted ||
        (await Permission.microphone.request()).isGranted;
  }

  Future<void> startRecording() async {
    if (!await _hasMicrophonePermission()) {
      debugPrint('🎤 Microphone permission denied');
      return;
    }

    try {
      _audioFilePath = await _generateFilePath();
      recordedText.clear();
      seconds = 0;
      minutes = 0;
      notifyListeners();

      await _socketService.connect((text) {
        recordedText.add(text);
        notifyListeners();
      });

      await _recorder.openRecorder();
      await _recorder.startRecorder(
        toStream: _audioStreamController,
        codec: Codec.pcm16WAV,
      );

      _audioStreamController.stream.listen((data) {
        _socketService.sendText(data);
      });

      _setStatus(1);
      _startTimer();
    } catch (e) {
      debugPrint('❌ Error during recording start: $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      await _recorder.stopRecorder();
      await _recorder.closeRecorder();
      await _audioStreamController.close();
      _socketService.close();
      _speechService.stopListening();

      _stopTimer();
      _setStatus(2);
    } catch (e) {
      debugPrint('❌ Error during recording stop: $e');
    }
  }

  void reset() {
    _setStatus(0);
    recordedText.clear();
    seconds = 0;
    minutes = 0;
    notifyListeners();
  }

  Future<void> saveMedicalForm(int form, int appointment) async {
    await _network.createLog(
      speaker: '1',
      transcription: 'some text',
      form: form,
      appointment: appointment,
    );
  }

  void toggleTextField() {
    _showTextField = !_showTextField;
    notifyListeners();
  }

  void setHideTextField(bool hide) {
    _showTextField = !hide;
    notifyListeners();
  }

  void close() {
    _speechService.cancelListening();
    _socketService.close();
    _recorder.closeRecorder();
    _stopTimer();
    _setStatus(3);
    notifyListeners();
  }

  @override
  void dispose() {
    debugPrint('🧹 Disposing RecordProvider');
    close();
    super.dispose();
  }

  void _setStatus(int newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (++seconds >= 60) {
        seconds = 0;
        minutes++;
      }
      notifyListeners();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
