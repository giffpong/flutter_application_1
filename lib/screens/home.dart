import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/authen.dart';
import 'package:flutter_application_1/screens/my_service.dart';
import 'package:flutter_application_1/screens/register.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User firebaseUser = await firebaseAuth.currentUser;
    if (firebaseUser != null) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }
  }

  Widget showLogo() {
    return Container(
      child: Image.asset('images/profile-logo.png'),
      width: 120.0,
      height: 150.0,
    );
  }

  Widget showAppName() {
    return Text(
      'CEREAL APP',
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
      onPressed: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Authen());
        Navigator.of(context).push(materialPageRoute);
      },
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
