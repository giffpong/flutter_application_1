import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/widgets/add_list_product.dart';
import 'package:flutter_application_1/widgets/show_list_product.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  String login = '...';
  Widget currentWidget = ShowListProduct();

  // Method
  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Widget showListProduct() {
    return ListTile(
      leading: Icon(
        Icons.list,
        size: 36.0,
        color: Colors.blue.shade300,
      ),
      title: Text('List Product'),
      onTap: () {
        setState(() {
          currentWidget = ShowListProduct();
        });
      },
      subtitle: Text('Show All List Product'),
    );
  }

  Widget showAddList() {
    return ListTile(
      leading: Icon(
        Icons.playlist_add,
        size: 36.0,
        color: Colors.green.shade500,
      ),
      title: Text('Add List Product'),
      onTap: () {
        setState(() {
          currentWidget = AddListProduct();
        });
      },
      subtitle: Text('Add New Product to Database'),
    );
  }

  Future<void> findDisplayName() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User firebaseUser = await firebaseAuth.currentUser;
    setState(() {
      login = firebaseUser.displayName;
    });
  }

  Widget showLogin() {
    return Text('Login By $login');
  }

  Widget showAppName() {
    return Text(
      'Cereal App',
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.blue.shade300,
        fontWeight: FontWeight.bold,
        fontFamily: 'OrelegaOne',
      ),
    );
  }

  Widget showLogo() {
    return Container(
      child: Image.asset('images/profile-logo.png'),
      width: 80.0,
      height: 80.0,
    );
  }

  Widget showHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('images/bg.jpg'),
        fit: BoxFit.cover,
      )),
      child: Column(
        children: <Widget>[
          showLogo(),
          SizedBox(
            height: 10.0,
          ),
          showAppName(),
          SizedBox(
            height: 6.0,
          ),
          showLogin(),
        ],
      ),
    );
  }

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          showHeader(),
          showListProduct(),
          showAddList(),
        ],
      ),
    );
  }

  Widget signOutButton() {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: 'Sign OUt',
      onPressed: () {
        myAlert();
      },
    );
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are You Sure?'),
            content: Text('Do You Want Sign Out?'),
            actions: <Widget>[
              cancelButton(),
              okButton(),
            ],
          );
        });
  }

  Widget cancelButton() {
    return FlatButton(
        child: Text('Cancel'),
        onPressed: () {
          Navigator.of(context).pop();
        });
  }

  Widget okButton() {
    return FlatButton(
        child: Text('OK'),
        onPressed: () {
          Navigator.of(context).pop();
          processSignOut();
        });
  }

  Future<void> processSignOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
        actions: <Widget>[signOutButton()],
      ),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }
}
