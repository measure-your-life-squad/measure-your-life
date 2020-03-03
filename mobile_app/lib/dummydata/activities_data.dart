import 'package:measure_your_life_app/models/activity.dart';
import 'package:measure_your_life_app/models/category.dart';

class ActivitiesData {
  static List<Activity> fetchDummyActivities = [
    getActivity(Category.WORK, 'Work', DateTime.parse('2020-01-01 08:00:00'),
        DateTime.parse('2020-01-01 16:00:00')),
    getActivity(
        Category.RESPONSIBILITIES,
        'Preparing dinner',
        DateTime.parse('2020-01-01 16:00:00'),
        DateTime.parse('2020-01-01 17:00:00')),
    getActivity(
        Category.RESPONSIBILITIES,
        'Cleaning house',
        DateTime.parse('2020-01-01 17:00:00'),
        DateTime.parse('2020-01-01 18:00:00')),
    getActivity(
        Category.LEISURE_TIME,
        'Relax',
        DateTime.parse('2020-01-01 18:00:00'),
        DateTime.parse('2020-01-01 21:00:00')),
    getActivity(
        Category.LEISURE_TIME,
        'Reading a book',
        DateTime.parse('2020-01-01 21:00:00'),
        DateTime.parse('2020-01-01 22:15:00')),
  ];

  static Activity getActivity(
      Category category, String name, DateTime start, DateTime end) {
    return Activity(
      category: category,
      name: name,
      start: start,
      end: end,
      duration: end.difference(start).inMinutes,
    );
  }
}
