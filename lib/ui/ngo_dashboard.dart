import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sampleproject/ui/login_page.dart';

class NgoDashboard extends StatefulWidget {
  String text;
  NgoDashboard({Key key, @required this.text}) : super(key: key);
  @override
  _NgoDashboardState createState() => _NgoDashboardState(this.text);
}

class _NgoDashboardState extends State<NgoDashboard> {
  String uid;
  _NgoDashboardState(String variable) {
    this.uid = variable;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Text("NGO Dashboard")),
    );
  }
}

