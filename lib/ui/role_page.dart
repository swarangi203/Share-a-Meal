import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sampleproject/ui/login_page.dart';

class RolePage extends StatefulWidget {
  @override
  _RolePageState createState() => _RolePageState();
}
class _RolePageState extends State<RolePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
               "What's your Role?",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.teal,
                  fontFamily: "BonaNova"
                ),
              ),
              SizedBox(
                height: 80,
              ),
              SizedBox(
                width: 230,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(text: 'Restaurant',),
                          ));
                     // Navigator.pushNamed(context, MyRoutes.RestaurantLogin);
                    },
                    child: Text("Restaurant", style: TextStyle(fontFamily: 'BonaNova', fontSize: 15),)),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 230,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(text: 'NGO',),
                          ));
                    },
                    child: Text("Non Profit Organization",style: TextStyle(fontFamily: 'BonaNova', fontSize: 15),)),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 230,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(text: 'admin',),
                          ));
                      // Navigator.pushNamed(context, MyRoutes.RestaurantLogin);
                    },
                    child: Text("Admin",style: TextStyle(fontFamily: 'BonaNova', fontSize: 15),)),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

