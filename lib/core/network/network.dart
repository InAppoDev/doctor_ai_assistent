import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecnx_ambient_listening/core/constants/consts.dart';
import 'package:ecnx_ambient_listening/core/models/appointment_model/appointment_model.dart';
import 'package:ecnx_ambient_listening/core/models/chunk_model/chunk_model.dart';
import 'package:ecnx_ambient_listening/core/models/form_model/form_model.dart';
import 'package:ecnx_ambient_listening/core/models/log_model/log_model.dart';
import 'package:ecnx_ambient_listening/core/models/user_model/user_model.dart';
import 'package:ecnx_ambient_listening/core/navigation/routes.dart';
import 'package:ecnx_ambient_listening/core/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/pages/login/controllers/auth_controller.dart';
import 'api_exception.dart';

part 'endpoints.dart';
part 'interceptors.dart';

enum RequestType {
  get,
  put,
  post,
  patch,
  delete,
}

class Network {
  final Dio _dio;
  final SharedPreferences _prefs;

  static final _logger = Logger();

  Network(this._prefs) : _dio = Dio(BaseOptions(baseUrl: Endpoints.baseUrl)) {
    addInterceptor();
  }

  Future<Response?> _makeRequest({
    required RequestType requestType,
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      late Response response;
      final options = Options(headers: headers);
      switch (requestType) {
        case RequestType.get:
          response = await _dio.get(endpoint,
              queryParameters: queryParameters, options: options);
          break;
        case RequestType.post:
          response = await _dio.post(endpoint,
              queryParameters: queryParameters, options: options, data: data);
          break;
        case RequestType.put:
          response = await _dio.put(endpoint,
              queryParameters: queryParameters, options: options, data: data);
          break;
        case RequestType.patch:
          response = await _dio.patch(endpoint,
              queryParameters: queryParameters, options: options, data: data);
          break;
        case RequestType.delete:
          response = await _dio.delete(endpoint,
              queryParameters: queryParameters, options: options);
          break;
      }

      return response;
    } catch (e, stackTrace) {
      _logger.e("Request to $endpoint failed: $e",
          error: e, stackTrace: stackTrace);
      return null;
    }
  }

  Future<void> autoLogin() async {
    final accessToken = _prefs.getString(PreferencesKeys.accessToken);
    final refreshToken = _prefs.getString(PreferencesKeys.refreshToken);

    if (accessToken != null && refreshToken != null) {
      try {
        AuthController.authorized = true;
      } on DioException catch (e) {
        final exception = handleException(e);
        if (exception is HttpError && exception.statusCode == 401) {
          await refreshTokens(refreshToken: refreshToken);
        } else {
          AuthController.authorized = false;
        }
      } catch (_) {
        AuthController.authorized = false;
      }
    }
  }

