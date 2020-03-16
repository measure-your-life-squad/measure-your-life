import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:measure_your_life_app/apis/api.dart';

import 'package:measure_your_life_app/models/user.dart';

enum Status { Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  User _user;
  Status _status = Status.Unauthenticated;

  User get user => _user;
  Status get status => _status;

  Future<bool> signIn(String username, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();

      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': basicAuth
      };

      final response = await http.post(
        API.loginUserUrl,
        headers: headers,
      );

      _status = Status.Unauthenticated;
      notifyListeners();

      if (response.statusCode != 200) {
        return false;
      }

      final Map<String, dynamic> responseData = json.decode(response.body);

      _user = new User(username: username, token: responseData['token']);
      _status = Status.Authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(String username, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();

      final Map<String, dynamic> authData = {
        'username': username,
        'password': password
      };

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.post(
        API.registerUserUrl,
        body: json.encode(authData),
        headers: headers,
      );

      _status = Status.Unauthenticated;
      notifyListeners();

      if (response.statusCode != 200) {
        return false;
      }

      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _user = null;
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
