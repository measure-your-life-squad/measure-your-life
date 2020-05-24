import 'package:flutter/material.dart';

class CategoryTheme {
  static Color getColor(String categoryName) {
    if (categoryName == 'work') {
      return Colors.red[400].withOpacity(0.7);
    } else if (categoryName == 'duties') {
      return Colors.orange[400].withOpacity(0.7);
    } else if (categoryName == 'leisure') {
      return Colors.green[400].withOpacity(0.7);
    }

    return Colors.black;
  }
}
