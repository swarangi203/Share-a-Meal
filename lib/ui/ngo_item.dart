//an image, name of ngo, city, number

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sampleproject/ui/resto_edit_profile.dart';
import 'package:sampleproject/ui/view_pdf.dart';
List<dynamic> ngolist;
Future<Map> ngoItem() async{
  ngolist = new List<dynamic>();
  int count=0;
  Map<dynamic, dynamic> data = new Map();
  Map<dynamic, dynamic> eachNgo = new Map();
  DatabaseReference reference =
  FirebaseDatabase.instance.reference().child("Users");
  reference.once().then((DataSnapshot snapshot) {
    data.addAll(snapshot.value);
    data.forEach((key, value) {
      eachNgo = value;
      if (eachNgo['role']=="NGO") {
        count++;
        print(count);
        ngolist.add(eachNgo);
      }
    });
    print(ngolist);

  });

}
