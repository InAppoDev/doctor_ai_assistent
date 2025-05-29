import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecnx_ambient_listening/core/network/network.dart';
import 'package:ecnx_ambient_listening/core/prefs.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final SharedPreferences _prefs;
  final Dio _dio = Dio(BaseOptions(
    baseUrl: Endpoints.baseUrl,
    headers: {'Content-Type': 'application/json'},
  ));

  AuthService(this._prefs);

  String? get accessToken => _prefs.getString(PreferencesKeys.accessToken);
  String? get refreshToken => _prefs.getString(PreferencesKeys.refreshToken);

  Future<bool> refreshTokenAction() async {
    final currentRefreshToken = refreshToken;
    if (currentRefreshToken == null) {
      debugPrint('⚠️ No refresh token available.');
      await clearTokens();
      return false;
    }

    try {
      final response = await _dio.post(
        Endpoints.refresh,
        data: {
          'refresh': currentRefreshToken,
        },
      );

      if (response.statusCode != null && response.statusCode! < 300) {
        final newAccessToken = response.data['access'] as String?;
        final newRefreshToken = response.data['refresh'] as String?;

        if (newAccessToken != null) {
          await _prefs.setString(PreferencesKeys.accessToken, newAccessToken);
        }

        if (newRefreshToken != null) {
          await _prefs.setString(PreferencesKeys.refreshToken, newRefreshToken);
        }

        debugPrint('🔁 Token refresh successful.');
        return true;
      } else {
        debugPrint('❌ Token refresh failed: ${response.statusCode}');
        await clearTokens();
        return false;
      }
    } catch (e) {
      debugPrint('❌ Exception during token refresh: $e');
      await clearTokens();
      return false;
    }
  }

  Future<void> clearTokens() async {
    await _prefs.remove(PreferencesKeys.accessToken);
    await _prefs.remove(PreferencesKeys.refreshToken);
  }

  Map<String, dynamic>? _decodeJwtPayload(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = base64Url.normalize(parts[1]);
      final payloadMap = json.decode(utf8.decode(base64Url.decode(payload)));

      if (payloadMap is! Map<String, dynamic>) return null;
      return payloadMap;
    } catch (_) {
      return null;
    }
  }

  Future<bool> isAccessTokenValid({int bufferInSeconds = 30}) async {
    final token = accessToken;
    if (token == null) return false;

    final payload = _decodeJwtPayload(token);
    final exp = payload?['exp'];
    if (exp == null) return false;

    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return exp - now > bufferInSeconds;
  }
}
