import 'package:ecnx_ambient_listening/core/models/appointment_model/appointment_model.dart';
import 'package:ecnx_ambient_listening/core/models/log_model/log_model.dart';
import 'package:ecnx_ambient_listening/core/network/network.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeState extends ChangeNotifier {
  late final Network _backendService;
  late stt.SpeechToText _speech;
  bool _isListening = false;

  bool get isListening => _isListening;

  HomeState() {
    init();
    _searchController.addListener(getAppointments);
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _backendService = Network(prefs);
    _speech = stt.SpeechToText();
    await _speech.initialize();
    await getAppointments();
    await _getLogs();
    await _backendService.getForms();
  }

  List<LogModel> logs = [];

  Future<void> _getLogs() async {
    isLoading = true;
    notifyListeners();

    logs = await _backendService.getLogs();
    isLoading = false;
    notifyListeners();
  }

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  bool isLoading = false;

  void onDateSelected(DateTime date) {
    _selectedDate = date;
    notifyListeners();
    getAppointments();
  }

  LogModel? getLogByAppointment(int appointmentId) {
    if (logs.isEmpty) return null;
    for (final log in logs) {
      if (log.appointment == appointmentId) {
        return log;
      } else {
        return null;
      }
    }
    return null;
  }

  // Search Bar Section
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  bool _isEmpty = true;
  bool get isEmpty => _isEmpty;

  void setIsEmpty(bool value) {
    _isEmpty = value;
    notifyListeners();
  }

  void onSearch(String query) {
    _searchController.text = query;
    notifyListeners();
    getAppointments();
  }

  void onMicTap() async {
    if (!_isListening) {
      final available = await _speech.initialize(
        onStatus: (status) {
          if (_isListening && (status == 'done' || status == 'notListening')) {
            _speech.listen(
              listenFor: Duration(seconds: 45),
              pauseFor: Duration(seconds: 15),
              listenOptions: stt.SpeechListenOptions(
                listenMode: stt.ListenMode.dictation,
              ),
              onResult: (result) {
                final text = result.recognizedWords;
                _searchController.text = text;
                notifyListeners();
                getAppointments();
              },
              localeId: 'en_US',
            );
          }
        },
      );

      if (available) {
        _isListening = true;
        notifyListeners();
        _speech.listen(
          listenFor: Duration(seconds: 45),
          pauseFor: Duration(seconds: 15),
          listenOptions: stt.SpeechListenOptions(
            listenMode: stt.ListenMode.dictation,
          ),
          onResult: (result) {
            final text = result.recognizedWords;
            _searchController.text = text;
            notifyListeners();
            getAppointments();
          },
          localeId: 'en_US',
        );
      }
    } else {
      _speech.stop();
      _isListening = false;
      notifyListeners();
    }
  }

  final List<AppointmentModel> _appointments = [];
  List<AppointmentModel> get appointments => _appointments;

  Future<void> getAppointments() async {
    isLoading = true;
    notifyListeners();

    _appointments.clear();
    final fetchedAppointments = await _backendService.getAppointments();

    final filteredByDate = fetchedAppointments.where((appointment) {
      return _isSameDay(appointment.createdAt, _selectedDate);
    });

    final query = _searchController.text.trim().toLowerCase();

    final filtered = query.isEmpty
        ? filteredByDate.toList()
        : filteredByDate.where((appointment) {
            final firstName = appointment.firstName.toLowerCase();
            final lastName = appointment.lastName.toLowerCase();
            return firstName.contains(query) || lastName.contains(query);
          }).toList();

    _appointments.addAll(filtered);

    isLoading = false;
    notifyListeners();
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
