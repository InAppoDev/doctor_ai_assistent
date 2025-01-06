import 'package:flutter/material.dart';

class ScheduleState extends ChangeNotifier {
  // first name controller
  final TextEditingController firstNameController = TextEditingController();

  // last name controller
  final TextEditingController lastNameController = TextEditingController();

  // date of birth controller
  final TextEditingController dateOfBirthController = TextEditingController();

  // schedule datetime
  DateTime? _scheduleDateTime;
  DateTime get scheduleDateTime => _scheduleDateTime ?? DateTime.now();

  void onScheduleDateTimeSelected(DateTime dateTime) {
    _scheduleDateTime = dateTime;
    notifyListeners();
  }

  // schedule time
  TimeOfDay? _scheduleTime;
  TimeOfDay get scheduleTime => _scheduleTime ?? TimeOfDay.now();

  void onScheduleTimeSelected(TimeOfDay time) {
    _scheduleTime = time;
    notifyListeners();
  }

  // list of available times
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
  List<TimeOfDay> get availableTimes => _availableTimes;
  

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dateOfBirthController.dispose();
    super.dispose();
  }
}
