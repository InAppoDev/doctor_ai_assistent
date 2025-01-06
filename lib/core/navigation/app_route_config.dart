import 'package:auto_route/auto_route.dart';
import 'package:doctor_ai_assistent/core/navigation/app_routes.dart';
import 'package:doctor_ai_assistent/features/auth/presentation/pages/registration/registration_page.dart';
import 'package:doctor_ai_assistent/features/edit/presentation/pages/edit_page.dart';
import 'package:doctor_ai_assistent/features/edit/presentation/pages/transcribed_list_page.dart';
import 'package:doctor_ai_assistent/features/medical_form/presentation/pages/medical_form_page.dart';
import 'package:doctor_ai_assistent/features/record/presentation/pages/record_page.dart';
import 'package:doctor_ai_assistent/features/schedule/presentation/pages/schedule_page.dart';
import 'package:doctor_ai_assistent/features/auth/presentation/pages/login/login_page.dart';
import 'package:doctor_ai_assistent/features/home_page/presentation/pages/home_page.dart';

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
        AutoRoute(page: LoginRoute.page, path: AppRoutes.login),
        AutoRoute(page: RegistrationRoute.page, path: AppRoutes.registration),

        /// Feature-specific routes, enabling navigation to different sections of the app.
        /// Each route is tied to a page responsible for a specific feature (e.g., Record, Medical Form).
        AutoRoute(
          page: RecordRoute.page,
          path: AppRoutes.home,
          initial: true, // Initial screen for record feature
        ),
        AutoRoute(page: HomeRoute.page, path: AppRoutes.record),
        AutoRoute(page: EditRoute.page, path: AppRoutes.editRecord),
        AutoRoute(page: MedicalFormRoute.page, path: AppRoutes.medicalForm),
        AutoRoute(page: TranscribedListRoute.page, path: AppRoutes.transcribedList),
        AutoRoute(page: ScheduleRoute.page, path: AppRoutes.schedule),
  ];
}
