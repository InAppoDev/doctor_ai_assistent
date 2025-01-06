import 'package:doctor_ai_assistent/features/home_page/data/models/appointment_model.dart';
import 'package:flutter/material.dart';

class HomeState extends ChangeNotifier {
  // selected date
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  void onDateSelected(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  // search bar controller
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  bool _isEmpty = true;
  bool get isEmpty => _isEmpty;

  void setIsEmpty(bool value) {
    _isEmpty = value;
    notifyListeners();
  }

  // appointments list
  final List<AppointmentModel> _appointments = [
    AppointmentModel(name: 'Anna Harney', birthDate: DateTime.now(), isReviewed: false, time: DateTime.now()),
    AppointmentModel(
        name: 'Anna Harney', birthDate: DateTime.now(), isReviewed: true, time: DateTime.now(), minutes: 14)
  ];
  List<AppointmentModel> get appointments => _appointments;

  void onSearch(String query) {
    _searchController.text = query;
    notifyListeners();
  }

  void onMicTap() {
    // handle mic tap
  }
}
