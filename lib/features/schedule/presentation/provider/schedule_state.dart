import 'package:flutter/material.dart';

/// Manages the state for scheduling, including user input fields, date and time selection, 
/// and available time slots. Notifies listeners of any changes.
class ScheduleState extends ChangeNotifier {
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
  /// 
  /// [dateTime] - The selected date and time for scheduling.
  void onScheduleDateTimeSelected(DateTime dateTime) {
    _scheduleDateTime = dateTime;
    notifyListeners();
  }

  // Private variable to hold the scheduled time. Defaults to the current time if not set.
  TimeOfDay? _scheduleTime;

  /// Returns the scheduled time, or the current time if not set.
  TimeOfDay get scheduleTime => _scheduleTime ?? TimeOfDay.now();

  /// Updates the scheduled time when selected and notifies listeners.
  /// 
  /// [time] - The selected time for scheduling.
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

  /// Disposes of the controllers to free up resources when no longer needed.
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dateOfBirthController.dispose();
    super.dispose();
  }
}
