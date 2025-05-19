part of 'network.dart';

class RefreshTokenInterceptor extends Interceptor {
  RefreshTokenInterceptor(this._prefs)
      : _dio = Dio(BaseOptions(
          baseUrl: Endpoints.baseUrl,
          headers: {'Content-Type': 'application/json'},
        ));

  final SharedPreferences _prefs;
  final Dio _dio;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _prefs.getString(PreferencesKeys.accessToken);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final didRefresh = await _refreshToken();

        if (didRefresh) {
          final retryResponse = await _retry(err.requestOptions);
          return handler.resolve(retryResponse);
        } else {
          _handleTokenExpiration();
          return super.onError(err, handler);
        }
      } catch (e) {
        _handleTokenExpiration();
        return super.onError(err, handler);
      }
    }

    return super.onError(err, handler);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final token = _prefs.getString(PreferencesKeys.accessToken);
    print('accessToken in _retry - $token');
    if (token == null) throw Exception("No access token after refresh");

    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $token',
      },
    );

    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<bool> _refreshToken() async {
    final refreshToken = _prefs.getString(PreferencesKeys.refreshToken);
    print('refreshToken - $refreshToken');
    if (refreshToken == null) {
      _redirectToLogin();
      return false;
    }

    try {
      final response = await _dio.post<dynamic>(
        Endpoints.refresh,
        data: {
          'refresh': refreshToken,
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
        debugPrint(
            '✅ Token refreshed successfully;  newAccessToken - $newAccessToken ; newRefreshToken - $newRefreshToken ');
        return true;
      }
    } catch (e, s) {
      debugPrint('🔁 Refresh token failed: $e, stack $s');
      await _prefs.remove(PreferencesKeys.accessToken);
      await _prefs.remove(PreferencesKeys.refreshToken);
    }
    await _prefs.remove(PreferencesKeys.accessToken);
    await _prefs.remove(PreferencesKeys.refreshToken);
    _redirectToLogin();
    return false;
  }

  void _redirectToLogin() {
    final context = navigatorKey.currentContext;
    if (context != null) {
      LoginRoute().go(context);
    } else {
      debugPrint('Navigator context is null, cannot redirect to login.');
    }
  }

  void _handleTokenExpiration() async {
    final context = navigatorKey.currentContext;
    await _prefs.remove(PreferencesKeys.accessToken);
    await _prefs.remove(PreferencesKeys.refreshToken);

    if (context != null && context.mounted) {
      LoginRoute().go(context);
    } else {
      debugPrint('Navigator context is null, cannot redirect to login.');
    }
  }
}

class PrettyLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('----------------- --> ${options.method} ${options.uri}');
    debugPrint('Headers: ${options.headers}');
    debugPrint('Body: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    debugPrint(
        '------------------ <-- ${response.statusCode} ${response.requestOptions.uri}');
    debugPrint('Response: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('❌ Error: ${err.error}');
    debugPrint('Response: ${err.response?.data}');
    super.onError(err, handler);
  }
}
