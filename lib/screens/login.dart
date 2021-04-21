import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Widget showLogo() {
    return Container(
      child: Image.asset('images/profile-logo.png'),
      width: 120.0,
      height: 150.0,
    );
  }

  Widget showAppName() {
    return Text(
      'LOGIN',
      style: TextStyle(
          fontSize: 30.0,
          color: Colors.blue.shade300,
          fontWeight: FontWeight.bold,
          fontFamily: 'OrelegaOne'),
    );
  }

  Widget signInButton() {
    return RaisedButton(
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {},
      color: Colors.blue.shade300,
    );
  }

  Widget signUpButton() {
    return OutlineButton(
      child: Text('Sign Up'),
      onPressed: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Register());
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget showButton() {
    return Row(
      children: <Widget>[
        signInButton(),
        SizedBox(
          width: 4.0,
        ),
        signUpButton()
      ],
      mainAxisSize: MainAxisSize.min,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [Colors.white, Colors.blue.shade200], radius: 1.0)),
          child: Center(
            child: Column(
              children: <Widget>[
                showLogo(),
                showAppName(),
                SizedBox(
                  height: 8.0,
                ),
                showButton()
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          ),
        ),
      ),
    );
  }
}
