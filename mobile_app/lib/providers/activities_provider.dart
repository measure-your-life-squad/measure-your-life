import 'dart:async';

import 'package:flutter/material.dart';
import 'package:measure_your_life_app/apis/api.dart';
import 'dart:convert';
import 'package:measure_your_life_app/models/activity.dart';

import 'package:http/http.dart' as http;

enum ActivitiesApiResponse { Ok, TimesOverlapping, ServerError }

class ActivitiesProvider with ChangeNotifier {
  List<Activity> _activities = [];
  bool _isFetching = false;
  DateTime _selectedDate = DateTime.now();

  List<Activity> get getActivites => _activities;
  bool get isFetching => _isFetching;
  DateTime get getSelectedDate => _selectedDate;

  set selectedDate(DateTime date) {
    _selectedDate = date;
  }

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
          .where((activity) =>
              activity.end.difference(_selectedDate).inDays == 0 &&
              activity.end.day == _selectedDate.day)
          .toList();

      _activities.sort((a, b) {
        return a.start.compareTo(b.start);
      });

      _isFetching = false;
      notifyListeners();
      return true;
    } catch (e) {
      processApiException(e);
      return false;
    }
  }

  Future<ActivitiesApiResponse> addActivity(String token, Activity activity,
      {DateTime date}) async {
    try {
      _isFetching = true;
      notifyListeners();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      date = date == null ? _selectedDate : date;

      var selectedStart = DateTime(date.year, date.month, date.day,
          activity.start.hour, activity.start.minute);
      var selectedEnd = DateTime(date.year, date.month, date.day,
          activity.end.hour, activity.end.minute);

      activity.startTime = selectedStart;
      activity.endTime = selectedEnd;

      final response = await http.post(
        API.activitiesPath,
        headers: headers,
        body: json.encode(
          activity.toJson(),
        ),
      );

      _isFetching = false;
      notifyListeners();

      if (response.statusCode == 422) {
        return ActivitiesApiResponse.TimesOverlapping;
      }

      if (response.statusCode != 200) {
        return ActivitiesApiResponse.ServerError;
      }

      final Map<String, dynamic> responseActivity = json.decode(response.body);
      activity.id = responseActivity['activity_id'];

      if (activity.end.difference(_selectedDate).inDays == 0 &&
          activity.end.day == _selectedDate.day) {
        _activities.add(activity);
      }

      _activities.sort((a, b) {
        return a.start.compareTo(b.start);
      });

      return ActivitiesApiResponse.Ok;
    } catch (e) {
      processApiException(e);
      return ActivitiesApiResponse.ServerError;
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

      var selectedStart = DateTime(_selectedDate.year, _selectedDate.month,
          _selectedDate.day, activity.start.hour, activity.start.minute);
      var selectedEnd = DateTime(_selectedDate.year, _selectedDate.month,
          _selectedDate.day, activity.end.hour, activity.end.minute);

      activity.startTime = selectedStart;
      activity.endTime = selectedEnd;

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
    _isFetching = false;
    notifyListeners();
  }
}
