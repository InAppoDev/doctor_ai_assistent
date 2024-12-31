import 'package:auto_route/auto_route.dart';
import 'package:doctor_ai_assistent/core/navigation/app_routes.dart';
import 'package:doctor_ai_assistent/features/auth/presentation/pages/registration/registration_page.dart';
import 'package:doctor_ai_assistent/features/edit/presentation/pages/edit_page.dart';
import 'package:doctor_ai_assistent/features/edit/presentation/pages/transcribed_list_page.dart';
import 'package:doctor_ai_assistent/features/medical_form/presentation/pages/medical_form_page.dart';
import 'package:doctor_ai_assistent/features/record/presentation/pages/record_page.dart';

import '../../features/auth/presentation/pages/login/login_page.dart';
import '../../features/home_page/presentation/pages/home_page.dart';

part 'app_route_config.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: RecordRoute.page, path: AppRoutes.home, initial: true),
        AutoRoute(
          page: HomeRoute.page,
          path: AppRoutes.record,
        ),
        AutoRoute(page: LoginRoute.page, path: AppRoutes.login),
        AutoRoute(page: EditRoute.page, path: AppRoutes.editRecord),
        AutoRoute(page: MedicalFormRoute.page, path: AppRoutes.medicalForm),
        AutoRoute(page: TranscribedListRoute.page, path: AppRoutes.transcribedList),
        AutoRoute(page: LoginRoute.page, path: AppRoutes.login),
        AutoRoute(page: RegistrationRoute.page, path: AppRoutes.registration)
  ];
}