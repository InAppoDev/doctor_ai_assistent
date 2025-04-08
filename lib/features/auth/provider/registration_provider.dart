import 'package:ecnx_ambient_listening/core/beckend_service/beckend_service.dart';
import 'package:ecnx_ambient_listening/core/models/user_model/user_model.dart';
import 'package:flutter/material.dart';

/// Manages the state for the registration process, including form fields,
/// password visibility toggling, and validation.
class RegisterState extends ChangeNotifier {
  // ---------------------------------------------------------------------------
  // Controllers and Form Key
  // ---------------------------------------------------------------------------

  final BackendService _backendService = BackendService();

  bool isLoading = false;

  /// Controller for the first name input field.
  final TextEditingController firstNameController = TextEditingController();

  /// Controller for the last name input field.
  final TextEditingController lastNameController = TextEditingController();

  /// Controller for the phone number input field.
  final TextEditingController phoneNumberController = TextEditingController();

  /// Controller for the email input field.
  final TextEditingController emailController = TextEditingController();

  /// Controller for the password input field.
  final TextEditingController passwordController = TextEditingController();

  /// Controller for the confirm password input field.
  final TextEditingController confirmPasswordController =
      TextEditingController();

  /// Global key for managing and validating the registration form.
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // ---------------------------------------------------------------------------
  // Password Visibility
  // ---------------------------------------------------------------------------

  /// Tracks whether the password field is currently visible.
  bool isPasswordVisible = false;

  /// Toggles the visibility of the password field and notifies listeners.
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners(); // Updates UI to reflect the change.
  }

  /// Tracks whether the confirm password field is currently visible.
  bool isPasswordConfirmationVisible = false;

  /// Toggles the visibility of the confirm password field and notifies listeners.
  void togglePasswordConfirmationVisibility() {
    isPasswordConfirmationVisible = !isPasswordConfirmationVisible;
    notifyListeners(); // Updates UI to reflect the change.
  }

  Future<UserModel?> register() async {
    UserModel? user;
    isLoading = true;
    notifyListeners();

    user = await _backendService.registerUser(
      email: emailController.text.trim(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      phoneNumber: phoneNumberController.text.trim(),
      password: passwordController.text.trim(),
    );
    isLoading = false;
    notifyListeners();
    return user;
  }

  // ---------------------------------------------------------------------------
  // Cleanup
  // ---------------------------------------------------------------------------

  /// Disposes of all [TextEditingController]s to free resources.
  ///
  /// Ensures proper cleanup to prevent memory leaks or dangling references.
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
