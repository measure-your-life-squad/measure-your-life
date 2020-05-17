import 'package:flutter/material.dart';
import 'package:measure_your_life_app/screens/login.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AppAlert {
  static void showAlert(BuildContext context, String content) {
    Alert(
      context: context,
      closeFunction: () {},
      title: 'INFO',
      desc: content,
      buttons: [
        DialogButton(
          child: Text(
            'Ok',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ).show();
  }

  static void showRegisterAlert(BuildContext context, String content) {
    Alert(
      context: context,
      closeFunction: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      title: 'INFO',
      desc: content,
      buttons: [
        DialogButton(
          child: Text(
            'Ok',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          ),
        )
      ],
    ).show();
  }
}
