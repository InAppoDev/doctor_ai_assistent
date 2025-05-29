extension StringToDateTimeExtension on String {
  DateTime toDateTime() {
    final parts = this.split('/');
    if (parts.length == 3) {
      final month = int.tryParse(parts[0]) ?? 1;
      final day = int.tryParse(parts[1]) ?? 1;
      final year = int.tryParse(parts[2]) ?? DateTime.now().year;
      return DateTime(year, month, day);
    }
    throw FormatException('Invalid date format. Expected MM/DD/YYYY.');
  }
}
