import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:measure_your_life_app/models/activity.dart';
import 'package:measure_your_life_app/models/user.dart';
import 'package:measure_your_life_app/providers/activities_provider.dart';
import 'package:measure_your_life_app/providers/categories_provider.dart';
import 'package:measure_your_life_app/providers/user_repository.dart';
import 'package:measure_your_life_app/widgets/activity_card.dart';
import 'package:measure_your_life_app/widgets/app_alert.dart';
import 'package:measure_your_life_app/widgets/app_drawer.dart';
import 'package:measure_your_life_app/widgets/new_activity_view.dart';
import 'package:provider/provider.dart';

class ActivitiesPage extends StatefulWidget {
  final User user;

  ActivitiesPage({Key key, this.user}) : super(key: key);

  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  var _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initiateProviders();
    initializeDateFormatting();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate.add(Duration(hours: 2));
        Provider.of<ActivitiesProvider>(context, listen: false)
            .fetchActivites(widget.user.token, date: _selectedDate);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final activitiesProvider = Provider.of<ActivitiesProvider>(context);
    final categoriesProvider = Provider.of<CategoriesProvider>(context);
    final userRepository = Provider.of<UserRepository>(context);

    return Scaffold(
      drawer: AppDrawer(widget.user, userRepository.signOut),
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
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
                    child: InkWell(
                      onTap: () {
                        _presentDatePicker();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            getFormattedDate(),
                            style:
                                TextStyle(color: Colors.white70, fontSize: 18),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                _selectedDate
                                            .difference(DateTime.now())
                                            .inDays ==
                                        0
                                    ? 'Today'
                                    : 'Selected',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 32),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.9,
              child: activitiesProvider.isFetching
                  ? Center(child: CircularProgressIndicator())
                  : (activitiesProvider.getActivites.isEmpty
                      ? _buildNoActivitiesFoundInfo()
                      : _buildActivitiesList(activitiesProvider, userRepository,
                          categoriesProvider)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _buildNewActivityView(context, _selectedDate),
      ),
    );
  }

  Center _buildNoActivitiesFoundInfo() {
    return Center(
      child: Text(
        'No activities found',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black.withOpacity(0.7),
        ),
      ),
    );
  }

  Future _buildNewActivityView(BuildContext context, DateTime selectedDate) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return NewActivityView(
          user: widget.user,
          selectedDate: selectedDate,
        );
      },
    );
  }

  ListView _buildActivitiesList(ActivitiesProvider activitiesProvider,
      UserRepository userRepository, CategoriesProvider categoriesProvider) {
    return ListView.builder(
      itemCount: activitiesProvider.getActivites.length,
      itemBuilder: (context, index) {
        Activity activity = activitiesProvider.getActivites[index];
        return Dismissible(
          key: Key(activity.activityId),
          background: Container(
            color: Colors.red,
          ),
          secondaryBackground: Container(
            margin: EdgeInsets.all(4.0),
            padding: EdgeInsets.all(8.0),
            color: Colors.red,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: MediaQuery.of(context).size.height * 0.03,
            ),
            alignment: Alignment.centerRight,
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) =>
              _removeActivity(activitiesProvider, activity, context),
          child: ActivityCard(
            userRepository.user,
            activity,
            categoriesProvider.getCategories(widget.user.token),
          ),
        );
      },
    );
  }

  String getFormattedDate() {
    var customDate = _selectedDate == null ? DateTime.now() : _selectedDate;
    return DateFormat('EEEE, dd MMMM', 'en').format(customDate);
  }

  void _removeActivity(ActivitiesProvider activitiesProvider, Activity activity,
      BuildContext context) async {
    if (!await activitiesProvider.removeActivity(widget.user.token, activity)) {
      AppAlert.showAlert(context, 'Could not remove activity');
    }
  }

  void initiateProviders() {
    Future.microtask(() => {
          Provider.of<ActivitiesProvider>(context, listen: false)
              .fetchActivites(widget.user.token, date: _selectedDate),
          Provider.of<CategoriesProvider>(context, listen: false)
              .getCategories(widget.user.token),
        });
  }
}
