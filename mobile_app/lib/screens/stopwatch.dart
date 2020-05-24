import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:measure_your_life_app/classes/dependencies.dart';
import 'package:measure_your_life_app/screens/main_stopwatch.dart';

// void main() {
//   debugPaintSizeEnabled = false;
//   runApp(StopwatchApp());
// }

// class StopwatchApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Stopwatch',
//       home: StopwatchHomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class StopwatchHomePage extends StatelessWidget {
  final Dependencies dependencies = new Dependencies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20.0),
            child: 
              MainScreenPortrait(dependencies: dependencies)
      )
    );
  }
}