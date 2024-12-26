import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerProvider extends ChangeNotifier {
  PlayerProvider();

  Future<void> initData({required String url}) async {
    if (url.isEmpty) {
      throw ArgumentError('URL cannot be empty');
    }

    try {
      await _player.setUrl(url);
      _duration = _player.duration ?? Duration.zero;
      notifyListeners();
    } catch (e) {
      debugPrint('Error initializing audio: $e');
      rethrow;
    }
  }

  // Audio player
  final AudioPlayer _player = AudioPlayer();
  AudioPlayer get player => _player;

  // Audio state
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  void setIsPlaying(bool value) {
    _isPlaying = value;
      notifyListeners();
  }

  Duration _duration = Duration.zero;
  Duration get duration => _duration;

  void setDuration(Duration newDuration) {
    _duration = newDuration;
    notifyListeners();
  }

  Duration _position = Duration.zero;
  Duration get position => _position;

  void setPosition(Duration newPosition) {
    _position = newPosition;
    notifyListeners();
  }

  void close() {
    _player.dispose();
    notifyListeners();
  }
}
