import 'package:flutter/material.dart';
import 'package:measure_your_life_app/models/user.dart';
import 'package:measure_your_life_app/providers/activities_provider.dart';
import 'package:measure_your_life_app/providers/categories_provider.dart';
import 'package:measure_your_life_app/providers/user_repository.dart';
import 'package:measure_your_life_app/widgets/activity_card.dart';
import 'package:measure_your_life_app/widgets/new_activity_view.dart';
import 'package:provider/provider.dart';

class ActivitiesPage extends StatefulWidget {
  final User user;

  ActivitiesPage({Key key, this.user}) : super(key: key);

  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {
          Provider.of<ActivitiesProvider>(context, listen: false)
              .fetchActivites(widget.user.token),
          Provider.of<CategoriesProvider>(context, listen: false)
              .getCategories(widget.user.token),
        });
  }

  @override
  Widget build(BuildContext context) {
    final activitiesProvider = Provider.of<ActivitiesProvider>(context);
    final categoriesProvider = Provider.of<CategoriesProvider>(context);
    final userRepository = Provider.of<UserRepository>(context);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              accountName: Text(
                'Hi, ' + widget.user.username + '!',
                style: TextStyle(fontSize: 24.0),
              ),
              accountEmail: Text('MeasureYourLife'),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign out'),
              onTap: () {
                userRepository.signOut();
              },
            )
          ],
        ),
      ),
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
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            return showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              builder: (BuildContext context) {
                                return NewActivityView();
                              },
                            );
                          },
                          color: Colors.white,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(
                                  Icons.assessment,
                                  size: 24,
                                ),
                                Text(
                                  'Statistics',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: activitiesProvider.isFetching
                    ? CircularProgressIndicator()
                    : (activitiesProvider.getActivites.isEmpty
                        ? Center(
                            child: Text(
                              'No activities found',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: activitiesProvider.getActivites.length,
                            itemBuilder: (context, index) {
                              return ActivityCard(
                                activitiesProvider.getActivites[index],
                                categoriesProvider
                                    .getCategories(widget.user.token),
                              );
                            },
                          ))),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          return showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            builder: (BuildContext context) {
              return NewActivityView(user: widget.user);
            },
          );
        },
      ),
    );
  }
}
