import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/services/get_it/get_it_service.dart';
import 'package:doctor_ai_assistent/features/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';

import '../../../core/navigation/app_route_config.dart';

class MyApp extends StatelessWidget {
  final _appRouter = getIt<AppRouter>();
  final _authProvider = getIt<AuthProvider>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'ECNX Ambient Listening',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accentGreen),
        primaryColor: AppColors.accentBlue,
        useMaterial3: true,
      ),
      routerConfig: _appRouter.config(
        reevaluateListenable: _authProvider,
      ),
    );
  }
}