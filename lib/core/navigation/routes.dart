// lib/core/navigation/app_router.dart
import 'package:ecnx_ambient_listening/features/auth/presentation/pages/login/login_page.dart';
import 'package:ecnx_ambient_listening/features/auth/presentation/pages/registration/registration_page.dart';
import 'package:ecnx_ambient_listening/features/auth/provider/auth_provider.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/pages/edit_page.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/pages/transcribed_list_page.dart';
import 'package:ecnx_ambient_listening/features/home_page/presentation/pages/home_page.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/pages/medical_form_page.dart';
import 'package:ecnx_ambient_listening/features/record/presentation/pages/record_page.dart';
import 'package:ecnx_ambient_listening/features/schedule/presentation/pages/schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    final authProvider = context.read<AuthProvider>();
    return authProvider.isLoggedIn ? null : const LoginRoute().location;
  }
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginPage();
}

@TypedGoRoute<RegistrationRoute>(path: '/registration')
class RegistrationRoute extends GoRouteData {
  const RegistrationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RegistrationPage();
}

@TypedGoRoute<RecordRoute>(path: '/record')
class RecordRoute extends GoRouteData {
  const RecordRoute(this.$extra);

  final RecordPageArgs $extra;
  @override
  Widget build(BuildContext context, GoRouterState state) => RecordPage(
        appointment: $extra.appointment,
      );
}

@TypedGoRoute<EditRoute>(path: '/edit-record')
class EditRoute extends GoRouteData {
  const EditRoute({required this.$extra});
  final EditPageArgs $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => EditPage(
        args: $extra,
      );
}

@TypedGoRoute<TranscribedListRoute>(path: '/transcribed-list')
class TranscribedListRoute extends GoRouteData {
  const TranscribedListRoute(this.$extra);

  final TranscribedListArgs $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      TranscribedListPage(log: $extra.log);
}

@TypedGoRoute<MedicalFormRoute>(path: '/medical-form')
class MedicalFormRoute extends GoRouteData {
  const MedicalFormRoute(this.path, this.appointmentId);

  final String path;
  final int appointmentId;

  @override
  Widget build(BuildContext context, GoRouterState state) => MedicalFormPage(
        path: path,
        appointmentId: appointmentId,
      );
}

@TypedGoRoute<ScheduleRoute>(path: '/schedule')
class ScheduleRoute extends GoRouteData {
  const ScheduleRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SchedulePage();
}
