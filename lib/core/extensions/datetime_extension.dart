/// Extension methods on [DateTime] that provide additional functionality for formatting date and time in human-readable formats.
///
/// This extension adds several methods to the `DateTime` class that convert a `DateTime` object into various formatted strings.
/// These include full and short month names, weekday names, and time formats commonly used in user interfaces or reports.
extension DateTimeExtension on DateTime {
  /// Returns the full month name and the day of the month as a string.
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().toNameOfMonthAndDay(); // "January 6"
  /// ```
  String toNameOfMonthAndDay() {
    return '${getMonthName()} $day';
  }

  String toShortNameOfMonthAndDay() {
    return '${getShortMonthName()} $day';
  }

  /// Returns the time in "HH:mm" format (24-hour format).
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().toHourAndMinute(); // "14:30"
  /// ```
  String toHourAndMinute() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  /// Returns the full month name corresponding to the [DateTime]'s [month] property.
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().getMonthName(); // "January"
  /// ```
  /// This method handles the conversion of the [month] integer (1-12) to a readable month name.
  String getMonthName() {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'Wrong month'; // Default case to handle unexpected values
    }
  }

  /// Returns the abbreviated (short) month name corresponding to the [DateTime]'s [month] property.
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().getShortMonthName(); // "Jan"
  /// ```
  /// This method provides a shorter version of the month name (e.g., "Jan" for January).
  String getShortMonthName() {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return 'No data'; // Default case in case of unexpected month values
    }
  }

  /// Returns the full weekday name corresponding to the [DateTime]'s [weekday] property.
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().getWeekDay(); // "Friday"
  /// ```
  /// The method returns the full weekday name (e.g., "Monday" for weekday 1).
  String getWeekDay() {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'No data'; // Default case to handle unexpected values
    }
  }

  /// Returns the time in a 12-hour format with AM/PM notation (e.g., "03:45 PM").
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().toUSAtimeString(); // "03:45 PM"
  /// ```
  /// This method formats the [DateTime] object into a string with the 12-hour time format.
  /// It uses "AM" for times before noon and "PM" for times after noon.
  String toUSAtimeString() {
    final hour = this.hour > 12 ? this.hour - 12 : this.hour;
    final minute = this.minute.toString().padLeft(2, '0');
    final period = this.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  String toUSAhourString() {
    final hour = this.hour > 12 ? this.hour - 12 : this.hour;
    final period = this.hour >= 12 ? 'PM' : 'AM';
    return '$hour$period';
  }

  String toUSAtimeWithoutPeriod() {
    final hour = this.hour > 12 ? this.hour - 12 : this.hour;
    final minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String getFormattedBirth() {
    final now = DateTime.now();
    int age = now.year - year;

    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }

    final shortMonth = getShortMonthName();
    return '$age yo, $shortMonth, $day, $year';
  }
}
