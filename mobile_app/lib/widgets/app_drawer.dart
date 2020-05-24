import 'package:flutter/material.dart';
import 'package:measure_your_life_app/models/user.dart';
import 'package:measure_your_life_app/screens/statistics.dart';
import 'package:measure_your_life_app/screens/stopwatch.dart';
import 'package:measure_your_life_app/theme/constants.dart';

class AppDrawer extends StatelessWidget {
  final User user;
  final Function signOut;

  AppDrawer(this.user, this.signOut);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            margin: EdgeInsets.zero,
            accountName: Text(
              _getGreetingsMessage(user.username),
              style: TextStyle(fontSize: 24.0),
            ),
            accountEmail: Text(Constants.appTitle),
          ),
          ListTile(
            leading: Icon(Icons.insert_chart),
            title: Text('Statistics (beta)'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StatisticsPage(
                    user: user,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.access_alarms),
            title: Text('Activity Stopwatch (beta)'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StopwatchHomePage(
                    user: user,
                  ),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign out'),
            onTap: () {
              signOut();
            },
          ),
        ],
      ),
    );
  }

  String _getGreetingsMessage(String username) {
    return 'Hi, ' + username + '!';
  }
}
