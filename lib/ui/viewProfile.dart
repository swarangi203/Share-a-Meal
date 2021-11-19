import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sampleproject/ui/view_pdf.dart';

class AnyProfile extends StatefulWidget {
  @override
  _AnyProfileState createState() => _AnyProfileState();
}

Map<dynamic, dynamic> ngoDetail = {};
String ngouid = '';
void getNGODetails(String ngoUid, Map ngoDet) {
  ngouid = ngoUid;
  ngoDetail = ngoDet;
}

class _AnyProfileState extends State<AnyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        flexibleSpace: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.black],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(Icons.notifications_none, color: Colors.white60,),
              onPressed: () {},
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                '  Share a Meal',
                style: TextStyle(
                    color: Colors.white, fontFamily: "BonaNova", fontSize: 25),
              ),
              SizedBox(
                height: 30,
              )
            ],
          )),
        ),
        //centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: IconButton(
            icon: Icon(
              Icons.restaurant_menu_outlined,
              color: Colors.white60,
            ),
            onPressed: () {},
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                                  "${ngoDetail['name']}",
                                  style: TextStyle(
                                      color: Colors.teal[600],
                                      fontFamily: "BonaNova",
                                      fontSize: 25),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${ngoDetail['city']}",
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
                                  initialRating:
                                      double.parse("${ngoDetail['rating']}"),
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
                                    "${ngoDetail['description']}",
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
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ViewPdf(
                                                  text:
                                                      "${ngoDetail['license']}"),
                                            ));
                                      },
                                      child: Icon(
                                        Icons.description,
                                        color: Colors.teal,
                                        size: 40,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ViewPdf(
                                                text:
                                                    "${ngoDetail['foodquality']}",
                                              ),
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
                      backgroundImage:
                          NetworkImage("${ngoDetail['profilePic']}"),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
