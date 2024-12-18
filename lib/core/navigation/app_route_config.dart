import 'package:auto_route/auto_route.dart';
import 'package:doctor_ai_assistent/core/navigation/app_routes.dart';
import 'package:doctor_ai_assistent/core/navigation/guard/auth_guard.dart';
import 'package:doctor_ai_assistent/features/record/presentation/pages/record_page.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login/login_page.dart';
import '../../features/home_page/presentation/pages/home_page.dart';

part 'app_route_config.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true, path: AppRoutes.home, guards: [AuthGuard()]),
    AutoRoute(page: LoginRoute.page, path: AppRoutes.login),
    AutoRoute(page: RecordRoute.page, path: AppRoutes.record, guards: [AuthGuard()]),
  ];
}