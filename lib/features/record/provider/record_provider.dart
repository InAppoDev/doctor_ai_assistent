import 'dart:async';

import 'package:flutter/cupertino.dart';

/// Manages the state and behavior for recording functionality, including status, timer, and visibility of text fields and buttons.
class RecordProvider extends ChangeNotifier {
  /*
  * 0 - Initial state (not recording)
  * 1 - Recording state
  * 2 - Stopped state (recording stopped)
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
    setStatus(1);
  }

  /// Stops the recording by setting the status to stopped (2).
  void stopRecording() {
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

  bool _hideShowButton = true;

  /// Returns whether the "show/hide" button is visible or hidden.
  bool get hideShowButton => _hideShowButton;

  /// Hides or shows the "show/hide" button based on the provided value.
  /// 
  /// [hideShowButton] - A boolean indicating whether to hide the button.
  void setHideShowButton(bool hideShowButton) {
    _hideShowButton = hideShowButton;
    notifyListeners();
  }

  /// Cleans up any resources when the provider is disposed.
  /// This ensures that the timer is canceled to avoid memory leaks.
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
