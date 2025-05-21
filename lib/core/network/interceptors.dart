part of 'network.dart';

class RefreshTokenInterceptor extends Interceptor {
  RefreshTokenInterceptor(this._prefs)
      : _dio = Dio(BaseOptions(
          baseUrl: Endpoints.baseUrl,
          headers: {'Content-Type': 'application/json'},
        ));

  final SharedPreferences _prefs;
  final Dio _dio;

  Completer<void>? _tokenRefreshing;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll(_authHeaders());
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final is401 = err.response?.statusCode == 401;
    final isRefreshEndpoint = err.requestOptions.path.contains('refreshToken');
    final alreadyRetried = err.requestOptions.headers['x-retried'] == 'true';

    if (!is401 || isRefreshEndpoint || alreadyRetried) {
      return super.onError(err, handler);
    }

    if (_tokenRefreshing != null) {
      await _tokenRefreshing!.future;
    } else {
      _tokenRefreshing = Completer<void>();
      final success = await _refreshToken();
      _tokenRefreshing!.complete();
      _tokenRefreshing = null;

      if (!success) {
        await _prefs.clear();
        super.onError(err, handler);
        _redirectToLogin();
        return;
      }
    }

    try {
      final response = await _retry(err.requestOptions);
      handler.resolve(response);
    } catch (_) {
      return super.onError(err, handler);
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        ..._authHeaders(),
        'x-retried': 'true',
      },
    );

    debugPrint(
      '🔁 Retrying request: ${requestOptions.method} ${requestOptions.path}',
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
    if (refreshToken == null) {
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

  Map<String, String> _authHeaders() {
    final token = _prefs.getString(PreferencesKeys.accessToken);
    return token != null ? {'Authorization': 'Bearer $token'} : {};
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
