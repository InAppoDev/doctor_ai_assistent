import 'dart:math';

import 'package:ecnx_ambient_listening/core/extensions/string_extension.dart';
import 'package:ecnx_ambient_listening/core/network/network.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages the state for scheduling, including user input fields, date and time selection,
/// and available time slots. Notifies listeners of any changes.
class ScheduleState extends ChangeNotifier {
  late final Network _networkService;

  ScheduleState() {
    init();
  }

  /// Initializes the backend service and any necessary setup.
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _networkService = Network(prefs);
    await fetchAvailableTimeSlots();
  }

  // TextEditingController for first name input field.
  final TextEditingController firstNameController = TextEditingController();

  // TextEditingController for last name input field.
  final TextEditingController lastNameController = TextEditingController();

  // TextEditingController for date of birth input field.
  final TextEditingController dateOfBirthController = TextEditingController();

  // Private variable to hold the scheduled date and time. Defaults to the current date if not set.
  DateTime? _scheduleDateTime;

  /// Returns the scheduled date and time, or the current date if not set.
  DateTime get scheduleDateTime => _scheduleDateTime ?? DateTime.now();

  /// Updates the scheduled date and time when selected and notifies listeners.
  void onScheduleDateTimeSelected(DateTime dateTime) {
    _scheduleDateTime = dateTime;
    notifyListeners();
  }

  // Private variable to hold the scheduled time. Defaults to the current time if not set.
  TimeOfDay? _scheduleTime;

  /// Returns the scheduled time, or the current time if not set.
  TimeOfDay get scheduleTime => _scheduleTime ?? TimeOfDay.now();

  /// Updates the scheduled time when selected and notifies listeners.
  void onScheduleTimeSelected(TimeOfDay time) {
    _scheduleTime = time;
    notifyListeners();
  }

  // List of available times for scheduling. These times are predefined.
  final List<TimeOfDay> _availableTimes = const [
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 10, minute: 0),
    TimeOfDay(hour: 11, minute: 0),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 13, minute: 0),
    TimeOfDay(hour: 14, minute: 0),
    TimeOfDay(hour: 15, minute: 0),
    TimeOfDay(hour: 16, minute: 0),
    TimeOfDay(hour: 17, minute: 0),
    TimeOfDay(hour: 18, minute: 0),
    TimeOfDay(hour: 19, minute: 0),
    TimeOfDay(hour: 20, minute: 0),
  ];

  /// Returns the list of available times for scheduling.
  List<TimeOfDay> get availableTimes => _availableTimes;

  /// For fetching the available time slots for scheduling.
  /// This method should be replaced with the actual API call.
  Future<void> fetchAvailableTimeSlots() async {
    try {
      // Fetch available time slots from the API.
    } catch (e) {
      debugPrint('Error fetching available time slots: $e');
    }
  }

  Future<void> savePatientScheduleAndCreateForm() async {
    await _networkService.createAppointment(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      birth: dateOfBirthController.text.toDateTime(),
      when: scheduleDateTime,
      physician: 'Lucas Cooper',
      record: _getRandom7DigitNumber().toString(),
    );
    await _createForm();
  }

  int _getRandom7DigitNumber() {
    final random = Random();
    return 1000000 + random.nextInt(9000000);
  }

  Future<void> _createForm() async {
    await _networkService.createForm(
        name: firstNameController.text.trim() + lastNameController.text.trim());
  }

  /// Disposes of the controllers to free up resources when no longer needed.
  @override
  void dispose() {
    debugPrint('ScheduleState disposed');
    firstNameController.dispose();
    lastNameController.dispose();
    dateOfBirthController.dispose();
    super.dispose();
  }
}
