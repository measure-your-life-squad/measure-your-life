import 'package:flutter/material.dart';
import 'package:measure_your_life_app/apis/api.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:measure_your_life_app/models/statistics.dart';

class StatisticsProvider with ChangeNotifier {
  Statistics _statistics;
  OldestDate _oldestDate;

  bool _isFetching = false;
  bool _isFetchingOldestDate = false;

  Statistics get statistics => _statistics;
  OldestDate get oldestDate => _oldestDate;

  bool get isFetching => _isFetching;
  bool get isFetchingOldestDate => _isFetchingOldestDate;

  Future<bool> getStatistics(String token,
      {String startRange, String endRange}) async {
    print(startRange);
    print(endRange);
    try {
      _isFetching = true;
      notifyListeners();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      String url;

      if (startRange == null || endRange == null) {
        url = API.statisticsPath + '?include_unassigned=true';
      } else {
        url = API.statisticsPath +
            '?include_unassigned=true&start_range=$startRange&end_range=$endRange';
      }
      final response = await http.get(
        url,
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

  Future<bool> getOldestDate(String token) async {
    try {
      _isFetchingOldestDate = true;
      notifyListeners();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await http.get(
        API.oldestdatePath,
        headers: headers,
      );

      final Map<String, dynamic> oldestDate = json.decode(response.body);

      if (oldestDate == null) {
        _isFetchingOldestDate = false;
        notifyListeners();
        return false;
      }

      _oldestDate = OldestDate.fromJson(oldestDate);

      _isFetchingOldestDate = false;
      notifyListeners();
      return true;
    } catch (e) {
      _oldestDate = OldestDate(oldestDate: DateTime.now().toString());
      processApiEception(e);
      return false;
    }
  }

  void processApiEception(e) {
    _isFetching = false;
    _isFetchingOldestDate = false;
    notifyListeners();
  }
}
