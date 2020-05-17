import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String username;
  final Function signOut;

  AppDrawer(this.username, this.signOut);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            margin: EdgeInsets.zero,
            accountName: Text(
              _getGreetingsMessage(username),
              style: TextStyle(fontSize: 24.0),
            ),
            accountEmail: Text('MeasureYourLife'),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign out'),
            onTap: () {
              signOut();
            },
          )
        ],
      ),
    );
  }

  String _getGreetingsMessage(String username) {
    return 'Hi, ' + username + '!';
  }
}
