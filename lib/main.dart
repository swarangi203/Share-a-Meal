import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/ui/admin_dashboard.dart';
import 'package:sampleproject/ui/ngo_dashboard.dart';
import 'package:sampleproject/ui/resto_dashboard.dart';
import 'package:sampleproject/ui/role_page.dart';


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
  //     //
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

      title: 'Share a Meal',
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

  DatabaseReference reference;
  @override
  void initState() {
    String role;
    super.initState();
    var page;
    setState(() {
      if(FirebaseAuth.instance.currentUser == null) {
        Timer(Duration(seconds: 3),
                ()=>Navigator.push(context,
                MaterialPageRoute(builder:
                    (context) =>
                    RolePage()
                )
            )
        );
      }
      else{
        print(role);
        reference = FirebaseDatabase.instance.reference().child("Users").child(FirebaseAuth.instance.currentUser.uid);
        String uid= FirebaseAuth.instance.currentUser.uid;
        print(uid);
        reference.once().then((DataSnapshot snapshot){
          Map<dynamic, dynamic> values = snapshot.value;
          role = values["role"];
          if(role=="Restaurant")
          {
            print(role);
            Timer(Duration(seconds: 3),
                    ()=>Navigator.push(context,
                    MaterialPageRoute(builder:
                        (context) =>
                        RestoDashboard(text: uid)
                    )
                )
            );
          }
          else if(role=="NGO")
          {
            Timer(Duration(seconds: 3),
                    ()=>Navigator.push(context,
                    MaterialPageRoute(builder:
                        (context) =>
                        NgoDashboard(text: FirebaseAuth.instance.currentUser.uid)
                    )
                )
            );
          }
          else if(role=="admin")
          {
            Timer(Duration(seconds: 3),
                    ()=>Navigator.push(context,
                    MaterialPageRoute(builder:
                        (context) =>
                        AdminDashboard(text: FirebaseAuth.instance.currentUser.uid)
                    )
                )
            );
          }
        });
      }

    });


  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[800],
        child:FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }
}


