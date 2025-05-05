import 'package:ecnx_ambient_listening/core/network/network.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages the authentication state of the application, including login and logout actions.
/// Notifies listeners whenever the login state changes.
class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _init();
  }

  late final SharedPreferences _prefs;
  late final Network network;

  // Private variable that holds the login state. Defaults to false (not logged in).
  bool _isLoggedIn = false;

  /// Returns the current login state. True if the user is logged in, false otherwise.
  bool get isLoggedIn => _isLoggedIn;

  /// Initialize preferences and backend, then check login status.
  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    network = Network(_prefs);
    await checkAuthStatus();
  }

  /// Logs the user in and updates the login state to true.
  /// Notifies listeners about the change in state.
  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  /// Checks if user is already logged in using backend logic.
  Future<void> checkAuthStatus() async {
    final isLogged = await network.autoLogin();
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
