import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as p;

/// Manages the state and behavior for recording functionality, including status, timer, and visibility of text fields and buttons.
class RecordProvider extends ChangeNotifier {
  /// The implementation of the Record for voice recording

  RecordProvider() {
    _audioRecord = AudioRecorder();
  }

  /// Initializes the provider with the provided [audioRecord].
  late final AudioRecorder _audioRecord;

  AudioRecorder get audioRecord => _audioRecord;

  /// Generates a random ID to use for the audio file name.
  /// This is used to ensure unique file names for each recording.
  String _generateRandomId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return List.generate(
      10,
      (index) => chars[random.nextInt(chars.length)],
      growable: false,
    ).join();
  }

  /// Determines the appropriate directory path based on the platform.
  Future<String> _getDirectoryPath() async {
    if (kIsWeb) {
      // Web platform: Store in memory or handle via browser APIs.
      return '/web_recordings';
    } else {
      // Mobile/Desktop platform: Use `path_provider`.
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
  }

  /// Starts recording audio using the [AudioRecorder].
  /// This method also starts the timer to track the recording duration.
  Future<void> startRecordingAudio() async {
    try {
      if (await hasPermission()) {
        final directory = await _getDirectoryPath();
        _audioFilePath = p.join(directory, '${_generateRandomId()}.wav');
        await _audioRecord.start(
          const RecordConfig(
            encoder: AudioEncoder.wav,
          ),
          path: _audioFilePath!
        );
      } else {
        debugPrint('Permission denied');
      }
    } catch (e) {
      debugPrint('Error starting recording: $e');
    }
  }

  Future<bool> hasPermission() async {
    final status = await Permission.microphone.status;
    if (status.isGranted) {
      return true;
    } else {
      final result = await Permission.microphone.request();
      return result.isGranted;
    }
  }

  /// Stops the ongoing audio recording.
  /// This method also stops the timer tracking the recording duration.
  Future<void> stopRecordingAudio() async {
    try {
      _audioFilePath = await  _audioRecord.stop();
    } catch (e) {
      debugPrint('Error stopping recording: $e');
    }
  }

  Future<void> resumeRecordingAudio() async {
    try {
      await _audioRecord.resume();
    } catch (e) {
      debugPrint('Error resuming recording: $e');
    }
  }

  Future<void> pauseRecordingAudio() async {
    try {
      await _audioRecord.pause();
    } catch (e) {
      debugPrint('Error pausing recording: $e');
    }
  }

  /// File path of the recorded audio file.
  /// This is used to play the recorded audio.

  String? _audioFilePath;

  String? get audioFilePath => _audioFilePath;

  /*
  * 0 - Initial state (not recording)
  * 1 - Recording state
  * 2 - Stopped state (recording stopped)
  # 3 - Ended session (provider disposed)
  */
  // Private variable to hold the current status of recording.
  int _status = 0;

  /// Returns the current status of the recording (initial, recording, or stopped).
  int get status => _status;

  /// Updates the recording status and notifies listeners of the change.
  ///
  /// [status] - The new status to set (0 for initial, 1 for recording, 2 for stopped).
  void setStatus(int status) {
    _status = status;
    notifyListeners();
  }

  /// Starts the recording by setting the status to recording (1).
  void startRecording() {
    if (_status == 0) {
      startRecordingAudio();
    } else if (_status == 2) {
      resumeRecordingAudio();
    }
    setStatus(1);
  }

  /// Stops the recording by setting the status to stopped (2).
  void stopRecording() {
    pauseRecordingAudio();
    setStatus(2);
  }

  /// Resets the recording status to the initial state (0).
  void reset() {
    setStatus(0);
  }

  // Timer
  Timer? _timer;

  int seconds = 0;
  int minutes = 0;

  /// Returns the current timer instance. Can be used to check if a timer is running.
  Timer? get timer => _timer;

  /// Starts a periodic timer that updates every second, tracking the elapsed time.
  ///
  /// The timer updates the [seconds] and [minutes] counters and notifies listeners of the changes.
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 59) {
        // When seconds reach 59, reset to 0 and increment minutes.
        seconds = 0;
        minutes++;
      } else {
        // Increment seconds.
        seconds++;
      }
      notifyListeners();
    });
  }

  /// Stops the ongoing timer.
  void stopTimer() {
    _timer?.cancel();
  }

  // TextField visibility management
  bool _showTextField = true;

  /// Returns whether the text field should be displayed or hidden.
  bool get showTextField => _showTextField;

  /// Hides or shows the text field based on the provided value.
  ///
  /// [hideTextField] - A boolean indicating whether to hide the text field.
  void setHideTextField(bool hideTextField) {
    _showTextField = hideTextField;
    notifyListeners();
  }

  /// Toggles the visibility of the text field.
  void toggleTextField() {
    _showTextField = !_showTextField;
    notifyListeners();
  }

  /// Cleans up any resources when the provider is disposed.
  /// This ensures that the timer is canceled to avoid memory leaks.
  @override
  void dispose() {
    debugPrint('Disposing RecordProvider');
    _audioRecord.dispose();
    _status = 3;
    _timer?.cancel();
    super.dispose();
  }

  void close() {
    _audioRecord.dispose();
    _status = 3;
    _timer?.cancel();
    notifyListeners();
  }
}
