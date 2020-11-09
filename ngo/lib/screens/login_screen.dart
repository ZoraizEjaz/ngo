import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:ngo/screens/activities_screen.dart';
import '../models/login_request_model.dart';
import '../screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _loginRequest = LoginRequestModel(email: '', password: '');
  var _initValues = {
    'email': '',
    'password': '',
  };

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    print(_loginRequest.email);

    setState(() {});

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ActivitiesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    TextStyle style = TextStyle(fontFamily: 'OpenSans', fontSize: 20.0);

    return Scaffold(
      body: Center(
        child: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 60, 20.0, 20),
            child: Form(
              key: _form,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      "assets/images/illustration.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 45.0,
                  ),
                  TextFormField(
                    initialValue: _initValues['email'],
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter email address!';
                      }

                      if (!(validateEmail(value))) {
                        return 'Invalid Email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _loginRequest = LoginRequestModel(
                        email: value,
                        password: _loginRequest.password,
                      );
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['password'],
                    focusNode: _passwordFocusNode,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password must be at-least 6 characters';
                      }
                      if (value.length < 6) {
                        return 'Password must be at-least 6 characters';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    onSaved: (value) {
                      _loginRequest = LoginRequestModel(
                          email: _loginRequest.email, password: value);
                    },
                    onFieldSubmitted: (_) {
                      _saveForm();
                    },
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    height: 45,
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.blue)),
                      onPressed: () {
                        _saveForm();
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text("Login".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(color: Colors.black38, fontSize: 15),
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(RegisterScreen.routeName);
                          },
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrangeAccent,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
