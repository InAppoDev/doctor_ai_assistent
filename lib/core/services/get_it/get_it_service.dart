import 'package:ecnx_ambient_listening/core/navigation/app_route_config.dart';
import 'package:ecnx_ambient_listening/core/services/shared_preferences/shared_preferences.dart';
import 'package:ecnx_ambient_listening/features/auth/provider/auth_provider.dart';
import 'package:get_it/get_it.dart';

/// The central service locator for dependency injection.
final GetIt getIt = GetIt.instance;

/// Initializes the dependency injection container.
///
/// Registers all necessary services, providers, and utilities
/// for use across the application. This ensures that instances
/// are properly managed and reusable where needed.
void initDI() {
  // ---------------------------------------------------------------------------
  // Shared Preferences Service
  // ---------------------------------------------------------------------------

  /// Registers `SharedPreferencesService` as a factory.
  ///
  /// A new instance will be created each time it is requested. If the service
  /// is expensive to initialize or should maintain state, consider changing
  /// this to a lazy singleton.
  getIt.registerFactory<SharedPreferencesService>(
    () => SharedPreferencesService(),
  );

  // ---------------------------------------------------------------------------
  // Authentication Provider
  // ---------------------------------------------------------------------------

  /// Registers `AuthProvider` as a factory.
  ///
  /// Useful if a fresh instance is required each time. If shared state is
  /// necessary (e.g., for user sessions), you might consider using
  /// `registerSingleton` or `registerLazySingleton`.
  getIt.registerFactory<AuthProvider>(() => AuthProvider());

  // ---------------------------------------------------------------------------
  // Application Router
  // ---------------------------------------------------------------------------

  /// Registers `AppRouter` as a lazy singleton.
  ///
  /// Since routing is a central component and only one instance is needed
  /// throughout the application, `registerLazySingleton` ensures it is
  /// instantiated once and reused.
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
}
