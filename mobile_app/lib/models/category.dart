import 'package:flutter/material.dart';

class Category {
  final int categoryId;
  final String name;
  final String iconName;

  int get category => categoryId;

  Category({
    @required this.categoryId,
    @required this.name,
    @required this.iconName,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['public_id'].toInt(),
      name: json['name'],
      iconName: json['icon_name'],
    );
  }
}
