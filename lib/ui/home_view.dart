import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/ui/routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            Text("Welcome"),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();

                  Navigator.pushNamed(context, MyRoutes.LoginRoute);
                },
                child: Text("Logout")),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.HomePage);

                },
                child: Text("Home page")),
          ],
        ),
      )),
    );
  }
}
