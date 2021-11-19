import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DonationDetail extends StatefulWidget {
  @override
  _DonationDetailState createState() => _DonationDetailState();
}
Map<dynamic, dynamic> donationMap;
String transId;
void getDonationDetail(Map<dynamic, dynamic> amap, String transactionId){
  donationMap = amap;
  transId= transactionId;
}
class _DonationDetailState extends State<DonationDetail> {

  @override
  Widget build(BuildContext context) {
    final DatabaseReference reference =
    FirebaseDatabase.instance.reference().child("Users").child(donationMap['ngo']);
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
