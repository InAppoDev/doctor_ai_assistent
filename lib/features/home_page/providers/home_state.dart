import 'package:ecnx_ambient_listening/core/models/appointment_model/appointment_model.dart';
import 'package:ecnx_ambient_listening/core/models/log_model/log_model.dart';
import 'package:ecnx_ambient_listening/core/network/network.dart';
import 'package:ecnx_ambient_listening/core/speech_to_text/speech_to_text_service.dart';
import 'package:ecnx_ambient_listening/core/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class HomeState extends ChangeNotifier {
  late final Network _backendService;
  final SpeechToTextService _speechService = SpeechToTextService();
  bool _isListening = false;

  bool get isListening => _isListening;

  HomeState() {
    init();
    _searchController.addListener(getAppointments);
  }

  Future<void> init() async {
    print('init called');
    final prefs = await SharedPreferences.getInstance();
    _backendService = Network(prefs);
    await getAppointments();
    await _getLogs();
    await _backendService.getForms();
    await _speechService.init();
    print('init finished');
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
      }
    }

    return null;
  }

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
    if (isListening) {
      _speechService.stopListening();
      _isListening = false;
      notifyListeners();
      return;
    }

    _isListening = true;
    notifyListeners();

    try {
      await _speechService.startListening((SpeechRecognitionResult result) {
        final recognizedText = result.recognizedWords;

        _searchController.text +=
            (recognizedText.isNotEmpty ? ' $recognizedText' : '');

        _searchController.selection = TextSelection.fromPosition(
          TextPosition(offset: _searchController.text.length),
        );

        notifyListeners();
      });
    } catch (e) {
      showToast('Microphone error');
      debugPrint('Error in onMicTap: $e');
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
        ? filteredByDate
        : filteredByDate.where((appointment) {
            final firstName = appointment.firstName.toLowerCase();
            final lastName = appointment.lastName.toLowerCase();
            return firstName.contains(query) || lastName.contains(query);
          });

    final seenIds = <int>{};
    final uniqueFiltered = <AppointmentModel>[];

    for (var appt in filtered) {
      if (!seenIds.contains(appt.id)) {
        seenIds.add(appt.id);
        uniqueFiltered.add(appt);
      }
    }

    _appointments.addAll(uniqueFiltered);

    isLoading = false;
    notifyListeners();
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
