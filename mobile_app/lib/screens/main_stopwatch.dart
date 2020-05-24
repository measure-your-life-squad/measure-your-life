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

  Color leftButtonColor;
  Color rightButtonColor;

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
        Icons.fiber_manual_record,
        color: Colors.red,
      );
      rightButtonColor = Colors.white70;
    } else {
      leftButtonIcon = Icon(Icons.play_arrow);
      leftButtonColor = Colors.green;
      rightButtonIcon = Icon(Icons.refresh);
      rightButtonColor = Colors.blue;
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
            SizedBox(width: 20.0),
            FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: rightButtonColor,
                onPressed: saveOrRefreshWatch,
                child: rightButtonIcon),
          ],
        ),
        SizedBox(height: 20.0),
        Expanded(
          child: ListView.builder(
              itemCount: widget.dependencies.savedTimeList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                      alignment: Alignment.center,
                      child: Text(
                        createListItemText(
                            widget.dependencies.savedTimeList.length,
                            index,
                            widget.dependencies.savedTimeList.elementAt(index)),
                        style: TextStyle(fontSize: 24.0),
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
      widget.dependencies.stopwatch.stop();
      setState(() {});
    } else {
      leftButtonIcon = Icon(Icons.pause);
      leftButtonColor = Colors.red;
      rightButtonIcon = Icon(
        Icons.fiber_manual_record,
        color: Colors.red,
      );
      rightButtonColor = Colors.white70;
      widget.dependencies.stopwatch.start();
      timer = new Timer.periodic(new Duration(milliseconds: 20), updateTime);
    }
  }

  saveOrRefreshWatch() {
    setState(() {
      if (widget.dependencies.stopwatch.isRunning) {
        widget.dependencies.savedTimeList.insert(
            0,
            widget.dependencies.transformMilliSecondsToString(
                widget.dependencies.stopwatch.elapsedMilliseconds));
      } else {
        widget.dependencies.stopwatch.reset();
        widget.dependencies.savedTimeList.clear();
      }
    });
  }

  String createListItemText(int listSize, int index, String time) {
    index = listSize - index;
    String indexText = index.toString().padLeft(2, '0');

    return 'Time $indexText, $time';
  }
}