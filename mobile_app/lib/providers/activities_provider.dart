import 'dart:async';

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
      processApiException(e);
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
      activity.id = responseActivity['activity_id'];

      _activities.add(activity);
      return true;
    } catch (e) {
      processApiException(e);
      return false;
    }
  }

  Future<bool> editActivity(
      String token, Activity activity, Activity editedActivity) async {
    try {
      _isFetching = true;
      notifyListeners();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await http.put(
        API.activitiesPath + '?activity_id=${activity.activityId}',
        headers: headers,
        body: json.encode(
          editedActivity.toJson(),
        ),
      );

      _isFetching = false;
      notifyListeners();

      if (response.statusCode != 200) {
        return false;
      }

      int editedActivityIndex = _activities.indexOf(activity);
      _activities[editedActivityIndex] = editedActivity;

      return true;
    } catch (e) {
      processApiException(e);
      return false;
    }
  }

  Future<bool> removeActivity(String token, Activity activity) async {
    try {
      _isFetching = true;
      notifyListeners();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await http.delete(
        API.activitiesPath + '?activity_id=${activity.activityId}',
        headers: headers,
      );

      _isFetching = false;
      notifyListeners();

      if (response.statusCode != 200) {
        return false;
      }

      _activities.remove(activity);

      return true;
    } catch (e) {
      processApiException(e);
      return false;
    }
  }

  void processApiException(e) {
    print(e);
    _isFetching = false;
    notifyListeners();
  }
}
