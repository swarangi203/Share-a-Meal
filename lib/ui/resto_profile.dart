
import 'dart:typed_data';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/adobe_xd.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:path/path.dart';
import 'package:sampleproject/ui/resto_edit_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sampleproject/ui/view_pdf.dart';
DatabaseReference reference;
File pdf;
String name;
String license;
String authentication;
String foodquality;
String description;
String rating;
String approval;
String city;
String address;
String ngos;
String role;
String profilePic;
String email;
String contact;
Widget restoProfile() {
  Color initial = Colors.grey[800];
  Color after = Colors.orange;
  return FutureBuilder(
    future: retrieve(),
    builder: (context, snapshot) {
      retrieve();
      return SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 70, 30, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                30,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 70, 5, 10),
                            child: Column(
                              children: [
                                Text(
                                  "$name",
                                  style: TextStyle(
                                      color: Colors.teal[600],
                                      fontFamily: "BonaNova",
                                      fontSize: 25),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "$city",
                                  style: TextStyle(
                                      color: Colors.white60,
                                      fontFamily: "BonaNova",
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                RatingBar.builder(
                                  unratedColor: Colors.grey[700],
                                  initialRating: double.parse(rating),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    '$description',
                                    style: TextStyle(
                                        color: Colors.white60,
                                        fontFamily: "BonaNova",
                                        fontSize: 19),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.teal,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfile(),
                                              ));
                                        },
                                        child: Text(
                                          "Edit Profile ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "BonaNova"),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewPdf(text: license),
                                            ));
                                      },
                                      child: Icon(
                                        Icons.description,
                                        color: Colors.teal,
                                        size: 40,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewPdf(text: foodquality,),
                                            ));
                                      },
                                      child: Icon(
                                        Icons.article_outlined,
                                        color: Colors.teal,
                                        size: 40,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ], // nai hone waala expand woh   .....hogaya fhaad!!!
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 50,
                      backgroundImage: NetworkImage(profilePic),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> retrieve() async {
  reference = FirebaseDatabase.instance
      .reference()
      .child("Users")
      .child(FirebaseAuth.instance.currentUser.uid);
  await reference.once().then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.value;
    name = values["name"];
    description = values["description"];
    city = values["city"];
    role = values["role"];
    profilePic = values["profilePic"];
    email = values["email"];
    rating = values["rating"];
    approval = values["aprroval"];
    ngos = values["ngos"];
    contact = values["contact"];
    address = values["address"];
    authentication = values['authentication'];
    foodquality = values['foodquality'];
    license = values['license'];
  });
}


