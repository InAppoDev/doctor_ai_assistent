import 'package:ecnx_ambient_listening/core/constants/consts.dart';
import 'package:ecnx_ambient_listening/core/navigation/routes.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  routes: $appRoutes,
);
