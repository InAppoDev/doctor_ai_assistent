import 'package:ecnx_ambient_listening/core/models/user_model/user_model.dart';
import 'package:ecnx_ambient_listening/core/network/network.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages the state for the registration process, including form fields,
/// password visibility toggling, and validation.
class RegisterState extends ChangeNotifier {
  // ---------------------------------------------------------------------------
  // Initialization
  // ---------------------------------------------------------------------------

  late final Network _backendService;

  RegisterState() {
    init();
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _backendService = Network(prefs);
  }

  // ---------------------------------------------------------------------------
  // Controllers and Form Key
  // ---------------------------------------------------------------------------

  bool isLoading = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // ---------------------------------------------------------------------------
  // Password Visibility
  // ---------------------------------------------------------------------------

  bool isPasswordVisible = false;
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  bool isPasswordConfirmationVisible = false;
  void togglePasswordConfirmationVisibility() {
    isPasswordConfirmationVisible = !isPasswordConfirmationVisible;
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Registration
  // ---------------------------------------------------------------------------

  Future<UserModel?> register() async {
    isLoading = true;
    notifyListeners();

    final user = await _backendService.registerUser(
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
