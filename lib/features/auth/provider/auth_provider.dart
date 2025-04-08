import 'package:ecnx_ambient_listening/core/beckend_service/beckend_service.dart';
import 'package:flutter/material.dart';

/// Manages the authentication state of the application, including login and logout actions.
/// Notifies listeners whenever the login state changes.
class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    checkAuthStatus();
  }

  final _backend = BackendService();
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

  Future<void> checkAuthStatus() async {
    final isLogged = await _backend.tryAutoLogin();
    _isLoggedIn = isLogged;
    notifyListeners();
  }

  /// Logs the user out and updates the login state to false.
  /// Notifies listeners about the change in state.
  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
