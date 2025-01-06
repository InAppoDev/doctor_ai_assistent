import 'package:shared_preferences/shared_preferences.dart';

/// A service for managing key-value data using `SharedPreferences`.
///
/// Provides a centralized way to persist and retrieve data in a lightweight,
/// key-value storage system.
class SharedPreferencesService {
  // ---------------------------------------------------------------------------
  // Singleton Implementation
  // ---------------------------------------------------------------------------

  /// Internal shared preferences instance.
  static late SharedPreferences _preferences;

  /// Private named constructor for singleton implementation.
  SharedPreferencesService._internal();

  /// Factory constructor to ensure only a single instance of the service exists.
  factory SharedPreferencesService() {
    return SharedPreferencesService._internal();
  }

  // ---------------------------------------------------------------------------
  // Initialization
  // ---------------------------------------------------------------------------

  /// Lazily initializes the `SharedPreferences` instance.
  ///
  /// Ensures that the preferences object is created only when needed and reused
  /// throughout the app lifecycle.
  Future<SharedPreferences?> get _initializePrefs async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences;
  }

  // ---------------------------------------------------------------------------
  // Data Retrieval
  // ---------------------------------------------------------------------------

  /// Retrieves the value associated with the given [key].
  ///
  /// Returns `null` if the key does not exist. The returned value can be
  /// of type `String`, `int`, `double`, `bool`, or `List<String>`, depending
  /// on what was stored.
  dynamic _getData(String key) {
    var value = _preferences.get(key);
    return value;
  }

  // ---------------------------------------------------------------------------
  // Data Storage
  // ---------------------------------------------------------------------------

  /// Saves a value to `SharedPreferences` under the given [key].
  ///
  /// The method supports saving the following data types:
  /// - `String`
  /// - `int`
  /// - `double`
  /// - `bool`
  /// - `List<String>`
  ///
  /// Throws an exception if the value is of an unsupported type.
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
    } else {
      throw ArgumentError('Unsupported value type: ${value.runtimeType}');
    }
  }
}
