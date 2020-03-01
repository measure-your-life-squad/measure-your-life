import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final Color backgroundColor;

  AddButton(this.title, this.textColor, this.backgroundColor);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.add,
            color: textColor,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 4.0,
            ),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                title,
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
      onPressed: () {},
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
}
