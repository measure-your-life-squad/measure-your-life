import 'package:flutter/material.dart';

class Statistics {
  final double dutiesRatio;
  final double leisureRatio;
  final double workRatio;
  final int dutiesAvg;
  final int leisureAvg;
  final int workAvg;

  Statistics({
    @required this.dutiesRatio,
    @required this.leisureRatio,
    @required this.workRatio,
    @required this.dutiesAvg,
    @required this.leisureAvg,
    @required this.workAvg,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      dutiesRatio: json['DUTIES'],
      leisureRatio: json['LEISURE'],
      workRatio: json['WORK'],
      dutiesAvg: json['DUTIES_AVG'],
      leisureAvg: json['LEISURE_AVG'],
      workAvg: json['WORK_AVG'],
    );
  }
}
