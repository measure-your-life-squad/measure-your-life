import 'package:flutter/material.dart';

class Activity {
  final int category;
  final String name;
  final DateTime start;
  final DateTime end;
  final int duration;
  String activityId;

  Activity(
      {@required this.category,
      @required this.name,
      @required this.start,
      @required this.end,
      @required this.duration,
      this.activityId});

  set id(String activityId) {
    this.activityId = activityId;
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    var start = DateTime.parse(json['activity_start']);
    var end = DateTime.parse(json['activity_end']);
    return Activity(
      category: json['category'],
      name: json['name'],
      start: start,
      end: end,
      duration: end.difference(start).inMinutes,
      activityId: json['activity_id'],
    );
  }

  Map<String, dynamic> toJson(DateTime date) {
    var selectedStart =
        DateTime(date.year, date.month, date.day, start.hour, start.minute);
    var selectedEnd =
        DateTime(date.year, date.month, date.day, end.hour, end.minute);

    return {
      'name': name,
      'category_id': category.toString(),
      'activity_start': selectedStart.toString(),
      'activity_end': selectedEnd.toString(),
    };
  }
}
