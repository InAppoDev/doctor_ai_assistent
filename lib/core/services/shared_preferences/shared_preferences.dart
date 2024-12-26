import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService{
  static late SharedPreferences _preferences;

  SharedPreferencesService._internal();
  factory SharedPreferencesService() {
    return SharedPreferencesService._internal();
  }

  Future<SharedPreferences?> get _initializePrefs async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences;
  }

  dynamic _getData(String key) {
    var value = _preferences.get(key);

    return value;
  }

  void _saveData(String key, dynamic value) {
    if (value is String) {
      _preferences.setString(key, value);
    } else if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    }
  }
}