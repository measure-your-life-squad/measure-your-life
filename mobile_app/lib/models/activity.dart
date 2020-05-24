import 'package:flutter/material.dart';

class Activity {
  final int category;
  final String name;
  final int duration;
  String activityId;
  DateTime start;
  DateTime end;

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

  set startTime(DateTime start) {
    this.start = start;
  }

  set endTime(DateTime end) {
    this.end = end;
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category_id': category.toString(),
      'activity_start': start.toString(),
      'activity_end': end.toString(),
    };
  }
}
