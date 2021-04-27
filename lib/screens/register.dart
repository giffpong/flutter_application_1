import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/screens/my_service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;

  // Method
  Widget registerButton() {
    return IconButton(
        icon: Icon(Icons.fact_check),
        padding: EdgeInsets.only(right: 20.0),
        tooltip: 'Register',
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            registerThread();
          }
        });
    // return RaisedButton(
    //     child: Text(
    //       'Sign Up',
    //       style: TextStyle(color: Colors.white),
    //     ),
    //     color: Colors.blue.shade300,
    //     onPressed: () {
    //       if (formKey.currentState.validate()) {
    //         formKey.currentState.save();
    //         registerThread();
    //       }
    //     });
  }

  Future<void> registerThread() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      print('Register Success for Email = $emailString');
      setupDisplayName();
    }).catchError((response) {
      String title = response.code;
      String message = response.message;
      myAlert(title, message);
    });
  }

  Future<void> setupDisplayName() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    var user = firebaseAuth.currentUser;
    if (user != null) {
      user.updateProfile(displayName: nameString);
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }
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
    ;
  }

  Widget nameText() {
    return TextFormField(
      keyboardType: TextInputType.name,
      style: TextStyle(
        color: Colors.purple,
      ),
      decoration: InputDecoration(
          icon: Icon(
            Icons.face,
            color: Colors.purple,
          ),
          labelText: 'Display Name: ',
          labelStyle: TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
          helperText: 'Type Your Nick Name for Display',
          helperStyle: TextStyle(
            color: Colors.purple,
            fontStyle: FontStyle.italic,
          )),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please Fill Your Name in the Blank';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        nameString = value.trim();
      },
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.green.shade800,
      ),
      decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            color: Colors.green.shade800,
          ),
          labelText: 'Email: ',
          labelStyle: TextStyle(
            color: Colors.green.shade800,
            fontWeight: FontWeight.bold,
          ),
          helperText: 'Type Your Email',
          helperStyle: TextStyle(
            color: Colors.green.shade800,
            fontStyle: FontStyle.italic,
          )),
      validator: (String value) {
        if (!(value.contains('@') && value.contains('.'))) {
          return 'Please Type Email in Email Format (Exp. you@email.com)';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        emailString = value.trim();
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
      style: TextStyle(
        color: Colors.blue.shade800,
      ),
      decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: Colors.blue.shade800,
          ),
          labelText: 'Password: ',
          labelStyle: TextStyle(
            color: Colors.blue.shade800,
            fontWeight: FontWeight.bold,
          ),
          helperText: 'Type Your Password',
          helperStyle: TextStyle(
            color: Colors.blue.shade800,
            fontStyle: FontStyle.italic,
          )),
      obscureText: true,
      validator: (String value) {
        if (value.length <= 6) {
          return 'Password More 6 Characters';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        passwordString = value.trim();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.blue.shade300,
        actions: <Widget>[registerButton()],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            nameText(),
            emailText(),
            passwordText(),
            // SizedBox(
            //   height: 40.0,
            // ),
            // registerButton(),
          ],
        ),
      ),
    );
  }
}
