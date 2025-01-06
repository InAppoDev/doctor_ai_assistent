import 'package:doctor_ai_assistent/features/home_page/data/models/appointment_model.dart';
import 'package:flutter/material.dart';

/// Manages the state for the home page, including selected date,
/// search bar functionality, and appointments list.
class HomeState extends ChangeNotifier {
  // ---------------------------------------------------------------------------
  // Selected Date Section
  // ---------------------------------------------------------------------------

  /// The currently selected date. Defaults to the current date.
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  /// Updates the selected date and notifies listeners of the change.
  /// 
  /// [date] - The new date selected by the user.
  void onDateSelected(DateTime date) {
    _selectedDate = date;
    notifyListeners(); // Notify UI to refresh based on the new date.
  }

  // ---------------------------------------------------------------------------
  // Search Bar Section
  // ---------------------------------------------------------------------------

  /// Controller for the search bar input field.
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  /// Tracks whether the search input is empty.
  bool _isEmpty = true;
  bool get isEmpty => _isEmpty;

  /// Updates the [_isEmpty] state to indicate whether the search field is empty.
  /// 
  /// [value] - `true` if the search field is empty; otherwise `false`.
  void setIsEmpty(bool value) {
    _isEmpty = value;
    notifyListeners(); // Trigger a rebuild for any UI dependent on this value.
  }

  /// Updates the search query in the controller and notifies listeners.
  /// 
  /// [query] - The search query entered by the user.
  void onSearch(String query) {
    _searchController.text = query; 
    notifyListeners(); // Notify UI to reflect the updated search query.
  }

  /// Handles the microphone tap for voice input (currently unimplemented).
  void onMicTap() {
    // TODO: Implement microphone functionality (e.g., voice search).
  }

  // ---------------------------------------------------------------------------
  // Appointments Section
  // ---------------------------------------------------------------------------

  /// A predefined list of appointments, each represented as an [AppointmentModel].
  /// 
  /// This list could later be fetched from a backend or dynamically updated
  /// based on user actions.
  final List<AppointmentModel> _appointments = [
    AppointmentModel(
      name: 'Anna Harney',
      birthDate: DateTime.now(),
      isReviewed: false,
      time: DateTime.now(),
    ),
    AppointmentModel(
      name: 'Anna Harney',
      birthDate: DateTime.now(),
      isReviewed: true,
      time: DateTime.now(),
      minutes: 14,
    ),
  ];
  List<AppointmentModel> get appointments => _appointments;

  // ---------------------------------------------------------------------------
  // Additional Notes
  // ---------------------------------------------------------------------------
  // 1. `_appointments` is currently hardcoded but could be replaced by
  //    API-driven logic.
  // 2. The `onMicTap` method needs implementation to make it functional.
}
