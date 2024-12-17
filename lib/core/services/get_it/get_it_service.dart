import 'package:doctor_ai_assistent/core/services/shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';


GetIt getIt = GetIt.instance;

void initDI(){

  //register shared preference
  getIt.registerFactory<SharedPreferencesService>(
          () => SharedPreferencesService());


}