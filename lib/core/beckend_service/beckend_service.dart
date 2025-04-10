import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecnx_ambient_listening/core/hive_service/hive_service.dart';
import 'package:ecnx_ambient_listening/core/models/user_model/user_model.dart';
import 'package:logger/logger.dart';

enum RequestType {
  get,
  put,
  post,
  delete,
}

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
      logPrint: (log) => _logger.d("📦 DioLog: $log"),
    ));
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request, handler) {
        _logger.d("""
            Request Path: ${request.path}
            Request Data: ${request.data} 
            Request queryParameters: ${request.queryParameters}
        """);
        return handler.next(request);
      },
      onResponse: (response, handler) {
        _logger.d("""
            Response Status Code: ${response.statusCode}
            Request Path: ${response.requestOptions.path}
            Response Data: ${response.data}
        """);
        if (response.statusCode != null &&
            response.statusCode! >= 400 &&
            response.statusCode! < 500) {
          _logger.e("Client error: ${response.data}");
        }
        return handler.next(response);
      },
      onError: (error, handler) {
        _logger.e("""
            Error: ${error.error}
            Request Path: ${error.requestOptions.path}
            Response: ${error.response}
        """);
        return handler.next(error);
      },
    ));
  }

  Future<Response?> _makeRequest({
    required RequestType requestType,
    required String endpoint,
    Map<String, dynamic>? data,
    bool requiresAuth = true,
  }) async {
    try {
      String? accessToken;
      if (requiresAuth) {
        accessToken = _storage.getTokens()["access"];
        accessToken ??= await _refreshToken();

        if (accessToken == null) {
          _logger.e("Access token is required but missing or expired");
          return null;
        }
      }

      final options = accessToken != null
          ? Options(headers: {"Authorization": "Bearer $accessToken"})
          : Options();

      Response response;

      switch (requestType) {
        case RequestType.get:
          response = await _dio.get(endpoint, options: options);
          break;
        case RequestType.post:
          response = await _dio.post(endpoint, data: data, options: options);
          break;
        case RequestType.put:
          response = await _dio.put(endpoint, data: data, options: options);
          break;
        case RequestType.delete:
          response = await _dio.delete(endpoint, options: options);
          break;
      }

      return response;
    } catch (e) {
      _logger.e("Request error: $e");
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
      _logger.e("Token refresh failed: $e");
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

    final response = await _makeRequest(
      requestType: RequestType.post,
      endpoint: '/users/register/',
      data: data,
      requiresAuth: false,
    );
    if (response?.statusCode == 201) {
      return UserModel.fromJson(response!.data);
    } else {
      _logger.e("Registration failed: ${response?.data}");
      return null;
    }
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    final response = await _makeRequest(
      requestType: RequestType.post,
      endpoint: '/users/login/',
      data: {
        "email": email,
        "password": password,
      },
      requiresAuth: false,
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
  }

  Future<bool> tryAutoLogin() async {
    String? access = _storage.getTokens()["access"];
    String? refresh = _storage.getTokens()["refresh"];

    if (access != null && !isTokenExpired(access)) {
      return true;
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
