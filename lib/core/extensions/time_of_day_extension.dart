import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String toUsaTime() {
    final hour = hourOfPeriod;
    final minute = this.minute;
    final period = this.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }
}