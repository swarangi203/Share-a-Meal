import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/ui/ngo_dashboard.dart';
import 'package:sampleproject/ui/role_page.dart';

class NGODonationDetail extends StatefulWidget {
  @override
  _NGODonationDetailState createState() => _NGODonationDetailState();
}
Map<dynamic, dynamic> donationMap;
String transId;

void getNGODonationDetail(Map<dynamic, dynamic> amap, String transactionId){
  donationMap = amap;
  transId= transactionId;
}
class _NGODonationDetailState extends State<NGODonationDetail> {
  bool isDonationComplete=false;
  Widget donationComplete()
  {
    if(isDonationComplete)
      {
          return SizedBox(height: 10,);
      }
    else return SizedBox(
      width: 200,
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
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              content: Text("Do you wish to Complete the donation?"),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                    onPressed: () {
                      DatabaseReference ref = FirebaseDatabase.instance.reference().child('Donations').child(transId).child('completion');
                      ref.set('Donation Received');
                      Navigator.of(ctx).pop();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NgoDashboard(text: FirebaseAuth.instance.currentUser.uid),
                          ));

                    },
                    child: Text("Yes")),
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();


                    },
                    child: Text("No"))
              ],
            ),
          );
        },
        child: Text(
          "Complete Donation",
          style: TextStyle(
              fontSize: 14,
              fontFamily: "BonaNova"),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final DatabaseReference reference =
    FirebaseDatabase.instance.reference().child("Users").child(donationMap['restaurant']);
    List lists = List();
    List uids = List();
    List eachList = List();
    List eachuid = List();
    return Center(
      child: Container(
        color: Colors.grey[900],
        child: StreamBuilder(
          stream: reference.onValue,
          builder: (context, AsyncSnapshot<Event> snapshot) {
            if (snapshot.hasData) {
              lists.clear();
              eachList.clear();
              uids.clear();
              eachuid.clear();
              DataSnapshot dataValues = snapshot.data.snapshot;
              Map<dynamic, dynamic> values = dataValues.value;
              print(values);
              if(donationMap['completion']!='no')
                {
                    isDonationComplete = true;
                }
              return new ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
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
                                          'Transaction ID: ${transId}',
                                          style: TextStyle(
                                              color: Colors.teal[600],
                                              fontFamily: "BonaNova",
                                              fontSize: 15,
                                              decoration: TextDecoration.none),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Status: ${donationMap['completion']}',
                                          style: TextStyle(
                                              color: Colors.white60,
                                              fontFamily: "BonaNova",
                                              fontSize: 15,
                                              decoration: TextDecoration.none),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${values['name']}',
                                          style: TextStyle(
                                              color: Colors.white60,
                                              fontFamily: "BonaNova",
                                              fontSize: 15,
                                              decoration: TextDecoration.none),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Food Items: ${donationMap['foodItems']}',
                                          style: TextStyle(
                                              color: Colors.white60,
                                              fontFamily: "BonaNova",
                                              fontSize: 15,
                                              decoration: TextDecoration.none),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Amount: ${donationMap['amount']} kg',
                                          style: TextStyle(
                                              color: Colors.white60,
                                              fontFamily: "BonaNova",
                                              fontSize: 15,
                                              decoration: TextDecoration.none),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Storage Instructions: ${donationMap['storageInstructions']} ',
                                          style: TextStyle(
                                              color: Colors.white60,
                                              fontFamily: "BonaNova",
                                              fontSize: 15,
                                              decoration: TextDecoration.none),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Time Of Collection: ${donationMap['timeOfCollection']} ',
                                          style: TextStyle(
                                              color: Colors.white60,
                                              fontFamily: "BonaNova",
                                              fontSize: 15,
                                              decoration: TextDecoration.none),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Time Of Transaction: ${donationMap['timeOfTransaction']}',
                                          style: TextStyle(
                                              color: Colors.white60,
                                              fontFamily: "BonaNova",
                                              fontSize: 15,
                                              decoration: TextDecoration.none),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        donationComplete(),
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
        ),
      ),
    );
  }
}
