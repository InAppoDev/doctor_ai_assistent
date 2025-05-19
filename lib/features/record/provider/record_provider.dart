import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:ecnx_ambient_listening/core/models/appointment_model/appointment_model.dart';
import 'package:ecnx_ambient_listening/core/models/form_model/form_model.dart';
import 'package:ecnx_ambient_listening/core/models/log_model/log_model.dart';
import 'package:ecnx_ambient_listening/core/models/transcription_model/transcription_model.dart';
import 'package:ecnx_ambient_listening/core/network/network.dart';
import 'package:ecnx_ambient_listening/core/web_socket/web_socket_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordProvider extends ChangeNotifier {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  late StreamController<Uint8List> _audioStreamController;

  final List<String> recordedText = [];

  final record = AudioRecorder();
  late final SharedPreferences _prefs;
  late final WebSocketService _socketService;
  late final Network _network;

  String? _audioFilePath; // final merged output
  final List<String> _chunkPaths = [];
  final List<TranscriptionModel> transcriptTimeline = [];

  int _status = 0; // 0=stopped, 1=recording, 2=paused, 3=closed
  bool _showTextField = true;
  Timer? _timer;
  int seconds = 0;
  int minutes = 0;
  String? audioKey;

  String? get audioFilePath => _audioFilePath;
  int get status => _status;
  bool get showTextField => _showTextField;
  Timer? get timer => _timer;

  LogModel? log;

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

  /// Start recording.
  /// If resume==false, starts fresh (clears recordedText and timer)
  /// If resume==true, resumes recording without resetting state
  Future<void> startRecording({bool resume = false}) async {
    if (!await _hasMicrophonePermission()) {
      debugPrint('🎤 Microphone permission denied');
      return;
    }

    // Only reset things if this is a fresh start
    if (!resume) {
      recordedText.clear();
      seconds = 0;
      minutes = 0;
      _chunkPaths.clear();
      _audioFilePath = await _generateFilePath();
      notifyListeners();
    }

    _audioStreamController = StreamController<Uint8List>.broadcast();

    try {
      final chunkFilePath = await _generateFilePath();
      _chunkPaths.add(chunkFilePath);

      if (!resume || !_socketService.isConnected) {
        await _socketService.connect();

        _socketService.socketListener(
          onTranscript: _handleTranscript,
          onKey: (key) {
            audioKey = key;
          },
        );
      }

      await record.start(RecordConfig(), path: chunkFilePath);

      await _recorder.openRecorder();

      await _recorder.startRecorder(
        toStream: _audioStreamController,
        codec: Codec.pcm16WAV,
      );

      _audioStreamController.stream.listen((data) {
        _socketService.sendText(data);
      });

      _setStatus(1);

      if (_timer == null) {
        _startTimer();
      }

      notifyListeners();
    } catch (e) {
      debugPrint('❌ Error during recording start/resume: $e');
    }
  }

  void _handleTranscript(TranscriptionModel transcriptReturnModel) {
    final transcript = transcriptReturnModel.transcription.trim();
    if (transcript.isEmpty) return;

    final model = TranscriptionModel(
      speaker: transcriptReturnModel.speaker,
      transcription: transcript,
      time: transcriptReturnModel.time,
    );
    recordedText.add(model.transcription);
    transcriptTimeline.add(model);

    notifyListeners();
  }

  // void createChunks() {
  //   _network.createChunk(
  //       speaker: speaker,
  //       transcription: transcription,
  //       time: time,
  //       logId: logId);
  // }

  Future<void> pauseRecording() async {
    if (_status != 1) return;

    try {
      await _recorder.stopRecorder();
      await record.stop();

      _setStatus(2);
      _stopTimer();
      notifyListeners();
    } catch (e) {
      debugPrint('❌ Error during recording pause: $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      if (_status == 1) {
        await pauseRecording();
      }

      if (_chunkPaths.isNotEmpty && _audioFilePath != null) {
        await _mergeWavFiles(_chunkPaths, _audioFilePath!);
      }

      _setStatus(2);
      _stopTimer();
      notifyListeners();
    } catch (e) {
      debugPrint('❌ Error during recording stop: $e');
    }
  }

  /// Merge multiple WAV files into one by concatenating PCM data, skipping headers except first file
  Future<void> _mergeWavFiles(
      List<String> chunkPaths, String outputPath) async {
    if (chunkPaths.isEmpty) return;

    final outputFile = File(outputPath);
    final outputSink = outputFile.openWrite();

    // Read first chunk (header + data)
    final firstChunk = File(chunkPaths.first);
    final firstBytes = await firstChunk.readAsBytes();

    // Write WAV header of first chunk
    outputSink.add(firstBytes.sublist(0, 44));

    // Write PCM data from all chunks skipping headers
    for (final chunkPath in chunkPaths) {
      final chunkFile = File(chunkPath);
      final bytes = await chunkFile.readAsBytes();

      // Skip header for all chunks (44 bytes)
      outputSink.add(bytes.sublist(44));
    }

    await outputSink.flush();
    await outputSink.close();
  }

  void reset() {
    _setStatus(0);
    recordedText.clear();
    _chunkPaths.clear();
    seconds = 0;
    minutes = 0;
    _audioFilePath = null;
    _stopTimer();
    notifyListeners();
  }

  Future<void> saveMedicalForm(
    AppointmentModel appointment,
  ) async {
    FormModel form;
    final key = await _socketService.requestAudioKey();
    debugPrint('audioKey - $key');
    final duration = await _getFormattedDuration();
    final forms = await _network.getForms();
    form = forms.firstWhere((f) => f.user == appointment.user);
    log = await _network.createLog(
      key: key,
      duration: duration,
      form: form.id,
      appointment: appointment.id,
    );

    if (log != null) {
      for (final transcribeData in transcriptTimeline) {
        await _network.createChunk(
          speaker: transcribeData.speaker,
          transcription: transcribeData.transcription,
          time: transcribeData.time,
          logId: log!.id,
        );
      }
    }

    notifyListeners();
  }

  void toggleTextField() {
    _showTextField = !_showTextField;
    notifyListeners();
  }

  void setHideTextField(bool hide) {
    _showTextField = !hide;
    notifyListeners();
  }

  void close() async {
    await _recorder.closeRecorder();
    await _audioStreamController.close();
    _socketService.close();

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
    _timer ??= Timer.periodic(const Duration(seconds: 1), (_) {
      seconds++;
      if (seconds >= 60) {
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

  Future<Duration?> _getAudioDuration(String path) async {
    final player = AudioPlayer();
    try {
      final pos = await player.setFilePath(path);
      debugPrint('Audio duration for $path - $pos');
      return player.duration;
    } catch (e) {
      debugPrint('❌ Error getting audio duration: $e');
      return null;
    } finally {
      await player.dispose();
    }
  }

  Future<double> _getFormattedDuration() async {
    if (_audioFilePath == null) return 0.0;
    debugPrint('_audioFilePath - $_audioFilePath');
    final duration = await _getAudioDuration(_audioFilePath!);
    if (duration == null) return 0.0;

    final int minutes = duration.inMinutes;
    final int seconds = duration.inSeconds % 60;
    return double.parse('$minutes.${seconds.toString().padLeft(2, '0')}');
  }
}
