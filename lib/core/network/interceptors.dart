part of 'network.dart';

class RefreshTokenInterceptor extends Interceptor {
  RefreshTokenInterceptor(this._prefs)
      : _dio = Dio(BaseOptions(baseUrl: Endpoints.baseUrl));

  final SharedPreferences _prefs;
  final Dio _dio;

  bool _isRefreshing = false;

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
    // Check for 401 and not already trying to refresh
    if (err.response?.statusCode == 401 &&
        !_isRefreshing &&
        !_isRefreshRequest(err.requestOptions.path)) {
      _isRefreshing = true;

      try {
        final didRefresh = await _refreshToken();
        _isRefreshing = false;

        if (didRefresh) {
          final retryResponse = await _retry(err.requestOptions);
          return handler.resolve(retryResponse);
        } else {
          _handleTokenExpiration();
          return super.onError(err, handler);
        }
      } catch (e) {
        _isRefreshing = false;
        _handleTokenExpiration();
        return super.onError(err, handler);
      }
    }

    return super.onError(err, handler);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final token = _prefs.getString(PreferencesKeys.accessToken);
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
    if (refreshToken == null) return false;

    try {
      final response = await _dio.post<dynamic>(
        Endpoints.refresh,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $refreshToken',
        }),
      );

      if (response.statusCode != null && response.statusCode! < 300) {
        final newAccessToken = response.data['data']['access_token'] as String?;
        final newRefreshToken =
            response.data['data']['refresh_token'] as String?;

        if (newAccessToken != null) {
          await _prefs.setString(PreferencesKeys.accessToken, newAccessToken);
        }

        if (newRefreshToken != null) {
          await _prefs.setString(PreferencesKeys.refreshToken, newRefreshToken);
        }

        return true;
      }
    } catch (e) {
      debugPrint('🔁 Refresh token failed: $e');
    }

    return false;
  }

  void _handleTokenExpiration() async {
    await _prefs.remove(PreferencesKeys.accessToken);
    await _prefs.remove(PreferencesKeys.refreshToken);

    router.go('/login');
  }

  bool _isRefreshRequest(String path) {
    return path.contains(Endpoints.refresh);
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
