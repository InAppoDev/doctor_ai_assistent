import 'package:auto_route/auto_route.dart';
import 'package:ecnx_ambient_listening/core/navigation/app_routes.dart';
import 'package:ecnx_ambient_listening/features/auth/presentation/pages/registration/registration_page.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/pages/edit_page.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/pages/transcribed_list_page.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/pages/medical_form_page.dart';
import 'package:ecnx_ambient_listening/features/record/presentation/pages/record_page.dart';
import 'package:ecnx_ambient_listening/features/schedule/presentation/pages/schedule_page.dart';
import 'package:ecnx_ambient_listening/features/auth/presentation/pages/login/login_page.dart';
import 'package:ecnx_ambient_listening/features/home_page/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

part 'app_route_config.gr.dart';

/// [AppRouter] is the main router configuration for the app. It defines all the routes used for navigation within the application.
/// 
/// It leverages the [AutoRouter] package to set up routes and automatic navigation. The routes are structured to separate 
/// different areas of functionality (authentication, features, etc.) for better organization and ease of maintenance.
///
/// - Each route has an associated [AutoRoute] that maps a path to a page (e.g., [HomeRoute.page]).
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        /// The initial route of the app, loading the home page when the app is first launched.
        AutoRoute(page: HomeRoute.page, path: AppRoutes.home, initial: true),

        /// Authentication-related routes, including login and registration pages.
        /// Need to add teh AuthGuard to the routes that require authentication.
        AutoRoute(page: LoginRoute.page, path: AppRoutes.login),
        AutoRoute(page: RegistrationRoute.page, path: AppRoutes.registration),

        /// Feature-specific routes, enabling navigation to different sections of the app.
        /// Each route is tied to a page responsible for a specific feature (e.g., Record, Medical Form).
        AutoRoute(
          page: RecordRoute.page,
          path: AppRoutes.record,
        ),
        AutoRoute(page: EditRoute.page, path: AppRoutes.editRecord),
        AutoRoute(page: MedicalFormRoute.page, path: AppRoutes.medicalForm),
        AutoRoute(page: TranscribedListRoute.page, path: AppRoutes.transcribedList),
        AutoRoute(page: ScheduleRoute.page, path: AppRoutes.schedule),
  ];
}
