/// Extension methods on [Duration] to format durations into human-readable time strings.
///
/// This extension adds methods to the [Duration] class that convert a `Duration` object into time format strings 
/// for hours and minutes or minutes and seconds. These formats are commonly used in user interfaces 
/// to display time durations in an easy-to-read format.
extension DurationExtension on Duration {

  /// Converts the [Duration] into a string formatted as "HH:mm", where HH is the number of hours 
  /// and mm is the number of minutes, excluding any days or weeks.
  ///
  /// This method works by first extracting the total hours and minutes from the [Duration] object, 
  /// then formatting them as a string with leading zeros if needed.
  ///
  /// Example:
  /// ```dart
  /// Duration(hours: 2, minutes: 45).toHourAndMinute(); // "02:45"
  /// ```
  /// The method uses `inHours` to get the total hours and `inMinutes.remainder(60)` to extract the minutes 
  /// after accounting for complete hours.
  String toHourAndMinute() {
    return '${inHours.toString().padLeft(2, '0')}:${inMinutes.remainder(60).toString().padLeft(2, '0')}';
  }

  /// Converts the [Duration] into a string formatted as "mm:ss", where mm is the number of minutes 
  /// and ss is the number of seconds, excluding any hours or larger units.
  ///
  /// This method works by extracting the total minutes and seconds from the [Duration] object, 
  /// and formatting them as a string with leading zeros if needed.
  ///
  /// Example:
  /// ```dart
  /// Duration(minutes: 5, seconds: 30).toMinuteAndSecond(); // "05:30"
  /// ```
  /// The method uses `inMinutes` to get the total minutes and `inSeconds.remainder(60)` to extract the seconds 
  /// after accounting for complete minutes.
  String toMinuteAndSecond() {
    return '${inMinutes.toString().padLeft(2, '0')}:${inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }
}
