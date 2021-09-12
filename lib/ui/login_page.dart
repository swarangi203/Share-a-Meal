import 'package:flutter/material.dart';
import 'package:sampleproject/net/flutterfire.dart';
import 'package:sampleproject/ui/mainpage.dart';
import 'package:sampleproject/ui/routes.dart';

import 'home_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool changeButton = false;
  bool _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
        ),
        body: Form(
          key: _formKey,
          autovalidate: _autovalidate,
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autocorrect: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Username can't be empty";
                    }

                    return null;
                  },
                  controller: _emailField,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your Username',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(17.0)),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(17.0)),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                    hintText: 'Enter your Password',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(17.0)),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(17.0)),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              //  ElevatedButton(

              //     onPressed: () async {
              //             bool shouldNavigate =
              //                 await register(_emailField.text, _passwordField.text);
              //             if (shouldNavigate) {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => HomeView(),
              //                 ),
              //               );
              //             }
              //           },
              //             style: ElevatedButton.styleFrom(
              //           primary: Colors.blueAccent,

              //           ),
              //    child: Text("Register")),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fixedSize: Size(150, 46)),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      // use the information provided

                      showLoaderDialog(context);
                      bool shouldNavigate =
                          await signIn(_emailField.text, _passwordField.text);
                      if (shouldNavigate) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
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
                  child: Text("Login ")),
              SizedBox(height: 30),
              new GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.Register);
                },
                child: new Text("Don't have an account ? create one "),
              )
            ],
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
          child: Text("       Pls wait..."),
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
