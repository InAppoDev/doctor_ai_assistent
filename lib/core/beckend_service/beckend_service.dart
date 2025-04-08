import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecnx_ambient_listening/core/hive_service/hive_service.dart';
import 'package:ecnx_ambient_listening/core/models/user_model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class BackendService {
  final Dio _dio;
  final HiveStorageService _storage = HiveStorageService();

  static final _logger = Logger();

  BackendService()
      : _dio = Dio(BaseOptions(baseUrl: "http://54.80.89.40/api/v1")) {
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      logPrint: (log) => print("📦 DioLog: $log"),
    ));
    _dio.interceptors.add(InterceptorsWrapper(
        // onRequest: (options, handle) {
        //   _logger.d("URL request. token: $_accessToken");
        //   options.headers["Authorization"] = "Bearer $_accessToken";
        //   return handle.next(options);
        // },
        onResponse: (response, handler) {
      _logger.d("""
              "Response auth status code: ${response.statusCode}
              "Response auth request options: ${response.requestOptions.path}"
              "Response auth data: ${response.data}"
              "Response auth data runtimeType: ${response.data.runtimeType}"
              """);
      if (response.statusCode != null) {
        if (response.statusCode! >= 400 && response.statusCode! < 500) {
          debugPrint("statusMessage: ${response.data}");
        }
      }
      return handler.next(response);
    }, onError: (error, handler) {
      _logger.d("""
              "Response error: ${error.error}
              "Response auth request options: ${error.requestOptions.path}"
              "Response response: ${error.response}"
              """);
      return handler.next(error);
    }));
  }

  Future<Response?> getData(String endpoint) async {
    try {
      String? accessToken = _storage.getTokens()["access"];
      accessToken ??= await _refreshToken();

      if (accessToken == null) return null;

      final response = await _dio.get(
        endpoint,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );
      return response;
    } catch (e) {
      print("GET request error: $e");
      return null;
    }
  }

  Future<Response?> postData(String endpoint, Map<String, dynamic> data) async {
    try {
      String? accessToken = _storage.getTokens()["access"];
      accessToken ??= await _refreshToken();

      if (accessToken == null) return null;

      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );
      return response;
    } catch (e) {
      print("POST request error: $e");
      return null;
    }
  }

  Future<Response?> putData(String endpoint, Map<String, dynamic> data) async {
    try {
      String? accessToken = _storage.getTokens()["access"];
      accessToken ??= await _refreshToken();

      if (accessToken == null) return null;

      final response = await _dio.put(
        endpoint,
        data: data,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );
      return response;
    } catch (e) {
      print("PUT request error: $e");
      return null;
    }
  }

  Future<Response?> deleteData(String endpoint) async {
    try {
      String? accessToken = _storage.getTokens()["access"];
      accessToken ??= await _refreshToken();

      if (accessToken == null) return null;

      final response = await _dio.delete(
        endpoint,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );
      return response;
    } catch (e) {
      print("DELETE request error: $e");
      return null;
    }
  }

  Future<String?> _refreshToken() async {
    String? refreshToken = _storage.getTokens()["refresh"];
    if (refreshToken == null) return null;

    try {
      final response = await _dio.post(
        "/users/token/refresh/",
        data: {"refresh": refreshToken},
      );
      String newAccessToken = response.data["access"];
      _storage.saveTokens(newAccessToken, refreshToken);
      return newAccessToken;
    } catch (e) {
      print("Token refresh failed: $e");
      return null;
    }
  }

  Future<UserModel?> registerUser({
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String password,
  }) async {
    final data = {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phoneNumber,
      "password": password,
    };

    final response = await postData("/users/register/", data);

    if (response != null &&
        (response.statusCode == 201 || response.statusCode == 200)) {
      return UserModel.fromJson(response.data);
    } else {
      print("Registration failed: ${response?.statusCode}");
      return null;
    }
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await postData(
        "/users/login/",
        {
          "email": email,
          "password": password,
        },
      );

      if (response?.data != null) {
        final access = response!.data["access"];
        final refresh = response.data["refresh"];

        if (access != null && refresh != null) {
          _storage.saveTokens(access, refresh);

          return true;
        }
      }
      return false;
    } catch (e) {
      print("Login failed: $e");
      return false;
    }
  }

  Future<bool> tryAutoLogin() async {
    String? access = _storage.getTokens()["access"];
    String? refresh = _storage.getTokens()["refresh"];

    if (access != null) {
      return isTokenExpired(access);
    } else if (refresh != null) {
      final newAccess = await _refreshToken();
      return newAccess != null;
    }
    return false;
  }

  bool isTokenExpired(String token) {
    final parts = token.split('.');
    if (parts.length != 3) return true;

    final payload =
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    final payloadMap = json.decode(payload);

    final expiry = payloadMap['exp'];
    final expiryDate = DateTime.fromMillisecondsSinceEpoch(expiry * 1000);
    return expiryDate.isBefore(DateTime.now());
  }
}
