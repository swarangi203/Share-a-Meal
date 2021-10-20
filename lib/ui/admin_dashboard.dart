import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sampleproject/ui/login_page.dart';
import 'package:minimize_app/minimize_app.dart';
import 'package:sampleproject/ui/role_page.dart';

class AdminDashboard extends StatefulWidget {
  String text;
  AdminDashboard({Key key, @required this.text}) : super(key: key);
  @override
  _AdminDashboardState createState() => _AdminDashboardState(this.text);
}

class _AdminDashboardState extends State<AdminDashboard> {
  String uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    await _auth.signOut();
  }

  _AdminDashboardState(String variable) {
    this.uid = variable;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            content: Text("Do you wish to exit?"),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    MinimizeApp.minimizeApp();
                  },
                  child: Text("Yes")),
              FlatButton(
                  onPressed: () {
                      _signOut();
                      Navigator.of(ctx).pop();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RolePage(),
                          ));
                  },
                  child: Text("Logout"))
            ],
          ),
        );
        // You can do some work here.
        // Returning true allows the pop to happen, returning false prevents it.
        return true;
      },
      child: Scaffold(
        body: Container(child: Text("Admin Dashboard")),
      ),
    );
  }
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),
        Container(
          margin: EdgeInsets.only(left: 7),
          child: Text("   Please wait..."),
        ),
      ],
    ),
  );
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}