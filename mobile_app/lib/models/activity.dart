import 'package:flutter/material.dart';
import 'package:measure_your_life_app/models/category.dart';

class Activity {
  final Category category;
  final String name;
  final DateTime start;
  final DateTime end;
  final int duration;

  Activity({
    @required this.category,
    @required this.name,
    @required this.start,
    @required this.end,
    @required this.duration,
  });
}
