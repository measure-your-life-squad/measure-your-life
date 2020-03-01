import 'package:flutter/material.dart';

class ActivityTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
}
