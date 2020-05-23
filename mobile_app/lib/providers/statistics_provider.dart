import 'package:flutter/material.dart';
import 'package:measure_your_life_app/apis/api.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:measure_your_life_app/models/statistics.dart';

class StatisticsProvider with ChangeNotifier {
  Statistics _statistics;
  bool _isFetching = false;

  Statistics get statistics => _statistics;
  bool get isFetching => _isFetching;

  Future<bool> getStatistics(String token) async {
    try {
      _isFetching = true;
      notifyListeners();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await http.get(
        API.statisticsPath + '?include_unassigned=false',
        headers: headers,
      );

      final Map<String, dynamic> statistics = json.decode(response.body);

      if (statistics == null) {
        _isFetching = false;
        notifyListeners();
        return false;
      }

      _statistics = Statistics.fromJson(statistics);

      _isFetching = false;
      notifyListeners();
      return true;
    } catch (e) {
      processApiEception(e);
      return false;
    }
  }

  void processApiEception(e) {
    _isFetching = false;
    notifyListeners();
  }
}
