import 'dart:async';

import 'package:flutter/cupertino.dart';

class RecordProvider extends ChangeNotifier {

  /*
  * 0 - Initial
  * 1 - Recording
  * 2 - Stopped
  */
  int _status = 0;

  int get status => _status;

  void setStatus(int status) {
    _status = status;
    notifyListeners();
  }

  void startRecording() {
    setStatus(1);
  }

  void stopRecording() {
    setStatus(2);
  }

  void reset() {
    setStatus(0);
  }


  // Timer
  Timer? _timer;

  int seconds = 0;
  int minutes = 0;

  Timer? get timer => _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 59) {
        seconds = 0;
        minutes++;
      } else {
        seconds++;
      }
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}