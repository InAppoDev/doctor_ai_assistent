part of 'network.dart';

abstract class Endpoints {
  static const String baseUrl = 'https://ecnx.org/api/v1';

  // Forms
  static const String forms = '$baseUrl/forms/';
  static String form(int id) => '$forms$id/';
  static String createForm = forms;
  static String updateForm(int id) => '$forms$id/';
  static String partialUpdateForm(int id) => '$forms$id/';
  static String deleteForm(int id) => '$forms$id/';

  // Appointments
  static const String appointments = '$baseUrl/appointments/';
  static String getAppointment(int id) => '$appointments$id/';
  static String createAppointment = appointments;
  static String updateAppointment(int id) => '$appointments$id/';
  static String partialUpdateAppointment(int id) => '$appointments$id/';
  static String deleteAppointment(int id) => '$appointments$id/';

  // Logs
  static const String logs = '$baseUrl/logs/';
  static String log(int id) => '$logs$id/';
  static String createLog = logs;
  static String updateLog(int id) => '$logs$id/';
  static String partialUpdateLog(int id) => '$logs$id/';
  static String deleteLog(int id) => '$logs$id/';

  // Log Chunks
  static const String logChunks = '${logs}chunks/';
  static String getLogChunk(int id) => '$logChunks$id/';
  static String createLogChunk = logChunks;
  static String updateLogChunk(int id) => '$logChunks$id/';
  static String partialUpdateLogChunk(int id) => '$logChunks$id/';
  static String deleteLogChunk(int id) => '$logChunks$id/';

  // Users
  static const String users = '$baseUrl/users/';
  static const String login = '${users}login/';
  static const String refresh = '${users}refresh/';
  static const String register = '${users}register/';
  static const String verify = '${users}verify/';
}
