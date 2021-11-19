import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/net/flutterfire.dart';
import 'package:sampleproject/ui/admin_dashboard.dart';
import 'package:sampleproject/ui/ngo_dashboard.dart';
import 'package:sampleproject/ui/register_admin.dart';
import 'package:sampleproject/ui/register_ngo.dart';
import 'package:sampleproject/ui/register_resto.dart';
import 'package:sampleproject/ui/resto_dashboard.dart';
import 'package:sampleproject/ui/resto_profile.dart';

class LoginPage extends StatefulWidget {
  final String text;

  LoginPage({Key key, @required this.text}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState(this.text);
}
DatabaseReference reference;
String role;
class _LoginPageState extends State<LoginPage> {
  String temp;

  _LoginPageState(String variable) {
    this.temp = variable;
  }
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool changeButton = false;
  bool _autovalidate = false;
  @override
  void initState(){
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Icon(Icons.restaurant_menu),
          title: Text("Share A Meal", style: TextStyle(color: Colors.white, fontFamily: "BonaNova"),),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              autovalidate: _autovalidate,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    'Login ',
                    style: TextStyle(fontSize: 30, fontFamily: "BonaNova", color: Colors.teal),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: 285,
                      height: 55,
                      child: TextFormField(
                        autocorrect: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Email can't be empty";
                          }

                          return null;
                        },
                        controller: _emailField,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white60, fontFamily: "BonaNova",),
                          hintText: 'Enter your Email',
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[800],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: 285,
                      height: 55,
                      child: TextFormField(
                        autocorrect: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password can't be empty";
                          }
                          if (value.length < 6) {
                            return "Password should be atleast 6 characters";
                          }
                          return null;
                        },
                        controller: _passwordField,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white60, fontFamily: "BonaNova",),
                          hintText: 'Enter your Password',
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[800],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          // use the information provided

                          showLoaderDialog(context);
                          bool shouldNavigate =
                              await signIn(_emailField.text, _passwordField.text);
                          if (shouldNavigate) {
                            setState(() {
                              reference = FirebaseDatabase.instance.reference().child("Users").child(FirebaseAuth.instance.currentUser.uid);
                              reference.once().then((DataSnapshot snapshot){
                                Map<dynamic, dynamic> values = snapshot.value;
                                role = values["role"];
                                print(role);
                                if (role == "Restaurant"&&temp == "Restaurant") {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RestoDashboard(),
                                    ),
                                  );
                                }
                                else if (role == "NGO"&&temp == "NGO") {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NgoDashboard(),
                                    ),
                                  );
                                }
                                else if (role == "admin"&&temp == "admin") {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdminDashboard(),
                                    ),
                                  );
                                }else{
                                  Navigator.pop(context);
                                  return showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text("Error"),
                                      content: Text("Are you registered as $temp?"),
                                      actions: <Widget>[
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Text("Ok"))
                                      ],
                                    ),
                                  );
                                }
                              });
                            });

                          } else {
                            Navigator.pop(context);
                            return showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text("Error"),
                                content: Text("Wrong username or password"),
                                actions: <Widget>[
                                  // ignore: deprecated_member_use
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Text("Ok"))
                                ],
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        "Login ",
                        style: TextStyle(fontSize: 20, fontFamily: "BonaNova"),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  new GestureDetector(
                    onTap: () {
                      if (temp == "Restaurant") {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterResto(text: temp),
                            ));
                      }
                      else if(temp == "NGO") {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Registerngo(text: temp),
                            ));
                      }
                      else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Registeradmin(text: temp),
                            ),);
                      }
                    },
                    child: new Text(
                      "Don't have an account ? Create one",
                      style: TextStyle(fontSize: 15, fontFamily: "BonaNova", color: Colors.teal),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

