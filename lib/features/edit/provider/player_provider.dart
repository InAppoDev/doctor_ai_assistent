import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

/// Manages the state and logic for an audio player using the Just Audio package.
/// This class handles audio playback, tracks player state, and manages cleanup.
class PlayerProvider extends ChangeNotifier {
  // ---------------------------------------------------------------------------
  // Initialization
  // ---------------------------------------------------------------------------
  /// Initializes the audio player with the provided [url].
  ///
  /// - Throws an [ArgumentError] if the URL is empty.
  /// - Sets the audio duration and notifies listeners upon success.
  /// - Logs and rethrows any errors that occur during initialization.
  Future<void> initData({required String url}) async {
    if (url.isEmpty) {
      throw ArgumentError('URL cannot be empty');
    }
    try {
      await player.setUrl(url);
      _duration = _player.duration ?? Duration.zero;
      notifyListeners();
    } catch (e) {
      debugPrint('Error initializing audio: $e');
      rethrow; // Rethrow the exception for higher-level handling.
    }
  }

  // ---------------------------------------------------------------------------
  // Audio Player and State Management
  // ---------------------------------------------------------------------------

  /// The Just Audio player instance responsible for audio playback.
  final AudioPlayer _player = AudioPlayer();

  /// Exposes the [AudioPlayer] instance to external widgets.
  AudioPlayer get player => _player;

  /// Tracks whether the audio player is currently playing.
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  /// Updates the [_isPlaying] state and notifies listeners.
  ///
  /// [value] - `true` if the player is playing; otherwise `false`.
  void setIsPlaying(bool value) {
    _isPlaying = value;
    notifyListeners(); // Notify UI of the updated playing state.
  }

  void playPause() {
    if (_player.playing) {
      _player.pause();
      setIsPlaying(false);
    } else {
      _player.play();
      setIsPlaying(true);
    }
  }

  // ---------------------------------------------------------------------------
  // Audio Duration and Position
  // ---------------------------------------------------------------------------

  /// The total duration of the loaded audio file.
  Duration _duration = Duration.zero;
  Duration get duration => _duration;

  /// Updates the total duration of the audio file and notifies listeners.
  ///
  /// [newDuration] - The updated duration value.
  void setDuration(Duration newDuration) {
    _duration = newDuration;
    notifyListeners(); // Notify UI of the updated duration.
  }

  /// The current playback position of the audio file.
  Duration _position = Duration.zero;
  Duration get position => _position;

  /// Updates the current playback position and notifies listeners.
  ///
  /// [newPosition] - The updated position value.
  void setPosition(Duration newPosition) {
    _position = newPosition;
    notifyListeners(); // Notify UI of the updated position.
  }

  int transcribedId = 0;

  void setTranscribedId(int id, double timePosition) {
    transcribedId = id;
    final newDuration = _duration.inMilliseconds > 0
        ? Duration(milliseconds: (timePosition * 1000).toInt())
        : Duration.zero;

    setPosition(newDuration);
    _player.seek(newDuration);
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Cleanup
  // ---------------------------------------------------------------------------

  /// Releases resources held by the audio player and notifies listeners.
  ///
  /// This should be called when the [PlayerProvider] is no longer needed
  /// to prevent memory leaks or dangling resources.
  @override
  void dispose() {
    debugPrint('PlayerProvider disposed');
    _player.dispose();
    super.dispose();
  }
}
