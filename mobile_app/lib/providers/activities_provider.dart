import 'dart:io';

import 'package:flutter/material.dart';
import 'package:measure_your_life_app/apis/activities_api.dart';
import 'package:measure_your_life_app/dummydata/activities_data.dart';
import 'dart:convert';
import 'package:measure_your_life_app/models/activity.dart';

import 'package:http/http.dart' as http;
import 'package:measure_your_life_app/models/category.dart';

class ActivitiesProvider with ChangeNotifier {
  ActivitiesProvider() {
    fetchActivites();
  }

  List<Activity> _activities = [];
  bool _isFetching = false;

  List<Activity> get getActivites => _activities;

  bool get isFetching => _isFetching;

  Future<void> fetchActivites() async {
    _isFetching = true;
    notifyListeners();
    // var response = await http.get(ActivitiesAPI.getActivitesURL);
    // final Map<String, dynamic> activities = json.decode(response.body);
    // if (activities == null) {
    //   _isFetching = false;
    //   notifyListeners();
    //   return;
    // }

    // final List<Activity> fetchedActivites = [];
    // activities.forEach((String id, dynamic activityData) {
    //   var start = DateTime.parse(activityData['start']);
    //   var end = DateTime.parse(activityData['end']);

    //   final Activity product = Activity(
    //     category: Category.values.firstWhere(
    //         (e) => e.toString() == 'Category.' + activityData['category']),
    //     name: activityData['name'],
    //     start: start,
    //     end: end,
    //     duration: end.difference(start).inMinutes,
    //   );
    //   fetchedActivites.add(product);
    // });

    // _activities = fetchedActivites;
    // sleep(Duration(seconds: 2));
    _activities = ActivitiesData.fetchDummyActivities;
    _isFetching = false;
    notifyListeners();
  }
}
