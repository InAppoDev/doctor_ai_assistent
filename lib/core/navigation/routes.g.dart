// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRoute,
      $loginRoute,
      $registrationRoute,
      $recordRoute,
      $editRoute,
      $transcribedListRoute,
      $medicalFormRoute,
      $scheduleRoute,
    ];

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeRouteExtension._fromState,
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginRouteExtension._fromState,
    );

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  String get location => GoRouteData.$location(
        '/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $registrationRoute => GoRouteData.$route(
      path: '/registration',
      factory: $RegistrationRouteExtension._fromState,
    );

extension $RegistrationRouteExtension on RegistrationRoute {
  static RegistrationRoute _fromState(GoRouterState state) =>
      const RegistrationRoute();

  String get location => GoRouteData.$location(
        '/registration',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $recordRoute => GoRouteData.$route(
      path: '/record',
      factory: $RecordRouteExtension._fromState,
    );

extension $RecordRouteExtension on RecordRoute {
  static RecordRoute _fromState(GoRouterState state) => RecordRoute(
        state.extra as RecordPageArgs,
      );

  String get location => GoRouteData.$location(
        '/record',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $editRoute => GoRouteData.$route(
      path: '/edit-record',
      factory: $EditRouteExtension._fromState,
    );

extension $EditRouteExtension on EditRoute {
  static EditRoute _fromState(GoRouterState state) => EditRoute(
        $extra: state.extra as EditPageArgs,
      );

  String get location => GoRouteData.$location(
        '/edit-record',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $transcribedListRoute => GoRouteData.$route(
      path: '/transcribed-list',
      factory: $TranscribedListRouteExtension._fromState,
    );

extension $TranscribedListRouteExtension on TranscribedListRoute {
  static TranscribedListRoute _fromState(GoRouterState state) =>
      TranscribedListRoute(
        state.uri.queryParameters['path']!,
      );

  String get location => GoRouteData.$location(
        '/transcribed-list',
        queryParams: {
          'path': path,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $medicalFormRoute => GoRouteData.$route(
      path: '/medical-form',
      factory: $MedicalFormRouteExtension._fromState,
    );

extension $MedicalFormRouteExtension on MedicalFormRoute {
  static MedicalFormRoute _fromState(GoRouterState state) => MedicalFormRoute(
        state.uri.queryParameters['path']!,
        int.parse(state.uri.queryParameters['appointment-id']!),
      );

  String get location => GoRouteData.$location(
        '/medical-form',
        queryParams: {
          'path': path,
          'appointment-id': appointmentId.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $scheduleRoute => GoRouteData.$route(
      path: '/schedule',
      factory: $ScheduleRouteExtension._fromState,
    );

extension $ScheduleRouteExtension on ScheduleRoute {
  static ScheduleRoute _fromState(GoRouterState state) => const ScheduleRoute();

  String get location => GoRouteData.$location(
        '/schedule',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
