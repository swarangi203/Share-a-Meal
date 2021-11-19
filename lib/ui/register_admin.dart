import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/net/flutterfire.dart';
import 'package:sampleproject/ui/resto_dashboard.dart';
import 'admin_dashboard.dart';
import 'login_page.dart';

class Registeradmin extends StatefulWidget {
  final String text;
  Registeradmin({Key key, @required this.text}) : super(key: key);

  @override
  _RegisteradminState createState() => _RegisteradminState(this.text);
}
DatabaseReference reference;

class _RegisteradminState extends State<Registeradmin> {
  String temp;
  final formKey = new GlobalKey<FormState>();
  _RegisteradminState(String variable) {
    this.temp = variable;
  }
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  TextEditingController _nameField = TextEditingController();
  TextEditingController _referral = TextEditingController();
  String _myActivity;
  String _myActivityResult;


  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
    reference = FirebaseDatabase.instance.reference().child("Users");
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivityResult = _myActivity;
      });
    }
  }

  final List<String> _dropdownValues = ["Mumbai", "Pune", "Sangli", "Delhi", "Kolkata"];
  bool changeButton = false;
  bool _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar:
        AppBar(title: Text("Share A Meal", style: TextStyle(fontFamily: "BonaNova",)), backgroundColor: Colors.black, leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.restaurant_menu_outlined),
        ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 285,
                      height: 55,
                      child: TextFormField(
                        autocorrect: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Name of the Admin can't be empty";
                          }
                          return null;
                        },
                        controller: _nameField,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(color: Colors.white60, fontFamily: "BonaNova",),
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[800],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30,),),
                            borderSide:
                            BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30,),),
                            borderSide:
                            BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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

                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[800],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30,),),
                            borderSide:
                            BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30,),),
                            borderSide:
                            BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 285,
                      height: 55,
                      child: TextFormField(
                        autocorrect: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Admin Referral can't be empty";
                          }
                          return null;
                        },
                        controller: _referral,
                        decoration: InputDecoration(
                          labelText: 'Admin Referral',
                          labelStyle: TextStyle(color: Colors.white60, fontFamily: "BonaNova",),
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[800],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30,),),
                            borderSide:
                            BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30,),),
                            borderSide:
                            BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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

                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[800],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide:
                            BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide:
                            BorderSide(color: Colors.black, width: 1),
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
                          primary: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            // use the information provided
                            showLoaderDialog(context);
                            bool shouldNavigate = await register(
                                _emailField.text, _passwordField.text);
                            if (shouldNavigate) {
                              String uid = FirebaseAuth.instance.currentUser.uid;
                              registerUser(uid, temp, _nameField.text, _emailField.text, _referral.text, _passwordField.text);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminDashboard(text: uid),
                                ),
                              );
                            } else {
                              Navigator.pop(context);
                              return showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text(
                                    "Error",
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: "BonaNova"),
                                  ),
                                  content: Text(
                                    "Could not SignUp, already have an account? ",
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: "BonaNova"),
                                  ),
                                  actions: <Widget>[
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Text(
                                          "Ok",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "BonaNova"),
                                        ))
                                  ],
                                ),
                              );
                            }
                          }
                        },
                        child: Text(
                          "Register ",
                          style:
                          TextStyle(fontSize: 20, fontFamily: "BonaNova"),
                        )),
                  ),
                  SizedBox(height: 30),
                  new GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(text: 'admin',),
                          ));
                    },
                    child: new Text(
                      "Already have an account ? SignIn",
                      style: TextStyle(fontSize: 20, fontFamily: "BonaNova", color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),
          Container(
            margin: EdgeInsets.only(left: 7),
            child: Text("       Please wait..."),
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
}

void registerUser(String uid, String role, String name, String email, String contact, String address){
  Map<String, String> userdata = {
    'name': name,
    'email': email,
    'referral': contact,
    'role': "admin",
    'approval': 'no'
  };
  reference.child(uid).set(userdata);
}
