import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/my_service.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String emailString, passwordString;

  // Method
  Widget backButton() {
    return IconButton(
        icon: Icon(Icons.navigate_before),
        onPressed: () {
          Navigator.of(context).pop();
        });
  }

  Widget content() {
    return Center(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            showAppName(),
            SizedBox(
              height: 10.0,
            ),
            emailText(),
            passwordText()
          ],
        ),
      ),
    );
  }

  Widget showAppName() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        showLogo(),
        SizedBox(
          width: 10.0,
        ),
        showText()
      ],
    );
  }

  Widget showLogo() {
    return Container(
      width: 48.0,
      height: 48.0,
      child: Image.asset('images/profile-logo.png'),
    );
  }

  Widget showText() {
    return Text(
      'CEREAL APP',
      style: TextStyle(
          fontSize: 30.0,
          color: Colors.blue.shade300,
          fontWeight: FontWeight.bold,
          fontFamily: 'OrelegaOne'),
    );
  }

  Widget emailText() {
    return Container(
      width: 300.0,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            size: 36.0,
            color: Colors.blue.shade300,
          ),
          labelText: 'Email',
          labelStyle: TextStyle(color: Colors.blue.shade300),
        ),
        onSaved: (String value) {
          emailString = value.trim();
        },
      ),
    );
  }

  Widget passwordText() {
    return Container(
      width: 300.0,
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            size: 36.0,
            color: Colors.blue.shade300,
          ),
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.blue.shade300),
        ),
        obscureText: true,
        onSaved: (String value) {
          passwordString = value.trim();
        },
      ),
    );
  }

  Future<void> checkAuthen() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      print('Authen Success');
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }).catchError((response) {
      String title = response.code;
      String message = response.message;
      myAlert(title, message);
    });
  }

  void myAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: ListTile(
            leading: Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48.0,
            ),
            title: Text(
              title,
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Text(message),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
            colors: [Colors.white, Colors.blue.shade200],
            radius: 1.0,
          )),
          child: Stack(
            children: <Widget>[
              backButton(),
              content(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade300,
        child: Icon(
          Icons.navigate_next,
          size: 36.0,
        ),
        onPressed: () {
          formKey.currentState.save();
          checkAuthen();
        },
      ),
    );
  }
}
