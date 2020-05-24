import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:measure_your_life_app/classes/dependencies.dart';
import 'package:measure_your_life_app/screens/main_stopwatch.dart';
import 'package:measure_your_life_app/widgets/new_activity_view_for_stopper.dart';
import 'package:measure_your_life_app/models/user.dart';
import 'package:measure_your_life_app/providers/activities_provider.dart';
import 'package:measure_your_life_app/providers/categories_provider.dart';
import 'package:measure_your_life_app/providers/user_repository.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

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

class StopwatchHomePage extends StatefulWidget {
  final User user;

  StopwatchHomePage({Key key, this.user}) : super(key: key);
  
  @override
  _StopwatchHomePageState createState() => _StopwatchHomePageState();
}

class _StopwatchHomePageState extends State<StopwatchHomePage> {
  final Dependencies dependencies = new Dependencies();
  String endTime;
  String startTime;

  @override
  void initState() {
    super.initState();
    initiateProviders();
    initializeDateFormatting();
  }

  Future _buildNewActivityView(BuildContext context, String endTime, String startTime) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return NewActivityView(user: widget.user, startTime: startTime, endTime: endTime);
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
            child: 
              MainScreenPortrait(dependencies: dependencies)
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
}