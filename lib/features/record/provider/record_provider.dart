import 'dart:async';
import 'dart:math';

import 'package:ecnx_ambient_listening/core/network/network.dart';
import 'package:ecnx_ambient_listening/core/prefs.dart';
import 'package:ecnx_ambient_listening/core/speech_to_text/speech_to_text_service.dart';
import 'package:ecnx_ambient_listening/core/web_socket/web_socket_service.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class RecordProvider extends ChangeNotifier {
  RecordProvider() {
    _init();
  }

  final SpeechToTextService _speechService = SpeechToTextService();
  final WebSocketService _socketService = WebSocketService();
  late final SharedPreferences _prefs;

  late final Network network;

  bool _showTextField = true;
  String? _audioFilePath;
  int _status = 0;
  Timer? _timer;
  int seconds = 0;
  int minutes = 0;
  final List<String> recordedText = [];

  String? get audioFilePath => _audioFilePath;

  int get status => _status;

  bool get showTextField => _showTextField;

  Timer? get timer => _timer;

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    network = Network(_prefs); // In
    await _speechService.init();
  }

  Future<String> _getDirectoryPath() async {
    if (kIsWeb) return '/web_recordings';
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  String _generateRandomId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return List.generate(10, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  Future<void> saveMedicalForm(int form, int appointment) async {
    await network.createLog(
      speaker: '1',
      transcription: 'some text',
      form: form,
      appointment: appointment,
    );
  }

  Future<bool> _hasPermission() async {
    final status = await Permission.microphone.status;
    if (status.isGranted) return true;
    return (await Permission.microphone.request()).isGranted;
  }

  Future<void> startRecordingAudio() async {
    final accessToken = _prefs.getString(PreferencesKeys.accessToken);

    if (!await _hasPermission()) {
      debugPrint('Microphone permission denied');
      return;
    }

    try {
      seconds = 0;
      minutes = 0;
      notifyListeners();

      final directory = await _getDirectoryPath();
      _audioFilePath = p.join(directory, '${_generateRandomId()}.wav');

      if (accessToken != null) {
        await _socketService.connect(accessToken);
      } else {
        debugPrint('No access token found');
        return;
      }

      await _speechService.startListening((SpeechRecognitionResult result) {
        final text = result.recognizedWords;
        if (text.isNotEmpty) {
          recordedText.add(text);
        }
      });
    } catch (e) {
      debugPrint('Error starting recording: $e');
    }
  }

  Future<void> stopRecordingAudio() async {
    try {
      stopTimer();
      _speechService.stopListening();
      _socketService.close();
    } catch (e) {
      debugPrint('Error stopping recording: $e');
    }
  }

  Future<void> pauseRecordingAudio() async {
    try {
      stopTimer();
      _socketService.sendText(recordedText.join());
      _speechService.stopListening();
      _socketService.close();
    } catch (e) {
      debugPrint('Error pausing recording: $e');
    }
  }

  Future<void> resumeRecordingAudio() async {
    try {
      await _speechService.startListening((result) {
        final text = result.recognizedWords;
        if (text.isNotEmpty) {
          recordedText.add(text);
          _socketService.sendText(text);
        }
      });
    } catch (e) {
      debugPrint('Error resuming recording: $e');
    }
  }

  void startRecording() {
    if (_status == 0) {
      startRecordingAudio();
    } else if (_status == 2) {
      resumeRecordingAudio();
    }
    setStatus(1);
    startTimer();
  }

  void stopRecording() {
    pauseRecordingAudio();
    setStatus(2);
    stopTimer();
  }

  void reset() {
    setStatus(0);
    recordedText.clear();
    seconds = 0;
    minutes = 0;
    notifyListeners();
  }

  void setStatus(int newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  void startTimer() {
    _timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      if (++seconds >= 60) {
        seconds = 0;
        minutes++;
      }
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
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
    _status = 3;
    stopTimer();
    notifyListeners();
  }

  @override
  void dispose() {
    debugPrint('Disposing RecordProvider');
    close();
    super.dispose();
  }
}
