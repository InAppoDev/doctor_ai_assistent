import 'package:ecnx_ambient_listening/core/services/get_it/get_it_service.dart';
import 'package:ecnx_ambient_listening/features/app/ui/app.dart';
import 'package:ecnx_ambient_listening/features/auth/provider/auth_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  await Hive.openBox('authBox');
  initDI();

  final authProvider = getIt<AuthProvider>();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => authProvider),
    ],
    child: MyApp(),
  ));
}
