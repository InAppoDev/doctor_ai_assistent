import 'package:doctor_ai_assistent/core/services/get_it/get_it_service.dart';
import 'package:flutter/material.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  initDI();
}