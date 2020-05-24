import 'dart:async';
import 'package:flutter/material.dart';
import 'package:measure_your_life_app/classes/dependencies.dart';
import 'package:measure_your_life_app/widgets/timer_clock.dart';

class MainScreenPortrait extends StatefulWidget {
  final Dependencies dependencies;

  MainScreenPortrait({Key key, this.dependencies}) : super(key: key);

  MainScreenPortraitState createState() => MainScreenPortraitState();
}

class MainScreenPortraitState extends State<MainScreenPortrait> {
  Icon leftButtonIcon;
  Icon rightButtonIcon;
  Icon centreButtonIcon;

  Color leftButtonColor;
  Color rightButtonColor;
  Color centreButtonColor;

  Timer timer;

  updateTime(Timer timer) {
    if (widget.dependencies.stopwatch.isRunning) {
      setState(() {});
    } else {
      timer.cancel();
    }
  }

  @override
  void initState() {
    if (widget.dependencies.stopwatch.isRunning) {
      timer = new Timer.periodic(new Duration(milliseconds: 20), updateTime);
      leftButtonIcon = Icon(Icons.pause);
      leftButtonColor = Colors.red;
      rightButtonIcon = Icon(
        Icons.refresh,
        color: Colors.blue,
      );
      rightButtonColor = Colors.white70;
      centreButtonIcon = Icon(Icons.fiber_manual_record);
      centreButtonColor = Colors.red;
    } else {
      leftButtonIcon = Icon(Icons.play_arrow);
      leftButtonColor = Colors.green;
      rightButtonIcon = Icon(Icons.refresh);
      rightButtonColor = Colors.blue;
      centreButtonIcon = Icon(Icons.fiber_manual_record);
      centreButtonColor = Colors.red;
    }
    super.initState();
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
      timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.23,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'MeasureYourLife',
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                      Text(
                        'Stopwatch',
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        SizedBox(height: 20.0),
        Container(
          height: 250.0,
          width: 250.0,
          child: TimerClock(widget.dependencies),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
                heroTag: "btn1",
                backgroundColor: leftButtonColor,
                onPressed: startOrStopWatch,
                child: leftButtonIcon),
            FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: rightButtonColor,
                onPressed: resetWatch,
                child: rightButtonIcon),
            FloatingActionButton(
                heroTag: "btn3",
                backgroundColor: centreButtonColor,
                onPressed: saveWatch,
                child: centreButtonIcon),
          ],
        ),
        SizedBox(height: 20.0),
        Expanded(
          child: ListView.builder(
              itemCount: widget.dependencies.savedTimeList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        createListItemText(
                            widget.dependencies.savedTimeList.length,
                            index,
                            widget.dependencies.savedTimeList.elementAt(index)),
                        style: TextStyle(fontSize: 15.0),
                      )),
                );
              }),
        ),
        //Text('$savedTimeList')
      ],
    );
  }

  startOrStopWatch() {
    if (widget.dependencies.stopwatch.isRunning) {
      leftButtonIcon = Icon(Icons.play_arrow);
      leftButtonColor = Colors.green;
      rightButtonIcon = Icon(Icons.refresh);
      rightButtonColor = Colors.blue;
      centreButtonIcon = Icon(Icons.fiber_manual_record);
      centreButtonColor = Colors.red;
      widget.dependencies.stopwatch.stop();
      setState(() {});
    } else {
      leftButtonIcon = Icon(Icons.pause);
      leftButtonColor = Colors.red;
      rightButtonIcon = Icon(
        Icons.refresh,
        color: Colors.white70,
      );
      rightButtonColor = Colors.blue;
      centreButtonIcon = Icon(Icons.fiber_manual_record);
      centreButtonColor = Colors.red;
      widget.dependencies.stopwatch.start();
      timer = new Timer.periodic(new Duration(milliseconds: 20), updateTime);
    }
  }

  resetWatch() {
    setState(() {
    if (widget.dependencies.stopwatch.isRunning) {
      widget.dependencies.stopwatch.stop();
    }
    leftButtonIcon = Icon(Icons.play_arrow);
    leftButtonColor = Colors.green;
    widget.dependencies.stopwatch.reset();
    widget.dependencies.savedTimeList.clear();
  });
  }

  saveWatch() {
    setState(() {
      if (widget.dependencies.stopwatch.isRunning) {
        widget.dependencies.stopwatch.stop();
      } 
      widget.dependencies.savedTimeList.insert(
        0,
        widget.dependencies.transformMilliSecondsToString(
        widget.dependencies.stopwatch.elapsedMilliseconds)
      );
    });
  }

Duration parseDuration(String s) {
  int hours = 0;
  int minutes = 0;
  int micros;
  List<String> parts = s.split(':');
  if (parts.length > 2) {
    hours = int.parse(parts[parts.length - 3]);
  }
  if (parts.length > 1) {
    minutes = int.parse(parts[parts.length - 2]);
  }
  micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
  return Duration(hours: hours, minutes: minutes, microseconds: micros);
}

  String createListItemText(int listSize, int index, String time) {
    Duration length = parseDuration(time);
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(length);
    print(endDate);
    print(startDate);
    return 'Activity Start: $startDate \nActivity End: $endDate';
  }
}