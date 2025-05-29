import 'package:ecnx_ambient_listening/core/network/network.dart';
import 'package:ecnx_ambient_listening/features/auth/presentation/pages/login/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages the authentication state of the application, including login and logout actions.
/// Notifies listeners whenever the login state changes.
class AuthProvider extends ChangeNotifier {
  late final SharedPreferences _prefs;
  late final Network network;

  /// Initialize preferences and backend, then check login status.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    network = Network(_prefs);
    await checkAuthStatus();
  }

  /// Logs the user in and updates the login state to true.
  /// Notifies listeners about the change in state.
  void login() {
    AuthController.authorized = true;
    notifyListeners();
  }

  /// Checks if user is already logged in using backend logic.
  Future<void> checkAuthStatus() async {
    await network.autoLogin();
  }

  /// Logs the user out and updates the login state to false.
  /// Notifies listeners about the change in state.
  void logout() {
    AuthController.authorized = false;
    notifyListeners();
  }
}
