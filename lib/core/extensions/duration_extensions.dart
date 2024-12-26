extension DurationExtension on Duration {
  String toHourAndMinute() {
    return '${inHours.toString().padLeft(2, '0')}:${inMinutes.remainder(60).toString().padLeft(2, '0')}';
  }

  String toMinuteAndSecond() {
    return '${inMinutes.toString().padLeft(2, '0')}:${inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }
}