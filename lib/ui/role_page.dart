import 'dart:async';
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: RolePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class RolePage extends StatefulWidget {
  @override
  _RolePageState createState() => _RolePageState();
}
class _RolePageState extends State<RolePage> {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}

