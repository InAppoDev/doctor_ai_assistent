import 'package:flutter/material.dart';

/// Manages the authentication state of the application, including login and logout actions.
/// Notifies listeners whenever the login state changes.
class AuthProvider extends ChangeNotifier {
  // Private variable that holds the login state. Defaults to false (not logged in).
  bool _isLoggedIn = false;

  /// Returns the current login state. True if the user is logged in, false otherwise.
  bool get isLoggedIn => _isLoggedIn;

  /// Logs the user in and updates the login state to true.
  /// Notifies listeners about the change in state.
  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  /// Logs the user out and updates the login state to false.
  /// Notifies listeners about the change in state.
  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
