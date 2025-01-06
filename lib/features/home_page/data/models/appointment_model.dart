import 'package:doctor_ai_assistent/core/extensions/datetime_extension.dart';
/// The AppointmentModel data model should be changed to the actual data model
class AppointmentModel {
  final String name;
  final DateTime birthDate;
  final bool isReviewed;
  final DateTime time;
  final double? minutes;

  const AppointmentModel({
    required this.name,
    required this.birthDate,
    required this.isReviewed,
    required this.time,
    this.minutes,
  });

  String getFormattedBirthDate() {
    final age = DateTime.now().year - birthDate.year -
        (DateTime.now().isBefore(DateTime(
          DateTime.now().year,
          birthDate.month,
          birthDate.day,
        ))
            ? 1
            : 0);

    final formattedDate =
        '${birthDate.getShortMonthName()} ${birthDate.day}, ${birthDate.year}';

    return '$age yo, $formattedDate';
  }

}
