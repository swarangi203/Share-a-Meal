import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sampleproject/ui/login_page.dart';

class AdminDashboard extends StatefulWidget {
  String text;
  AdminDashboard({Key key, @required this.text}) : super(key: key);
  @override
  _AdminDashboardState createState() => _AdminDashboardState(this.text);
}

class _AdminDashboardState extends State<AdminDashboard> {
  String uid;
  _AdminDashboardState(String variable) {
    this.uid = variable;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Text("Admin Dashboard")),
    );
  }
}

