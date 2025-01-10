import 'package:flutter/material.dart';

/// Manages the state for the login functionality, including form fields
/// and password visibility.
class LoginState extends ChangeNotifier {
  // ---------------------------------------------------------------------------
  // Controllers and Form Key
  // ---------------------------------------------------------------------------

  /// Controller for the login (username or email) input field.
  final TextEditingController loginController = TextEditingController();

  /// Controller for the password input field.
  final TextEditingController passwordController = TextEditingController();

  /// Global key used to manage and validate the login form.
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // ---------------------------------------------------------------------------
  // Password Visibility
  // ---------------------------------------------------------------------------

  /// Tracks whether the password field is currently visible.
  bool isPasswordVisible = false;

  /// Toggles the visibility of the password field and notifies listeners.
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners(); // Triggers UI updates for visibility changes.
  }

  // ---------------------------------------------------------------------------
  // Cleanup
  // ---------------------------------------------------------------------------

  /// Disposes of the [TextEditingController]s to free up resources.
  /// 
  /// This is called when the [LoginState] is no longer needed to prevent
  /// memory leaks or dangling references.
  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
