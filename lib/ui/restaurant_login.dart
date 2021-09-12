import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sampleproject/ui/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RestaurantLogin());
}

class RestaurantLogin extends StatelessWidget {
  const RestaurantLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _name = TextEditingController();
    TextEditingController _number = TextEditingController();
    TextEditingController _email = TextEditingController();
    TextEditingController _address = TextEditingController();
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Restaurant Data",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 60,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: _name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: ' Name of the restaurant',
                        )),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _email,
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ' Email',
                    )),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: _number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: ' Phone no.',
                        )),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _address,
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ' Address',
                    )),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                     
                      Map<String, dynamic> data = {
                        "Address":_address.text,
                        "Name": _name.text,
                        "Number": _number.text,

                        "Email":_email.text,

                        
                      };
                      FirebaseFirestore.instance
                          .collection("Restaurant")
                          .add(data);


                       return showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text("Submited"),
                              content: Text("Your data has been submitted further part yet to be done"),
                              actions: <Widget>[
                                // ignore: deprecated_member_use
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                     Navigator.pushNamed(context, MyRoutes.HomePage);

                                    },
                                    child: Text("Ok"))
                              ],
                            ),
                          );
                    },
                    
                    child: Text("Submit")
                    
                    
          
                    
                    
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
