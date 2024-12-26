import 'package:auto_route/auto_route.dart';
import 'package:doctor_ai_assistent/core/navigation/app_route_config.dart';
import 'package:doctor_ai_assistent/core/services/get_it/get_it_service.dart';
import 'package:doctor_ai_assistent/features/auth/provider/auth_provider.dart';

class AuthGuard extends AutoRouteGuard{
  final _authProvider = getIt<AuthProvider>();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_authProvider.isLoggedIn) {
      resolver.next(true);
    } else {
      resolver.redirect(
        LoginRoute(
          onResult: (didLogin) {
            // stop re-pushing any pending routes after current
            resolver.resolveNext(didLogin, reevaluateNext: false);
          },
        ),
      );
    }
  }
}