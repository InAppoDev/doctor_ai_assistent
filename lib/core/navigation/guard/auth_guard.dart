import 'package:auto_route/auto_route.dart';
import 'package:doctor_ai_assistent/core/navigation/app_route_config.dart';
import 'package:doctor_ai_assistent/core/services/get_it/get_it_service.dart';
import 'package:doctor_ai_assistent/features/auth/provider/auth_provider.dart';

/// [AuthGuard] is a custom route guard for managing navigation based on the authentication status of the user.
/// 
/// It implements the [AutoRouteGuard] class to control access to specific routes depending on whether the user is logged in.
/// When a user attempts to navigate to a protected route, this guard checks the authentication status and either allows the
/// navigation or redirects the user to the login page if they are not logged in.
///
/// - The guard uses the [AuthProvider] to verify if the user is logged in.
class AuthGuard extends AutoRouteGuard {
  // The [AuthProvider] instance is retrieved using the GetIt service locator to check the authentication state.
  final _authProvider = getIt<AuthProvider>();

  /// This method is invoked when navigation is attempted.
  ///
  /// It checks if the user is logged in by accessing [_authProvider.isLoggedIn].
  /// - If the user is logged in, navigation is allowed by calling [resolver.next(true)].
  /// - If the user is not logged in, navigation is redirected to the login page using [resolver.redirect()].
  ///
  /// The `resolver` provides the ability to manage the navigation flow, either allowing it to continue or redirecting
  /// to another page. The [router] can be used for additional navigation control if needed.
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_authProvider.isLoggedIn) {
      // User is logged in, proceed with navigation
      resolver.next(true);
    } else {
      // User is not logged in, redirect to login page
      resolver.redirect(
        LoginRoute(
          // The onResult callback is currently commented out but could be used to handle
          // post-login logic, like stopping additional route pushes or reevaluating the navigation stack.
          // onResult: (didLogin) {
          //   resolver.resolveNext(didLogin, reevaluateNext: false);
          // },
        ),
      );
    }
  }
}
