import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sampleproject/ui/role_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/ui/home_view.dart';
import 'package:sampleproject/ui/login_page.dart';
import 'package:sampleproject/ui/mainpage.dart';
import 'package:sampleproject/ui/register_resto.dart';
import 'package:sampleproject/ui/restaurant_login.dart';
import 'package:sampleproject/ui/routes.dart';
import 'package:sampleproject/ui/splashscreen.dart';
import 'ui/authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
/*

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  //   return MaterialApp(
  //     initialRoute: MyRoutes.HomePage,
  //     //FirebaseAuth.instance.currentUser == null  ? MyRoutes.LoginRoute : MyRoutes.HomePage
  //     // initialRoute: MyRoutes.HomeViewRoute,
  //     routes: {
  //       MyRoutes.LoginRoute:(context)=>LoginPage(),
  //       MyRoutes.AuthRoute:(context)=>Authentication(),
  //       MyRoutes.HomeViewRoute:(context)=>HomeView(),
  //       MyRoutes.Register:(context)=>RegisterPage(),
  //       MyRoutes.RestaurantLogin:(context)=>RestaurantLogin(),
  //       MyRoutes.HomePage:(context)=>MyHomePage(),
  //       // MyRoutes.SignupRoute:(context)=>SignupPage(),
  //     },
  //   );
   }
}
*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                RolePage()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }
}


