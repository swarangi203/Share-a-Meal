import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/ui/ngo_dashboard.dart';
import 'package:sampleproject/ui/resto_dashboard.dart';

class DonationPage extends StatefulWidget {
  @override
  _DonationPageState createState() => _DonationPageState();
}

Map<dynamic, dynamic> ngoDetail = {};
String ngouid = '';
void getDonationDetails(String ngoUid, Map ngoDet) {
  ngouid = ngoUid;
  ngoDetail = ngoDet;
}

class _DonationPageState extends State<DonationPage> {
  String restoUid = FirebaseAuth.instance.currentUser.uid;
  String foodItems, amount, instructions, timeOfCollection, contact, collectionAddress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  '   Share a Meal',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "BonaNova",
                      fontSize: 25),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: Colors.white60,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 30, 20),
              child: Text(
                '${ngoDetail['name']}',
                style: TextStyle(
                    color: Colors.white60,
                    fontFamily: "BonaNova",
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 30, 20),
              child: Text(
                'Address: ${ngoDetail['city']}',
                style: TextStyle(
                    color: Colors.white60,
                    fontFamily: "BonaNova",
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 30, 20),
              child: Text(
                'Contact: ${ngoDetail['contact']}',
                style: TextStyle(
                    color: Colors.white60,
                    fontFamily: "BonaNova",
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
              child: SizedBox(
                width: 470,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {
                    foodItems = value;
                  },
                  style: TextStyle(
                    color: Colors.white60,
                    fontFamily: "BonaNova",
                  ),
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Food Items',
                    labelStyle: TextStyle(
                      color: Colors.white60,
                      fontFamily: "BonaNova",
                    ),
                    hintStyle: TextStyle(color: Colors.white60),
                    filled: true,
                    fillColor: Colors.grey[800],
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          30,
                        ),
                      ),
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          30,
                        ),
                      ),
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
              child: SizedBox(
                width: 470,
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    amount = value;
                  },
                  style: TextStyle(
                    color: Colors.white60,
                    fontFamily: "BonaNova",
                  ),
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Amount in kgs',
                    labelStyle: TextStyle(
                      color: Colors.white60,
                      fontFamily: "BonaNova",
                    ),
                    hintStyle: TextStyle(color: Colors.white60),
                    filled: true,
                    fillColor: Colors.grey[800],
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          30,
                        ),
                      ),
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          30,
                        ),
                      ),
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
              child: SizedBox(
                width: 470,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {
                    instructions= value;
                  },
                  style: TextStyle(
                    color: Colors.white60,
                    fontFamily: "BonaNova",
                  ),
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Storage Instructions',
                    labelStyle: TextStyle(
                      color: Colors.white60,
                      fontFamily: "BonaNova",
                    ),
                    hintStyle: TextStyle(color: Colors.white60),
                    filled: true,
                    fillColor: Colors.grey[800],
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          30,
                        ),
                      ),
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          30,
                        ),
                      ),
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
              child: SizedBox(
                width: 470,
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    contact = value;
                  },
                  style: TextStyle(
                    color: Colors.white60,
                    fontFamily: "BonaNova",
                  ),
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Contact Number',
                    labelStyle: TextStyle(
                      color: Colors.white60,
                      fontFamily: "BonaNova",
                    ),
                    hintStyle: TextStyle(color: Colors.white60),
                    filled: true,
                    fillColor: Colors.grey[800],
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          30,
                        ),
                      ),
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          30,
                        ),
                      ),
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
              child: SizedBox(
                width: 470,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {
                    collectionAddress = value;
                  },
                  style: TextStyle(
                    color: Colors.white60,
                    fontFamily: "BonaNova",
                  ),
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Collection Address',
                    labelStyle: TextStyle(
                      color: Colors.white60,
                      fontFamily: "BonaNova",
                    ),
                    hintStyle: TextStyle(color: Colors.white60),
                    filled: true,
                    fillColor: Colors.grey[800],
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          30,
                        ),
                      ),
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          30,
                        ),
                      ),
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
              child: SizedBox(
                width: 470,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {
                    timeOfCollection = value;
                  },
                  style: TextStyle(
                    color: Colors.white60,
                    fontFamily: "BonaNova",
                  ),
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Time of Collection',
                    labelStyle: TextStyle(
                      color: Colors.white60,
                      fontFamily: "BonaNova",
                    ),
                    hintStyle: TextStyle(color: Colors.white60),
                    filled: true,
                    fillColor: Colors.grey[800],
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          30,
                        ),
                      ),
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          30,
                        ),
                      ),
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 20),
              child: SizedBox(
                width: 370,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    onPressed: () async {
                      if(foodItems == null) {
                        final snackBar = SnackBar(
                          content: Text('Please enter Food Items'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      if(amount == null) {
                        final snackBar = SnackBar(
                          content: Text('Please enter amount'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      if(instructions == null) {
                        final snackBar = SnackBar(
                          content: Text('Please enter storage Instructions'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      if(contact == null) {
                        final snackBar = SnackBar(
                          content: Text('Please enter contact number'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      if(collectionAddress == null) {
                        final snackBar = SnackBar(
                          content: Text('Please enter collection Address'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          backgroundColor: Colors.grey[800],
                          content: Text("Do you wish to offer a donation to ${ngoDetail['name']} with collection address as $collectionAddress ?", style: TextStyle(color: Colors.white60, fontFamily: "BonaNova"),),
                          actions: <Widget>[
                            // ignore: deprecated_member_use
                            FlatButton(
                                onPressed: () {
                                  Map<dynamic, dynamic> donationMap = {
                                    'restaurant': ngouid,
                                    'ngo': FirebaseAuth.instance.currentUser.uid,
                                    'foodItems': foodItems,
                                    'amount': amount,
                                    'storageInstructions': instructions,
                                    'completion': 'no',
                                    'contact': contact,
                                    'collectionAddress': collectionAddress,
                                    'timeOfCollection': timeOfCollection,
                                    'timeOfTransaction': DateTime.now().hour.toString()+':'+DateTime.now().minute.toString()+':'+DateTime.now().second.toString(),
                                    'dateOfTransaction': DateTime.now().day.toString()+'/'+DateTime.now().month.toString()+'/'+DateTime.now().year.toString()
                                  };
                                  DatabaseReference reference = FirebaseDatabase.instance.reference().child('Donations');
                                  reference.push().set(donationMap);
                                  final snackBar = SnackBar(
                                    content: Text('Donation Request Sent!'),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                      NgoDashboard(text: restoUid),));
                                },
                                child: Text("Yes", style: TextStyle(color: Colors.white60, fontFamily: "BonaNova"),)),

                          ],
                        ),
                      );
                      
                    },
                    child: Text(
                      "Donate",
                      style:
                      TextStyle(fontSize: 20, fontFamily: "BonaNova"),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
