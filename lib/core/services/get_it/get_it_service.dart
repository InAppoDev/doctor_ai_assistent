import 'package:doctor_ai_assistent/core/navigation/app_route_config.dart';
import 'package:doctor_ai_assistent/core/services/shared_preferences/shared_preferences.dart';
import 'package:doctor_ai_assistent/features/auth/provider/auth_provider.dart';
import 'package:get_it/get_it.dart';


GetIt getIt = GetIt.instance;

void initDI(){

  //register shared preference
  getIt.registerFactory<SharedPreferencesService>(
          () => SharedPreferencesService());

  // register auth provider
  getIt.registerFactory<AuthProvider>(() => AuthProvider());

  // register app router
  getIt.registerFactory<AppRouter>(() => AppRouter());
}