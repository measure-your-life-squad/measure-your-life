import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:measure_your_life_app/classes/dependencies.dart';
import 'package:measure_your_life_app/widgets/new_activity_view_for_stopper.dart';
import 'package:measure_your_life_app/models/user.dart';
import 'package:measure_your_life_app/providers/activities_provider.dart';
import 'package:measure_your_life_app/providers/categories_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:measure_your_life_app/widgets/timer_clock.dart';

class StopwatchHomePage extends StatefulWidget {
  final User user;

  StopwatchHomePage({Key key, this.user}) : super(key: key);

  @override
  _StopwatchHomePageState createState() => _StopwatchHomePageState();
}

class _StopwatchHomePageState extends State<StopwatchHomePage> {
  final Dependencies dependencies = new Dependencies();
  DateTime endTime;
  DateTime startTime;

  @override
  void initState() {
    initiateProviders();
    initializeDateFormatting();
    if (dependencies.stopwatch.isRunning) {
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

  Future _buildNewActivityView(
      BuildContext context, DateTime endTime, DateTime startTime) {
    resetWatch();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        print('co tu mamy: ' + startTime.toString());
        return NewActivityView(
            user: widget.user, startTime: startTime, endTime: endTime);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
      ),
      body: new Container(
        alignment: Alignment.center,
        child: Column(
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
              child: TimerClock(dependencies),
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
                  itemCount: dependencies.savedTimeList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            createListItemText(
                                dependencies.savedTimeList.length,
                                index,
                                dependencies.savedTimeList.elementAt(index)),
                            style: TextStyle(fontSize: 18.0),
                          )),
                    );
                  }),
            ),

            //Text('$savedTimeList')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _buildNewActivityView(context, endTime, startTime),
      ),
    );
  }

  void initiateProviders() {
    Future.microtask(() => {
          Provider.of<ActivitiesProvider>(context, listen: false)
              .fetchActivites(widget.user.token),
          Provider.of<CategoriesProvider>(context, listen: false)
              .getCategories(widget.user.token),
        });
  }

  Icon leftButtonIcon;
  Icon rightButtonIcon;
  Icon centreButtonIcon;

  Color leftButtonColor;
  Color rightButtonColor;
  Color centreButtonColor;

  Timer timer;

  updateTime(Timer timer) {
    if (dependencies.stopwatch.isRunning) {
      setState(() {});
    } else {
      timer.cancel();
    }
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
      timer = null;
    }
    super.dispose();
  }

  startOrStopWatch() {
    if (dependencies.stopwatch.isRunning) {
      leftButtonIcon = Icon(Icons.play_arrow);
      leftButtonColor = Colors.green;
      rightButtonIcon = Icon(Icons.refresh);
      rightButtonColor = Colors.blue;
      centreButtonIcon = Icon(Icons.fiber_manual_record);
      centreButtonColor = Colors.red;
      dependencies.stopwatch.stop();
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
      dependencies.stopwatch.start();
      timer = new Timer.periodic(new Duration(milliseconds: 20), updateTime);
    }
  }

  resetWatch() {
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        dependencies.stopwatch.stop();
      }
      leftButtonIcon = Icon(Icons.play_arrow);
      leftButtonColor = Colors.green;
      dependencies.stopwatch.reset();
      dependencies.savedTimeList.clear();
    });
  }

  saveWatch() {
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        dependencies.stopwatch.stop();
      }
      dependencies.savedTimeList.insert(
          0,
          dependencies.transformMilliSecondsToString(
              dependencies.stopwatch.elapsedMilliseconds));
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
    endTime = endDate;
    startTime = startDate;

    print(endDate);
    return 'Activity Start: $startDate \nActivity End  : $endDate';
  }
}
