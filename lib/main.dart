  
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/ui/home_view.dart';
import 'package:sampleproject/ui/login_page.dart';
import 'package:sampleproject/ui/mainpage.dart';
import 'package:sampleproject/ui/register_page.dart';
import 'package:sampleproject/ui/restaurant_login.dart';
import 'package:sampleproject/ui/routes.dart';
import 'ui/authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Wallet',
      
      initialRoute: FirebaseAuth.instance.currentUser == null  ? MyRoutes.LoginRoute : MyRoutes.HomePage,
      // initialRoute: MyRoutes.HomeViewRoute,
      routes: {
        MyRoutes.LoginRoute:(context)=>LoginPage(),
        MyRoutes.AuthRoute:(context)=>Authentication(),
        MyRoutes.HomeViewRoute:(context)=>HomeView(),
        MyRoutes.Register:(context)=>RegisterPage(),
        MyRoutes.RestaurantLogin:(context)=>RestaurantLogin(),
        
               MyRoutes.HomePage:(context)=>HomePage(),


        // MyRoutes.SignupRoute:(context)=>SignupPage(),

      },
    );
    
  }
  
}
