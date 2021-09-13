import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sampleproject/ui/login_page.dart';

class RestoDashboard extends StatefulWidget {
  String text;
  RestoDashboard({Key key, @required this.text}) : super(key: key);
  @override
  _RestoDashboardState createState() => _RestoDashboardState(this.text);
}

class _RestoDashboardState extends State<RestoDashboard> {
  String uid;
  _RestoDashboardState(String variable) {
    this.uid = variable;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Text("Restaurant Dashboard")),
    );
  }
}

