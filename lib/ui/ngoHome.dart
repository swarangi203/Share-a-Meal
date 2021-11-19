import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sampleproject/ui/donation_detail.dart';
import 'package:sampleproject/ui/view_pdf.dart';

import 'donation_deatail_ngo.dart';
// bas karna bhot bolri kya ha you wa
Widget ngoHome(BuildContext context){
  final DatabaseReference reference =
  FirebaseDatabase.instance.reference().child("Donations");
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
          if(lists[i]['ngo']==FirebaseAuth.instance.currentUser.uid&&lists[i]['completion']=='no')
          {
            eachList.add(lists[i]);
            eachuid.add(uids[i]);
            print(eachuid);
          }
        }
        if(eachList.isNotEmpty)
        {
          return new ListView.builder(
            shrinkWrap: true,
            itemCount: eachList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NGODonationDetail(),

                      ));
                  getNGODonationDetail(eachList[index], eachuid[index]);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Transaction ID: ${eachuid[index]}',
                                        style: TextStyle(
                                            color: Colors.teal[600],
                                            fontFamily: "BonaNova",
                                            fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Status: ${eachList[index]['completion']}',
                                        style: TextStyle(
                                            color: Colors.white60,
                                            fontFamily: "BonaNova",
                                            fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Food Items: ${eachList[index]['foodItems']}',
                                        style: TextStyle(
                                            color: Colors.white60,
                                            fontFamily: "BonaNova",
                                            fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Amount: ${eachList[index]['amount']} kg',
                                        style: TextStyle(
                                            color: Colors.white60,
                                            fontFamily: "BonaNova",
                                            fontSize: 15),
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
                    ]),
                  ],
                ),
              );
            },
          );
        }
        else{
          return Center(
            child: Text('Your Donations will appear here', style: TextStyle( color: Colors.teal[600],
                fontFamily: "BonaNova",
                fontSize: 18),),
          );
        }

      }

      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.teal,
        ),
      );
    },
  );
}