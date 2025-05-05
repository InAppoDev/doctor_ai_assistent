import 'package:ecnx_ambient_listening/core/prefs.dart';
import 'package:hive/hive.dart';

class HiveStorageService {
  final Box _authBox = Hive.box('authBox');

  void saveTokens(String access, String refresh) {
    _authBox.put(PreferencesKeys.accessToken, access);
    _authBox.put(PreferencesKeys.refreshToken, refresh);
  }

  Map<String, String?> getTokens() {
    print(
        'access: ${_authBox.get(PreferencesKeys.accessToken)}; refresh: ${_authBox.get(PreferencesKeys.refreshToken)}');
    return {
      "access": _authBox.get(PreferencesKeys.accessToken),
      "refresh": _authBox.get(PreferencesKeys.refreshToken),
    };
  }

  void clearTokens() {
    _authBox.delete(PreferencesKeys.accessToken);
    _authBox.delete(PreferencesKeys.refreshToken);
  }
}
