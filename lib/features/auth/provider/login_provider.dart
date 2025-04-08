import 'package:ecnx_ambient_listening/core/beckend_service/beckend_service.dart';
import 'package:flutter/cupertino.dart';

class LoginState extends ChangeNotifier {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _backend = BackendService();

  bool isPasswordVisible = false;
  bool isLoading = false;

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
