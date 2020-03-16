import 'package:flutter/material.dart';
import 'package:measure_your_life_app/providers/user_repository.dart';
import 'package:measure_your_life_app/providers/activities_provider.dart';
import 'package:measure_your_life_app/screens/home.dart';
import 'package:measure_your_life_app/theme/constants.dart';
import 'package:measure_your_life_app/theme/theme_color.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserRepository()),
        ChangeNotifierProvider(create: (_) => ActivitiesProvider()),
      ],
      child: MaterialApp(
        title: Constants.appTitle,
        theme: ThemeData(
          primarySwatch: themeColor,
        ),
        home: HomePage(),
      ),
    );
  }
}
