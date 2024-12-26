import 'package:doctor_ai_assistent/core/services/get_it/get_it_service.dart';
import 'package:doctor_ai_assistent/features/app/ui/app.dart';
import 'package:doctor_ai_assistent/features/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  initDI();

  final authProvider = getIt<AuthProvider>();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => authProvider),
    ],
    child: MyApp(),
  ));
}