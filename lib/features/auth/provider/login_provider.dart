import 'package:ecnx_ambient_listening/core/network/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginState extends ChangeNotifier {
  LoginState() {
    init();
  }
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final Network _backend;

  bool isPasswordVisible = false;
  bool isLoading = false;

  /// Call this method after creating the instance
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _backend = Network(prefs);
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  Future<bool> submitLogin() async {
    if (!formKey.currentState!.validate()) return false;

    isLoading = true;
    notifyListeners();

    final success = await _backend.loginUser(
      email: loginController.text.trim(),
      password: passwordController.text,
    );

    isLoading = false;
    notifyListeners();

    return success;
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
