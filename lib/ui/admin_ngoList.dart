import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sampleproject/ui/resto_edit_profile.dart';
import 'package:sampleproject/ui/viewProfile.dart';
import 'package:sampleproject/ui/view_pdf.dart';

import 'admin_dashboard.dart';
import 'donationPage.dart';

Widget adminNgoList() {
  final DatabaseReference reference =
  FirebaseDatabase.instance.reference().child("Users");
  List lists = List();
  List uids = List();
  List eachList = List();
  List eachuid = List();
  return StreamBuilder(
    stream: reference.onValue,
    builder: (context, AsyncSnapshot<Event> snapshot) {
      if (snapshot.hasData) {
        lists.clear();
        eachList.clear();
        uids.clear();
        eachuid.clear();
        DataSnapshot dataValues = snapshot.data.snapshot;
        Map<dynamic, dynamic> values = dataValues.value;
        values.forEach((key, values) {
          lists.add(values);
          uids.add(key);
        });
        for(int i=0; i<lists.length; i++)
        {
          if(lists[i]['role']=='NGO'&&lists[i]['approval']=='no')
          {
            eachList.add(lists[i]);
            eachuid.add(uids[i]);
            print(eachuid);
          }
        }
        return new ListView.builder(
          shrinkWrap: true,
          itemCount: eachList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                getNGODetails(eachuid[index], eachList[index]);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AnyProfile() )) ;
              },
              child: Card(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                                        eachList[index]['name'],
                                        style: TextStyle(
                                            color: Colors.teal[600],
                                            fontFamily: "BonaNova",
                                            fontSize: 25),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        eachList[index]['city'],
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
                                        initialRating: double.parse(eachList[index]['rating']),
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
                                      SizedBox(
                                        height: 15,
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
                                                DatabaseReference reference = FirebaseDatabase.instance.reference().child('Users').child(eachuid[index]).child('approval');
                                                reference.set('yes');
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdminDashboard(text: FirebaseAuth.instance.currentUser.uid),
                                                    ));
                                              },
                                              child: Text(
                                                "Approve",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: "BonaNova"),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if(eachList[index]['license']=='')
                                              {
                                                final snackBar = SnackBar(
                                                  content: Text('Oh no! No certificate to show'),
                                                );
                                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                return;
                                              }
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewPdf(text: eachList[index]['license']),
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
                                              if(eachList[index]['foodquality']=='')
                                              {
                                                final snackBar = SnackBar(
                                                  content: Text('Oh no! No certificate to show'),
                                                );
                                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                return;
                                              }
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewPdf(text: eachList[index]['foodquality'],),
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
                            backgroundImage: NetworkImage(eachList[index]['profilePic']),
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
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.teal,
        ),
      );
    },
  );
}

/*
Container(
child:
);
*/