  // --- User Authentication Methods ---
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
      endpoint: Endpoints.register,
      data: data,
    );
    if (response?.statusCode == 201) {
      return UserModel.fromJson(response!.data);
    } else {
      _logger.e("Registration failed: ${response?.data}");
      return null;
    }
  }

  Future<UserModel?> getUserData() async {
    final response = await _makeRequest(
      requestType: RequestType.get,
      endpoint: Endpoints.me,
    );
    if (response != null &&
        response.data != null &&
        response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      _logger.e("getUserData failed: ${response?.data}");
      return null;
    }
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    final response = await _makeRequest(
      requestType: RequestType.post,
      endpoint: Endpoints.login,
      data: {
        "email": email,
        "password": password,
      },
    );

    if (response?.statusCode == 200 && response?.data != null) {
      final access = response!.data["access"];
      final refresh = response.data["refresh"];
      if (access != null && refresh != null) {
        _prefs.setString(PreferencesKeys.accessToken, access);
        _prefs.setString(PreferencesKeys.refreshToken, refresh);
        return true;
      }
    }
    return false;
  }

  Future<bool> refreshTokens({
    required String refreshToken,
  }) async {
    final response = await _makeRequest(
      requestType: RequestType.post,
      endpoint: Endpoints.refresh,
      data: {
        "refresh": refreshToken,
      },
    );

    if (response?.data != null) {
      final access = response!.data["access"];
      final refresh = response.data["refresh"];
      if (access != null && refresh != null) {
        _prefs.setString(PreferencesKeys.accessToken, access);
        _prefs.setString(PreferencesKeys.refreshToken, refresh);
        return true;
      }
    }
    return false;
  }

  // --- Appointment Methods ---
  Future<List<AppointmentModel>> getAppointments() async {
    final response = await _makeRequest(
      requestType: RequestType.get,
      endpoint: Endpoints.appointments,
    );

    if (response?.statusCode == 200 && response?.data is List) {
      return (response!.data as List)
          .map((item) => AppointmentModel.fromJson(item))
          .toList();
    } else {
      _logger.e("Failed to fetch appointments: ${response?.data}");
      return [];
    }
  }

  Future<AppointmentModel?> createAppointment({
    required String firstName,
    required String lastName,
    required String physician,
    required String record,
    required DateTime birth,
    required DateTime when,
  }) async {
    final data = {
      "first_name": firstName,
      "last_name": lastName,
      "physician": physician,
      "record": record,
      "birth": birth.toIso8601String(),
      "when": when.toIso8601String(),
    };

    final response = await _makeRequest(
      requestType: RequestType.post,
      endpoint: Endpoints.createAppointment,
      data: data,
    );

    if (response?.statusCode == 201) {
      return AppointmentModel.fromJson(response!.data);
    } else {
      _logger.e("Failed to create appointment: ${response?.data}");
      return null;
    }
  }

  Future<AppointmentModel?> getAppointmentById(int id) async {
    final response = await _makeRequest(
      requestType: RequestType.get,
      endpoint: Endpoints.getAppointment(id),
    );

    if (response?.statusCode == 200) {
      return AppointmentModel.fromJson(response?.data);
    } else {
      _logger.e("Failed to fetch appointment: ${response?.data}");
      return null;
    }
  }

  Future<Map<String, dynamic>?> updateAppointment({
    required int id,
    required String firstName,
    required String lastName,
    required String birth,
    required String when,
  }) async {
    final data = {
      "first_name": firstName,
      "last_name": lastName,
      "birth": birth,
      "when": when,
    };

    final response = await _makeRequest(
      requestType: RequestType.put,
      endpoint: Endpoints.updateAppointment(id),
      data: data,
    );

    if (response?.statusCode == 200) {
      return response!.data;
    } else {
      _logger.e("Failed to update appointment: ${response?.data}");
      return null;
    }
  }

  Future<bool> deleteAppointment(int id) async {
    final response = await _makeRequest(
      requestType: RequestType.delete,
      endpoint: Endpoints.deleteAppointment(id),
    );

    if (response?.statusCode == 204) {
      return true;
    } else {
      _logger.e("Failed to delete appointment: ${response?.data}");
      return false;
    }
  }

  // --- Log Methods ---
  Future<List<LogModel>> getLogs() async {
    final response = await _makeRequest(
      requestType: RequestType.get,
      endpoint: Endpoints.logs,
    );

    if (response?.statusCode == 200 && response?.data is List) {
      return (response!.data as List)
          .map((item) => LogModel.fromJson(item))
          .toList();
    } else {
      _logger.e("Failed to fetch logs: ${response?.data}");
      return [];
    }
  }

  Future<LogModel?> createLog({
    required String key,
    required double duration,
    required int form,
    required int appointment,
  }) async {
    final data = {
      "key": key,
      "duration": duration,
      "form": form,
      "appointment": appointment,
    };

    final response = await _makeRequest(
      requestType: RequestType.post,
      endpoint: Endpoints.createLog,
      data: data,
    );

    if (response?.statusCode == 201) {
      return LogModel.fromJson(response!.data);
    } else {
      _logger.e("Failed to create log: ${response?.data}");
      return null;
    }
  }

  Future<LogModel?> getLogById(int id) async {
    final response = await _makeRequest(
      requestType: RequestType.get,
      endpoint: Endpoints.log(id),
    );

    if (response?.statusCode == 200) {
      return LogModel.fromJson(response!.data);
    } else {
      _logger.e("Failed to fetch log: ${response?.data}");
      return null;
    }
  }

  Future<Map<String, dynamic>?> updateLog({
    required int id,
    required String message,
    required String level,
    required String timestamp,
  }) async {
    final data = {
      "message": message,
      "level": level,
      "timestamp": timestamp,
    };

    final response = await _makeRequest(
      requestType: RequestType.put,
      endpoint: Endpoints.updateLog(id),
      data: data,
    );

    if (response?.statusCode == 200) {
      return response!.data;
    } else {
      _logger.e("Failed to update log: ${response?.data}");
      return null;
    }
  }

  Future<bool> deleteLog(int id) async {
    final response = await _makeRequest(
      requestType: RequestType.delete,
      endpoint: Endpoints.deleteLog(id),
    );

    if (response?.statusCode == 204) {
      return true;
    } else {
      _logger.e("Failed to delete log: ${response?.data}");
      return false;
    }
  }

  // --- Form Methods ---
  Future<List<FormModel>> getForms() async {
    final response = await _makeRequest(
      requestType: RequestType.get,
      endpoint: Endpoints.forms,
    );

    if (response?.statusCode == 200 && response?.data is List) {
      return (response!.data as List)
          .map((item) => FormModel.fromJson(item))
          .toList();
    } else {
      _logger.e("Failed to fetch forms: ${response?.data}");
      return [];
    }
  }

  Future<FormModel?> createForm({
    required String name,
  }) async {
    final data = {
      "name": name,
    };

    final response = await _makeRequest(
      requestType: RequestType.post,
      endpoint: Endpoints.createForm,
      data: data,
    );

    if (response?.statusCode == 201) {
      return FormModel.fromJson(response!.data);
    } else {
      _logger.e("Failed to create form: ${response?.data}");
      return null;
    }
  }

  Future<FormModel?> getFormById(int id) async {
    final response = await _makeRequest(
      requestType: RequestType.get,
      endpoint: Endpoints.form(id),
    );

    if (response?.statusCode == 200) {
      return FormModel.fromJson(response!.data);
    } else {
      _logger.e("Failed to fetch form: ${response?.data}");
      return null;
    }
  }

  Future<Map<String, dynamic>?> updateForm({
    required int id,
    required String name,
    required String conclusion,
  }) async {
    final data = {
      "name": name,
      "conclusion": conclusion,
    };

    final response = await _makeRequest(
      requestType: RequestType.put,
      endpoint: Endpoints.updateForm(id),
      data: data,
    );

    if (response?.statusCode == 200) {
      return response!.data;
    } else {
      _logger.e("Failed to update form: ${response?.data}");
      return null;
    }
  }

  Future<bool> deleteForm(int id) async {
    final response = await _makeRequest(
      requestType: RequestType.delete,
      endpoint: Endpoints.deleteForm(id),
    );

    if (response?.statusCode == 204) {
      return true;
    } else {
      _logger.e("Failed to delete form: ${response?.data}");
      return false;
    }
  }

  // --- Chunk Methods ---
  Future<List<ChunkModel>> getChunks() async {
    final response = await _makeRequest(
      requestType: RequestType.get,
      endpoint: Endpoints.logChunks,
    );

    if (response?.statusCode == 200 && response?.data is List) {
      return (response!.data as List)
          .map((item) => ChunkModel.fromJson(item))
          .toList();
    } else {
      _logger.e("Failed to fetch chunks: ${response?.data}");
      return [];
    }
  }

  Future<ChunkModel?> createChunk({
    required int speaker,
    required String transcription,
    required double time,
    required int logId,
  }) async {
    final data = {
      "speaker": speaker,
      "transcription": transcription,
      "time": time,
      "log": logId,
    };

    final response = await _makeRequest(
      requestType: RequestType.post,
      endpoint: Endpoints.createLogChunk,
      data: data,
    );

    if (response?.statusCode == 201) {
      return ChunkModel.fromJson(response!.data);
    } else {
      _logger.e("Failed to create chunk: ${response?.data}");
      return null;
    }
  }

  Future<ChunkModel?> getChunkById(int id) async {
    final response = await _makeRequest(
      requestType: RequestType.get,
      endpoint: Endpoints.getLogChunk(id),
    );

    if (response?.statusCode == 200) {
      return ChunkModel.fromJson(response!.data);
    } else {
      _logger.e("Failed to fetch chunk: ${response?.data}");
      return null;
    }
  }

  Future<Map<String, dynamic>?> updateChunk({
    required int id,
    required String speaker,
    required String transcription,
    required double time,
    required int log,
  }) async {
    final data = {
      "speaker": speaker,
      "transcription": transcription,
      "time": time,
      "log": log,
    };

    final response = await _makeRequest(
      requestType: RequestType.put,
      endpoint: Endpoints.updateLogChunk(id),
      data: data,
    );

    if (response?.statusCode == 200) {
      return response!.data;
    } else {
      _logger.e("Failed to update chunk: ${response?.data}");
      return null;
    }
  }

  Future<bool> deleteChunk(int id) async {
    final response = await _makeRequest(
      requestType: RequestType.delete,
      endpoint: Endpoints.deleteLogChunk(id),
    );

    if (response?.statusCode == 204) {
      return true;
    } else {
      _logger.e("Failed to delete chunk: ${response?.data}");
      return false;
    }
  }

  ApiException handleException(Object err) {
    log('HttpError: $err');
    if (err is DioException) {
      final response = err.response?.data.toString() ?? '-';
      final request = {
        err.requestOptions.baseUrl,
        err.requestOptions.path,
        err.requestOptions.data,
      };
      log('Response: $response\nRequest: $request');
      return _handleDioException(err);
    } else {
      return _handleUnknownException(err);
    }
  }

  ApiException _handleDioException(DioException err) {
    String message;

    if (err.type == DioExceptionType.connectionError) {
      return const ConnectionError();
    }

    final data = err.response?.data;
    if (data is Map<String, dynamic>) {
      final error = data['error'];
      if (error is Map<String, dynamic> && error['message'] is String) {
        message = error['message'] as String;
      } else {
        message = 'Unexpected error format';
      }
    } else if (err.message != null) {
      message = err.message!;
    } else {
      message = 'Something went wrong';
    }

    return HttpError(
      message: message,
      statusCode: err.response?.statusCode ?? 400,
    );
  }

  HttpError _handleUnknownException(Object err) {
    return HttpError(message: err.toString(), statusCode: 400);
  }

  void addInterceptor() {
    _dio
      ..interceptors.add(RefreshTokenInterceptor(_prefs))
      ..interceptors.add(PrettyLoggerInterceptor());
  }
}
