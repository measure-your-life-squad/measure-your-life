import 'package:flutter/material.dart';
import 'package:measure_your_life_app/providers/user_repository.dart';
import 'package:measure_your_life_app/theme/constants.dart';
import 'package:measure_your_life_app/utils/validators.dart';
import 'package:measure_your_life_app/widgets/app_alert.dart';
import 'package:measure_your_life_app/widgets/sign_up_view.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  final Map<String, dynamic> _formData = {
    'username': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    final userRepository = Provider.of<UserRepository>(context);
    return Scaffold(
      key: _key,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildAppLogo(),
                  Expanded(child: _buildGreetings()),
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          _buildUsernameTextField(),
                          SizedBox(
                            height: 10.0,
                          ),
                          _buildPasswordTextField(),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                RaisedButton(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          userRepository.status ==
                                                  Status.Authenticating
                                              ? 'Signing in..'
                                              : 'Sign in',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () =>
                                      _submitForm(userRepository.signIn),
                                  color: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                _buildSignUpButton(context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  RaisedButton _buildSignUpButton(BuildContext context) {
    return RaisedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              'Sign up',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
      onPressed: () => _showSignUpView(context),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1.5,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }

  Future _showSignUpView(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return SignUpView();
      },
    );
  }

  void _submitForm(Function signIn) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    UserApiResponse response =
        await signIn(_formData['username'], _formData['password']);
    if (response == UserApiResponse.ServerError) {
      AppAlert.showAlert(context, 'Wrong credentials provided');
    }

    if (response == UserApiResponse.MailNotConfirmed) {
      AppAlert.showAlert(context, 'Account not confirmed');
    }
  }

  Widget _buildAppLogo() {
    return Container(
      color: Theme.of(context).primaryColor,
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.3,
      child: Center(
          child: Text(
        'AppLogo',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }

  Widget _buildUsernameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Username',
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.person_outline),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        return Validators.validateField(value, 'Username');
      },
      onSaved: (String value) {
        _formData['username'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.lock),
      ),
      obscureText: true,
      validator: (String value) {
        return Validators.validateField(value, 'Password');
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildGreetings() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Welcome to ${Constants.appTitle}',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 4.0,
        ),
        Text(
          'Get to know your life a little bit better',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
