import 'package:flutter/material.dart';
import 'package:measure_your_life_app/providers/user_repository.dart';
import 'package:measure_your_life_app/screens/activities.dart';
import 'package:measure_your_life_app/screens/login.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, UserRepository userRepository, _) {
        switch (userRepository.status) {
          case Status.Unauthenticated:
          case Status.Authenticating:
            return LoginPage();
          case Status.Authenticated:
            return ActivitiesPage(user: userRepository.user);
        }
        return null;
      },
    );
  }
}
