import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        icon: Icon(Icons.cloud_upload),
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        });
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
      keyboardType: TextInputType.visiblePassword,
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
          ],
        ),
      ),
    );
  }
}
