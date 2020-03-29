import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final String title;

  CancelButton(this.title);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.cancel,
            color: Theme.of(context).primaryColor,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 4.0,
            ),
            child: FittedBox(
              child: Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      onPressed: () {},
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
}
