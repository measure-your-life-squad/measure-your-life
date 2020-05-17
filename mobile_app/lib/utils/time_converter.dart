import 'package:flutter/material.dart';

class TimeConverter {
  static DateTime getDateTime(String time) {
    var splittedTime = time.split(':');
    TimeOfDay timeOfDay = TimeOfDay(
        hour: int.parse(splittedTime[0]), minute: int.parse(splittedTime[1]));
    final now = DateTime.now();
    return DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  }
}
