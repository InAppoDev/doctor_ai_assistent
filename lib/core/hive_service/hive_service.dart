import 'package:hive/hive.dart';

class HiveStorageService {
  final Box _authBox = Hive.box('authBox');

  void saveTokens(String access, String refresh) {
    _authBox.put('access_token', access);
    _authBox.put('refresh_token', refresh);
  }

  Map<String, String?> getTokens() {
    return {
      "access": _authBox.get('access_token'),
      "refresh": _authBox.get('refresh_token'),
    };
  }

  void clearTokens() {
    _authBox.delete('access_token');
    _authBox.delete('refresh_token');
  }
}
