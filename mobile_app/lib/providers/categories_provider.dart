import 'package:flutter/material.dart';
import 'package:measure_your_life_app/apis/api.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:measure_your_life_app/models/category.dart';

class CategoriesProvider with ChangeNotifier {
  List<Category> _categories;
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  List<Category> getCategories(String token) {
    if (_categories == null) {
      fetchCategories(token);
    }

    return _categories;
  }

  Future<bool> fetchCategories(String token) async {
    try {
      _isFetching = true;
      notifyListeners();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await http.get(
        API.categoriesPath,
        headers: headers,
      );

      final Map<String, dynamic> categories = json.decode(response.body);

      if (categories == null) {
        _isFetching = false;
        notifyListeners();
        return false;
      }

      var categoriesList = categories['categories'] as List;
      _categories = categoriesList
          .map((category) => Category.fromJson(category))
          .toList();

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
