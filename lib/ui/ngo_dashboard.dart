import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimize_app/minimize_app.dart';
import 'package:sampleproject/ui/login_page.dart';
import 'package:sampleproject/ui/ngoHome.dart';
import 'package:sampleproject/ui/ngoProfile.dart';
import 'package:sampleproject/ui/restoList.dart';
import 'package:sampleproject/ui/role_page.dart';

import 'ngoSettings.dart';

class NgoDashboard extends StatefulWidget {
  String text;
  NgoDashboard({Key key, @required this.text}) : super(key: key);
  @override
  _NgoDashboardState createState() => _NgoDashboardState(this.text);
}

class _NgoDashboardState extends State<NgoDashboard> {
  String uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    await _auth.signOut();
  }
  _NgoDashboardState(String variable) {
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
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text('  Share a Meal',style: TextStyle(color: Colors.white, fontFamily: "BonaNova", fontSize: 25),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              )),
            ),
            //centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(15.0),
              child: IconButton(
                icon: Icon(Icons.restaurant_menu_outlined, color: Colors.white60,),
                onPressed: () {},
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                  icon: Icon(Icons.notifications_none, color: Colors.white60,),
                  onPressed: () {},
                ),
              ),
            ],
            //backgroundColor: Colors.purple,
            flexibleSpace: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.black],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
            ),
            bottom: TabBar(
              //isScrollable: true,
              indicatorColor: Colors.teal,
              indicatorWeight: 5,
              tabs: [
                Tab(icon: Icon(Icons.home),),// say no to padding!!!!!!
                Tab(icon: Icon(Icons.restaurant),),
                Tab(icon: Icon(Icons.person),),
                Tab(icon: Icon(Icons.settings),),
              ],
            ),
            elevation: 20,
            titleSpacing: 20,
          ),
          body: TabBarView(
            children: [
              Container(
                color: Colors.grey[900],
                width: double.infinity,
                height: double.infinity,
                child: ngoHome(context),
              ),
              Container(
                color: Colors.grey[900],
                width: double.infinity,
                height: double.infinity,
                child: restoList(),
              ),
              Container(
                color: Colors.grey[900],
                width: double.infinity,
                height: double.infinity,
                child:  NGOProfile(),
              ),
              Container(
                color: Colors.grey[900],
                width: double.infinity,
                height: double.infinity,
                child: ngoSettings(),
              ),
            ],
          ),
        ),
      )
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

