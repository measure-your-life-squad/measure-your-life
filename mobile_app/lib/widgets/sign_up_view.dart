import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:measure_your_life_app/providers/user_repository.dart';
import 'package:measure_your_life_app/utils/validators.dart';
import 'package:measure_your_life_app/widgets/app_alert.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordTextController = TextEditingController();

  final Map<String, dynamic> _formData = {
    'email': '',
    'username': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    final userRepository = Provider.of<UserRepository>(context);

    return Container(
      key: _key,
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              height: 4,
              width: 60,
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    _buildSignUpInfo(),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _buildEmailTextField(),
                            SizedBox(
                              height: 10,
                            ),
                            _buildUsernameTextField(),
                            SizedBox(
                              height: 10.0,
                            ),
                            _buildPasswordTextField(),
                            SizedBox(
                              height: 10.0,
                            ),
                            _buildPasswordConfirmTextField(),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: RaisedButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.person_add,
                                              color: Colors.white,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 4.0,
                                              ),
                                              child: FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text(
                                                  'Sign up',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        onPressed: () =>
                                            _submitForm(userRepository.signUp),
                                        color: Theme.of(context).primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: RaisedButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.cancel,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 4.0,
                                              ),
                                              child: FittedBox(
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: SvgPicture.asset(
                                  'assets/images/register.svg'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm(Function signUp) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    UserApiResponse response = await signUp(
        _formData['email'], _formData['username'], _formData['password']);
    if (response != UserApiResponse.Ok) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Could not register, try again later'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        },
      );
    } else {
      AppAlert.showRegisterAlert(context, 'Verification email sent');
    }
  }

  Widget _buildSignUpInfo() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'We require minimum amount of data',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            'Don\'t reuse your bank password, we didn\'t spend a lot on security for this app',
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Email',
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.mail_outline),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        return Validators.validateEmail(value, 'Email');
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
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
        prefixIcon: Icon(Icons.lock_outline),
      ),
      obscureText: true,
      controller: _passwordTextController,
      validator: (String value) {
        return Validators.validateField(value, 'Password');
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Confirm password',
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.lock_outline),
      ),
      obscureText: true,
      validator: (String value) {
        return Validators.validateConfirmedPassword(
            value, _passwordTextController.text);
      },
    );
  }
}
