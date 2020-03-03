import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;

  CategoryCard(this.label, this.icon, this.isActive);

  @override
  Widget build(BuildContext context) {
    var categoryCardSize = MediaQuery.of(context).size.width * 0.25;
    var color;

    if (!isActive) {
      color = Colors.grey.withOpacity(0.7);
    } else {
      color = Theme.of(context).primaryColor;
    }

    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      width: categoryCardSize,
      height: categoryCardSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          width: 2.5,
          color: color,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            icon,
            size: 46,
            color: color,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
