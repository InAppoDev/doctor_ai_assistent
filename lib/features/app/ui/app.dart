import 'package:doctor_ai_assistent/core/services/get_it/get_it_service.dart';
import 'package:doctor_ai_assistent/features/auth/provider/auth_provider.dart';
import 'package:doctor_ai_assistent/features/home_page/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/navigation/app_route_config.dart';

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  final _authProvider = getIt<AuthProvider>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ECNX Ambient Listening',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _appRouter.config(
        reevaluateListenable: _authProvider,
      ),
    );
  }
}