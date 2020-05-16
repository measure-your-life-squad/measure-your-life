import 'package:flutter/material.dart';
import 'package:measure_your_life_app/apis/api.dart';
import 'dart:convert';
import 'package:measure_your_life_app/models/activity.dart';

import 'package:http/http.dart' as http;

class ActivitiesProvider with ChangeNotifier {
  List<Activity> _activities = [];
  bool _isFetching = false;

  List<Activity> get getActivites => _activities;

  bool get isFetching => _isFetching;

  Future<bool> fetchActivites(String token) async {
    try {
      _isFetching = true;
      notifyListeners();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await http.get(
        API.activitiesPath,
        headers: headers,
      );

      final Map<String, dynamic> activities = json.decode(response.body);
      if (activities == null) {
        _isFetching = false;
        notifyListeners();
        return false;
      }

      var activitiesList = activities['activities'] as List;
      if (activitiesList == null) {
        _isFetching = false;
        notifyListeners();
        return false;
      }

      _activities = activitiesList
          .map((activity) => Activity.fromJson(activity))
          .toList();

      _isFetching = false;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      _isFetching = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> addActivity(String token, Activity activity) async {
    try {
      _isFetching = true;
      notifyListeners();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await http.post(
        API.activitiesPath,
        headers: headers,
        body: json.encode(
          activity.toJson(),
        ),
      );

      _isFetching = false;
      notifyListeners();

      if (response.statusCode != 200) {
        return false;
      }

      final Map<String, dynamic> responseActivity = json.decode(response.body);
      activity.id = responseActivity["activity_id"];

      _activities.add(activity);
      return true;
    } catch (e) {
      _isFetching = false;
      notifyListeners();
      return false;
    }
  }
}
